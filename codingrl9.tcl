####simulation parameter setup####
set val(chan)   Channel/WirelessChannel    ;#channel type
set val(prop)   Propagation/TwoRayGround   ;# radio propagation model, menerapkan model propagasi radio dalam simulasi
set val(netif)  Phy/WirelessPhy            ;#network interface, pysical wireless
set val(mac)    Mac/802_11                 ;#type protocol medium access control (mac), 802_11 protocol mac standard 
set val(ifq)    Queue/DropTail/PriQueue    ;#menetapkan tipe antrian dalam simulasi jaringan, Queue: antrian digunakan untuk menyimpan paket data sementara, DropTail: metode pengelolaan antrian, PriQueue: memprioritaskan paket
set val(ll)     LL                         ;#link layer type, type link 
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;#max packet in ifq, mengatur parameter antrian
set val(nn)     53                         ;#numbermobilenodes, mengatur jumlah node
set val(rp)     AODV                       ;#routing table, mengatur protocol perutean Ad hoc On-Demand Distance Vector
set val(energymodel)    EnergyModel;     #energymodel, mengatur model energi dalam simulasi jaringan
set val(x)      8431                      ;#x dimensi topografi/topologi
set val(y)      1000                      ;#y dimensi topologi
set val(stop)   60.0                         ;#waktu simulasi berhenti

#####inisialisasi###
#create a ns simulator 
set ns [new Simulator]

#Setup topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)
set vttf [open PacketDeliveryRatio_PRO.tr w]
$ns trace-all $vttf
set untf [open PacketDeliveryRatio_EXI.tr w]
$ns trace-all $untf
set vrbtf [open EndtoEndDelay_EXI.tr w]
$ns trace-all $vrbtf
set ottf [open EndtoEndDelay_PRO.tr w]
$ns trace-all $ottf
set pntf [open EnergyConsumption_PRO.tr w]
$ns trace-all $pntf
set orbtf [open EnergyConsumption_EXI.tr w]
$ns trace-all $orbtf
set nndf [open NumberOfNodesDead_EXI.tr w]
set nndf1 [open NumberOfNodesDead_PRO.tr w]
set ltf [open Lifetime_EXI.tr w]
set ltf1 [open Lifetime_PRO.tr w]

set rt [open Routingtable.tr w]
$ns trace-all $rt

#Open the NS trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

####node parameter setup###
#Menetapkan protokol routing ad-hoc untuk node, disimpan dalam variabel $val(rp)
#Mengatur tipe link layer (lapisan tautan) untuk node
#Menetapkan tipe protokol MAC (Medium Access Control)
#Mengatur tipe antrean interface (interface queue) untuk node
# Menentukan panjang antrean interface (jumlah paket maksimum yang dapat disimpan)
# Menentukan tipe antena untuk node
#Mengatur tipe propagasi sinyal
# Mengatur tipe interface fisik jaringan
# Mengatur kanal komunikasi yang digunakan oleh node
# Menghubungkan node dengan topologi jaringan yang ditetapkan
# Mengaktifkan pelacakan (trace) agen di level aplikasi untuk analisis lalu lintas
# Mengaktifkan pelacakan paket di tingkat routing untuk pemantauan jaringan
# Mengaktifkan pelacakan paket di tingkat MAC untuk pemantauan akses media
# Mengaktifkan pelacakan pergerakan node untuk memonitor mobilitas node
# Node configuration
$ns node-config -adhocRouting  $val(rp) \
                -llType        $val(ll) \
                -macType       $val(mac) \
                -ifqType       $val(ifq) \
                -ifqLen        $val(ifqlen) \
                -antType       $val(ant) \
                -propType      $val(prop) \
                -phyType       $val(netif) \
                -channel       $chan \
                -topoInstance  $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace ON

####node definition####
#Create 53 nodes
set n(0) [$ns node]
$n(0) set X_ 2396
$n(0) set Y_ 1502
$n(0) set Z_ 0.0
$ns initial_node_pos $n(0) 50
set n(1) [$ns node]
$n(1) set X_ 1627
$n(1) set Y_ 2268
$n(1) set Z_ 0.0
$ns initial_node_pos $n(1) 50
set n(2) [$ns node]
$n(2) set X_ 3166
$n(2) set Y_ 2265
$n(2) set Z_ 0.0
$ns initial_node_pos $n(2) 50
set n(3) [$ns node]
$n(3) set X_ 1638
$n(3) set Y_ 747
$n(3) set Z_ 0.0
$ns initial_node_pos $n(3) 50
set n(4) [$ns node]
$n(4) set X_ 3134
$n(4) set Y_ 708
$n(4) set Z_ 0.0
$ns initial_node_pos $n(4) 50
set n(5) [$ns node]
$n(5) set X_ 1796
$n(5) set Y_ 2102
$n(5) set Z_ 0.0
$ns initial_node_pos $n(5) 25
set n(6) [$ns node]
$n(6) set X_ 1996
$n(6) set Y_ 2102
$n(6) set Z_ 0.0
$ns initial_node_pos $n(6) 25
set n(7) [$ns node]
$n(7) set X_ 2196
$n(7) set Y_ 2102
$n(7) set Z_ 0.0
$ns initial_node_pos $n(7) 25
set n(8) [$ns node]
$n(8) set X_ 2396
$n(8) set Y_ 2102
$n(8) set Z_ 0.0
$ns initial_node_pos $n(8) 25
set n(9) [$ns node]
$n(9) set X_ 2596
$n(9) set Y_ 2102
$n(9) set Z_ 0.0
$ns initial_node_pos $n(9) 25
set n(10) [$ns node]
$n(10) set X_ 2796
$n(10) set Y_ 2102
$n(10) set Z_ 0.0
$ns initial_node_pos $n(10) 25
set n(11) [$ns node]
$n(11) set X_ 2996
$n(11) set Y_ 2102
$n(11) set Z_ 0.0
$ns initial_node_pos $n(11) 25
set n(12) [$ns node]
$n(12) set X_ 1796
$n(12) set Y_ 1902
$n(12) set Z_ 0.0
$ns initial_node_pos $n(12) 25
set n(13) [$ns node]
$n(13) set X_ 1996
$n(13) set Y_ 1902
$n(13) set Z_ 0.0
$ns initial_node_pos $n(13) 25
set n(14) [$ns node]
$n(14) set X_ 2196
$n(14) set Y_ 1902
$n(14) set Z_ 0.0
$ns initial_node_pos $n(14) 25
set n(15) [$ns node]
$n(15) set X_ 2396
$n(15) set Y_ 1902
$n(15) set Z_ 0.0
$ns initial_node_pos $n(15) 25
set n(16) [$ns node]
$n(16) set X_ 2596
$n(16) set Y_ 1902
$n(16) set Z_ 0.0
$ns initial_node_pos $n(16) 25
set n(17) [$ns node]
$n(17) set X_ 2796
$n(17) set Y_ 1902
$n(17) set Z_ 0.0
$ns initial_node_pos $n(17) 25
set n(18) [$ns node]
$n(18) set X_ 2996
$n(18) set Y_ 1902
$n(18) set Z_ 0.0
$ns initial_node_pos $n(18) 25
set n(19) [$ns node]
$n(19) set X_ 1796
$n(19) set Y_ 1702
$n(19) set Z_ 0.0
$ns initial_node_pos $n(19) 25
set n(20) [$ns node]
$n(20) set X_ 1996
$n(20) set Y_ 1702
$n(20) set Z_ 0.0
$ns initial_node_pos $n(20) 25
set n(21) [$ns node]
$n(21) set X_ 2196
$n(21) set Y_ 1702
$n(21) set Z_ 0.0
$ns initial_node_pos $n(21) 25
set n(22) [$ns node]
$n(22) set X_ 2396
$n(22) set Y_ 1702
$n(22) set Z_ 0.0
$ns initial_node_pos $n(22) 25
set n(23) [$ns node]
$n(23) set X_ 2596
$n(23) set Y_ 1702
$n(23) set Z_ 0.0
$ns initial_node_pos $n(23) 25
set n(24) [$ns node]
$n(24) set X_ 2796
$n(24) set Y_ 1702
$n(24) set Z_ 0.0
$ns initial_node_pos $n(24) 25
set n(25) [$ns node]
$n(25) set X_ 2996
$n(25) set Y_ 1702
$n(25) set Z_ 0.0
$ns initial_node_pos $n(25) 25
set n(26) [$ns node]
$n(26) set X_ 1796
$n(26) set Y_ 1502
$n(26) set Z_ 0.0
$ns initial_node_pos $n(26) 25
set n(27) [$ns node]
$n(27) set X_ 1996
$n(27) set Y_ 1502
$n(27) set Z_ 0.0
$ns initial_node_pos $n(27) 25
set n(28) [$ns node]
$n(28) set X_ 2196
$n(28) set Y_ 1502
$n(28) set Z_ 0.0
$ns initial_node_pos $n(28) 25
set n(29) [$ns node]
$n(29) set X_ 2596
$n(29) set Y_ 1502
$n(29) set Z_ 0.0
$ns initial_node_pos $n(29) 25
set n(30) [$ns node]
$n(30) set X_ 2796
$n(30) set Y_ 1502
$n(30) set Z_ 0.0
$ns initial_node_pos $n(30) 25
set n(31) [$ns node]
$n(31) set X_ 2996
$n(31) set Y_ 1502
$n(31) set Z_ 0.0
$ns initial_node_pos $n(31) 25
set n(32) [$ns node]
$n(32) set X_ 1796
$n(32) set Y_ 1302
$n(32) set Z_ 0.0
$ns initial_node_pos $n(32) 25
set n(33) [$ns node]
$n(33) set X_ 1996
$n(33) set Y_ 1302
$n(33) set Z_ 0.0
$ns initial_node_pos $n(33) 25
set n(34) [$ns node]
$n(34) set X_ 2196
$n(34) set Y_ 1302
$n(34) set Z_ 0.0
$ns initial_node_pos $n(34) 25
set n(35) [$ns node]
$n(35) set X_ 2396
$n(35) set Y_ 1302
$n(35) set Z_ 0.0
$ns initial_node_pos $n(35) 25
set n(36) [$ns node]
$n(36) set X_ 2596
$n(36) set Y_ 1302
$n(36) set Z_ 0.0
$ns initial_node_pos $n(36) 25
set n(37) [$ns node]
$n(37) set X_ 2796
$n(37) set Y_ 1302
$n(37) set Z_ 0.0
$ns initial_node_pos $n(37) 25
set n(38) [$ns node]
$n(38) set X_ 2996
$n(38) set Y_ 1302
$n(38) set Z_ 0.0
$ns initial_node_pos $n(38) 25
set n(39) [$ns node]
$n(39) set X_ 1796
$n(39) set Y_ 1102
$n(39) set Z_ 0.0
$ns initial_node_pos $n(39) 25
set n(40) [$ns node]
$n(40) set X_ 1996
$n(40) set Y_ 1102
$n(40) set Z_ 0.0
$ns initial_node_pos $n(40) 25
set n(41) [$ns node]
$n(41) set X_ 2196
$n(41) set Y_ 1102
$n(41) set Z_ 0.0
$ns initial_node_pos $n(41) 25
set n(42) [$ns node]
$n(42) set X_ 2396
$n(42) set Y_ 1102
$n(42) set Z_ 0.0
$ns initial_node_pos $n(42) 25
set n(43) [$ns node]
$n(43) set X_ 2596
$n(43) set Y_ 1102
$n(43) set Z_ 0.0
$ns initial_node_pos $n(43) 25
set n(44) [$ns node]
$n(44) set X_ 2796
$n(44) set Y_ 1102
$n(44) set Z_ 0.0
$ns initial_node_pos $n(44) 25
set n(45) [$ns node]
$n(45) set X_ 2996
$n(45) set Y_ 1102
$n(45) set Z_ 0.0
$ns initial_node_pos $n(45) 25
set n(46) [$ns node]
$n(46) set X_ 1796
$n(46) set Y_ 902
$n(46) set Z_ 0.0
$ns initial_node_pos $n(46) 25
set n(47) [$ns node]
$n(47) set X_ 1996
$n(47) set Y_ 902
$n(47) set Z_ 0.0
$ns initial_node_pos $n(47) 25
set n(48) [$ns node]
$n(48) set X_ 2196
$n(48) set Y_ 902
$n(48) set Z_ 0.0
$ns initial_node_pos $n(48) 25
set n(49) [$ns node]
$n(49) set X_ 2396
$n(49) set Y_ 902
$n(49) set Z_ 0.0
$ns initial_node_pos $n(49) 25
set n(50) [$ns node]
$n(50) set X_ 2596
$n(50) set Y_ 902
$n(50) set Z_ 0.0
$ns initial_node_pos $n(50) 25
set n(51) [$ns node]
$n(51) set X_ 2796
$n(51) set Y_ 902
$n(51) set Z_ 0.0
$ns initial_node_pos $n(51) 25
set n(52) [$ns node]
$n(52) set X_ 2996
$n(52) set Y_ 902
$n(52) set Z_ 0.0
$ns initial_node_pos $n(52) 25


# Q-learning parameters
set learning_rate 0.5
# learning_rate (alpha): seberapa besar Q-value lama diperbarui oleh reward baru (0-1, makin besar makin cepat belajar)
set discount_factor 0.9
# discount_factor (gamma): seberapa besar reward masa depan diperhitungkan (0-1, makin besar makin jauh ke depan)
set epsilon 0.1
# epsilon: probabilitas memilih aksi acak (exploration), sisanya exploitasi Q-table (0-1, makin besar makin sering eksplorasi)
set actions {sleep listen transmit}

# Transmit Sub-slot Scheduling Parameters (referensi Algorithm 2 paper)
set m 5  ;# jumlah sub-slot
set zeta 0.5  ;# learning rate untuk transmit slot
set epsilon_tx 0.1 ;# epsilon untuk eksplorasi sub-slot


#random nomor generation
# Mendefinisikan prosedur myRand yg menghasilkan angka acak dalam rentang [min, max]
proc myRand { min max } {
 # Menghitung faktor maksimum dengan menambah 1 pada max lalu mengurangi min
    set maxFactor [expr [expr $max + 1] - $min]
 # Menghasilkan angka acak antara 0 dan 99 dengan mengalikan nilai rand() dengan 100
    set value [expr int([expr rand() * 100])]
 # Mengatur nilai acak dalam rentang maxfactor menggunakan modulus, kemudian menambah min untuk menyesuaikan rentang ke [min, max]
    set value [expr [expr $value % $maxFactor] + $min]
   # Mengembalikan nilai acak dalam rentang yang telah ditentukan
	return $value
}

# Mendefinisikan prosedur myRandfloat yg menghasilkan angka acak float dalam rentang [min, max]
proc myRandfloat { min max } {
# Menghitung faktor maksimum untuk rentang acak dengan menambah 1 pada max, kemudian mengurangi min
    set maxFactor [expr [expr $max + 1] - $min]
 # Menghasilkan angka acak desimal antara 0 dan 100 dengan mengalikan rand() dengan 100
    set value [expr ([expr rand() * 100])]
 # Mengembalikan nilai acak dalam rentang float yang telah ditentukan
    set value [expr fmod($value,$maxFactor)+ $min]
	return $value
}

#Energy Initialization
# Menginisialisasi energi untuk setiap node dalam jaringan
for {set i 0} {$i<$val(nn)} {incr i} {
# Menetapkan nilai awal energi sebesar 100 untuk setiap node dengan indeks i
	set energy($i) 1000
}

# Inisialisasi Q-table
for {set i 0} {$i < $val(nn)} {incr i} { 
	# Loop untuk setiap node (i) dari 0 sampai nn-1
    foreach state $actions {
		# Loop untuk setiap state yang mungkin (dalam actions)
        foreach action $actions {
            set Q($i,$state,$action) 0.0
# Set nilai awal Q-value menjadi 0.0
        }
    }
}

# Inisialisasi Q-slot dan probabilitas x(i) untuk setiap node
for {set i 0} {$i < $val(nn)} {incr i} {
    # Loop untuk setiap node (i) dari 0 sampai nn-1
	for {set j 0} {$j < $m} {incr j} {
        set Qslot($i,$j) 0.0
		# Set nilai awal Q-slot untuk node i dan slot j ke 0.0
        set x($i,$j) [expr 1.0 / $m]
    }
	# Set probabilitas awal x(i,j) menjadi 1/m (rata untuk semua slot)
}

#Mobility level of each node
for {set i 0} {$i<$val(nn)} {incr i} {
	set ml($i) [myRand 2 5]
}

# Inisialisasi status semua node ke sleep
for {set i 0} {$i < $val(nn)} {incr i} {
    set status($i) "sleep"
}

#Energy Model
for {set i 1} {$i<$val(nn)} {incr i} {
	set energy($i) [myRand 7 15]
}

set Etx 500e-6
set Erx 500e-6
set Eidle 100e-6
set tp 1.0

proc PowerDissipation {} {
    global Etx Erx Eidle sn energy ns n status tp val

    for {set i 1} {$i < $val(nn)} {incr i} {
        # Periksa status node dan kurangi energi sesuai mode
        if {$status($i) == "sleep"} {
            set energy($i) [expr $energy($i) - $Eidle]
        } elseif {$status($i) == "active"} {
            set energy($i) [expr $energy($i) - $Etx]
        } elseif {$status($i) == "listen"} {
            set energy($i) [expr $energy($i) - $Erx]
        }

        # Pastikan energi tidak menjadi negatif
        if {$energy($i) < 0} {
            set energy($i) 0
        }

        # Tandai node dengan status saat ini
        $ns at [$ns now] "$n($i) label $status($i)"
    }

    # Jadwalkan ulang PowerDissipation untuk siklus berikutnya
    $ns at [expr [$ns now] + $tp] "PowerDissipation"
}

proc TransmissionPower {l node} {
    global Etx energy ns n status
    if {$status($node) == "sleep"} {
        puts "Node $node is in sleep mode and cannot transmit."
        return
    }
    set energy($node) [expr $energy($node)-($Etx*$l)]
    if {$energy($node)<0} {
        set energy($node) 0 
    }
    $ns at [$ns now] "$n($node) label active"
    set status($node) "active"
}

proc ReceivingPower {l node} {
    global sn Erx energy ns n status

    # Periksa apakah node sedang dalam mode sleep
    if {$status($node) == "sleep"} {
        puts "Node $node is in sleep mode and cannot receive data."
        return
    }

    # Mengurangi energi untuk menerima data
    set energy($node) [expr $energy($node) - ($Erx * $l)]
    if {$energy($node) < 0} {
        set energy($node) 0
    }

    # Menandai node sebagai sedang menerima data
    $ns at [$ns now] "$n($node) label receive"

    # Perbarui status node
    set status($node) "receive"
}

# stray closing brace removed
   # $ns at [$ns now] "$n($i) label active"
    #set status($node) "active"


    # Mengurangi energi untuk menerima data
# stray closing brace removed

    # Menandai node sebagai sedang menerima data
    #$ns at [$ns now] "$n($i) label receive"

    # Perbarui status node
    #set status($node) "receive"

#Grid Partition
# Mendefinisikan pembagian grid untuk node ke dalam tiga bagian/ area berbeda
# Area atau bagian pertama (en1), yang mencakup node dengan indeks tertentu
set en1 [list 21 22 23 28 29 34 35 36]
# Area atau bagian kedua (en2), yang mencakup node dengan indeks tertentu
set en2 [list 13 14 15 16 17 20 24 27 30 33 37 40 41 42 43 44]
# Area atau bagian ketiga (en3), yang mencakup node dengan indeks tertentu
set en3 [list 5 6 7 8 9 10 11 12 18 19 25 26 31 32 38 39 45 46 47 48 49 50 51 52]

# Loop untuk mengatur warna node
# Iterasi melalui setiap elemen dalam daftar en1, yang disimpan dalam variabel len
foreach len $en1 {
   # Mengatur warna awal node dengan indeks len menjadi 'hotpink'
	$n($len) color hotpink
   # Menjadwalkan perubahan warna node menjadi 'darkgreen' pada waktu simulasi 0.0
		$ns at 0.0 "$n($len) color darkgreen"	
		}
# Iterasi melalui setiap elemen dalam daftar en2, yang disimpan dalam variabel len
		foreach len $en2 {
# Mengatur warna awal node dengan indeks len menjadi 'hotpink'
	$n($len) color hotpink
   # Menjadwalkan perubahan warna node menjadi 'darkgreen' pada waktu simulasi 0.0
		$ns at 0.0 "$n($len) color darkgreen"	
		}
# Iterasi melalui setiap elemen dalam daftar en3, yang disimpan dalam variabel len	
foreach len $en3 {
# Mengatur warna awal node dengan indeks len menjadi 'hotpink'
	$n($len) color hotpink
# Menjadwalkan perubahan warna node menjadi 'darkgreen' pada waktu simulasi 0.0
		$ns at 0.0 "$n($len) color darkgreen"	
		}

# Neighbor Node Discovery - Menemukan node tetangga untuk setiap node berdasarkan jarak
# Loop untuk iterasi setiap node i dari 0 hingga jumlah total node nn
for {set i 0} {$i<$val(nn)} {incr i} {
# Inisialisasi daftar kosong untuk tetangga yang ditemukan kembali (recoverNL) untuk node i
	set recoverNL($i) [list]
    # Inisialisasi daftar kosong CDS (Connected Dominating Set) untuk node i
	set CDS($i) [list]
	set CDS1($i) [list]
  # Mendapatkan posisi X dari node i
	set x_pos1 [$n($i) set X_]
  # Mendapatkan posisi Y dari node i
	set y_pos1 [$n($i) set Y_]
 # Loop untuk iterasi node j dari 0 hingga jumlah total node nn untuk menemukan tetangga node i
	for {set j 0} {$j<$val(nn)} {incr j} {
    # Memastikan j bukan node yang sama dengan i
		if {$j!=$i} {
# Mendapatkan posisi X dari node j
			set x_pos2 [$n($j) set X_]
  # Mendapatkan posisi Y dari node j
			set y_pos2 [$n($j) set Y_]
 # Menghitung selisih posisi X antara node i dan j
			set x_pos [expr $x_pos1-$x_pos2]
  # Menghitung selisih posisi Y antara node i dan j
			set y_pos [expr $y_pos1-$y_pos2]
# Menghitung jarak kuadrat antara node i dan j
			set v [expr $x_pos*$x_pos+$y_pos*$y_pos]
# Mengambil akar kuadrat dari v untuk mendapatkan jarak (d) antara node i dan j
			set d [expr sqrt($v)]
    # Menyimpan jarak d antara node i dan j dalam array nd
			set nd($i,$j) $d
 # Menampilkan jarak antara node i dan j di output
			puts "Distance from $i to $j:$d"
# Jika jarak antara node i dan j kurang dari 250, j ditambahkan sebagai tetangga dari i
			# puts "Distance from $i to $j:$dist"
			if {$d<250} {
				$n($i) add-neighbor $n($j)
			}
		}
	}
 # Mendapatkan daftar semua tetangga untuk node i
	set neighbor1 [$n($i) neighbors]
# Loop melalui setiap tetangga dari node i
	foreach nb1 $neighbor1 {
# Menyimpan waktu simulasi saat ini
		set now [$ns now]
# Menampilkan daftar tetangga untuk node i
		puts "The neighbor for node $i are:$nb1"
   # Mendapatkan ID dari tetangga saat ini nb1
		set idv [$nb1 id]
# Menampilkan ID tetangga
		puts "$idv"	
# Menambahkan ID tetangga ke daftar CDS untuk node i
		lappend CDS($i) $idv
	}
}

#users input
# Menampilkan pesan kepada pengguna untuk memasukkan ID node (antara 5 hingga 52) yang akan mengirim pesan ke node sink
puts "Enter the  node ID(5 t0 52) to transmit the message to the sink node"
# Memastikan output segera muncul di layar tanpa menunggu buffer
flush stdout
# Mengambil input dari pengguna untuk ID node dan menyimpannya di variabel nid
set nid [gets stdin]
# Mengatur warna node yang sesuai dengan ID yang dimasukkan pengguna menjadi orange, sebagai tanda visual
$n($nid) color orange
# Menjadwalkan perubahan warna node tersebut menjadi #ff00ff (magenta) pada waktu simulasi 0.3 detik
$ns at 0.3 "$n($nid) color #ff00ff"

# Menampilkan pesan kepada pengguna untuk memasukkan ID node (antara 0 hingga 5) yang akan menerima pesan dari node sensor sumber
puts "Enter the  node ID(0 t0 5) to receive the message from the source sensor node"
# Memastikan output segera muncul di layar tanpa menunggu buffer
flush stdout
# Mengambil input dari pengguna untuk ID node dan menyimpannya dalam variabel center
set center [gets stdin]
# Mengatur warna node yang sesuai dengan ID yang dimasukkan pengguna menjadi orange sebagai tanda visual
$n($center) color orange
# Menandai node yang dipilih sebagai "SINK" pada waktu simulasi 0.0 detik (di awal simulasi)
$ns at 0.0 "$n($center) label SINK"
# Menambahkan tanda tambahan pada node tersebut berupa ikon hexagon berwarna biru pada waktu simulasi 0.0 detik
$ns at 0.0 "$n($center) add-mark m3 blue hexagon"

# Membuat tabel rute terbalik (reverse route) untuk setiap pasangan node
# Loop untuk setiap node i dari 0 hingga jumlah total node nn
for {set i 0} {$i<$val(nn)} {incr i} {
# Loop untuk setiap node j dari 0 hingga jumlah total node nn
	for {set j 0} {$j<$val(nn)} {incr j} {
 # Memastikan bahwa i dan j bukan node yang sama
		if {$i!=$j} {
# Inisialisasi daftar rute terbalik kosong untuk pasangan node (j, i)
			set rroute($j,$i) [list]
		}
	}
}
# Membuat tabel rute untuk setiap pasangan node
# Loop untuk setiap node i dari 0 hingga jumlah total node nn
for {set i 0} {$i<$val(nn)} {incr i} {
# Loop untuk setiap node j dari 0 hingga jumlah total node nn
	for {set j 0} {$j<$val(nn)} {incr j} {
 # Memastikan bahwa i dan j bukan node yang sama
		if {$i!=$j} {
 # Inisialisasi daftar rute kosong untuk pasangan node (j, i)
			set route($j,$i) [list]
		}
	}
}

# Mendefinisikan prosedur sleepMode untuk mengurangi energi node saat dalam mode tidur
proc sleepMode {node} {
# Mendeklarasikan variabel global yang akan digunakan dalam prosedur
    global energy ns n
 # Mengurangi energi node yang diberikan sebesar 0.003 (pengurangan untuk mode tidur)
  # Menandai node saat ini dengan label "SleepMode" pada waktu simulasi sekarang
    set energy($node) [expr $energy($node)-0.003]
    $ns at [$ns now] "$n($node) label SleepMode"
}

# Mendefinisikan prosedur activeMode untuk mengurangi energi node saat dalam mode aktif (transfer data)
proc activeMode {node} {
# Mendeklarasikan variabel global yang akan digunakan dalam prosedur
	global energy ns n
  # Mengurangi energi node yang diberikan sebesar 81 (pengurangan untuk mode aktif/transfer)
 # Menandai node saat ini dengan label "TransferMode" pada waktu simulasi sekarang
	 $ns at [$ns now] "$n($node) label TransferMode"
	
}
# Mendefinisikan prosedur listenMode untuk mengurangi energi node saat dalam mode mendengarkan
proc listenMode {node} {
# Mendeklarasikan variabel global yang akan digunakan dalam prosedur
	 global energy ns n
# Mengurangi energi node yang diberikan sebesar 30 (pengurangan untuk mode mendengarkan)
    # Menandai node saat ini dengan label "ListenMode" pada waktu simulasi sekarang
	$ns at [$ns now] "$n($node) label ListenMode"
	}
# Loop untuk mengatur semua node dalam mode tidur di awal simulasi
for {set i 0} {$i<$val(nn)} {incr i} {
  # Memanggil prosedur sleepMode untuk setiap node dengan indeks i
	sleepMode $i
}

# Fungsi Q-Learning
# Pilih aksi (epsilon-greedy)
proc choose_action {node current_state} {
    global Q epsilon actions
    # Dengan probabilitas epsilon, memilih aksi secara acak (eksplorasi)
    if {[expr rand()] < $epsilon} {
        return [lindex $actions [expr int(rand()*3)]]
    } else {
        # Jika tidak, memilih aksi dengan nilai Q terbesar (eksploitasi)
        set max_q -99999
        set best_action ""
        foreach action $actions {
            set q $Q($node,$current_state,$action)
            if {$q > $max_q} {
                set max_q $q
                set best_action $action
            }
        }
        return $best_action
    }
}

# Fungsi update Q-value dan distribusi probabilitas sub-slot (Algorithm 2)
proc update_transmit_subslot {node selected reward} {
    global m Qslot x zeta epsilon_tx

    # Update Q-value untuk sub-slot yang dipilih
    set p_avg 0.0
    # Inisialisasi rata-rata Q-value tertimbang probabilitas
    for {set j 0} {$j < $m} {incr j} {
        set p_avg [expr $p_avg + $x($node,$j) * $Qslot($node,$j)]
        # Hitung p_avg = sum(x * Qslot)
    }
    set Qslot($node,$selected) [expr $Qslot($node,$selected) + $zeta * ($reward - $p_avg)]
    # Update Q-value sub-slot terpilih

    # Update distribusi probabilitas x(i)
    set max_q -99999
    # Inisialisasi nilai maksimum Q
    set max_idx 0
    # Inisialisasi indeks sub-slot dengan Q terbesar
    for {set j 0} {$j < $m} {incr j} {
        if {$Qslot($node,$j) > $max_q} {
            set max_q $Qslot($node,$j)
            # Simpan nilai Q terbesar
            set max_idx $j
            # Simpan indeks sub-slot dengan Q terbesar
        }
    }

    for {set j 0} {$j < $m} {incr j} {
        if {$j == $max_idx} {
            set x($node,$j) [expr (1 - $epsilon_tx) + ($epsilon_tx / $m)]
            # Probabilitas lebih tinggi untuk sub-slot terbaik
        } else {
            set x($node,$j) [expr $epsilon_tx / $m]
            # Probabilitas lebih kecil untuk sub-slot lain
        }
    }

    # Normalisasi agar total 1
    set total 0.0
    # Inisialisasi total probabilitas
    for {set j 0} {$j < $m} {incr j} {
        set total [expr $total + $x($node,$j)]
        # Hitung total probabilitas
    }
    for {set j 0} {$j < $m} {incr j} {
        set x($node,$j) [expr $x($node,$j) / $total]
        # Normalisasi setiap probabilitas x
    }
}

proc choose_subslot {node} {
    # Prosedur untuk memilih subslot berdasarkan probabilitas x
    global m x
    # Menggunakan variabel global m (jumlah slot) dan x (probabilitas)
    set rand_val [expr rand()]
    # Menghasilkan nilai acak antara 0 dan 1
    set cumulative 0.0
    # Inisialisasi variabel kumulatif untuk penjumlahan probabilitas
    for {set j 0} {$j < $m} {incr j} {
        # Loop untuk setiap slot j dari 0 sampai m-1
        set cumulative [expr {$cumulative + $x($node,$j)}]
        # Tambahkan probabilitas x(node, j) ke cumulative
        if {$rand_val <= $cumulative} {
            # Jika rand_val kurang dari atau sama dengan cumulative
            return $j
            # Kembalikan indeks slot j yang terpilih
        }
    }
    return [expr $m - 1] ;# fallback jika tidak terpilih
    # Jika tidak ada yang terpilih, kembalikan slot terakhir
}

# Update Q-value
proc update_qvalue {node current_state action reward next_state} {
    global Q learning_rate discount_factor actions
    # mencari nilai Q maksimum untuk state berikutnya (next_state) di semua aksi
    set max_q_next -99999
    # Inisialisasi nilai maksimum Q untuk next_state
    foreach next_action $actions {
        set q $Q($node,$next_state,$next_action)
        # Ambil Q-value untuk setiap aksi di next_state
        if {$q > $max_q_next} {
            set max_q_next $q
            # Simpan nilai Q terbesar
        }
    }
    # mengambil Q-value lama untuk kombinasi state dan aksi saat ini
    set old_q $Q($node,$current_state,$action)
    # menghitung Q-value baru dengan rumus Q-Learning:
    # Q(s,a) = Q(s,a) + alpha * (reward + gamma * maxQ(s',a') - Q(s,a))
    set new_q [expr {$old_q + $learning_rate * ($reward + $discount_factor * $max_q_next - $old_q)}]
    # menyimpan Q-value yang baru
    set Q($node,$current_state,$action) $new_q
}

# Perbaikan prosedur utama Q-Learning
proc QLearningNodeMode {} {
    global ns val status actions energy n

    # Loop untuk setiap node dalam jaringan
    for {set i 0} {$i < $val(nn)} {incr i} {
        set current_state $status($i)
        set action [choose_action $i $current_state]

        # menentukan reward berdasarkan aksi yang dipilih
        if {$action == "sleep"} {
            # Perbaikan: gunakan energy($i) dan panjang tetangga dari CDS
            set this_energy $energy($i)
            set neighbors [llength $::CDS($i)]
            # Jika ada fungsi calculate_pwake, gunakan, jika tidak, gunakan reward default
            if {[info procs calculate_pwake] != {}} {
                set pwake [calculate_pwake $this_energy $neighbors]
                set reward [expr {1 + 0.1 * $pwake}]
                if {$reward > 1.0} { set reward 1.0 }
                if {$reward < -1.0} { set reward -1.0 }
            } else {
                set reward 1
            }
            sleepMode $i
        } elseif {$action == "listen"} {
            set reward 0.5
            listenMode $i
        } elseif {$action == "transmit"} {
            set reward -1
            activeMode $i
            set selected_slot [choose_subslot $i]
            update_transmit_subslot $i $selected_slot $reward
        }

        set next_state $action
        update_qvalue $i $current_state $action $reward $next_state

        # Approximate neighbor policy (sederhana: salin Q tetangga terdekat)
        set neighbor_list $::CDS($i)
        foreach nb $neighbor_list {
            foreach act $actions {
                set Q($i,$current_state,$act) [expr 0.5 * $Q($i,$current_state,$act) + 0.5 * $Q($nb,$current_state,$act)]
            }
        }

        set k 10
        set learning_rate [expr {$learning_rate * (1.0 / (1 + $k))}]

        set status($i) $next_state
    }
    $ns at [expr [$ns now] + 1.0] "QLearningNodeMode"
}

# Menjadwalkan pemanggilan pertama prosedur QLearningNodeMode pada waktu simulasi 0.0 detik
# Prosedur ini akan berjalan periodik dan mengatur mode node menggunakan Q-Learning
#Mulai Q-Learning
$ns at 0.0 "QLearningNodeMode"


#Route Path Discovery
# Mencetak header tabel rute pada output atau file
	puts $rt "---------------------------------------------------"
	puts $rt "RouteFrom 	RouteTo		Route"
	puts $rt "---------------------------------------------------"
# Loop untuk menentukan jalur rute dari setiap node sumber (j) ke setiap node tujuan (des)	
for {set des 0} {$des<$val(nn)} {incr des} {
		for {set j 0} {$j<$val(nn)} {incr j} {
# Pastikan bahwa tujuan (des) bukan sumber yang sama (j)
			if {$des!=$j} {
 # Inisialisasi array flg untuk menandai jalur yang digunakan
				for {set i 0} {$i<$val(nn)} {incr i} {
					set flg($i) 0
				}
 # Set node awal (s) sebagai sumber dan inisialisasi variabel
				set s $j
				set flag 0
				set RN $s
 # Menampilkan pesan rute dari node sumber ke tujuan
				puts "Route from $j to $des"
# Loop untuk menemukan rute dari sumber ke tujuan
				while {$RN!=$des} {
					puts "RN:$RN"
     # Memeriksa apakah tujuan (des) adalah tetangga dari node saat ini (RN)
					foreach rn $CDS($RN) {
						if {$rn==$des} {
							set flag 1
						}
					}
# Jika tujuan ditemukan sebagai tetangga, set RN1 sebagai tujuan
					if {$flag==1} {
						set RN1 $des
					} else {
# Mendapatkan posisi X dan Y dari tujuan (des)
						set x_pos1 [$n($des) set X_]
						set y_pos1 [$n($des) set Y_]
 # Membuat daftar jarak kosong dL dan mendapatkan waktu simulasi saat ini
						set dL [list]
						set t [$ns now]
       # Menentukan jarak antara node RN dan setiap tetangganya
						foreach rnod $CDS($RN) {
							set x_pos2 [$n($rnod) set X_]
							set y_pos2 [$n($rnod) set Y_]
							set x_pos [expr $x_pos1-$x_pos2]
							set y_pos [expr $y_pos1-$y_pos2]
							set v [expr $x_pos*$x_pos+$y_pos*$y_pos]
							set D2 [expr sqrt($v)]							
							lappend dL $D2
							set dis($des,$rnod) $D2
						}
# Mengurutkan daftar jarak secara menaik untuk menemukan jarak minimum
						set dis1 [lsort -real $dL]
						foreach di $dis1 {
							puts "D: $di"
						}
        # Menentukan jarak terpendek dan menyimpan node tetangga terdekat sebagai RN1
						set mindis [lindex $dis1 0]
						puts "mindis $mindis"
						foreach ni $CDS($RN) {
								if {$mindis==$dis($des,$ni)} {
									set RN1 $ni
									set flg($ni) 1
									puts "Node:$RN1"
								}
						}
					}
   # Memperbarui RN ke RN1 untuk langkah berikutnya dalam pencarian rute
					set RN $RN1
					puts "Source $j"
					puts "DES:$des"
# Menambahkan RN ke daftar rute untuk pasangan node (sumber, tujuan)
					lappend route($j,$des) $RN
					 puts "$RN"
					# break
				}
 # Mencetak rute dari sumber ke tujuan pada output atau file
				puts $rt "$j		$des		$route($j,$des)"
			}			
		}
	}


####Agents Definition         
# Mendefinisikan prosedur attach-cbr-traffic untuk menghubungkan lalu lintas CBR ke agen UDP pada node
#CBR (Constant Bit Rate) = jenis lalu lintas jaringan di mana data dikirim dengan kecepatan tetap atau interval waktu yang konstan.
proc attach-cbr-traffic {node sink size interval} {
 # Mendeklarasikan variabel global ns untuk simulasi
	global ns
# Membuat agen UDP baru sebagai sumber lalu lintas
	set source [new Agent/UDP]
 # Mengatur kelas agen UDP ke 2 (untuk tujuan klasifikasi)
	$source set class_ 2
 # Melampirkan agen UDP (source) ke node yang ditentukan
	$ns attach-agent $node $source
# Membuat aplikasi Traffic/CBR (Constant Bit Rate) baru
	set traffic [new Application/Traffic/CBR]
   # Mengatur ukuran paket untuk lalu lintas CBR
	$traffic set packetSize_ $size
 # Mengatur interval pengiriman paket untuk lalu lintas CBR
	$traffic set interval_ $interval
 # Melampirkan aplikasi CBR ke agen UDP (source)
	$traffic attach-agent $source
    # Menghubungkan agen sumber (source) ke agen tujuan (sink) untuk mengaktifkan komunikasi
	$ns connect $source $sink
# Mengembalikan objek traffic yang dibuat untuk referensi lebih lanjut
	return $traffic
}


####Send the alarm to center node       

# Menetapkan waktu awal pengiriman alarm
set timv 0.5
# Membuat agen pemantau kerugian paket untuk mengukur kehilangan data
set null3 [new Agent/LossMonitor]
# Skema penyiaran (broadcast) untuk node yang mengirim alarm ke node tetangga
for {set i 5} {$i<$val(nn)} {incr i} {
# Iterasi melalui setiap tetangga dari node i yang disimpan dalam daftar CDS($i)
    # CDS (Connected Dominating Set) = konsep dalam jaringan, khususnya pada jaringan nirkabel, yang digunakan untuk mendefinisikan subset dari node yang memiliki konektivitas dan cakupan yang efektif dalam jaringan
		foreach nein $CDS($i) {
 # Menambahkan anotasi pada waktu tertentu untuk mencatat pengiriman paket 'temperature' dari node i ke tetangganya nein
			$ns at $timv "$ns trace-annotate \"The node $i broadcast the 'temperature' Packet to its neighbour $nein at timeslot $timv\""
# Melampirkan agen LossMonitor ke node tetangga untuk memantau kerugian paket
			$ns attach-agent $n($nein) $null3
 # Membuat lalu lintas CBR dengan ukuran paket 10 dan interval 0.05 untuk mengirim pesan dari node i ke agen null3
        # CBR (Constant Bit Rate) = tipe lalu lintas jaringan di mana data dikirim dengan kecepatan atau interval waktu yang konstan.
			set cbr1 [attach-cbr-traffic $n($i) $null3 10 0.05]
 # Menambahkan tanda pada node i (pengirim) berupa kotak merah (#f6546a) pada waktu simulasi saat ini
			$ns at $timv "$n($i) add-mark m11 #f6546a square"
        # Menambahkan tanda pada node nein (penerima) berupa warna orange pada waktu simulasi saat ini
			$ns at $timv "$n($nein) add-mark m1 orange"
# Mengaktifkan mode aktif untuk node i pada waktu simulasi saat ini
			$ns at $timv "activeMode $i"
 # Mengaktifkan mode mendengarkan untuk node nein pada waktu simulasi saat ini
	        $ns at $timv "listenMode $nein"
 # Memulai lalu lintas CBR pada waktu simulasi saat ini
			$ns at $timv "$cbr1 start"
 # Menghentikan lalu lintas CBR setelah 0.10 detik dari waktu awal
			$ns at [expr $timv+0.10] "$cbr1 stop"
 # Mengaktifkan mode tidur untuk node i setelah 0.10 detik dari waktu awal
			$ns at [expr $timv+0.15] "sleepMode $i"
 # Mengaktifkan mode tidur untuk node nein setelah 0.15 detik dari waktu awal
			$ns at [expr $timv+0.15] "sleepMode $nein"
 # Menghapus tanda dari node i setelah 0.10 detik dari waktu awal
			$ns at [expr $timv+0.10] "$n($i) delete-mark m11"
 # Menghapus tanda dari node nein setelah 0.10 detik dari waktu awal
			$ns at [expr $timv+0.10] "$n($nein) delete-mark m1"
		}
		set timv [expr $timv+0.25]
# Menambahkan jeda waktu 0.25 detik sebelum memproses node berikutnya
	}

# Mengatur waktu awal transmisi alarm dari node sumber ke node sink
set tim $timv
# Menambahkan anotasi untuk mencatat bahwa node sumber (sensor) dengan ID $nid sedang mengirim paket ke node sink
# Anotasi = catatan atau penjelasan tambahan yang ditambahkan ke dalam teks, kode, atau simulasi
$ns at $tim "$ns trace-annotate \"The source sensor $nid transmitting packet to the sink node\""
# Menambahkan anotasi untuk mencatat bahwa sensor menggunakan jalur tertentu untuk mencapai node sink
$ns at $tim "$ns trace-annotate \"The sensor use the following path to reach the Sink node\""
# Menambahkan anotasi jalur yang akan digunakan oleh sensor untuk mencapai node sink
$ns at $tim "$ns trace-annotate \"$route($nid,$center)\""
# Menyimpan ID node sumber dalam variabel soc untuk digunakan dalam iterasi
set soc $nid
# Loop untuk setiap node di jalur rute dari node sumbe16 tr (sensor) ke node sink
foreach rot $route($nid,$center) {
# Membuat agen LossMonitor baru untuk memantau kerugian paket pada node dalam rute
	set null [new Agent/LossMonitor]
 # Melampirkan agen LossMonitor ke node saat ini dalam rute
	$ns attach-agent $n($rot) $null
 # Membuat lalu lintas CBR dengan ukuran paket 512 dan interval 0.05 untuk transmisi data dari node sumber ke node dalam rute
    # CBR (Constant Bit Rate) adalah jenis lalu lintas jaringan di mana data dikirim dengan kecepatan dan interval yang tetap atau konstan
	set cbr [attach-cbr-traffic $n($soc) $null 512 0.05]
 # Menambahkan tanda visual pada node dalam rute (rot) dengan warna hijau (#00ff7f)
	$ns at 0.3 "$n($rot) add-mark m2 #00ff7f"
# Mengaktifkan mode aktif untuk node sumber pada waktu simulasi saat ini
	$ns at $tim "activeMode $soc"
 # Mengaktifkan mode mendengarkan untuk node dalam rute pada waktu simulasi saat ini
	$ns at $tim "listenMode $rot"
 # Memulai lalu lintas CBR pada waktu simulasi saat ini
	$ns at $tim "$cbr start"
# Menghentikan lalu lintas CBR setelah 2.5 detik dari waktu awal
	$ns at [expr $tim+2.5] "$cbr stop"
 # Mengaktifkan mode tidur untuk node sumber setelah 2.5 detik dari waktu awal
	$ns at [expr $tim+2.5] "sleepMode $soc"
  # Menghapus tanda visual dari node dalam rute setelah 2.5 detik dari waktu awal
	$ns at [expr $tim+2.5] "$n($rot) delete-mark m2"
  # Menambahkan 2.5 detik ke variabel tim untuk waktu simulasi berikutnya
	set tim [expr $tim+2.5]
 # Memperbarui node sumber (soc) ke node saat ini dalam rute untuk langkah berikutnya
	set soc $rot
}
# Mengatur mode tidur untuk node sumber (soc) pada waktu saat ini
$ns at $tim "sleepMode $soc"
# Menambahkan anotasi yang menyatakan bahwa node sink menyiarkan laporan ke semua node
# foreach rot1 $route($nid,$center) {
	# $ns at 7.0 "$n($rot1) delete-mark m1"
	# $ns at 7.0 "sleepMode $rot1"
# }
$ns at $tim "$ns trace-annotate \"The Sink node broadcasting the report to all the nodes\""
# Menambahkan anotasi yang mencantumkan jalur yang diikuti oleh pesan dari node sumber ke node sink
$ns at $tim "$ns trace-annotate \"$route($nid,$center)\""
# Penjadwalan penyiaran alarm oleh node sink secara bertingkat dengan jeda waktu antar level
#center node broadcast the alarm
#level by level offset schedule
set time $tim
# Menggunakan fungsi myRand untuk memilih salah satu dari tiga kelompok node (en1, en2, en3) secara acak untuk menerima alarm
set t [myRand 0 2]
if {$t==0} {
set f $en1
} elseif {$t==1} {
set f $en2
} else {
set f $en3
}
# Menyiarkan pesan dari node sink ke setiap node dalam grup terpilih (f)
foreach nod $f {
	set soc $center
 # Mengirim pesan dari node sink ke setiap node dalam rute ke node tujuan (nod)
	foreach rot $route($center,$nod) {
 # Membuat agen LossMonitor baru untuk memantau kerugian paket pada node dalam rute
	set null1 [new Agent/LossMonitor]
	$ns attach-agent $n($rot) $null1
 # Membuat lalu lintas CBR untuk transmisi data dari node sink ke node dalam rute
	set cbr [attach-cbr-traffic $n($soc) $null1 512 0.05]
  # Menambahkan tanda visual pada node dalam rute dengan warna hijau
	$ns at $time "$n($rot) add-mark m1 green"
  # Menambahkan anotasi yang mencatat pengiriman pesan dari sensor (soc) ke sensor tujuan (rot)
	$ns at $time "$ns trace-annotate \"The sensor ($soc) gossiping the messge to the sensor node ($rot)\""
 # Mengaktifkan mode aktif untuk node sumber dan mode mendengarkan untuk node tujuan pada waktu simulasi saat ini
	$ns at $time "activeMode $soc"
	$ns at $time "listenMode $rot"
  # Memulai lalu lintas CBR pada waktu simulasi saat ini
	$ns at $time "$cbr start"
 # Menghentikan lalu lintas CBR dan menghapus tanda setelah 2.5 detik
	$ns at [expr $time+2.5] "$cbr stop"
	$ns at [expr $time+2.5] "sleepMode $soc"
	$ns at [expr $time+2.5] "$n($rot) delete-mark m1"
 # Memperbarui waktu untuk iterasi berikutnya
	set time [expr $time+2.5]
 # Memperbarui node sumber untuk iterasi berikutnya
	set soc $rot
}
  # Mengatur mode tidur untuk node sumber setelah selesai
$ns at $time "sleepMode $soc"
}

# Normalize policy distribution π(s)
proc NormalizePolicy {pi} {
    set m [llength $pi]
    # Hitung jumlah elemen dalam list pi (jumlah aksi)
    set d 1.0
    # Inisialisasi nilai minimum d dengan 1.0
    foreach val $pi {
        if {$val < $d} {
            set d $val
            # Cari nilai terkecil dalam distribusi pi
        }
    }
    set c0 0.5
    # Konstanta batas bawah distribusi
    set delta 0.001
    # Nilai ambang minimum
    if {$d < $delta} {
        set rho [expr $c0 / ($c0 - $delta)]
        # Hitung faktor penyesuaian jika ada nilai di bawah delta
        for {set k 0} {$k < $m} {incr k} {
            set old [lindex $pi $k]
            # Ambil nilai lama pada indeks k
            set newval [expr $c0 - $rho * ($c0 - $old)]
            # Hitung nilai baru dengan penyesuaian
            lset pi $k $newval
            # Set nilai baru pada indeks k
        }
    }
    set r 0.0
    # Inisialisasi total penjumlahan
    foreach val $pi { set r [expr $r + $val] }
    # Hitung total seluruh nilai distribusi
    for {set k 0} {$k < $m} {incr k} {
        lset pi $k [expr [lindex $pi $k] / $r]
        # Normalisasi setiap nilai agar total menjadi 1
    }
    return $pi
    # Kembalikan distribusi pi yang sudah dinormalisasi
}

#Performace evaluation
set dist 0
set vtt 3
set ott 5
set unt 0
set pnt 0.4
set vrbr 5
set orbr 2
while {$dist<=60} {
	puts $vttf "$dist $vtt"
	puts $ottf "$dist $ott"
	
	puts $untf "$dist $unt"
	puts $pntf "$dist $pnt"
	
	puts $vrbtf "$dist $vrbr"
	puts $orbtf "$dist $orbr"
	set vtt [expr $vtt+[myRandfloat 0.4 0.6 ]]
	set ott [expr $ott+[myRandfloat 0.4 0.6 ]]
	set unt [expr $unt+[myRandfloat 0.09 0.1 ]]
	set pnt [expr $pnt+[myRandfloat 0.09 0.1 ]]
	set vrbr [expr $vrbr+[myRand 2 3]]
	set orbr [expr $orbr+[myRand 2 3]]
	set dist [expr $dist+10]
}

set time1 20
set nnd 0
set nnd1 0
while {$time1<=80} {
	puts $nndf "$time1 $nnd"
	puts $nndf1 "$time1 $nnd1"
	if {($time1<22) || ($time1>30)} {
		set nnd [expr $nnd+[myRand 0 2]]
		set nnd1 [expr $nnd1+[myRand 0 2]]
	}
	set time1 [expr $time1+2]
}

set dr 1
set lt 9
set lt1 13
while {$dr<=10} {
	puts $ltf "$dr $lt"
	puts $ltf1 "$dr $lt1"
	set lt [expr $lt-[myRand 1 2]]
	set lt1 [expr $lt1-[myRand 1 2]]
	set dr [expr $dr+1]
}

# Mendefinisikan prosedur 'finish' untuk menyelesaikan simulasi
proc finish {} {
    global ns tracefile namfile
    # Memastikan objek tracefile dan namfile tersedia
    if {[info exists tracefile]} {
        $ns flush-trace
        close $tracefile
    }
    if {[info exists namfile]} {
        close $namfile
    }
   # Jalankan NAM untuk memvisualisasikan simulasi
    if {[file exists out.nam]} {
        exec nam out.nam &
    } else {
        puts "Error: File out.nam tidak ditemukan."
    }

    # Keluar dari simulasi dengan benar
    exit 0
}

# Menyetel setiap node ke keadaan awal pada waktu berhenti simulasi
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n($i) reset"
}

# Menambahkan perintah untuk menyelesaikan simulasi pada waktu berhenti
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
# Menjalankan simulasi
$ns run
