Content-Type: multipart/mixed; boundary="===============5867977924623855211=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: keep unaccepted MPC subflow into
 join list
Date: Wed, 21 Oct 2020 11:57:26 +0800
Message-ID: <CA+WQbwsuNs6GoQmQ5dsyZOAPUP-pqhrL+sSUjQi8X5ttiL=QEA@mail.gmail.com>
In-Reply-To: 9dc5467c-ec68-4398-1a95-f5d7ade57c9@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6378

--===============5867977924623855211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=B4=
10=E6=9C=8821=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8811:33=E5=86=99=
=E9=81=93=EF=BC=9A
>
>
> On Tue, 20 Oct 2020, Paolo Abeni wrote:
>
> > This will simplify all operation dealing with subflows
> > before accept time (e.g. data fin processing, add_addr).
> >
> > The join list is already flushed by mptcp_stream_accept()
> > before returning the newly created msk to the user space.
> >
> > This also fixes an potential bug present into the old code:
> > conn_list was manipulated without helding the msk lock
> > in mptcp_stream_accept().
> >
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > This is the pre-req to simplify ADD_ADDR pure-ack
> > generation (for unaccepted MPC subflow): with this
> > patch applpied the PM could
> > simply call flush_join_list() before sending the
> > pure ack.

I have tested this patch with my ADD_ADDR IPv6 patches,
they all work well. Thanks for your help.

Tested-by: Geliang Tang <geliangtang(a)gmail.com>

-Geliang

>
> Yes, this looks like a better approach and definitely improves some of the
> accept-time issues we've known about for a while. Looks good for
> the export branch. Thanks!
>
> Mat
>
> > ---
> > net/mptcp/protocol.c | 24 ++++++++----------------
> > net/mptcp/protocol.h |  9 +++++++++
> > net/mptcp/subflow.c  | 10 +++++-----
> > 3 files changed, 22 insertions(+), 21 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index ebb43b2c1b34..0bff3aa08270 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2319,7 +2319,6 @@ static struct sock *mptcp_accept(struct sock *sk,=
 int flags, int *err,
> >       if (sk_is_mptcp(newsk)) {
> >               struct mptcp_subflow_context *subflow;
> >               struct sock *new_mptcp_sock;
> > -             struct sock *ssk =3D newsk;
> >
> >               subflow =3D mptcp_subflow_ctx(newsk);
> >               new_mptcp_sock =3D subflow->conn;
> > @@ -2334,22 +2333,8 @@ static struct sock *mptcp_accept(struct sock *sk=
, int flags, int *err,
> >
> >               /* acquire the 2nd reference for the owning socket */
> >               sock_hold(new_mptcp_sock);
> > -
> > -             local_bh_disable();
> > -             bh_lock_sock(new_mptcp_sock);
> > -             msk =3D mptcp_sk(new_mptcp_sock);
> > -             msk->first =3D newsk;
> > -
> >               newsk =3D new_mptcp_sock;
> > -             mptcp_copy_inaddrs(newsk, ssk);
> > -             list_add(&subflow->node, &msk->conn_list);
> > -             sock_hold(ssk);
> > -
> > -             mptcp_rcv_space_init(msk, ssk);
> > -             bh_unlock_sock(new_mptcp_sock);
> > -
> > -             __MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIV=
EACK);
> > -             local_bh_enable();
> > +             MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEA=
CK);
> >       } else {
> >               MPTCP_INC_STATS(sock_net(sk),
> >                               MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
> > @@ -2799,6 +2784,12 @@ static int mptcp_stream_accept(struct socket *so=
ck, struct socket *newsock,
> >       if (err =3D=3D 0 && !mptcp_is_tcpsk(newsock->sk)) {
> >               struct mptcp_sock *msk =3D mptcp_sk(newsock->sk);
> >               struct mptcp_subflow_context *subflow;
> > +             struct sock *newsk =3D newsock->sk;
> > +             bool slowpath;
> > +
> > +             slowpath =3D lock_sock_fast(newsk);
> > +             mptcp_copy_inaddrs(newsk, msk->first);
> > +             mptcp_rcv_space_init(msk, msk->first);
> >
> >               /* set ssk->sk_socket of accept()ed flows to mptcp socket.
> >                * This is needed so NOSPACE flag can be set from tcp sta=
ck.
> > @@ -2810,6 +2801,7 @@ static int mptcp_stream_accept(struct socket *soc=
k, struct socket *newsock,
> >                       if (!ssk->sk_socket)
> >                               mptcp_sock_graft(ssk, newsock);
> >               }
> > +             unlock_sock_fast(newsk, slowpath);
> >       }
> >
> >       if (inet_csk_listen_poll(ssock->sk))
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index b4c8dbe9236b..24a361c684f4 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -404,6 +404,15 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_su=
bflow_context *subflow)
> >       return subflow->map_seq + mptcp_subflow_get_map_offset(subflow);
> > }
> >
> > +static inline void mptcp_add_pending_subflow(struct mptcp_sock *msk,
> > +                                       struct mptcp_subflow_context *s=
ubflow)
> > +{
> > +     sock_hold(mptcp_subflow_tcp_sock(subflow));
> > +     spin_lock_bh(&msk->join_list_lock);
> > +     list_add_tail(&subflow->node, &msk->join_list);
> > +     spin_unlock_bh(&msk->join_list_lock);
> > +}
> > +
> > int mptcp_is_enabled(struct net *net);
> > unsigned int mptcp_get_add_addr_timeout(struct net *net);
> > void mptcp_subflow_fully_established(struct mptcp_subflow_context *subf=
low,
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 443c491c2897..1e9a72af67dc 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -578,6 +578,10 @@ static struct sock *subflow_syn_recv_sock(const st=
ruct sock *sk,
> >                        */
> >                       inet_sk_state_store((void *)new_msk, TCP_ESTABLIS=
HED);
> >
> > +                     /* link the newly created socket to the msk */
> > +                     mptcp_add_pending_subflow(mptcp_sk(new_msk), ctx);
> > +                     WRITE_ONCE(mptcp_sk(new_msk)->first, child);
> > +
> >                       /* new mpc subflow takes ownership of the newly
> >                        * created mptcp socket
> >                        */
> > @@ -1124,11 +1128,7 @@ int __mptcp_subflow_connect(struct sock *sk, con=
st struct mptcp_addr_info *loc,
> >       if (err && err !=3D -EINPROGRESS)
> >               goto failed;
> >
> > -     sock_hold(ssk);
> > -     spin_lock_bh(&msk->join_list_lock);
> > -     list_add_tail(&subflow->node, &msk->join_list);
> > -     spin_unlock_bh(&msk->join_list_lock);
> > -
> > +     mptcp_add_pending_subflow(msk, subflow);
> >       return err;
> >
> > failed:
> > --
> > 2.26.2
>
> --
> Mat Martineau
> Intel
--===============5867977924623855211==--
