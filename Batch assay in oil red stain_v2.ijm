//Set Batch
   dir = getDirectory("Choose a Directory ");
   Table.create("Oil red analysis");
   setBatchMode(true);
   count = 0;
   countFiles(dir);
   n = 0;
   processFiles(dir);
   
   function countFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              countFiles(""+dir+list[i]);
          else
              count++;
      }
    }
    //print(count);
    
    function processFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              processFiles(""+dir+list[i]);
          else {
             showProgress(n++, count);
             path = dir+list[i];
             processFile(path);
          }
      }
   	}

  		function processFile(path) {
       		if (endsWith(path, ".tif")) {
           		open(path);
           		oilred();
       		}
  		}

		function oilred(){
			//IO
				tifName = getTitle();
				folderName = replace(tifName, ".tif", "");
				dir1parent = File.directory;
				dir2 = dir1parent+File.separator+folderName ;
				if (File.exists(dir2)==false) {
					File.makeDirectory(dir2);
				}
			//Prepare for analysis
	    		run("Set Scale...", "distance=0 known=0 unit=pixel global");
	    		run("Set Measurements...", "area mean integrated redirect=None decimal=2");
				selectWindow(tifName);
				rename("Raw");
				run("Duplicate...", "title=Tissue");
				selectWindow("Raw");
				run("Colour Deconvolution", "vectors=[User values] [r1]=0.748963 [g1]=0.6062903 [b1]=0.26733226 [r2]=0.099971585 [g2]=0.73738605 [b2]=0.6680326 [r3]=0.00000 [g3]=0.00000 [b3]=0.00000");//B from FastBlue, R from Masson Trichrome
				selectWindow("Raw-(Colour_3)");
				close();
				selectWindow("Colour Deconvolution");
				close();
				selectWindow("Raw");
				close();
				selectWindow("Raw-(Colour_1)");
				close();
				selectWindow("Raw-(Colour_2)");
				rename("Oil red");
			//Measure oil red
				selectWindow("Oil red");
				run("Invert");
				run("Grays");
				run("Auto Local Threshold", "method=Phansalkar radius=3 parameter_1=0 parameter_2=0 white");
				setThreshold(255, 255, "raw");
				run("Analyze Particles...", "size=10-Infinity display summarize add");
				run("Summarize");
				n = nResults(); // n = AP no + 4 statistics
				if(n>1){
					c = n-4; // c = AP no
					nmean = n-4; // where the mean value locates
					a = getResult("Area",nmean);
					b = getResult("IntDen", nmean);
					OrAreaSum = a * c;
					OrIntSum = b *c;
				}
				else{
					a = getResult("Area",0);
					b = getResult("IntDen",0);
					OrAreaSum = a;
					OrIntSum = b;
				}
				/*
				print("APno  " + c);
				print("APno + statistics  " + n);
				print("mean index  " + nmean);
    			print("OrAreaMean  " + a);
    			print("OrIntDenMean  " + b);
    			print("OrAreaSum  " + OrAreaSum);
    			print("OrIntDenSum  " + OrIntSum);
				*/
				roiManager("Save", dir2+File.separator+"oilred.zip");
				roiManager("Delete");
				selectWindow("Oil red");
				close();
				run("Clear Results");
			//Measure tissue area
				selectWindow("Tissue");
				run("8-bit");
				setAutoThreshold("Default");
				run("Analyze Particles...", "display summarize add");
				run("Summarize");
				n = nResults(); // n = AP no + 4 statistics
				if (n>1) {
					c = n-4; // c = AP no
					nmean = n-4; // where the mean value locates
					d = getResult("Area",nmean); 
					TsAreaSum = d * c;
				}
				else{
					TsAreaSum = getResult("Area",0); 
				}
    			/*
				print("APno  " + c);
				print("APno + statistics  " + n);
				print("mean index  " + nmean);
				print("TsAreaMean  " + d);
				print("TsAreaSum  " + TsAreaSum);
				*/
				roiManager("Save", dir2+File.separator+"tissue.zip");
				roiManager("Delete");
				selectWindow("Tissue");
				close();
				run("Clear Results");
			//Give result
				OrPerTs=OrAreaSum*100/TsAreaSum;
				//print(tifName + ";" + OrPerTs+ ";" + OrIntSum);
				selectWindow("Oil red analysis");
				Table.set("File Name", i, tifName);
				Table.set("Oil red in Tissue area (%)", i, OrPerTs);
				Table.set("Oil red intensity sum", i, OrIntSum);
	}
	