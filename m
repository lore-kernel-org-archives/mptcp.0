Content-Type: multipart/mixed; boundary="===============4942508475431866917=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 2/9] mptcp: set the listening
 socket's subflow
Date: Wed, 25 Nov 2020 13:11:36 +0100
Message-ID: <cd1417d6db72fa81877d0960d339cfc584a866f2.camel@redhat.com>
In-Reply-To: CA+WQbwuAsFfnq=FN-5mJrMJxaWDFmhuWT58dtJ6HOmniBkUXzw@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6929

--===============4942508475431866917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-25 at 18:20 +0800, Geliang Tang wrote:
> Hi Paolo,
> =

> Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:25=E5=86=99=E9=81=93=EF=BC=9A
> > On Wed, 2020-11-25 at 11:01 +0800, Geliang Tang wrote:
> > > This patch set the subflow context of the listening socket.
> > > =

> > > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > > ---
> > >  net/mptcp/pm_netlink.c |  5 +++++
> > >  net/mptcp/protocol.h   |  1 +
> > >  net/mptcp/subflow.c    | 37 +++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 43 insertions(+)
> > > =

> > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > index 0d9a3c77fdf1..39a91fcac403 100644
> > > --- a/net/mptcp/pm_netlink.c
> > > +++ b/net/mptcp/pm_netlink.c
> > > @@ -330,6 +330,11 @@ static void mptcp_pm_create_subflow_or_signal_ad=
dr(struct mptcp_sock *msk)
> > >                       if (mptcp_pm_alloc_anno_list(msk, local)) {
> > >                               msk->pm.add_addr_signaled++;
> > >                               mptcp_pm_announce_addr(msk, &local->add=
r, false, local->addr.port);
> > > +                             if (local->addr.port) {
> > > +                                     spin_unlock_bh(&msk->pm.lock);
> > > +                                     mptcp_pm_set_listen_socket_subf=
low(sk, local->lsk);
> > =

> > Why it's needed to this at announce time? Why not at lsk creation time?
> > Probably more related to the previous patch, why lsk is TCP socket
> > instead of an MPTCP one? (I feel the latter would be a more natural
> > choice, but it's just a feeling).
> =

> I think the listening socket lsk is a subsocket. It should be joined to
> the msk as a subflow. lsk is created in PM netlink as a TCP socket, since
> this moment, the msk is not created.

Ah that is the main point! I think quite the opposite: the listening
socket *should* be unrelated to any user-created msk, because it's sort
of "shared" among all the msk announcing the additional port.

The subflow created by the listening sockets at accept time instead
should join an existing msk, and that is already done
by subflow_syn_recv_sock().
> =

> At announce time, the msk is fully established, here I set up lsk's subfl=
ow
> context, and add it into the msk as a subflow.

What if another msk annunces the same endpoint?

> If lsk is an MPTCP socket, how can it to be joined to the msk?

As said, I think the listener subflow should _not_ join any existing
user-created msk.

Not sure if the above is clear enough, please let me know.

Paolo

--===============4942508475431866917==--
