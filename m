Content-Type: multipart/mixed; boundary="===============5430611871735650007=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 02/10] mptcp: add the pernet
 listening socket operations
Date: Mon, 23 Nov 2020 10:04:56 +0100
Message-ID: <07797aab1148767be1c4b704d565b0b1ceec9939.camel@redhat.com>
In-Reply-To: CA+WQbwuqCJRvqbQYhVaMhXt6oohF1uV37o39mhv7rp1AvOe7Ww@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6893

--===============5430611871735650007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-23 at 15:57 +0800, Geliang Tang wrote:
> Hi Paolo,
> =

> Thanks for your suggestions.
> =

> Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:24=E5=86=99=E9=81=93=EF=BC=9A
> > On Thu, 2020-11-19 at 18:19 +0800, Geliang Tang wrote:
> > > This patch added three new pernet listening socket operations:
> > > =

> > > mptcp_pm_alloc_listen_socket, mptcp_pm_free_listen_socket and
> > > mptcp_pm_get_listen_socket to alloc, free and get the pernet
> > > listening socket.
> > > =

> > > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > > ---
> > >  net/mptcp/pm_netlink.c | 54 ++++++++++++++++++++++++++++++++++++++++=
++
> > >  net/mptcp/protocol.c   |  5 ++++
> > >  net/mptcp/protocol.h   |  5 ++++
> > >  net/mptcp/subflow.c    |  2 +-
> > >  4 files changed, 65 insertions(+), 1 deletion(-)
> > > =

> > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > index 2560c502356b..19d557df4684 100644
> > > --- a/net/mptcp/pm_netlink.c
> > > +++ b/net/mptcp/pm_netlink.c
> > > @@ -45,6 +45,8 @@ struct pm_nl_pernet {
> > >       unsigned int            add_addr_accept_max;
> > >       unsigned int            local_addr_max;
> > >       unsigned int            subflows_max;
> > > +     struct socket           *listen_socket;
> > > +     bool                    sock_created;
> > >       unsigned int            next_id;
> > >  };
> > > =

> > > @@ -306,6 +308,56 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *=
msk)
> > >       }
> > >  }
> > > =

> > > +int mptcp_pm_alloc_listen_socket(struct mptcp_sock *msk)
> > > +{
> > > +     struct sock *sk =3D (struct sock *)msk;
> > > +     struct pm_nl_pernet *pernet;
> > > +     bool need_create =3D false;
> > > +
> > > +     pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
> > > +
> > > +     spin_lock_bh(&pernet->lock);
> > > +     if (!pernet->sock_created) {
> > > +             pernet->sock_created =3D true;
> > > +             need_create =3D true;
> > > +     }
> > > +     spin_unlock_bh(&pernet->lock);
> > > +
> > > +     if (!need_create)
> > > +             return 0;
> > > +
> > > +     return mptcp_create_listen_socket(sk, &pernet->listen_socket);
> > > +}
> > > +
> > > +void mptcp_pm_free_listen_socket(struct mptcp_sock *msk)
> > > +{
> > > +     struct sock *sk =3D (struct sock *)msk;
> > > +     struct pm_nl_pernet *pernet;
> > > +
> > > +     pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
> > > +
> > > +     if (!pernet || !pernet->listen_socket || !pernet->listen_socket=
->sk)
> > > +             return;
> > > +
> > > +     subflow_drop_ctx(pernet->listen_socket->sk);
> > > +     sock_release(pernet->listen_socket);
> > > +     pernet->listen_socket =3D NULL;
> > > +     pernet->sock_created =3D false;
> > > +}
> > > +
> > > +struct socket *mptcp_pm_get_listen_socket(struct mptcp_sock *msk)
> > > +{
> > > +     struct pm_nl_pernet *pernet;
> > > +     struct sock *sk =3D (struct sock *)msk;
> > > +
> > > +     pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
> > > +
> > > +     if (!pernet)
> > > +             return NULL;
> > > +
> > > +     return pernet->listen_socket;
> > > +}
> > > +
> > >  static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock=
 *msk)
> > >  {
> > >       struct mptcp_addr_info remote =3D { 0 };
> > > @@ -885,6 +937,8 @@ static void __reset_counters(struct pm_nl_pernet =
*pernet)
> > >       pernet->add_addr_accept_max =3D 0;
> > >       pernet->local_addr_max =3D 0;
> > >       pernet->addrs =3D 0;
> > > +     pernet->listen_socket =3D NULL;
> > > +     pernet->sock_created =3D false;
> > >  }
> > > =

> > >  static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl=
_info *info)
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 7a0364860feb..1a9e895e953e 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -2006,6 +2006,10 @@ static int mptcp_init_sock(struct sock *sk)
> > >       if (ret)
> > >               return ret;
> > > =

> > > +     ret =3D mptcp_pm_alloc_listen_socket(mptcp_sk(sk));
> > > +     if (ret)
> > > +             return ret;
> > > +
> > >       sk_sockets_allocated_inc(sk);
> > >       sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
> > >       sk->sk_sndbuf =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[1];
> =

> This v5 still has bugs in it, it can't work when we use announced multiple
> addresses with port, the following new test cases will fail:
[...]

Yep, with a single socket we can't accomodate multiple ports, we would
need one socket per port (specifcally one socket per port-based
endpoint), see below.

> I think the listening socket creation and bind should be done at
> > endpoint creation time, that is, while handling the
> > MPTCP_PM_CMD_ADD_ADDR netlink command.
> =

> Do you mean we can do it in mptcp_nl_cmd_add_addr? I had tested moving the
> creation and bind to mptcp_nl_cmd_add_addr, but it not work. This moment =
is
> much earlier for the socket creation. Since we want to create the subflow
> within a msk, but at this moment, the msk is not created yet.

The idea is that the listening socket is created _before_ we actually
create the msk or subflow.

Thanks to the destination port number and token checks, already in
place, that should be fine from security PoV: we will accept connection
only after a msk is created and fully established.

> I think maybe we can create and bind the listening socket in
> mptcp_pm_create_subflow_or_signal_addr. Do you think it's OK?

Doing the creation earlier, inside the scope of the user-space process
doing the netlink configuration:
- reduces the overhead for subflow creation. =

- allows closing the listening socket ASA the port endpoint is deleted.
- allows reporting to the user-space any port usage conflict and/or
other socket creation errors.

It looks the better option to me.

> > The socket pointer itself could be stored inside the 'struct
> > mptcp_pm_addr_entr'.
> =

> We have defined another struct mptcp_pm_add_entry, it will be added
> in
> anno_list. I think we can stored the socket pointer inside it, instead of
> mptcp_pm_addr_entry. But in that case, the listening socket is not per
> netns, it is per announced address. There are several listening sockets
> per netns. Is this acceptable?

I mentioned the 'mptcp_pm_addr_entry' struct because it's per netns.
Why can't we use it? Hopefully should be just a matter of moving the
socket creation and initialization inside mptcp_nl_cmd_add_addr().

Thanks,

Paolo

--===============5430611871735650007==--
