Content-Type: multipart/mixed; boundary="===============8558554224118286331=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export 100f845620 ("tcp: mptcp:
 use mptcp receive buffer space to select rcv window")
Date: Fri, 17 Apr 2020 11:26:15 +0800
Message-ID: <5e9921d7.igha0Pf8MHyU6Gks%lkp@intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4195

--===============8558554224118286331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : 100f845620e7d7d4f9e457945cb614a5991f0f2b
subject: tcp: mptcp: use mptcp receive buffer space to select rcv window
date   : 2020-04-17 09:16:42 +0800
author : Florian Westphal <fw(a)strlen.de>


Test status of 100f845620e7d7d4f9e457945cb614a5991f0f2b (compared to v5.6)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--------------------------------------------------------------------------=
-----+------+------+----------+------+---+------------+-----+
|                                                                          =
     | pass | fail | unstable | skip | - | regression | fix |
| kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftes=
ts   | 43   | 5    |          | 3    |   |            |     |
| kselftests-mptcp/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselft=
ests | 3    |      |          |      |   |            |     |
+--------------------------------------------------------------------------=
-----+------+------+----------+------+---+------------+-----+

Fails
=3D=3D=3D=3D=3D
kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftests
---
- kernel-selftests.bpf.test_progs.fail
- kernel-selftests.bpf.test_align.fail
- kernel-selftests.bpf.test_btf.fail
- kernel-selftests.bpf.test_sysctl.fail
- kernel-selftests.bpf.test_progs-no_alu32.fail


--===============8558554224118286331==--
