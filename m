Content-Type: multipart/mixed; boundary="===============8054667764875859498=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] BPF-related self test failure with part1-v5 patches
Date: Mon, 06 Jan 2020 15:05:41 -0800
Message-ID: <alpine.OSX.2.21.2001061427530.8969@mjmartin-mac01.local>
X-Status: 
X-Keywords:                  
X-UID: 3256

--===============8054667764875859498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello everyone -


I received a 0day automated build email this morning related to patch 2/11 =

in our v5 patch set:

https://lists.01.org/hyperkitty/list/lkp(a)lists.01.org/thread/XB3HTABNGVKP=
J5QEF46NLIYN6AN5DNGD/

In summary, there's a test failure in the BPF self tests:

"""
# selftests: bpf: test_select_reuseport
...
# ######## IPv6/TCP LOOPBACK ########
# test_err_inner_map: unexpected result
# result: [0, 0, 0, 1, 0, 0]
# expected: [1, 0, 0, 0, 0, 0]
# check_results(343):FAIL:unexpected result expected_results[0] !=3D result=
s[0]
bpf_prog_linum:142
not ok 17 selftests: bpf: test_select_reuseport # exit=3D255
"""

It seems like a good idea to see if this is reproducible before sending =

v6, for a few reasons:

  * The commit noted is the one changing the size of the sock protocol field

  * This test is looking at protocol numbers

  * There are recently-merged commits in net-next refactoring this selftest =

that were not part of this CI build

  * I haven't found similar failures reported for other 0day builds


I run in to build problems, though - it looks like LLVM 10 is required to =

build the BPF tests, is anyone already set up with that version?


--
Mat Martineau
Intel
--===============8054667764875859498==--
