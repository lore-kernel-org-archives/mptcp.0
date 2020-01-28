Content-Type: multipart/mixed; boundary="===============3506464948565270291=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 2/2] mptcp: mptcp_close: avoid a lockdep
 splat when mcast group was joined
Date: Mon, 27 Jan 2020 17:34:27 -0800
Message-ID: <alpine.OSX.2.21.2001271729520.11293@obarba-mobl2.amr.corp.intel.com>
In-Reply-To: 20200126234101.7256-3-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3530

--===============3506464948565270291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jan 2020, Florian Westphal wrote:

> syzbot triggered following lockdep splat:
>
> ffffffff82d2cd40 (rtnl_mutex){+.+.}, at: ip_mc_drop_socket+0x52/0x180
> but task is already holding lock:
> ffff8881187a2310 (sk_lock-AF_INET){+.+.}, at: mptcp_close+0x18/0x30
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
> -> #1 (sk_lock-AF_INET){+.+.}:
>       lock_acquire+0xee/0x230
>       lock_sock_nested+0x89/0xc0
>       do_ip_setsockopt.isra.0+0x335/0x22f0
>       ip_setsockopt+0x35/0x60
>       tcp_setsockopt+0x5d/0x90
>       __sys_setsockopt+0xf3/0x190
>       __x64_sys_setsockopt+0x61/0x70
>       do_syscall_64+0x72/0x300
>       entry_SYSCALL_64_after_hwframe+0x49/0xbe
> -> #0 (rtnl_mutex){+.+.}:
>       check_prevs_add+0x2b7/0x1210
>       __lock_acquire+0x10b6/0x1400
>       lock_acquire+0xee/0x230
>       __mutex_lock+0x120/0xc70
>       ip_mc_drop_socket+0x52/0x180
>       inet_release+0x36/0xe0
>       __sock_release+0xfd/0x130
>       __mptcp_close+0xa8/0x1f0
>       inet_release+0x7f/0xe0
>       __sock_release+0x69/0x130
>       sock_close+0x18/0x20
>       __fput+0x179/0x400
>       task_work_run+0xd5/0x110
>       do_exit+0x685/0x1510
>       do_group_exit+0x7e/0x170
>       __x64_sys_exit_group+0x28/0x30
>       do_syscall_64+0x72/0x300
>       entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The trigger is:
>  socket(AF_INET, SOCK_STREAM, 0x106 /* IPPROTO_MPTCP */) =3D 4
>  setsockopt(4, SOL_IP, MCAST_JOIN_GROUP, {gr_interface=3D7, gr_group=3D{s=
a_family=3DAF_INET, sin_port=3Dhtons(20003), sin_addr=3Dinet_addr("224.0.0.=
2")}}, 136) =3D 0
>  exit(0)
>
> Which results in a call to rtnl_lock while we are holding
> the parent mptcp socket lock via
> mptcp_close -> lock_sock(msk) -> inet_release -> ip_mc_drop_socket -> rtn=
l_lock().
>
> From lockdep point of view we thus have both
> 'rtnl_lock; lock_sock' and 'lock_sock; rtnl_lock'.
>
> Fix this by stealing the msk conn_list and doing the subflow close
> without holding the msk lock.
>
> Fixes: cec37a6e41aae7bf ("mptcp: Handle MP_CAPABLE options for outgoing c=
onnections")
> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f8232e9f08e7..120b3305a594 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -644,11 +644,16 @@ static void __mptcp_close(struct sock *sk, long tim=
eout)
> {
> 	struct mptcp_subflow_context *subflow, *tmp;
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	LIST_HEAD(conn_list);
>
> 	mptcp_token_destroy(msk->token);
> 	inet_sk_state_store(sk, TCP_CLOSE);
>
> -	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> +	list_splice_init(&msk->conn_list, &conn_list);
> +
> +	release_sock(sk);

Moving the release_sock() here also means the lock is not held for the =

cached_ext and __mptcp_clear_xmit cleanup. Should those be moved around to =

happen under the lock or use some other temp variables to safely clean up?


Mat


> +
> +	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
> 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>
> 		__mptcp_close_ssk(sk, ssk, subflow, timeout);
> @@ -656,7 +661,7 @@ static void __mptcp_close(struct sock *sk, long timeo=
ut)
>
> 	if (msk->cached_ext)
> 		__skb_ext_put(msk->cached_ext);
> -	release_sock(sk);
> +
> 	sk_common_release(sk);
> }
>
> -- =

> 2.24.1
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============3506464948565270291==--
