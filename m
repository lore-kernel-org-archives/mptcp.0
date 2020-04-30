Content-Type: multipart/mixed; boundary="===============4270548567424840450=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix uninitialized value access
Date: Thu, 30 Apr 2020 10:46:15 +0200
Message-ID: <9fafae0798a3e85c161d11c87c8ddf2862f2f201.camel@redhat.com>
In-Reply-To: 20200429.115602.466970698181251524.davem@davemloft.net
X-Status: 
X-Keywords:                  
X-UID: 4281

--===============4270548567424840450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi,

On Wed, 2020-04-29 at 11:56 -0700, David Miller wrote:
> From: Paolo Abeni <pabeni(a)redhat.com>
> Date: Wed, 29 Apr 2020 12:50:37 +0200
> =

> > Fixes: 20882e2cb904 ("mptcp: avoid flipping mp_capable field in syn_rec=
v_sock()")
> =

> [davem(a)localhost net]$ git describe 20882e2cb904
> fatal: Not a valid object name 20882e2cb904
> [davem(a)localhost net]$ =

> =

> Please fix this.

Thank you for double checking! =


I'm sorry, I dumbly used my local hash instead of the the '-net' one
I'll send a v2!

Cheers,

Paolo

--===============4270548567424840450==--
