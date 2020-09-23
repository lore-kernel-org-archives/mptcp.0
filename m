Content-Type: multipart/mixed; boundary="===============0599166510985197258=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 1/3] mptcp: add add_addr_echo
 sysctl
Date: Wed, 23 Sep 2020 12:26:10 +0200
Message-ID: <d6f2c576a003194210726ff820df728640340bb8.camel@redhat.com>
In-Reply-To: 8d5a4bc3ef6b50f38e829f2cd5db881a30d41d5d.1600762109.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5988

--===============0599166510985197258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-09-22 at 16:12 +0800, Geliang Tang wrote:
> This patch added a new sysctl, named add_addr_echo, to control the
> ADD_ADDR
> echo ability.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

If I read the series correctly, this sysctl is only needed for self-
test's sake, right? can you instead drop the add_addr packet with some
netfilter rules ? possibly matching on TCP PROTO, TCP len =3D=3D 0 and the
appropriate packet len should be sufficient.

Disabling the echo would likely violate the RFC, I think that exposing
this ability to user-space would be too much even for unix
philosophy[1] ;)

Cheers,

Paolo

[1] http://www.anvari.org/fortune/Miscellaneous_Collections/412232_the-unix=
-philosophy-basically-involves-giving-you-enough-rope-to-hang-yourself.html

--===============0599166510985197258==--
