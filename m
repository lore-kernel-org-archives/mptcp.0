Content-Type: multipart/mixed; boundary="===============4609463001459201410=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export e2366b97f1 ("[DO-NOT-MERGE]
 mptcp: enabled by default")
Date: Mon, 04 May 2020 23:07:55 +0800
Message-ID: <5eb02fcb.q2Er0w3BcSNtMzeG%lkp@intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4306

--===============4609463001459201410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : e2366b97f12783349fc57eca428b1213d8be0043
subject: [DO-NOT-MERGE] mptcp: enabled by default
date   : 2020-05-02 09:05:54 +0800
author : Matthieu Baerts <matthieu.baerts(a)tessares.net>


Test status of e2366b97f12783349fc57eca428b1213d8be0043 (compared to v5.6)
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
ts                     | 44   | 4    |          | 3    |   |            |  =
   |
| kselftests-net-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64=
-rhel-7.6-kselftests     | 33   | 8    |          | 1    |   |            |=
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
- kernel-selftests.bpf.test_sysctl.fail
- kernel-selftests.bpf.test_progs-no_alu32.fail

kselftests-net-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64-r=
hel-7.6-kselftests
---
- kernel-selftests.net.fib_tests.sh.fail
- kernel-selftests.net.test_vxlan_under_vrf.sh.fail
- kernel-selftests.net.fib_nexthop_multiprefix.sh.fail
- kernel-selftests.net.fib_nexthops.sh.fail
- kernel-selftests.net.altnames.sh.fail
- kernel-selftests.net.icmp_redirect.sh.fail
- kernel-selftests.net.txtimestamp.sh.fail
- kernel-selftests.net.vrf-xfrm-tests.sh.fail


--===============4609463001459201410==--
