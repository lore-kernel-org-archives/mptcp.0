Content-Type: multipart/mixed; boundary="===============3976527342956410312=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 4/7] mptcp: avoid callback invocation when
 mptcp parent socket doesn't exist
Date: Wed, 15 Apr 2020 19:41:15 +0200
Message-ID: <4a58f8fa3a140be8b09bf6ee0605a5dcc4492858.camel@redhat.com>
In-Reply-To: 20200415171954.15321-5-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4187

--===============3976527342956410312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-04-15 at 19:19 +0200, Florian Westphal wrote:
> We can crash with a NULL dereference in case a packet arrives on the new
> socket before ctx->conn has been initialized.

I don't understand this race. I thought tcp_v4_syn_recv_sock() creates
the new socket and acquires the socket lock atomically, and ctx->conn =3D
new_msk happens in the same critical section ?!?

So no packets should reach the newly created socket while conn is NULL
!?!

but I do see a similar crash even if ctx->conn is not NULL, is a low,
invalid value.

I'll try to give this patch a spin in my testbed.

Thanks!


/P

--===============3976527342956410312==--
