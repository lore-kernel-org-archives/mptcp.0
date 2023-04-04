Received: from ma-mailsvcp-mx-lapp01.apple.com (ma-mailsvcp-mx-lapp01.apple.com [17.32.222.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A3328F3
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 17:10:07 +0000 (UTC)
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com
 (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
 by ma-mailsvcp-mx-lapp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) with ESMTPS id <0RSL00HJ6M8IHW20@ma-mailsvcp-mx-lapp01.apple.com> for
 mptcp@lists.linux.dev; Tue, 04 Apr 2023 09:09:57 -0700 (PDT)
X-Proofpoint-ORIG-GUID: IXrqYbLAdQU2mUOklpXziTS2bs4WTFCJ
X-Proofpoint-GUID: IXrqYbLAdQU2mUOklpXziTS2bs4WTFCJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.573,18.0.942
 definitions=2023-04-04_08:2023-04-04,2023-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=967
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304040149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=1y/HXq1fnJqnL8ZbdYzW6K2vnFfLMlbTY0F/rMa8jSI=;
 b=cq/5lkMelK7qfufdUPWdzOo0E3k4mZZ4+RumvZHo1qfTZ9GCRkLZFXVquvufLcztmjDj
 NeZt08H913sD1WUosSGrbV6ktJMW8OavXXj+LacHhJwC1kXwrecgwzOU2H88eBcK1vAG
 xD9BitRdSB9P8My6lJbfjJoe2rccPtV/1AFwSonhwUhdnQ0fXQgqepnwrGH4kkwANafB
 PIR/oC9XvvHm7KhS0ldvoJd0UlTGixZEg1fbaq7HR6XD9c0+u58IhYBQjmGns83HxkWy
 iiHuwJucRB4yk+6TxKzpvYM7R1csYJA2V892MuC2HLaoZf7LPk5SizsIDXprACmbtTaS rA==
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) with ESMTPS id <0RSL0003PM8JWIC0@rn-mailsvcp-mta-lapp01.rno.apple.com>;
 Tue, 04 Apr 2023 09:09:55 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) id <0RSL00C00M6TNM00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Tue,
 04 Apr 2023 09:09:55 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-Va-E-CD: 1477a7037170f80cb0137699e0cf5be1
X-Va-R-CD: eec1826aaaeb5821f8d556fe5b44fdbe
X-Va-ID: 2b9651eb-4d81-428b-ae54-c8b7f28ce50f
X-Va-CD: 0
X-V-A:
X-V-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-V-E-CD: 1477a7037170f80cb0137699e0cf5be1
X-V-R-CD: eec1826aaaeb5821f8d556fe5b44fdbe
X-V-ID: 02cadb7b-e8f0-45a5-89fa-37ed05bef0a1
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.573,18.0.942
 definitions=2023-04-04_08:2023-04-04,2023-04-04 signatures=0
Received: from smtpclient.apple (unknown [17.192.155.213])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023))
 with ESMTPSA id <0RSL00D0MM8JUJ00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Tue,
 04 Apr 2023 09:09:55 -0700 (PDT)
Content-type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3731.500.221\))
Subject: Re: [PATCH v3 mptcp-net 2/2] mptcp: fix accept vs worker race
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to:
 <b12779f37770dbdad059232c9cb45fbd56afabd2.1680204074.git.pabeni@redhat.com>
Date: Tue, 04 Apr 2023 09:09:45 -0700
Cc: mptcp@lists.linux.dev
Content-transfer-encoding: quoted-printable
Message-id: <5D08A0CA-C69B-4EA6-BEC3-06DBB6492AFF@apple.com>
References: <cover.1680204074.git.pabeni@redhat.com>
 <b12779f37770dbdad059232c9cb45fbd56afabd2.1680204074.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3731.500.221)



> On Mar 30, 2023, at 12:22 PM, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> The mptcp worker and mptcp_accept() can race, as reported by =
Christoph:
>=20
> refcount_t: addition on 0; use-after-free.
> WARNING: CPU: 1 PID: 14351 at lib/refcount.c:25 =
refcount_warn_saturate+0x105/0x1b0 lib/refcount.c:25
> Modules linked in:
> CPU: 1 PID: 14351 Comm: syz-executor.2 Not tainted =
6.3.0-rc1-gde5e8fd0123c #11
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.11.0-2.el7 04/01/2014
> RIP: 0010:refcount_warn_saturate+0x105/0x1b0 lib/refcount.c:25
> Code: 02 31 ff 89 de e8 1b f0 a7 ff 84 db 0f 85 6e ff ff ff e8 3e f5 =
a7 ff 48 c7 c7 d8 c7 34 83 c6 05 6d 2d 0f 02 01 e8 cb 3d 90 ff <0f> 0b =
e9 4f ff ff ff e8 1f f5 a7 ff 0f b6 1d 54 2d 0f 02 31 ff 89
> RSP: 0018:ffffc90000a47bf8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88802eae98c0 RSI: ffffffff81097d4f RDI: 0000000000000001
> RBP: ffff88802e712180 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: ffff88802eaea148 R12: ffff88802e712100
> R13: ffff88802e712a88 R14: ffff888005cb93a8 R15: ffff88802e712a88
> FS:  0000000000000000(0000) GS:ffff88803ed00000(0000) =
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f277fd89120 CR3: 0000000035486002 CR4: 0000000000370ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> __refcount_add include/linux/refcount.h:199 [inline]
> __refcount_inc include/linux/refcount.h:250 [inline]
> refcount_inc include/linux/refcount.h:267 [inline]
> sock_hold include/net/sock.h:775 [inline]
> __mptcp_close+0x4c6/0x4d0 net/mptcp/protocol.c:3051
> mptcp_close+0x24/0xe0 net/mptcp/protocol.c:3072
> inet_release+0x56/0xa0 net/ipv4/af_inet.c:429
> __sock_release+0x51/0xf0 net/socket.c:653
> sock_close+0x18/0x20 net/socket.c:1395
> __fput+0x113/0x430 fs/file_table.c:321
> task_work_run+0x96/0x100 kernel/task_work.c:179
> exit_task_work include/linux/task_work.h:38 [inline]
> do_exit+0x4fc/0x10c0 kernel/exit.c:869
> do_group_exit+0x51/0xf0 kernel/exit.c:1019
> get_signal+0x12b0/0x1390 kernel/signal.c:2859
> arch_do_signal_or_restart+0x25/0x260 arch/x86/kernel/signal.c:306
> exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
> exit_to_user_mode_prepare+0x131/0x1a0 kernel/entry/common.c:203
> __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
> syscall_exit_to_user_mode+0x19/0x40 kernel/entry/common.c:296
> do_syscall_64+0x46/0x90 arch/x86/entry/common.c:86
> entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7fec4b4926a9
> Code: Unable to access opcode bytes at 0x7fec4b49267f.
> RSP: 002b:00007fec49f9dd78 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00000000006bc058 RCX: 00007fec4b4926a9
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006bc058
> RBP: 00000000006bc050 R08: 00000000007df998 R09: 00000000007df998
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006bc05c
> R13: fffffffffffffea8 R14: 000000000000000b R15: 000000000001fe40
> </TASK>
>=20
> The root cause is that the worker can force fallback to TCP the first
> mptcp subflow, actually deleting the unaccepted msk socket.
>=20
> We can explicitly prevent the race delaying the unaccepted msk =
deletion
> at listener shutdown time. In case the closed subflow is later =
accepted,
> just just drop the mptcp contenxt and let the user-space deal with the
> paiered mptcp socket.
>=20
> Fixes: b6985b9b8295 ("mptcp: use the workqueue to destroy unaccepted =
sockets")
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/375
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 48 ++++++++++++++++++++++++++------------------
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  | 26 ++++++++++++++++--------
> 3 files changed, 48 insertions(+), 27 deletions(-)

Tested the reproducer and can=E2=80=99t trigger a Panic anymore:

Tested-by: Christoph Paasch <cpaasch@apple.com>


Christoph

>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d28528df43fa..ce495b5a683a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2373,6 +2373,15 @@ static void __mptcp_close_ssk(struct sock *sk, =
struct sock *ssk,
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> 	bool need_push, dispose_it;
>=20
> +	/* If the first subflow moved to a close state, e.g. due to
> +	 * incoming reset and we reach here before accept we need to be =
able
> +	 * to deliver the msk to user-space.
> +	 * Do nothing at the moment and take action at accept and/or =
listener
> +	 * shutdown.
> +	 */
> +	if (msk->in_accept_queue && msk->first =3D=3D ssk)
> +		return;
> +
> 	dispose_it =3D !msk->subflow || ssk !=3D msk->subflow->sk;
> 	if (dispose_it)
> 		list_del(&subflow->node);
> @@ -2407,18 +2416,6 @@ static void __mptcp_close_ssk(struct sock *sk, =
struct sock *ssk,
> 	if (!inet_csk(ssk)->icsk_ulp_ops) {
> 		WARN_ON_ONCE(!sock_flag(ssk, SOCK_DEAD));
> 		kfree_rcu(subflow, rcu);
> -	} else if (msk->in_accept_queue && msk->first =3D=3D ssk) {
> -		/* if the first subflow moved to a close state, e.g. due =
to
> -		 * incoming reset and we reach here before =
inet_child_forget()
> -		 * the TCP stack could later try to close it via
> -		 * inet_csk_listen_stop(), or deliver it to the user =
space via
> -		 * accept().
> -		 * We can't delete the subflow - or risk a double free - =
nor let
> -		 * the msk survive - or will be leaked in the non accept =
scenario:
> -		 * fallback and let TCP cope with the subflow cleanup.
> -		 */
> -		WARN_ON_ONCE(sock_flag(ssk, SOCK_DEAD));
> -		mptcp_subflow_drop_ctx(ssk);
> 	} else {
> 		/* otherwise tcp will dispose of the ssk and subflow ctx =
*/
> 		if (ssk->sk_state =3D=3D TCP_LISTEN) {
> @@ -2487,13 +2484,6 @@ static void __mptcp_close_subflow(struct sock =
*sk)
> 		mptcp_close_ssk(sk, ssk, subflow);
> 	}
>=20
> -	/* if the MPC subflow has been closed before the msk is =
accepted,
> -	 * msk will never be accept-ed, close it now
> -	 */
> -	if (!msk->first && msk->in_accept_queue) {
> -		sock_set_flag(sk, SOCK_DEAD);
> -		inet_sk_state_store(sk, TCP_CLOSE);
> -	}
> }
>=20
> static bool mptcp_check_close_timeout(const struct sock *sk)
> @@ -2976,6 +2966,14 @@ static void __mptcp_destroy_sock(struct sock =
*sk)
> 	sock_put(sk);
> }
>=20
> +void __mptcp_unaccepted_force_close(struct sock *sk)
> +{
> +	sock_set_flag(sk, SOCK_DEAD);
> +	inet_sk_state_store(sk, TCP_CLOSE);
> +	mptcp_do_fastclose(sk);
> +	__mptcp_destroy_sock(sk);
> +}
> +
> static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
> {
> 	/* Concurrent splices from sk_receive_queue into receive_queue =
will
> @@ -3825,6 +3823,18 @@ static int mptcp_stream_accept(struct socket =
*sock, struct socket *newsock,
> 			if (!ssk->sk_socket)
> 				mptcp_sock_graft(ssk, newsock);
> 		}
> +
> +		/* Do late cleanup for the first subflow as necessary. =
Also
> +		 * deal with bad peers not doing a complete shutdown.
> +		 */
> +		if (msk->first &&
> +		    unlikely(inet_sk_state_load(msk->first) =3D=3D =
TCP_CLOSE)) {
> +			__mptcp_close_ssk(newsk, msk->first,
> +					  mptcp_subflow_ctx(msk->first), =
0);
> +			if (unlikely(list_empty(&msk->conn_list)))
> +				inet_sk_state_store(newsk, TCP_CLOSE);
> +		}
> +
> 	}
> 	release_sock(newsk);
>=20
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a4e82bcfc7b8..457c9f63ed82 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -631,6 +631,7 @@ void mptcp_subflow_reset(struct sock *ssk);
> void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
> void mptcp_sock_graft(struct sock *sk, struct socket *parent);
> struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk);
> +void __mptcp_unaccepted_force_close(struct sock *sk);
> bool __mptcp_close(struct sock *sk, long timeout);
> void mptcp_cancel_work(struct sock *sk);
> void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d90267da9114..3d6ccf5067d7 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1813,12 +1813,13 @@ void mptcp_subflow_queue_clean(struct sock =
*listener_sk, struct sock *listener_s
> 	struct request_sock_queue *queue =3D =
&inet_csk(listener_ssk)->icsk_accept_queue;
> 	struct mptcp_sock *msk, *next, *head =3D NULL;
> 	struct request_sock *req;
> +	struct sock *sk, *ssk;
>=20
> 	/* build a list of all unaccepted mptcp sockets */
> 	spin_lock_bh(&queue->rskq_lock);
> 	for (req =3D queue->rskq_accept_head; req; req =3D req->dl_next) =
{
> 		struct mptcp_subflow_context *subflow;
> -		struct sock *ssk =3D req->sk;
> +		ssk =3D req->sk;
>=20
> 		if (!sk_is_mptcp(ssk))
> 			continue;
> @@ -1828,11 +1829,12 @@ void mptcp_subflow_queue_clean(struct sock =
*listener_sk, struct sock *listener_s
> 			continue;
>=20
> 		/* skip if already in list */
> -		msk =3D mptcp_sk(subflow->conn);
> +		sk =3D subflow->conn;
> +		msk =3D mptcp_sk(sk);
> 		if (msk->dl_next || msk =3D=3D head)
> 			continue;
>=20
> -		sock_hold(subflow->conn);
> +		sock_hold(sk);
> 		msk->dl_next =3D head;
> 		head =3D msk;
> 	}
> @@ -1846,18 +1848,26 @@ void mptcp_subflow_queue_clean(struct sock =
*listener_sk, struct sock *listener_s
> 	release_sock(listener_ssk);
>=20
> 	for (msk =3D head; msk; msk =3D next) {
> -		struct sock *sk =3D (struct sock *)msk;
> +		sk =3D (struct sock *)msk;
>=20
> 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
> +		ssk =3D msk->first;
> 		next =3D msk->dl_next;
> 		msk->dl_next =3D NULL;
>=20
> -		/* prevent the stack from later re-schedule the worker =
for
> -		 * this socket
> -		 */
> -		inet_sk_state_store(sk, TCP_CLOSE);
> +		__mptcp_unaccepted_force_close(sk);
> 		release_sock(sk);
>=20
> +		/* the first subflow is not touched by the above, as the =
msk
> +		 * is still in the accept queue, see __mptcp_close_ssk,
> +		 * we need to release only the ctx related resources, =
the
> +		 * tcp socket will be destroyed by =
inet_csk_listen_stop()
> +		 */
> +		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> +		mptcp_subflow_drop_ctx(ssk);
> +		release_sock(ssk);
> +		sock_put(ssk);
> +
> 		/* lockdep will report a false positive ABBA deadlock
> 		 * between cancel_work_sync and the listener socket.
> 		 * The involved locks belong to different sockets WRT
> --=20
> 2.39.2
>=20
>=20

