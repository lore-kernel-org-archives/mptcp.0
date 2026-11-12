Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459580;
	b=RAuMZ5lVN6LIOtbS9XYMMVxrEWzHzxF9RdRrrQTSOUnftUCOC3ioDEdhfIJss+2aQEQ/
	 3/teOCrcQFmnjnYWra0/0TQW8sbHZ3n+4JNsEWA1W9hvyQI0Pui1+Sl1dPjwCm0ghJbLD
	 3YHlcOoKSUu0tysVMi76bM20K9Rm9cfSwBPyFNJXJJbumjsTNSZETilsK8MPfVrs59RTE
	 sgNQlKA6LmDTVaPJaPxFTzx7bAIlFN6L+/JNJz/qyAoQX2Fhe5V4IoZ6GiJFNstloZU66
	 Oyq6gF1A34ACFtxAmlVdOAwdQ1Fw+KYN3BLMvYVH7IaJkYRo0Sh+iCu9wSBeHv/8+4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459580;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6Bd0qNNO5kyV3hyjPhgl/xwB0u0cTb4nLBDdKuYZlnY=;
	b=FA2I+e3HtfH5oWI/Kh0vMUtJVw/30cQZkXR/ESLvfweoeVLm14DEfWpkhqrPXW1WvdmF
	 kNv+SqBIGwD2Z+UG5pgFFqYx3wDRDSjvvSJkgIKpi2lBxHesZThsUbR5eTbWtyefVns+R
	 fzMEuPQ03Glp56+/NfJTqOW9nmalbGhmP24LG662tm7RKhsR7UOxZH6zPZwn0fUOCKEh0
	 uAef/itYmS+kS6tkTB95sq+YIdkL0GOzSL0A2MIbZYiqkSsOlHUo2KJjWmdNPsYqX7CXU
	 jBPZKoMjVMnVLAovXcLY1QNUMN92b//NC0tKHY1VARaLersMThTbjfa5ns/lfVT5Vxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHEGF449;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F2606A32D
	for <mptcp@lists.linux.dev>; Thu, 12 Nov 2026 04:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHEGF449
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482D81F00A0C;
	Thu, 12 Nov 2026 04:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794459580;
	bh=6Bd0qNNO5kyV3hyjPhgl/xwB0u0cTb4nLBDdKuYZlnY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WHEGF449K/tdeE7+kJACwtS+wRQ/9O6sYel3qy426onFvO5L54LcEGSJ0IHSOEjmd
	 4KDBEAApCGR1T1/oforD6B4L5fwRSPmxj5ODEJz5SgSuqA2YrrkQ01aGWt650w4vPa
	 nSfY9UEfNKD2icHfJ6RKnDYgeNjG8ZEhxDpBjyQ9AT9C1P6y/qGtoDkT7S9OgKU48U
	 ImMnyvXWYgqJCG2cypbWHPXoLSEFdbWTKd6fn2RnTnbHGINAbdscVCCuA1QDByE9lP
	 bpDzyKjm79DxI6hjBSe9KKa6CbLu3xvXkxO6jWO7Rgbey61kWUPcEdcaG4OCz0NNYl
	 oW96pj2HEvFUQ==
Subject:
 Re: [PATCH mptcp-next v25 8/8] mptcp: defer read_sock cleanup to mptcp_worker
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 12 Nov 2026 04:59:39 +0000
Message-ID: <179445957978.488855.18074378536120470954@kernel.org>
In-Reply-To: <7396957e6e466cb4cf6864734d805c823451a5a3.1794304840.git.tanggeliang@kylinos.cn>
References: <7396957e6e466cb4cf6864734d805c823451a5a3.1794304840.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message lists svc_tcp_recvfrom() as a current caller
  of __mptcp_read_sock(), but it can never reach an MPTCP socket.

--

mptcp: defer read_sock cleanup to mptcp_worker

This patch makes the cleanup step of __mptcp_read_sock() conditional.
When the caller owns the socket lock, the cleanup still runs inline. When
it does not (the planned BH context for MPTCP TLS), the consumed byte
count goes into msk->read_copied and the work is handed to mptcp_worker()
through MPTCP_WORK_READ_COMPLETE. The backlog flush in mptcp_recv_skb() is
also gated on sock_owned_by_user().

The commit message says:

> Note: The BH call path does not exist in the current tree. This is
> groundwork for the upcoming MPTCP TLS series. Currently, the only
> callers are mptcp_splice_read() and svc_tcp_recvfrom(), both of which
> hold lock_sock() and run in process context.

[Severity: Low]
Can svc_tcp_recvfrom() actually reach an MPTCP socket?

svc_tcp_recvfrom() does call sock->ops->read_sock() under lock_sock().
Kernel-created svc sockets are made with IPPROTO_TCP via
sock_create_kern(), though. The BPF update_socket_protocol() hook that can
turn TCP into MPTCP only runs on the socket() syscall path.

Sockets passed in from userspace go through svc_addsock() in
net/sunrpc/svcsock.c, which rejects anything other than TCP or UDP:

	err =  -EPROTONOSUPPORT;
	if (so->sk->sk_protocol != IPPROTO_TCP &&
	    so->sk->sk_protocol != IPPROTO_UDP)
		goto out;

An MPTCP msk always has sk_protocol == IPPROTO_MPTCP. That would leave
mptcp_splice_read()->__mptcp_splice_read() as the only in-tree path into
__mptcp_read_sock(), and it takes lock_sock() first.

Could the note drop svc_tcp_recvfrom() from the caller list, so readers
don't conclude that NFS/sunrpc over MPTCP is affected? The conclusion that
only the inline branch runs today still holds.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 981599a702163..5318b54920e4e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4650,6 +4670,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
>  /*
>   * Note:
>   *	- It is assumed that the socket was locked by the caller.
> + *	- Can be invoked in BH scope.
>   */
>  static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  			     sk_read_actor_t recv_actor, bool noack)

[Severity: Low]
The new comment on __mptcp_read_sock() says it can be invoked in BH scope.
The commit message says no BH call path exists in the current tree.

Would it be clearer to word this as a future possibility (for example, for
the upcoming MPTCP TLS support), or to add the comment together with the
series that adds the BH caller? As written, it describes planned behaviour
rather than the code being merged.

The first line of the same comment also still says the socket is assumed to
be locked by the caller. That sits a bit oddly next to a BH path that does
not own the socket lock.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794304840.git.tanggeliang%40kylinos.cn
