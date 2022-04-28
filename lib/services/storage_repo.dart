import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepo {
  final storage = FirebaseStorage.instanceFor(
      bucket: "gs://my-project-1538048980189.appspot.com");

  uploadFile(file) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    print(user);
    var storageRef = storage.ref().child("user/profile/" + user!.uid);
    String imageUrl = '';
    /* var completedTask = await uploadTask.on */
  
      var uploadTask = storageRef
          .putFile(file)
          .snapshotEvents
          .listen((TaskSnapshot taskSnapshot) async{
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            // Handle unsuccessful uploads
            break;
          case TaskState.success:
            // Handle successful uploads on complete
            // ...
            await storageRef.getDownloadURL();
            
            await user.updatePhotoURL(imageUrl);
             
            
        }
      });
   
    return uploadTask;
  }
}
