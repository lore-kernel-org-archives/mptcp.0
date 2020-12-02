Content-Type: multipart/mixed; boundary="===============0531705638602619139=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 3/5] mptcp: deal with
 MPTCP_PM_ADDR_FLAG_BACKUP in PM netlink
Date: Wed, 02 Dec 2020 12:35:10 +0800
Message-ID: <CA+WQbwsdOv4O+-nEORWHjJJse10bnTH0YDbKZTPkxTKzBZ2p9g@mail.gmail.com>
In-Reply-To: e4243ada-1666-1ac0-7e68-cfd43d8313f0@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7004

--===============0531705638602619139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=B4=
12=E6=9C=882=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=888:40=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Mon, 30 Nov 2020, Geliang Tang wrote:
>
> > Hi Mat,
> >
> > Thanks for your review.
> >
> > Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=
=B9=B411=E6=9C=8821=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=889:17=E5=86=
=99=E9=81=93=EF=BC=9A
> >>
> >> On Fri, 20 Nov 2020, Geliang Tang wrote:
> >>
> >>> This patch added the MP_PRIO support for PM netlink:
> >>>
> >>> When PM netlink adds an address, check whether the
> >>> MPTCP_PM_ADDR_FLAG_BACKUP flag is set. If it is, check whether this
> >>> address had been added in the local address list. If it had been, then
> >>> call mptcp_nl_addr_backup to deal with this address.
> >>>
> >>> In mptcp_nl_addr_backup, we traverse all the existing msk sockets to =
find
> >>> the relevant sockets, and get the backup value according to whether t=
he
> >>> MPTCP_PM_ADDR_FLAG_BACKUP flag is set, then call
> >>> mptcp_pm_nl_mp_prio_send_ack to send out a MP_PRIO ACK packet.
> >>>
> >>> In mptcp_pm_nl_mp_prio_send_ack, we set or clear the
> >>> MPTCP_PM_ADDR_FLAG_BACKUP flag.
> >>>
> >>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> >>> ---
> >>> net/mptcp/pm_netlink.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >>> 1 file changed, 41 insertions(+)
> >>>
> >>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> >>> index dd48af3c5ed5..58960e1cdc32 100644
> >>> --- a/net/mptcp/pm_netlink.c
> >>> +++ b/net/mptcp/pm_netlink.c
> >>> @@ -535,6 +535,11 @@ void mptcp_pm_nl_mp_prio_send_ack(struct mptcp_s=
ock *msk,
> >>>                       return;
> >>>               }
> >>>
> >>> +             if (addr->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> >>> +                     addr->flags &=3D =E2=80=BEMPTCP_PM_ADDR_FLAG_BA=
CKUP;
> >>> +             else
> >>> +                     addr->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
> >>> +
> >>
> >> Why is the backup bit inverted here? It's not clear why it's changed, =
and
> >> why bkup is passed in based on the value of the bit when read by the
> >> calling function.
> >>
> >
> > I think we can use backup command not only to 'turn on' a subflow's bac=
kup
> > bit, but also to 'turn off' a subflow's backup bit. So the pm_nl_ctl ba=
ckup
> > command will work like this:
> >
> > # pm_nl_ctl add 10.0.2.1 flags signal; pm_nl_ctl dump
> > id 1 flags signal 10.0.2.1
> > # pm_nl_ctl add 10.0.2.1 flags backup; pm_nl_ctl dump
> > id 1 flags signal,backup 10.0.2.1
> > # pm_nl_ctl add 10.0.2.1 flags backup; pm_nl_ctl dump
> > id 1 flags signal 10.0.2.1
>
> I would prefer to have the 'backup' bit in the netlink flags set the
> backup bit directly - if the backup flag is 0 the subflow backup bit gets
> set to 0, and if the netlink backup flag is 1 the subflow backup bit gets
> set to 1. Paolo, does that interpretation of the backup flag match what
> you were thinking too?

Should we add an argument behind backup for the pm_nl_ctl tool? Then we
can use pm_nl_ctl to set backup flag like this:

 pm_nl_ctl add 10.0.2.1 flags backup 1
 pm_nl_ctl add 10.0.2.1 flags backup 0

Or add a new argument 'set' instead of using 'add' when changing
the backup flag:

 pm_nl_ctl set 10.0.2.1 flags backup 1
 pm_nl_ctl set 10.0.2.1 flags backup 0

-Geliang

>
>
> >
> >>>               subflow->backup =3D bkup;
> >>>               mptcp_schedule_work(sk);
> >>>
> >>> @@ -847,17 +852,53 @@ static struct pm_nl_pernet *genl_info_pm_nl(str=
uct genl_info *info)
> >>>       return net_generic(genl_info_net(info), pm_nl_pernet_id);
> >>> }
> >>>
> >>> +static int mptcp_nl_addr_backup(struct net *net,
> >>> +                             struct mptcp_addr_info *addr)
> >>> +{
> >>> +     long s_slot =3D 0, s_num =3D 0;
> >>> +     struct mptcp_sock *msk;
> >>> +
> >>> +     while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=
=3D NULL) {
> >>> +             u8 bkup =3D !(addr->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> >>> +             struct sock *sk =3D (struct sock *)msk;
> >>> +
> >>> +             if (list_empty(&msk->conn_list))
> >>> +                     goto next;
> >>> +
> >>> +             lock_sock(sk);
> >>> +             spin_lock_bh(&msk->pm.lock);
> >>> +             mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
> >>> +             spin_unlock_bh(&msk->pm.lock);
> >>> +             release_sock(sk);
> >>> +
> >>> +next:
> >>> +             sock_put(sk);
> >>> +             cond_resched();
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_inf=
o *info)
> >>> {
> >>>       struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> >>>       struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> >>>       struct mptcp_pm_addr_entry addr, *entry;
> >>> +     struct net *net =3D sock_net(skb->sk);
> >>>       int ret;
> >>>
> >>>       ret =3D mptcp_pm_parse_addr(attr, info, true, &addr);
> >>>       if (ret < 0)
> >>>               return ret;
> >>>
> >>> +     if (addr.addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP) {
> >>> +             list_for_each_entry(entry, &pernet->local_addr_list, li=
st) {
> >>> +                     if (addresses_equal(&entry->addr, &addr.addr, f=
alse))
> >>> +                             mptcp_nl_addr_backup(net, &entry->addr);
> >>
> >> I think a more strict match should be required here that includes the
> >> 'id' as well. There may be multiple endpoints with the same address but
> >> different port numbers.
> >>
> >
> > Adding 'id' match doesn't work, since addr.addr's id is always 0 here.
> >
> > I think we can use addresses_equal(&entry->addr, &addr.addr, true) here,
> > it's enough to cover the same address with different port numbers case.
>
> Ok, yes, addresses_equal() does compare port numbers so that should help.
>
> >>> +             }
> >>> +             return 0;
> >>> +     }
> >>> +
> >>>       entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
> >>>       if (!entry) {
> >>>               GENL_SET_ERR_MSG(info, "can't allocate addr");
> >>> --
> >>> 2.26.2
>
> --
> Mat Martineau
> Intel
--===============0531705638602619139==--
