Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8F479E1
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806186; cv=none; b=GACQkQRxMUIk/EZqbK4BEjdoOYIb9ODifEOHZEqe4mlXtDjd3BZMcnCLFAT3E9qCExiGs6sjAlhFjoE0oHpyfujSZ2JNPHPTnzy+z+qSJIBJmGjAZgQrO4TvD76fs0vZk7GmHSfK1JRPZSyJhq09hv96Rl0XyYRjW+NySFwQQOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806186; c=relaxed/simple;
	bh=xIMMGDr+WsAJfAO4pKTmvR7l+M5cTxCQLjLj8tnB+Fg=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=U3XcynpZp3+cvfLjdAfkR4FGeu3C/tj/AxMonySuo/nLyffApKTqonDG+p88ZbCcPNlON/4RaVxBpnEKpEKDeGgAUOLigLv6/it+M3L6V5YfEA4TYi2L+PalGLQa1wFTCsT2Y7IIgoii/wH+Q/6+rkM8NMerjsTxOKdw1ZUz+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa2ey2EI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa2ey2EI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E72CC2BBFC;
	Mon, 27 May 2024 10:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716806186;
	bh=xIMMGDr+WsAJfAO4pKTmvR7l+M5cTxCQLjLj8tnB+Fg=;
	h=Date:Subject:References:From:To:Cc:In-Reply-To:From;
	b=aa2ey2EIlx906Fpt7a6Fsp/u/37qITm/2Af34QOctUPPRCa1i9q6JNvrGensXRZDd
	 CcNbg3mYIA/6ZGIFzeiIwafM+Pfuy1zMpJHlSngsRVmov3YQhsZfMfcgaXgKvFHcq/
	 yc5QLnTGc7unmdFa6wnrENug7m6js5A/C7q8n2EP6RI8yBlG4uLru1J5JUk5E28Ocd
	 rNmfmT3cNBLKL/VeUud2pfRVL5hEbuc0+KCrFA2MhO7M8U9i+iUo/2HyXEL+4R2EQE
	 Ora6RH5cnqY3j8B9AeDD+PVMizos+ZFghHpacjMboNbqGl+26cN9jHYvlaFl38uVMS
	 CQuB1Bkz5DGIA==
Message-ID: <d7c53bce-f759-4102-a1f1-46a836110c6c@kernel.org>
Date: Mon, 27 May 2024 12:36:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Fwd: Patch "mptcp: implement TCP_NOTSENT_LOWAT support" has been
 added to the 6.8-stable tree
References: <20240526173559.3483900-1-sashal@kernel.org>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
In-Reply-To: <20240526173559.3483900-1-sashal@kernel.org>
X-Forwarded-Message-Id: <20240526173559.3483900-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

It looks like your series adding TCP_NOTSENT_LOWAT support (4 patches)
has been selected to be backported to v6.8 to ease the backport of
"mptcp: fix full TCP keep-alive support". I was going to complain, but
it doesn't seem to hurt, only adding an isolated feature, and most
importantly, v6.8 will likely be marked as EOL in less than a month. No
objections then?

Cheers,
Matt


-------- Forwarded Message --------
Subject: Patch "mptcp: implement TCP_NOTSENT_LOWAT support" has been
added to the 6.8-stable tree
Date: Sun, 26 May 2024 13:35:59 -0400
From: Sasha Levin <sashal@kernel.org>
Reply-To: stable@vger.kernel.org
To: stable-commits@vger.kernel.org, pabeni@redhat.com
CC: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
<martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, David S.
Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
Kicinski <kuba@kernel.org>

This is a note to let you know that I've just added the patch titled

    mptcp: implement TCP_NOTSENT_LOWAT support

to the 6.8-stable tree which can be found at:

http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-implement-tcp_notsent_lowat-support.patch
and it can be found in the queue-6.8 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.



commit 2a46eda8186692bbbf798c05afd9481c5d708887
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Fri Mar 1 18:43:46 2024 +0100

    mptcp: implement TCP_NOTSENT_LOWAT support
        [ Upstream commit 29b5e5ef87397963ca38d3eec0d296ad1c979bbc ]
        Add support for such socket option storing the user-space provided
    value in a new msk field, and using such data to implement the
    _mptcp_stream_memory_free() helper, similar to the TCP one.
        To avoid adding more indirect calls in the fast path, open-code
    a variant of sk_stream_memory_free() in mptcp_sendmsg() and add
    direct calls to the mptcp stream memory free helper where possible.
        Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/464
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    Reviewed-by: Mat Martineau <martineau@kernel.org>
    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>
    Stable-dep-of: bd11dc4fb969 ("mptcp: fix full TCP keep-alive support")
    Signed-off-by: Sasha Levin <sashal@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fcd85adc621c1..54e29ab911f0d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1757,6 +1757,30 @@ static int do_copy_data_nocache(struct sock *sk,
int copy,
 	return 0;
 }
 +/* open-code sk_stream_memory_free() plus sent limit computation to
+ * avoid indirect calls in fast-path.
+ * Called under the msk socket lock, so we can avoid a bunch of ONCE
+ * annotations.
+ */
+static u32 mptcp_send_limit(const struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 limit, not_sent;
+
+	if (sk->sk_wmem_queued >= READ_ONCE(sk->sk_sndbuf))
+		return 0;
+
+	limit = mptcp_notsent_lowat(sk);
+	if (limit == UINT_MAX)
+		return UINT_MAX;
+
+	not_sent = msk->write_seq - msk->snd_nxt;
+	if (not_sent >= limit)
+		return 0;
+
+	return limit - not_sent;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1801,6 +1825,12 @@ static int mptcp_sendmsg(struct sock *sk, struct
msghdr *msg, size_t len)
 		struct mptcp_data_frag *dfrag;
 		bool dfrag_collapsed;
 		size_t psize, offset;
+		u32 copy_limit;
+
+		/* ensure fitting the notsent_lowat() constraint */
+		copy_limit = mptcp_send_limit(sk);
+		if (!copy_limit)
+			goto wait_for_memory;
  		/* reuse tail pfrag, if possible, or carve a new one from the
 		 * page allocator
@@ -1808,9 +1838,6 @@ static int mptcp_sendmsg(struct sock *sk, struct
msghdr *msg, size_t len)
 		dfrag = mptcp_pending_tail(sk);
 		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
 		if (!dfrag_collapsed) {
-			if (!sk_stream_memory_free(sk))
-				goto wait_for_memory;
-
 			if (!mptcp_page_frag_refill(sk, pfrag))
 				goto wait_for_memory;
 @@ -1825,6 +1852,7 @@ static int mptcp_sendmsg(struct sock *sk, struct
msghdr *msg, size_t len)
 		offset = dfrag->offset + dfrag->data_len;
 		psize = pfrag->size - offset;
 		psize = min_t(size_t, psize, msg_data_left(msg));
+		psize = min_t(size_t, psize, copy_limit);
 		total_ts = psize + frag_truesize;
  		if (!sk_wmem_schedule(sk, total_ts))
@@ -3761,6 +3789,7 @@ static struct proto mptcp_prot = {
 	.unhash		= mptcp_unhash,
 	.get_port	= mptcp_get_port,
 	.forward_alloc_get	= mptcp_forward_alloc_get,
+	.stream_memory_free	= mptcp_stream_memory_free,
 	.sockets_allocated	= &mptcp_sockets_allocated,
  	.memory_allocated	= &tcp_memory_allocated,
@@ -3932,12 +3961,12 @@ static __poll_t mptcp_check_writeable(struct
mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 -	if (sk_stream_is_writeable(sk))
+	if (__mptcp_stream_is_writeable(sk, 1))
 		return EPOLLOUT | EPOLLWRNORM;
  	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 	smp_mb__after_atomic(); /* NOSPACE is changed by mptcp_write_space() */
-	if (sk_stream_is_writeable(sk))
+	if (__mptcp_stream_is_writeable(sk, 1))
 		return EPOLLOUT | EPOLLWRNORM;
  	return 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6b83869ef7938..2f17f295d7c8b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -305,6 +305,7 @@ struct mptcp_sock {
 			in_accept_queue:1,
 			free_first:1,
 			rcvspace_init:1;
+	u32		notsent_lowat;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
@@ -789,11 +790,36 @@ static inline bool mptcp_data_fin_enabled(const
struct mptcp_sock *msk)
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 +static inline u32 mptcp_notsent_lowat(const struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+	u32 val;
+
+	val = READ_ONCE(mptcp_sk(sk)->notsent_lowat);
+	return val ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
+}
+
+static inline bool mptcp_stream_memory_free(const struct sock *sk, int
wake)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 notsent_bytes;
+
+	notsent_bytes = READ_ONCE(msk->write_seq) - READ_ONCE(msk->snd_nxt);
+	return (notsent_bytes << wake) < mptcp_notsent_lowat(sk);
+}
+
+static inline bool __mptcp_stream_is_writeable(const struct sock *sk,
int wake)
+{
+	return mptcp_stream_memory_free(sk, wake) &&
+	       __sk_stream_is_writeable(sk, wake);
+}
+
 static inline void mptcp_write_space(struct sock *sk)
 {
 	/* pairs with memory barrier in mptcp_poll */
 	smp_mb();
-	sk_stream_write_space(sk);
+	if (mptcp_stream_memory_free(sk, 1))
+		sk_stream_write_space(sk);
 }
  static inline void __mptcp_sync_sndbuf(struct sock *sk)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 82d0cd0819f09..f2fe28a3912a9 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -810,6 +810,16 @@ static int mptcp_setsockopt_sol_tcp(struct
mptcp_sock *msk, int optname,
 		return 0;
 	case TCP_ULP:
 		return -EOPNOTSUPP;
+	case TCP_NOTSENT_LOWAT:
+		ret = mptcp_get_int_option(msk, optval, optlen, &val);
+		if (ret)
+			return ret;
+
+		lock_sock(sk);
+		WRITE_ONCE(msk->notsent_lowat, val);
+		mptcp_write_space(sk);
+		release_sock(sk);
+		return 0;
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_CORK:
@@ -1343,6 +1353,8 @@ static int mptcp_getsockopt_sol_tcp(struct
mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->cork);
 	case TCP_NODELAY:
 		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
+	case TCP_NOTSENT_LOWAT:
+		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	}
 	return -EOPNOTSUPP;
 }
