Content-Type: multipart/mixed; boundary="===============3390729393439232751=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export 63f83c673f ("tcp: mptcp:
 use mptcp receive buffer space to select rcv window")
Date: Sat, 25 Apr 2020 12:12:24 +0800
Message-ID: <5ea3b8a8.6dKiOBmRJ2UnxHLS%lkp@intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4247

--===============3390729393439232751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : 63f83c673fdef4d111c74530abf056c9db3a6465
subject: tcp: mptcp: use mptcp receive buffer space to select rcv window
date   : 2020-04-25 09:08:36 +0800
author : Florian Westphal <fw(a)strlen.de>


Test status of 63f83c673fdef4d111c74530abf056c9db3a6465 (compared to v5.6)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--------------------------------------------------------------------------=
-----------------------+------+------+----------+------+---+------------+--=
---+
|                                                                          =
                       | pass | fail | unstable | skip | - | regression | f=
ix |
| kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftes=
ts                     | 41   | 7    |          | 3    |   |            |  =
   |
| kselftests-net-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64=
-rhel-7.6-kselftests     | 34   | 7    |          | 1    |   |            |=
     |
| kselftests-mptcp/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselft=
ests                   | 3    |      |          |      |   |            |  =
   |
| kselftests-cpufreq-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x8=
6_64-rhel-7.6-kselftests | 1    |      |          |      |   |            |=
     |
| kselftests-kvm-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64=
-rhel-7.6-kselftests     | 20   |      |          | 1    |   |            |=
     |
+--------------------------------------------------------------------------=
-----------------------+------+------+----------+------+---+------------+--=
---+

Fails
=3D=3D=3D=3D=3D
kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftests
---
- kernel-selftests.bpf.test_progs.fail
- kernel-selftests.bpf.test_align.fail
- kernel-selftests.bpf.test_tcpbpf_user.fail
- kernel-selftests.bpf.test_btf.fail
- kernel-selftests.bpf.test_sysctl.fail
- kernel-selftests.bpf.test_progs-no_alu32.fail
- kernel-selftests.bpf.test_lwt_ip_encap.sh.fail

kselftests-net-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64-r=
hel-7.6-kselftests
---
- kernel-selftests.net.fib_tests.sh.fail
- kernel-selftests.net.test_vxlan_under_vrf.sh.fail
- kernel-selftests.net.fib_nexthop_multiprefix.sh.fail
- kernel-selftests.net.altnames.sh.fail
- kernel-selftests.net.icmp_redirect.sh.fail
- kernel-selftests.net.txtimestamp.sh.fail
- kernel-selftests.net.vrf-xfrm-tests.sh.fail


--===============3390729393439232751==--
