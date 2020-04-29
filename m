Content-Type: multipart/mixed; boundary="===============8917303499983252238=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix uninitialized value access
Date: Wed, 29 Apr 2020 11:56:02 -0700
Message-ID: <20200429.115602.466970698181251524.davem@davemloft.net>
In-Reply-To: c2b96b3751ccf64357d2c6f0e7d23908dda8a601.1588157274.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4279

--===============8917303499983252238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Wed, 29 Apr 2020 12:50:37 +0200

> Fixes: 20882e2cb904 ("mptcp: avoid flipping mp_capable field in syn_recv_=
sock()")

[davem(a)localhost net]$ git describe 20882e2cb904
fatal: Not a valid object name 20882e2cb904
[davem(a)localhost net]$ =


Please fix this.
--===============8917303499983252238==--
