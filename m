Content-Type: multipart/mixed; boundary="===============4113818141473858495=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] accept() not returning on current export branch?
Date: Wed, 24 Jun 2020 21:50:06 -0700
Message-ID: <alpine.OSX.2.23.453.2006242127020.47920@dnoeunx-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4793

--===============4113818141473858495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello -

I was trying to run some connection tests between two VMs (not the self =

tests) on the current export branch (tag export/20200624T164427), and ran =

in to some odd behavior. Here's the strace from the server side:

socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP) =3D 3
bind(3, {sa_family=3DAF_INET, sin_port=3Dhtons(55555), sin_addr=3Dinet_addr=
("0.0.0.0")}, 16) =3D 0
listen(3, 10)                           =3D 0
accept(3, ^C  <--- hangs here when peer is trying to connect

After SIGINT the rest of the output for accept is printed:
{sa_family=3DAF_INET, sin_port=3Dhtons(57828), sin_addr=3Dinet_addr("192.16=
8.122.168")}, [128->16]) =3D 4


With additional debug output, I can see that the call to =

ssock->ops->accept() in mptcp_accept isn't returning.

Self tests are working fine on this kernel, and the same test program has =

been working fine with older MPTCP code and with IPPROTO_TCP on this =

kernel. Sorry I haven't had a chance to bisect it yet or put together some =

minimal userspace code to repro, I can send that tomorrow. Kernel config =

is generated with 'make defconfig; make kvm_guest.config' and the required =

config options for the mptcp self test.

Anyone seen similar issues recently with accept()?

--
Mat Martineau
Intel
--===============4113818141473858495==--
