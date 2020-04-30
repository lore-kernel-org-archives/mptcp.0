Content-Type: multipart/mixed; boundary="===============7392680029288496116=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net v2] mptcp: fix uninitialized value access
Date: Thu, 30 Apr 2020 12:34:47 -0700
Message-ID: <20200430.123447.1558476832887483140.davem@davemloft.net>
In-Reply-To: a94e83fdb29c9c3cdd971e3f57c434efa757c750.1588243772.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4292

--===============7392680029288496116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Thu, 30 Apr 2020 15:03:22 +0200

> tcp_v{4,6}_syn_recv_sock() set 'own_req' only when returning
> a not NULL 'child', let's check 'own_req' only if child is
> available to avoid an - unharmful - UBSAN splat.
> =

> v1 -> v2:
>  - reference the correct hash
> =

> Fixes: 4c8941de781c ("mptcp: avoid flipping mp_capable field in syn_recv_=
sock()")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied.
--===============7392680029288496116==--
