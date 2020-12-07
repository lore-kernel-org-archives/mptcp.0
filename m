Content-Type: multipart/mixed; boundary="===============1963470486916399566=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v7 mptcp-next 1/7] mptcp: create the
 listening socket for new port
Date: Mon, 07 Dec 2020 14:30:52 +0800
Message-ID: <20201207063052.GA20630@MiBook>
In-Reply-To: 373b7226-6933-47a3-73c2-938b755189a@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7063

--===============1963470486916399566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On Thu, Dec 03, 2020 at 05:36:08PM -0800, Mat Martineau wrote:
> On Mon, 30 Nov 2020, Geliang Tang wrote:
> =

> > This patch created a listening socket when an address with a port-number
> > is added by PM netlink. Then binded the new port to the socket, and
> > listened for the connection.
> > =

> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> > net/mptcp/pm_netlink.c | 58 ++++++++++++++++++++++++++++++++++++++++++
> > net/mptcp/protocol.c   |  2 +-
> > net/mptcp/protocol.h   |  3 +++
> > net/mptcp/subflow.c    |  4 +--
> > 4 files changed, 64 insertions(+), 3 deletions(-)
> > =

> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 5151cfcd6962..c296927bf167 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -26,6 +26,7 @@ struct mptcp_pm_addr_entry {
> > 	struct list_head	list;
> > 	struct mptcp_addr_info	addr;
> > 	struct rcu_head		rcu;
> > +	struct socket		*lsk;
> =

> Two things to fix up:
> =

> Non-zero lsk is not released everywhere mptcp_pm_addr_entry structs are
> freed.
> =

> lsk is not initialized in mptcp_pm_nl_get_local_id()
> =

> > };
> > =

> > struct mptcp_pm_add_entry {
> > @@ -732,6 +733,53 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct=
 genl_info *info)
> > 	return net_generic(genl_info_net(info), pm_nl_pernet_id);
> > }
> > =

> > +static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> > +					    struct mptcp_pm_addr_entry *entry)
> > +{
> > +	struct sockaddr_storage addr;
> > +	struct mptcp_sock *msk;
> > +	struct socket *ssock;
> > +	int backlog =3D 20;
> =

> Any comment on the choice of '20' here? Could it be too small for a high
> connection rate, or worth a sysctl?
> =

> Thanks,
> =

> Mat
> =

> > +	int err;
> > +
> > +	err =3D sock_create_kern(sock_net(sk), entry->addr.family,
> > +			       SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
> > +	if (err)
> > +		return err;
> > +
> > +	msk =3D mptcp_sk(entry->lsk->sk);
> > +	if (!msk) {
> > +		err =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	ssock =3D __mptcp_nmpc_socket(msk);
> > +	if (!ssock) {
> > +		err =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	mptcp_info2sockaddr(&entry->addr, &addr);
> > +	err =3D kernel_bind(ssock, (struct sockaddr *)&addr,
> > +			  sizeof(struct sockaddr_in));
> > +	if (err) {
> > +		pr_warn("kernel_bind error, err=3D%d", err);
> > +		goto out;
> > +	}
> > +
> > +	err =3D kernel_listen(ssock, backlog);
> > +	if (err) {
> > +		pr_warn("kernel_listen error, err=3D%d", err);
> > +		goto out;
> > +	}
> > +
> > +	return 0;
> > +
> > +out:
> > +	sock_release(entry->lsk);

I need some help about releasing the MPTCP type listening socket. When I
use "sock_release(entry->lsk)" to release it, I'll get a deadlock warning
like this:

----

[   55.789592] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   55.789593] WARNING: possible recursive locking detected
[   55.789594] 5.10.0-rc6-mptcp+ #742 Not tainted
[   55.789595] --------------------------------------------
[   55.789596] pm_nl_ctl/5583 is trying to acquire lock:
[   55.789597] ffff9ff9883cb960 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: __mptc=
p_close_ssk+0x52/0x160
[   55.789604]
               but task is already holding lock:
[   55.789605] ffff9ff949c1c1a0 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_=
close+0x45/0x320
[   55.789608]
               other info that might help us debug this:
[   55.789609]  Possible unsafe locking scenario:

[   55.789610]        CPU0
[   55.789610]        ----
[   55.789611]   lock(k-sk_lock-AF_INET);
[   55.789613]   lock(k-sk_lock-AF_INET);
[   55.789614]
                *** DEADLOCK ***

[   55.789615]  May be due to missing lock nesting notation

[   55.789616] 3 locks held by pm_nl_ctl/5583:
[   55.789617]  #0: ffffffff8c5f9af0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x=
15/0x40
[   55.789621]  #1: ffffffff8c5f9b88 (genl_mutex){+.+.}-{3:3}, at: genl_rcv=
_msg+0xf5/0x1c0
[   55.789625]  #2: ffff9ff949c1c1a0 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: m=
ptcp_close+0x45/0x320
[   55.789629]
               stack backtrace:
[   55.789631] CPU: 1 PID: 5583 Comm: pm_nl_ctl Kdump: loaded Not tainted 5=
.10.0-rc6-mptcp+ #742
[   55.789632] Hardware name: TIMI Mi Laptop Pro 15/TM1905, BIOS XMACM500P0=
301 04/08/2020
[   55.789633] Call Trace:
[   55.789637]  dump_stack+0x8b/0xb0
[   55.789639]  __lock_acquire.cold+0x159/0x2ab
[   55.789643]  ? debug_object_assert_init+0x4b/0x130
[   55.789646]  lock_acquire+0x116/0x370
[   55.789648]  ? __mptcp_close_ssk+0x52/0x160
[   55.789651]  ? lock_sock_nested+0x51/0x90
[   55.789653]  lock_sock_nested+0x70/0x90
[   55.789655]  ? __mptcp_close_ssk+0x52/0x160
[   55.789657]  __mptcp_close_ssk+0x52/0x160
[   55.789659]  __mptcp_destroy_sock+0x119/0x210
[   55.789661]  mptcp_close+0x281/0x320
[   55.789663]  inet_release+0x99/0xa8
[   55.789665]  sock_release+0x20/0x70
[   55.789667]  mptcp_nl_cmd_add_addr+0x27c/0x2e0
[   55.789670]  genl_family_rcv_msg_doit+0xcd/0x110
[   55.789675]  genl_rcv_msg+0xce/0x1c0
[   55.789677]  ? mptcp_nl_cmd_get_limits+0x260/0x260
[   55.789680]  ? genl_get_cmd+0xd0/0xd0
[   55.789683]  netlink_rcv_skb+0x50/0xf0
[   55.789687]  genl_rcv+0x24/0x40
[   55.789688]  netlink_unicast+0x16d/0x230
[   55.789690]  netlink_sendmsg+0x23f/0x460
[   55.789693]  sock_sendmsg+0x5e/0x60
[   55.789694]  __sys_sendto+0xf1/0x160
[   55.789698]  ? do_user_addr_fault+0x215/0x440
[   55.789701]  ? lockdep_hardirqs_on_prepare+0xff/0x180
[   55.789702]  __x64_sys_sendto+0x25/0x30
[   55.789704]  do_syscall_64+0x33/0x40
[   55.789707]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   55.789709] RIP: 0033:0x7fca52863efa
[   55.789710] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f =
1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 76 c3 0f 1f 44 00 00 55 48 83 ec 30 44 89 4c
[   55.789712] RSP: 002b:00007ffc6a45db88 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002c
[   55.789714] RAX: ffffffffffffffda RBX: 00007ffc6a45dbf0 RCX: 00007fca528=
63efa
[   55.789715] RDX: 0000000000000038 RSI: 00007ffc6a45dbf0 RDI: 00000000000=
00003
[   55.789716] RBP: 0000000000000038 R08: 00007ffc6a45db94 R09: 00000000000=
0000c
[   55.789717] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00000
[   55.789718] R13: 0000000000000003 R14: 00007ffc6a45e170 R15: 00007ffc6a4=
5e138
[   55.789751] MPTCP: msk=3D000000001cb8c5f2
[   55.798357] MPTCP: subflow=3D0000000008e7e757

----

I spent a few days trying to solve this problem, but it didn't go well.
Please give some suggestions about it, thanks very much.

-Geliang

> > +	return err;
> > +}
> > +
> > static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info =
*info)
> > {
> > 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> > @@ -750,9 +798,19 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *s=
kb, struct genl_info *info)
> > 	}
> > =

> > 	*entry =3D addr;
> > +	if (entry->addr.port) {
> > +		ret =3D mptcp_pm_nl_create_listen_socket(skb->sk, entry);
> > +		if (ret) {
> > +			GENL_SET_ERR_MSG(info, "create listen socket error");
> > +			kfree(entry);
> > +			return ret;
> > +		}
> > +	}
> > 	ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
> > 	if (ret < 0) {
> > 		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
> > +		if (entry->lsk)
> > +			sock_release(entry->lsk);
> > 		kfree(entry);
> > 		return ret;
> > 	}
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
> > 	if (!msk->subflow || READ_ONCE(msk->can_ack))
> > 		return NULL;
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 9d8f01aac91c..ec179f3a6b4b 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -466,11 +466,14 @@ void mptcp_subflow_shutdown(struct sock *sk, stru=
ct sock *ssk, int how);
> > void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> > 		       struct mptcp_subflow_context *subflow);
> > void mptcp_subflow_reset(struct sock *ssk);
> > +struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
> > =

> > /* called with sk socket lock held */
> > int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_in=
fo *loc,
> > 			    const struct mptcp_addr_info *remote);
> > int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_so=
ck);
> > +void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> > +			 struct sockaddr_storage *addr);
> > =

> > static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
> > 					      struct mptcp_subflow_context *ctx)
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 96c585f003f8..43cc5e2c3234 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1035,8 +1035,8 @@ void mptcpv6_handle_mapped(struct sock *sk, bool =
mapped)
> > }
> > #endif
> > =

> > -static void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> > -				struct sockaddr_storage *addr)
> > +void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> > +			 struct sockaddr_storage *addr)
> > {
> > 	memset(addr, 0, sizeof(*addr));
> > 	addr->ss_family =3D info->family;
> > -- =

> > 2.26.2
> =

> --
> Mat Martineau
> Intel
--===============1963470486916399566==--
