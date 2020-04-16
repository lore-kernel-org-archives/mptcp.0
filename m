Content-Type: multipart/mixed; boundary="===============7821084334762830737=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 4/7] mptcp: avoid callback invocation when
 mptcp parent socket doesn't exist
Date: Thu, 16 Apr 2020 11:57:31 +0200
Message-ID: <20200416095731.GA14098@breakpoint.cc>
In-Reply-To: 20200415204951.GA32392@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 4189

--===============7821084334762830737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Florian Westphal <fw(a)strlen.de> wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Wed, 2020-04-15 at 19:19 +0200, Florian Westphal wrote:
> > > We can crash with a NULL dereference in case a packet arrives on the =
new
> > > socket before ctx->conn has been initialized.
> > =

> > I don't understand this race. I thought tcp_v4_syn_recv_sock() creates
> > the new socket and acquires the socket lock atomically, and ctx->conn =
=3D
> > new_msk happens in the same critical section ?!?
> > =

> > So no packets should reach the newly created socket while conn is NULL
> > !?!
> =

> Might be related to the last patch, i.e. this patch is bogus because the
> NULL was because of lack of is_mptcp =3D 0 assignment?
> =

> I will test again with this patch removed from the series.

I powered off my VM after ~8h of continuos tests; but without this patch I
get crash after ~30 minutes.

I think its related to the case where we return child with subflow but
with ctx->conn =3D=3D NULL.

I plan to mangle the last patch with this one and reset the sk callbacks
in that case.

Alternative is to keep this patch as-is, squash in the last one and
amdend the commit message.
--===============7821084334762830737==--
