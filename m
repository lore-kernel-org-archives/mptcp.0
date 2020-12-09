Content-Type: multipart/mixed; boundary="===============4235325998815980256=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v7 mptcp-next 1/7] mptcp: create the
 listening socket for new port
Date: Wed, 09 Dec 2020 18:27:19 +0800
Message-ID: <CA+WQbwt01UPVJ2GGUwseE3opEeJ4EiVvNN2ab_QS76FHqzS8Zw@mail.gmail.com>
In-Reply-To: 373b7226-6933-47a3-73c2-938b755189a@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7095

--===============4235325998815980256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=B4=
12=E6=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=889:36=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Mon, 30 Nov 2020, Geliang Tang wrote:
>
> > This patch created a listening socket when an address with a port-number
> > is added by PM netlink. Then binded the new port to the socket, and
> > listened for the connection.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> > net/mptcp/pm_netlink.c | 58 ++++++++++++++++++++++++++++++++++++++++++
> > net/mptcp/protocol.c   |  2 +-
> > net/mptcp/protocol.h   |  3 +++
> > net/mptcp/subflow.c    |  4 +--
> > 4 files changed, 64 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 5151cfcd6962..c296927bf167 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -26,6 +26,7 @@ struct mptcp_pm_addr_entry {
> >       struct list_head        list;
> >       struct mptcp_addr_info  addr;
> >       struct rcu_head         rcu;
> > +     struct socket           *lsk;
>
> Two things to fix up:
>
> Non-zero lsk is not released everywhere mptcp_pm_addr_entry structs are
> freed.

I'll add the following releasing code in mptcp_nl_cmd_del_addr and
__flush_addrs in v8:

      if (entry->lsk)
              sock_release(entry->lsk);

But as I mentioned on my last letter, there is a deadlock warning when
releasing this listening socket.

>
> lsk is not initialized in mptcp_pm_nl_get_local_id()
>

I'll add the following code in mptcp_pm_nl_get_local_id in v8:

     entry->lsk =3D NULL;

> > };
> >
> > struct mptcp_pm_add_entry {
> > @@ -732,6 +733,53 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct=
 genl_info *info)
> >       return net_generic(genl_info_net(info), pm_nl_pernet_id);
> > }
> >
> > +static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> > +                                         struct mptcp_pm_addr_entry *e=
ntry)
> > +{
> > +     struct sockaddr_storage addr;
> > +     struct mptcp_sock *msk;
> > +     struct socket *ssock;
> > +     int backlog =3D 20;
>
> Any comment on the choice of '20' here? Could it be too small for a high
> connection rate, or worth a sysctl?

I'll change it to '1024' in v8, since on the textbook UNPv3, 1024 is always
used as the 2nd argument to listen():

       int backlog =3D 1024;

-Geliang

>
> Thanks,
>
> Mat
>
> > +     int err;
> > +
> > +     err =3D sock_create_kern(sock_net(sk), entry->addr.family,
> > +                            SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
> > +     if (err)
> > +             return err;
> > +
> > +     msk =3D mptcp_sk(entry->lsk->sk);
> > +     if (!msk) {
> > +             err =3D -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     ssock =3D __mptcp_nmpc_socket(msk);
> > +     if (!ssock) {
> > +             err =3D -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     mptcp_info2sockaddr(&entry->addr, &addr);
> > +     err =3D kernel_bind(ssock, (struct sockaddr *)&addr,
> > +                       sizeof(struct sockaddr_in));
> > +     if (err) {
> > +             pr_warn("kernel_bind error, err=3D%d", err);
> > +             goto out;
> > +     }
> > +
> > +     err =3D kernel_listen(ssock, backlog);
> > +     if (err) {
> > +             pr_warn("kernel_listen error, err=3D%d", err);
> > +             goto out;
> > +     }
> > +
> > +     return 0;
> > +
> > +out:
> > +     sock_release(entry->lsk);
> > +     return err;
> > +}
> > +
> > static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info =
*info)
> > {
> >       struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> > @@ -750,9 +798,19 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *s=
kb, struct genl_info *info)
> >       }
> >
> >       *entry =3D addr;
> > +     if (entry->addr.port) {
> > +             ret =3D mptcp_pm_nl_create_listen_socket(skb->sk, entry);
> > +             if (ret) {
> > +                     GENL_SET_ERR_MSG(info, "create listen socket erro=
r");
> > +                     kfree(entry);
> > +                     return ret;
> > +             }
> > +     }
> >       ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
> >       if (ret < 0) {
> >               GENL_SET_ERR_MSG(info, "too many addresses or duplicate o=
ne");
> > +             if (entry->lsk)
> > +                     sock_release(entry->lsk);
> >               kfree(entry);
> >               return ret;
> >       }
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 4c36969873b9..5e464dfc0f6f 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -49,7 +49,7 @@ static void __mptcp_check_send_data_fin(struct sock *=
sk);
> >  * completed yet or has failed, return the subflow socket.
> >  * Otherwise return NULL.
> >  */
> > -static struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
> > +struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
> > {
> >       if (!msk->subflow || READ_ONCE(msk->can_ack))
> >               return NULL;
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 9d8f01aac91c..ec179f3a6b4b 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -466,11 +466,14 @@ void mptcp_subflow_shutdown(struct sock *sk, stru=
ct sock *ssk, int how);
> > void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> >                      struct mptcp_subflow_context *subflow);
> > void mptcp_subflow_reset(struct sock *ssk);
> > +struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
> >
> > /* called with sk socket lock held */
> > int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_in=
fo *loc,
> >                           const struct mptcp_addr_info *remote);
> > int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_so=
ck);
> > +void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> > +                      struct sockaddr_storage *addr);
> >
> > static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
> >                                             struct mptcp_subflow_contex=
t *ctx)
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 96c585f003f8..43cc5e2c3234 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1035,8 +1035,8 @@ void mptcpv6_handle_mapped(struct sock *sk, bool =
mapped)
> > }
> > #endif
> >
> > -static void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> > -                             struct sockaddr_storage *addr)
> > +void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> > +                      struct sockaddr_storage *addr)
> > {
> >       memset(addr, 0, sizeof(*addr));
> >       addr->ss_family =3D info->family;
> > --
> > 2.26.2
>
> --
> Mat Martineau
> Intel
--===============4235325998815980256==--
