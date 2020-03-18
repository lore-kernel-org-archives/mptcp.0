Content-Type: multipart/mixed; boundary="===============3333734414517421922=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC mptcp-next] tcp: mptcp: use mptcp receive buffer
 space to select rcv window
Date: Wed, 18 Mar 2020 21:59:20 +0100
Message-ID: <20200318205920.GK979@breakpoint.cc>
In-Reply-To: 95e08be8-9902-f998-6558-e7e574d783b0@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 3987

--===============3333734414517421922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <eric.dumazet(a)gmail.com> wrote:
> >>> +/* If ssk has an mptcp parent socket, use the mptcp rcvbuf occupancy,
> >>> + * not the ssk one.
> >>> + *
> >>> + * In mptcp, rwin is about the mptcp-level connection data.
> >>> + *
> >>> + * Data that is still on the ssk rx queue can thus be ignored,
> >>> + * as far as mptcp peer is concerened that data is still inflight.
> >>> + */
> >>> +void mptcp_space(const struct sock *ssk, int *space, int *full_space)
> >>> +{
> >>> +	const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(s=
sk);
> >>> +	const struct sock *sk =3D READ_ONCE(subflow->conn);
> >>
> >> What are the rules protecting subflow->conn lifetime ?
> >>
> >> Why dereferencing sk after this line is safe ?
> > =

> > Subflow sockets hold a reference on the master/parent mptcp-socket.
> > =

> =

> Presence of READ_ONCE() tells something might happen on
> this pointer after you read it.

Right, sorry about this. The READ_ONCE() isn't needed anymore after
recent improvement from Paolo.

> Can this pointer be set while this thread is owning the socket lock ?

Only by the one holding the sk lock, so no race.

> If not, then you do not need READ_ONCE(), this is confusing.

Yes.

> If yes, then it means that whatever changes the pointer might also releas=
e the reference
> on the old object.

The reference is released only after aquiring the socket lock.
--===============3333734414517421922==--
