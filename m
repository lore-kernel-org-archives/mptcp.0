Content-Type: multipart/mixed; boundary="===============6929506949820787773=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 2/9] mptcp: set the listening
 socket's subflow
Date: Wed, 25 Nov 2020 18:20:43 +0800
Message-ID: <CA+WQbwuAsFfnq=FN-5mJrMJxaWDFmhuWT58dtJ6HOmniBkUXzw@mail.gmail.com>
In-Reply-To: f011270ffb2897b12632af508b6d0db6c3be28f4.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6925

--===============6929506949820787773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 2020-11-25 at 11:01 +0800, Geliang Tang wrote:
> > This patch set the subflow context of the listening socket.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> >  net/mptcp/pm_netlink.c |  5 +++++
> >  net/mptcp/protocol.h   |  1 +
> >  net/mptcp/subflow.c    | 37 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 43 insertions(+)
> >
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 0d9a3c77fdf1..39a91fcac403 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -330,6 +330,11 @@ static void mptcp_pm_create_subflow_or_signal_addr=
(struct mptcp_sock *msk)
> >                       if (mptcp_pm_alloc_anno_list(msk, local)) {
> >                               msk->pm.add_addr_signaled++;
> >                               mptcp_pm_announce_addr(msk, &local->addr,=
 false, local->addr.port);
> > +                             if (local->addr.port) {
> > +                                     spin_unlock_bh(&msk->pm.lock);
> > +                                     mptcp_pm_set_listen_socket_subflo=
w(sk, local->lsk);
>
> Why it's needed to this at announce time? Why not at lsk creation time?
> Probably more related to the previous patch, why lsk is TCP socket
> instead of an MPTCP one? (I feel the latter would be a more natural
> choice, but it's just a feeling).

I think the listening socket lsk is a subsocket. It should be joined to
the msk as a subflow. lsk is created in PM netlink as a TCP socket, since
this moment, the msk is not created.

At announce time, the msk is fully established, here I set up lsk's subflow
context, and add it into the msk as a subflow.

If lsk is an MPTCP socket, how can it to be joined to the msk?

-Geliang

>
> > +                                     spin_lock_bh(&msk->pm.lock);
> > +                             }
> >                               mptcp_pm_nl_add_addr_send_ack(msk);
> >                       }
> >               } else {
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index f202e22058b5..38001b7b0bf6 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -469,6 +469,7 @@ int __mptcp_subflow_connect(struct sock *sk, const =
struct mptcp_addr_info *loc,
> >  int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_s=
ock);
> >  void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> >                        struct sockaddr_storage *addr);
> > +int mptcp_pm_set_listen_socket_subflow(struct sock *sk, struct socket =
*sf);
> >
> >  static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
> >                                             struct mptcp_subflow_contex=
t *ctx)
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index d4c136f1e754..6053a88c176f 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1208,6 +1208,43 @@ int mptcp_subflow_create_socket(struct sock *sk,=
 struct socket **new_sock)
> >       return 0;
> >  }
> >
> > +int mptcp_pm_set_listen_socket_subflow(struct sock *sk, struct socket =
*sf)
> > +{
> > +     struct mptcp_subflow_context *subflow;
> > +     struct net *net =3D sock_net(sk);
> > +     int err;
> > +
> > +     if (!sf)
> > +             return -EINVAL;
> > +
> > +     lock_sock(sf->sk);
> > +
> > +     mptcp_attach_cgroup(sk, sf->sk);
>
> This will likely not work if there are multiple MPTCP sockets using
> this endpoint.
>
> Possibly the cgroup attaching should be done at subflow_syn_recv_sock()
> time, for the child socket, with some custom code - because it must
> override the existing cgroup inherited from the listener.
>
> /P
>
--===============6929506949820787773==--
