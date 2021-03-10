Content-Type: multipart/mixed; boundary="===============8947232605944385487=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Stable backport for DATA_FIN fix?
Date: Tue, 09 Mar 2021 17:59:45 -0800
Message-ID: <cec5e9c-b83-3880-f73a-5ba74b9d9844@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 8085

--===============8947232605944385487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Paolo -

Greg KH hit a conflict when applying "mptcp: fix DATA_FIN generation on =

early shutdown" to 5.10-stable.

(upstream commit for reference: =

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3Dd87903b63e3ce1eafaa701aec5cc1d0ecd0d84dc =

)

The conflict is fairly simple to resolve, do you think that one is worth =

the effort for v5.10.x? I can handle the backport.

--
Mat Martineau
Intel
--===============8947232605944385487==--
