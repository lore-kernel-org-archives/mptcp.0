Content-Type: multipart/mixed; boundary="===============3054502065033588249=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 1/2] mptcp: remove address
 when netlink flush addrs
Date: Sat, 05 Dec 2020 08:51:44 +0800
Message-ID: <CA+WQbwvnqp5cyM=AgnPeZyXpy35b+UYhRuzf0AXLt31YCDxz8Q@mail.gmail.com>
In-Reply-To: ee48b64b-2a2-36b7-75fa-31adb234567d@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7058

--===============3054502065033588249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=B4=
12=E6=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8810:16=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Mon, 30 Nov 2020, Geliang Tang wrote:
>
> > When the PM netlink flushs the addresses, invoke the remove address
> > function mptcp_nl_remove_subflow_and_signal_addr to remove the addresses
> > and the subflows. Since this function should not be invoked under lock,
> > move __flush_addrs out of the pernet->lock.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> > net/mptcp/pm_netlink.c | 15 ++++++++++-----
> > 1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index ba31065ef462..4f1b7f44c03b 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -962,13 +962,14 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *=
skb, struct genl_info *info)
> >       return ret;
> > }
> >
> > -static void __flush_addrs(struct pm_nl_pernet *pernet)
> > +static void __flush_addrs(struct net *net, struct list_head *list)
> > {
> > -     while (!list_empty(&pernet->local_addr_list)) {
> > +     while (!list_empty(list)) {
> >               struct mptcp_pm_addr_entry *cur;
> >
> > -             cur =3D list_entry(pernet->local_addr_list.next,
> > +             cur =3D list_entry(list->next,
> >                                struct mptcp_pm_addr_entry, list);
> > +             mptcp_nl_remove_subflow_and_signal_addr(net, &cur->addr);
>
> I do think it makes sense to treat a 'flush' the same as a
> MPTCP_PM_CMD_DEL_ADDR on every entry in the list, so the patch is ok with
> me. I think I'll add an item to next week's meeting to talk about what
> happens when the last subflow is closed this way.

Do you mean the subflow whose local_id and remote_id are all 0? This
subflow will not be closed by mptcp_nl_remove_subflow_and_signal_addr.
This fuction will ignore the zero id, so the zero id subflow will not be cl=
osed.

-Geliang

>
> Mat
>
> >               list_del_rcu(&cur->list);
> >               kfree_rcu(cur, rcu);
> >       }
> > @@ -985,11 +986,13 @@ static void __reset_counters(struct pm_nl_pernet =
*pernet)
> > static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_in=
fo *info)
> > {
> >       struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> > +     LIST_HEAD(free_list);
> >
> >       spin_lock_bh(&pernet->lock);
> > -     __flush_addrs(pernet);
> > +     list_splice_init(&pernet->local_addr_list, &free_list);
> >       __reset_counters(pernet);
> >       spin_unlock_bh(&pernet->lock);
> > +     __flush_addrs(sock_net(skb->sk), &free_list);
> >       return 0;
> > }
> >
> > @@ -1253,10 +1256,12 @@ static void __net_exit pm_nl_exit_net(struct li=
st_head *net_list)
> >       struct net *net;
> >
> >       list_for_each_entry(net, net_list, exit_list) {
> > +             struct pm_nl_pernet *pernet =3D net_generic(net, pm_nl_pe=
rnet_id);
> > +
> >               /* net is removed from namespace list, can't race with
> >                * other modifiers
> >                */
> > -             __flush_addrs(net_generic(net, pm_nl_pernet_id));
> > +             __flush_addrs(net, &pernet->local_addr_list);
> >       }
> > }
> >
> > --
> > 2.26.2
>
> --
> Mat Martineau
> Intel
--===============3054502065033588249==--
