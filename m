Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704608;
	b=gWERc0iS+fP5Mf2rtLo/Dkr4mu+vj+UoFfouIeVqG14ReHlpowALbdFvCYhwS3OKg3VX
	 y7EhJpbskWfozaO5adIctMOnKF3BylP7eQRWZAWf5vBQVtR6fH2+9TwKOOdXH2jVzZW/B
	 86PwPi6Wc2FJntfRKzyCl9jzxn4vvlvIA/uS6evCQiuS7XY3e8SJOF1L9ZyWLqg7TQIuD
	 i9Gx6jp+9EgR64ZVtrYJHfoIwxHrp0cg1FEdV3Bep3qT9M6z4ZyHJlH/+q1Z2KZIvZiBJ
	 pDXNXR4qVvWmepQ+F8niiEh3Lj/fuPqe9uonxBUXxB1Tq4x2PGqDbGWaeF4IOEubMlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704608;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fluwiKM0KNN0wfG8/BT1XGUY+T1aqurTHjBkjG2BhDc=;
	b=EKzK+YIbQHFsVLWmK+0YsEWcdUFxGpSt1+JgAA3rEyMqMLpyDbOIpk3DYv2YrwML/1gt
	 N7fuK+XEwfyxp2+iWd6foMkDmT8K58LQ2ElfQOM6TWuT/g9sIgfkO6McI2YHXORzkSq8Q
	 XEs0/Y/Mrs3nDvH4eXjbQ+6ZeugX5L8LHvYJilnBSf8Nn726YT3ZfYKBm8D1HWr/iEkAp
	 jixnS8UF7ZWb7IoAfVDeoK6KD0qhQo/mkqWYy/LiBkOWYHxKP4sPqN+91XQPlkyajli6R
	 VoN2JjTtu4XddPxo/wEmSAe8o2knLicJ3KcOHhUbhq9BNUOCaYnPYZg/sTK1yi04Mgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFWJ+28S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BB9606A329
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 01:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFWJ+28S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBE61F000C8;
	Sun, 15 Nov 2026 01:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794704607;
	bh=fluwiKM0KNN0wfG8/BT1XGUY+T1aqurTHjBkjG2BhDc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nFWJ+28SJM8mq74mzUeASsT6C0T1mJWBVH6ST572ysI2IAUhBNTYBNnYC23Nh4G2W
	 GjbEVt4Unee8+k2yIHnDauxcbu/yQHIOEjKT3MfKHd0WJWvRtOIP7uQLFf0dtkcggc
	 rm6+wopi70B9tzq0cDgtQujiVZxpM6AVxOX9P+WY1KhS/3wUrSbt31fDSHu3CjH1dq
	 LniVmn6EsotnsA3pOJbQXqCjRhK+saMfRe4PMIipkxAMhkNslMQsRZ7++kC32lEGMQ
	 eDbsaDU/xk/5tzZY1inT5D72A4EfljTglZfcMUAFibTuNVoAV0dPU9a2EFGYzTrVeO
	 6BluE2HLbYC9A==
Subject:
 Re: [PATCH mptcp-next v26 8/8] mptcp: defer read_sock cleanup to mptcp_worker
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sun, 15 Nov 2026 01:03:27 +0000
Message-ID: <179470460729.488855.14344814021715509505@kernel.org>
In-Reply-To: <00ee9df4e862fe136c4b2a953abf065d2507a173.1794563432.git.tanggeliang@kylinos.cn>
References: <00ee9df4e862fe136c4b2a953abf065d2507a173.1794563432.git.tanggeliang@kylinos.cn>
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

- [Low] The commit's author address does not match its sign-off address.
- [Low] msk->read_copied (a signed int in struct mptcp_sock,
  net/mptcp/protocol.h:332) collects consumed bytes in the deferred…

--

mptcp: defer read_sock cleanup to mptcp_worker

This patch prepares __mptcp_read_sock() to be called from BH context by
a future MPTCP TLS series. When the caller doesn't own the socket lock,
the consumed byte count goes into msk->read_copied. The receive space
adjustment and rbuf cleanup are then deferred to mptcp_worker() through
MPTCP_WORK_READ_COMPLETE.

> Author: Geliang Tang <geliang@kernel.org>

[ ... ]

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the From: address and the only Signed-off-by
address don't match. checkpatch.pl reports this as
FROM_SIGN_OFF_MISMATCH ("From:/Signed-off-by: email address mismatch").

The earlier patches in this series, co-developed with Paolo Abeni, sign
off as Geliang Tang <geliang@kernel.org>.

Could this patch either use the kylinos.cn address in From:, or add a
Signed-off-by with the kernel.org address?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d124b702c9576..91523bdd1b30d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4702,11 +4723,18 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	if (noack)
>  		goto out;
>  
> -	mptcp_rcv_space_adjust(msk, copied);
> -
>  	if (copied > 0) {
> -		mptcp_recv_skb(sk, &offset);
> -		mptcp_cleanup_rbuf(msk, copied);
> +		if (sock_owned_by_user(sk)) {
> +			/* Process context: inline cleanup */
> +			mptcp_rcv_space_adjust(msk, copied);
> +			mptcp_recv_skb(sk, &offset);
> +			mptcp_cleanup_rbuf(msk, copied);
> +		} else {
> +			/* BH context: defer to worker */
> +			msk->read_copied += copied;

[Severity: Low]
Can msk->read_copied wrap negative here? It is declared as a signed int
in struct mptcp_sock. Nothing bounds it, and only mptcp_worker() drains
it.

While the work item is already pending, schedule_work() returns false,
but each new BH read still adds to the counter. If more than INT_MAX
bytes go through this path before mptcp_worker() runs, the sum goes
negative. A delayed system workqueue on a fast link is one way that
could happen.

mptcp_read_complete() would then do:

	mptcp_rcv_space_adjust(msk, read_copied);
	if (read_copied > 0)
		mptcp_cleanup_rbuf(msk, read_copied);

mptcp_rcv_space_adjust() returns early when copied <= 0, and the
read_copied > 0 test skips mptcp_cleanup_rbuf(). The whole batch is
then lost to receive buffer autotuning, and no forced window update is
sent for it. The counter is reset to 0 afterwards, so later cycles
recover.

The kernel builds with -fno-strict-overflow, so the wrap itself is
defined, but UBSAN signed-wrap builds would report it.

Would an unsigned or 64-bit accumulator, or saturating the value, work
better here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794563432.git.tanggeliang%40kylinos.cn
