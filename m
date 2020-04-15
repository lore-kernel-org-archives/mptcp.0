Content-Type: multipart/mixed; boundary="===============0162036327481910757=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 4/7] mptcp: avoid callback invocation when
 mptcp parent socket doesn't exist
Date: Wed, 15 Apr 2020 22:49:51 +0200
Message-ID: <20200415204951.GA32392@breakpoint.cc>
In-Reply-To: 4a58f8fa3a140be8b09bf6ee0605a5dcc4492858.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4188

--===============0162036327481910757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Wed, 2020-04-15 at 19:19 +0200, Florian Westphal wrote:
> > We can crash with a NULL dereference in case a packet arrives on the new
> > socket before ctx->conn has been initialized.
> =

> I don't understand this race. I thought tcp_v4_syn_recv_sock() creates
> the new socket and acquires the socket lock atomically, and ctx->conn =3D
> new_msk happens in the same critical section ?!?
> =

> So no packets should reach the newly created socket while conn is NULL
> !?!

Might be related to the last patch, i.e. this patch is bogus because the
NULL was because of lack of is_mptcp =3D 0 assignment?

I will test again with this patch removed from the series.

sorry.
--===============0162036327481910757==--
