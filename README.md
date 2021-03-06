# Candy
3 minuts electroacoustic music

Στόχος της εργασίας είναι να εφαρμόσω τις τεχνικές, που δείχνονται στα βίντεο του  Eli Fieldsteel (SuperCollider Tutorial: 0. Introduction έως SuperCollider Tutorial: 7. Server Architecture) και τις τεχνικές που διδάχθηκα στις διαλέξεις του μαθήματος «Μουσική πληροφορική». Για την εκπλήρωση του στόχου αυτού δημιούργησα ένα κομμάτι τριών λεπτών, το οποίο έχει αρχή, μέση και τέλος.

Υπάρχουν δύο αρχεία το “start up file_synthdefs.scd” και το “Candy.scd”. 
Στο “start up file_synthdefs.scd” ο κώδικας πρέπει να μπει στο startup file πριν γίνει boot ο server και να γίνει αποθήκευση. Έπειτα, αφού κλείσει το SC και ξανά ανοίξει, τα synthdefs θα έχουν φορτωθεί. Σε αυτό το αρχείο υπάρχουν οι συνθετητές και το reverb.
Αναλυτικότερα
υπάρχει ένα reverb, όπου στην είσοδο του περνάνε όλοι οι συνθετητές. Αυτό γίνεται, για να δώσει στο κομμάτι την αίσθηση του χώρου. Ο χώρος παίζει σημαντικό ρόλο στην εμπειρία του ακροατή, δίνοντας όγκο στους ήχους και γεμίζοντας τα κενά μεταξύ των ήχων. Υπάρχουν έξι ομάδες συνθετητών με τα εξής ονόματα : bassnote, drone, simplesig, ufo, blip και crazysynth. Οι συνθετητές καταλαμβάνουν διαφορετική συχνοτική περιοχή, ώστε καθ’ όλη τη διάρκεια του κομματιού να υπάρχει μία ομοιόμορφη απόδοση των συχνοτήτων.
Οι έξοδοι από τους συνθετητές αποστέλλονται στην είσοδο του reverb.


Στο “Candy.scd” γίνεται η εκτέλεση του κομματιού. Στο πρώτο μέρος εισάγονται με τη σειρά συνθετητές μέχρι να φτάσει σε μία κορύφωση. Αφού φτάσει στην κορύφωση, εισάγεται μία παύση και ύστερα ξανά μπαίνει το κομμάτι στην κορύφωση, που υπήρχε πριν την παύση με νέα στοιχεία. Το κομμάτι τελειώνει αφαιρώντας συνθετητές, ώστε να φτάσει ομαλά σε κατάσταση ηρεμίας.
Ο κώδικας χωρίζεται σε τρία μέρη. 
1.	Στο πρώτο μέρος του κώδικα (step 1) δημιουργούνται δύο buses σε ελεύθερα κανάλια και δύο groups, τα οποία αργότερα στον κώδικα θα χρησιμεύσουν, για να στείλουμε την έξοδο από τους συνθετητές στην είσοδο του reverb με τη σωστή σειρά. Τα buses εξασφαλίζουν ότι όλοι οι ήχοι θα αποστέλλονται στην είσοδο του reverb ανεξαρτήτως με ποια σειρά θα είναι γραμμένοι στον κώδικα. 

2.	Στο δεύτερο μέρος (step 2) κάτω από το σχόλιο «Time arrangement» είναι γραμμένοι οι χρόνοι έναρξης για κάθε ομάδα συνθετητών (εκτός του crazysynth), reverb και αλλαγή παραμέτρων κάποιων συνθετητών. Οι χρόνοι είναι δομημένοι, έτσι ώστε το κομμάτι να διαρκεί τρία λεπτά και οι συνθετητές να δημιουργούν ένα εύηχο αποτέλεσμα. 
Οι χρόνοι του συνθετητή με όνομα crazysynth τρέχουν ανεξάρτητα από τους υπόλοιπους, γιατί γίνεται η επανάληψή του στο τρίτο μέρος.

3.	Τέλος στο τρίτο μέρος (step 3) γίνεται η εκτέλεση του κώδικα. Σε αυτό το μέρος του κώδικα εκτελείται ο κώδικας, που εμπεριέχεται στο argument candy με τις χρονικές καθυστερήσεις και τις επεξεργασίες των ρυθμιστικών των συνθετητών και ο κώδικας του crazysynthloop. Στον κώδικα, που εμπεριέχεται στο argument crazysynthloop, η εκτέλεση του γίνεται 7 φορές σε τυχαία χρονική στιγμή μεταξύ 45 και 55 δευτερολέπτων. 

Ο στόχος της εργασίας επιτεύχθηκε με επιτυχία, αφού εφαρμόστηκαν οι περισσότερες τεχνικές, που διδάχθηκα από το μάθημα και τα βίντεο σε κομμάτι μουσικής με αρχή μέση και τέλος.

Ωστόσο οι δυσκολίες, που παρουσιάστηκαν, ήταν αρκετές. Οι πιο χρονοβόρες ήταν η αυτόματη αναπαραγωγή των συνθετητών και η δημιουργία της παύσης κατά τη διάρκεια του κομματιού.

Το κομμάτι υπάρχει ηχογραφημένο στον παρακάτω σύνδεσμο:
https://drive.google.com/file/d/1ZIvZ0iJsZgubDfSsibBax0QibQKniW7O/view?usp=sharing
