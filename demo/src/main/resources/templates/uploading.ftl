<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Uploading Files Example with Spring Boot, Freemarker</title>
</head>

<body onload="updateSize();">
<form name="uploadingForm" enctype="multipart/form-data" action="/square" method="POST">
    <p>
        <input id="fileInput" type="file" name="uploadingFiles" onsubmit =submitImage() onchange="updateSize();" multiple>
        <input id ="size" type="number" name="size">
        selected files: <span id="fileNum">0</span>;
        total size: <span id="fileSize">0</span>
    </p>
    <p>
        <input type="submit" value="Upload files" id="submit" disabled="true">
    </p>
</form>
<div>
   original width: <span id ='width'></span>  original height: <span id ='height'></span>
</div>
<h1>Your picture:</h1>
<img src="" id="img">


<script>
    var selectedFile;
    function submitImage(){
       var size = document.getElementById('size').value;
       if (size <= 0){
           alert("Size must be over 0");
           return;
       }
        $.post("/square",{uploadingFiles:selectedFile,size:size},function(result){
            alert("success");
        });

    }

    function updateSize() {
        var _URL = window.URL || window.webkitURL;
        var validImageTypes = [ 'image/jpeg', 'image/png'];
        var nBytes = 0,
            oFiles = document.getElementById("fileInput").files,
            nFiles = oFiles.length;
        if (nFiles > 1) {
            alert("You can only chose one picture");
            document.getElementById("fileNum").innerHTML = 0;
            return;
        }
        else if (nFiles < 1){
            alert("You can should  choose one picture");
            document.getElementById('submit').disabled=true;
        }
        else {
            var file = oFiles[0];
            var fileType = file['type'];

            if (!validImageTypes.includes(fileType)) {
                document.getElementById('submit').disabled = true;
                alert("You should choose image to process");
                return;
                // invalid file type code goes here.
            }
            document.getElementById('submit').disabled = false;
            var img = document.getElementById('img');
            img.onload = function () {
                document.getElementById('width').innerHTML = img.naturalWidth  || img.width;
                document.getElementById('height').innerHTML = img.naturalHeight || img.height;
                document.getElementById('img').height = 500;
                document.getElementById('img').width = 500;


            }
            img.src=_URL.createObjectURL(file);
        }


        for (var nFileId = 0; nFileId < nFiles; nFileId++) {
            nBytes += oFiles[nFileId].size;
        }

        var sOutput = nBytes + " bytes";
        // optional code for multiples approximation
        for (var aMultiples = ["KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"], nMultiple = 0, nApprox = nBytes / 1024; nApprox > 1; nApprox /= 1024, nMultiple++) {
            sOutput = nApprox.toFixed(3) + " " + aMultiples[nMultiple] + " (" + nBytes + " bytes)";
        }
        // end of optional code

        document.getElementById("fileNum").innerHTML = nFiles;
        document.getElementById("fileSize").innerHTML = sOutput;
        selectedFile = file;
    }
</script>
</body>
</html>