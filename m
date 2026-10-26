Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016896;
	b=KLcmabW2m+UPzvVjWYjyQOyWVF19yxuO9l6pOVTNI4xnXHF0ktVM/W1469Mg/vYFzw39
	 UOSQ+jVEarm0IdbCHnWN8h8Xrw0E0Y8CTodSRhR9lpe+xNONMeO+rUZ7juWBpSz39xNKN
	 UDf7bdFfubPNdC/DxKDSOqyR5jfAPK4KulKFypd3F+1TVb0LJOeTJFu6t4noSCIsol2Qc
	 +ASxIkGVbFxwIqjyvwCGGIumkfS9z6X+dFFd5IIQO315ugfLRFhvXBW3H1vHf63x9inFN
	 VoH2nnyRl9A/Pr9Z5xltjbqIugRov6A9LI9BlC8MtZp2Mmb28X7MA1fvaskeNkrK66Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016896;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X46RJGSk2YJ3lsjCASVnmd4SSiA3EduwLD0gj3hyU+4=;
	b=Rd3uQiMrKnvtRfro2/PNS3/G2u14ZuFUznwi6WDtiNpmj+L9akhE82v9IgS+/m3xT9K9
	 IQ+jxN1j7oEK1pPQyh6uZ5B/E2O3XgSKIeMBiHHZCJbWcNz0o6atE2UOhATjfZ7+5AJ5/
	 2j9ujU9IVND3Woovytxzn22zrArTZraT9OhOyd3o2+iviVOx6Kgx7F6bLeq9DTPEzYglx
	 E+zaWsrGdKuhd4ABiwi6RqHsmtoX5crUmgiVSp42yHmyIrTqKbT5wU6vMTJfzEdHzMGVT
	 x+Pd+tYWtoTDE6AUESMYKMlh0JF19kjQgFMxwKdeL5RqMAzeL9nHIc9CdFTwF9ke3dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kS4lKQph;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9416D606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kS4lKQph
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3BF1F01828;
	Mon, 26 Oct 2026 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016896;
	bh=X46RJGSk2YJ3lsjCASVnmd4SSiA3EduwLD0gj3hyU+4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kS4lKQphmWF/tmXMd8w8ftqfzdIkrJYLnGO2Zf+DMNM3U52Le2GmENT9jB7sNSL5j
	 NnV+ELvIXfSxiV+25Cyhri2fVaSIEeBaapPYnE7Hj0pJ2/VgJfESHzFm/ZhBrfGEW5
	 h+D68OJTuagDBNwmq+vbP6cs4NkSG26AXq6rZCsNPwhOlvMy7A7+YyKZ5ozL7MFKXT
	 jvwTa6erqq02dVB6QxAKbGoAJsUfAxzTgj7dKDmsJxwsDIs7NJyMG3xqQrbbub1nDX
	 MBmPnBY8UzxLTCBRk/McYLc/Y4Cv2qX0KKSywBXGybKDRhSbwaU/8tRrPUNLJXiyxl
	 B0CIwSbbl0cQA==
Message-ID: <sashiko-outbox-185191@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 3/4] nbd: allow MPTCP sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <ed971f839d9482713fca427b4b3dad3935a593c4.1793010744.git.tanggeliang@kylinos.cn>
References: <cover.1793010744.git.tanggeliang@kylinos.cn>
 <ed971f839d9482713fca427b4b3dad3935a593c4.1793010744.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:14:55 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] nbd: per-I/O sk_set_memalloc() in __sock_xmit() leaks static key a=
nd locks
- [High] nbd: unreclassified MPTCP subflows and GFP_KERNEL in mptcp_worker(=
) deadlock
- [High] mptcp: new subflows miss SOCK_MEMALLOC sync in mptcp_sockopt_sync_=
locked()
--

commit 1d164aaf19b3c6998b999ca3f8b551a6fe753173
Author: Geliang Tang <geliang@kernel.org>

nbd: allow MPTCP sockets

This commit allows MPTCP sockets to be attached to NBD devices by checking
msk_is_mptcp(sock->sk) in nbd_get_socket().

> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index c5e26fc98d1aa..9cf89d53839a1 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
[ ... ]
> @@ -1222,8 +1223,9 @@ static struct socket *nbd_get_socket(struct nbd_dev=
ice *nbd, unsigned long fd,
>  		return NULL;
> =20
>  	if (!sk_is_tcp(sock->sk) &&
> +	    !msk_is_mptcp(sock->sk) &&
>  	    !sk_is_stream_unix(sock->sk)) {

[Severity: High]
With MPTCP sockets enabled here in drivers/block/nbd.c:nbd_get_socket(),
an earlier patch in this series (commit b144942ec73c, "sock: add
set_memalloc protocol callback") added a call to sk_set_memalloc(sock->sk)
inside the per-segment loop of drivers/block/nbd.c:__sock_xmit():

drivers/block/nbd.c:__sock_xmit() {
	...
		do {
			sock->sk->sk_allocation =3D GFP_NOIO | __GFP_MEMALLOC;
			sock->sk->sk_use_task_frag =3D false;
			sk_set_memalloc(sock->sk);
			msg.msg_flags =3D msg_flags | MSG_NOSIGNAL;
}

Looking at net/core/sock.c:sk_set_memalloc():

void sk_set_memalloc(struct sock *sk)
{
	sock_set_flag(sk, SOCK_MEMALLOC);
	sk->sk_allocation |=3D __GFP_MEMALLOC;
	static_branch_inc(&memalloc_socks_key);

	/* Call protocol-specific callback if available */
	if (sk->sk_prot->set_memalloc)
		sk->sk_prot->set_memalloc(sk);
}

Since NBD already calls sk_set_memalloc() at device setup in
nbd_start_device() and nbd_genl_reconnect_sock_cb() (and never calls
sk_clear_memalloc() on teardown), won't calling sk_set_memalloc() on every
send and receive iteration in __sock_xmit() cause several regressions?

1. Unbounded static key refcount leak and overflow:
   static_branch_inc(&memalloc_socks_key) is called unconditionally on
   every request header, write bvec, reply header, and read bvec until
   memalloc_socks_key.key.enabled saturates at INT_MAX, at which point
   kernel/jump_label.c:static_key_slow_inc_cpuslocked() takes
   jump_label_mutex and triggers
   WARN_ON_ONCE(!static_key_fast_inc_not_disabled(key)) on every I/O.

2. Lock hierarchy inversion in the block I/O path:
   static_branch_inc() calls static_key_slow_inc(), which acquires
   cpus_read_lock() (cpu_hotplug_lock) inside __sock_xmit() while
   nbd_queue_rq() -> nbd_handle_cmd() -> nbd_send_cmd() holds
   &q->q_usage_counter(io), cmd->lock, and nsock->tx_lock under
   memalloc_noreclaim_save().

3. Unlocked non-atomic race on sk->sk_flags:
   __sock_xmit() runs concurrently in the send path (under nsock->tx_lock)
   and the receive path (recv_work, without nsock->tx_lock or
   lock_sock(sk)), so sock_set_flag(sk, SOCK_MEMALLOC) performs an
   unlocked non-atomic __set_bit() racing with sk->sk_flags updates under
   lock_sock(sk) in sock_sendmsg() and sock_recvmsg().

4. Per-segment subflow lock contention:
   For MPTCP sockets, sk_set_memalloc() calls
   net/mptcp/protocol.c:mptcp_set_memalloc(), which acquires lock_sock(sk)
   and lock_sock_nested(ssk, SINGLE_DEPTH_NESTING) across all subflows
   before every sock_sendmsg() and sock_recvmsg() call.

[Severity: High]
Can attaching an MPTCP socket via nbd_add_socket() -> nbd_get_socket() ->
nbd_reclassify_socket() cause lockdep circular locking dependency warnings
and memory-reclaim deadlocks with MPTCP subflows and mptcp_worker()?

In drivers/block/nbd.c:nbd_reclassify_socket():

static void nbd_reclassify_socket(struct socket *sock)
{
	struct sock *sk =3D sock->sk;

	if (!sock_allow_reclassification(sk))
		return;

	switch (sk->sk_family) {
	case AF_INET:
		sock_lock_init_class_and_name(sk, "slock-AF_INET-NBD",
					      &nbd_slock_key[0],
					      "sk_lock-AF_INET-NBD",
					      &nbd_key[0]);
		break;

This only reclassifies the outer MPTCP master socket (sock->sk), while its
underlying TCP subflow sockets (ssk) created via sock_create_kern() in
net/mptcp/subflow.c:mptcp_subflow_create_socket() remain in the generic
kernel socket lock class (k-sk_lock-AF_INET / k-sk_lock-AF_INET6):

net/mptcp/subflow.c:mptcp_subflow_create_socket() {
	err =3D sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
	if (err)
		return err;

	lock_sock_nested(sf->sk, SINGLE_DEPTH_NESTING);
	...
	sk_net_refcnt_upgrade(sf->sk);
	err =3D tcp_set_ulp(sf->sk, "mptcp");
}

Here mptcp_subflow_create_socket() holds sf->sk's lock (k-sk_lock-AF_INET)
while calling sk_net_refcnt_upgrade() (which calls get_net_track() with
GFP_KERNEL) and tcp_set_ulp() -> subflow_ulp_init() -> subflow_create_ctx()
with GFP_KERNEL, establishing k-sk_lock-AF_INET -> fs_reclaim.

When NBD submits I/O via nbd_queue_rq() -> nbd_handle_cmd() ->
nbd_send_cmd() -> sock_xmit() -> __sock_xmit(), it holds
&q->q_usage_counter(io), cmd->lock, and nsock->tx_lock and calls into
mptcp_set_memalloc() and mptcp_sendmsg() -> __mptcp_push_pending(), which
acquire lock_sock(sk) (sk_lock-AF_INET-NBD) and lock_sock(ssk)
(k-sk_lock-AF_INET). Since blk_alloc_queue() establishes
fs_reclaim -> &q->q_usage_counter(io), doesn't this create a circular lock
dependency chain:

  k-sk_lock-AF_INET -> fs_reclaim -> &q->q_usage_counter(io) ->
  cmd->lock -> nsock->tx_lock -> sk_lock-AF_INET-NBD -> k-sk_lock-AF_INET

Additionally, in net/mptcp/protocol.c:mptcp_worker():

static void mptcp_worker(struct work_struct *work)
{
	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
	struct sock *sk =3D (struct sock *)msk;
	unsigned long fail_tout;
	int state;

	lock_sock(sk);
	...
	mptcp_pm_worker(msk);

mptcp_worker() acquires lock_sock(sk) (sk_lock-AF_INET-NBD) without
memalloc_noreclaim_save() or memalloc_noio_save() and runs
mptcp_pm_worker() -> __mptcp_subflow_connect() ->
mptcp_subflow_create_socket() and kernel_connect() (as well as
__mptcp_close_ssk() -> mptcp_event(..., GFP_KERNEL)), performing GFP_KERNEL
allocations under lock_sock(sk). If memory reclaim recurses into NBD I/O,
won't __sock_xmit() deadlock waiting for lock_sock(sk) held by
mptcp_worker()?

[Severity: High]
How do newly created or passively joined MPTCP subflows inherit
SOCK_MEMALLOC, sk_allocation, and sk_use_task_frag when an MPTCP socket is
used by NBD?

When the MPTCP path manager creates an additional subflow in
mptcp_worker() -> mptcp_pm_worker() -> __mptcp_subflow_connect() ->
mptcp_subflow_create_socket(), or finishes a passive MP_JOIN in
__mptcp_finish_join(), socket options are synchronized from the master
socket to the subflow via net/mptcp/sockopt.c:mptcp_sockopt_sync_locked():

void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
{
	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);

	msk_owned_by_me(msk);

	ssk->sk_rcvlowat =3D 0;

	/* subflows must ignore any latency-related settings: will not affect
	 * the user-space - only the msk is relevant - but will foul the
	 * mptcp scheduler
	 */
	tcp_sk(ssk)->notsent_lowat =3D UINT_MAX;

	if (READ_ONCE(subflow->setsockopt_seq) !=3D msk->setsockopt_seq) {
		sync_socket_options(msk, ssk);

		subflow->setsockopt_seq =3D msk->setsockopt_seq;
	}
}

Neither mptcp_sockopt_sync_locked() nor sync_socket_options() propagates
SOCK_MEMALLOC, sk->sk_allocation, or sk->sk_use_task_frag from msk to ssk.
Meanwhile, net/mptcp/protocol.c:mptcp_set_memalloc() only iterates over
subflows already in msk->conn_list when sk_set_memalloc() is called (which
also misses subflows still on msk->join_list waiting for mptcp_release_cb(),
and in nbd_start_device() and nbd_genl_reconnect_sock_cb() is called before
sk_allocation =3D GFP_NOIO | __GFP_MEMALLOC and sk_use_task_frag =3D false =
are
assigned).

Won't this leave new subflows with ssk->sk_allocation =3D=3D GFP_KERNEL dur=
ing
kernel_connect() and without SOCK_MEMALLOC set (for instance, while
recv_work is already blocked in mptcp_recvmsg()), causing GFP_KERNEL
allocations during connection establishment and causing incoming pfmemalloc
packets on the new subflow to be dropped by sk_filter_trim_cap() under
memory pressure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793010744.gi=
t.tanggeliang@kylinos.cn?part=3D3
