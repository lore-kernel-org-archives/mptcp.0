Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353545;
	b=xN2yei2tRbBA5cJgle4pcBOpowCba2ocDeryTCAzAW8rYnP1XZYR+7RYFb80qi6Xmb1w
	 0cEPwz9J6YEng0bALPESHeK19O/PnwCzxLStczNQz1DiYa/ZztkBUvFJqmA32RBeYpkzm
	 TYqA7LvMjKSpX8gWKvy9BvOoWDCSfuRjS73ZNqeFvZtMH03eDlYlnnhNipu6QkvVuMJ/n
	 h1skN11eCGIAHHlhccliVQ7/Yf2rsPA2VwSGpNFDcdo1vDtU4Ec/AlaTZWeXiURtsvZpf
	 S5S18D4lyKjVkzqzdpf9W/O6FAH5BTVzEg/am4pR4lJfPboNg3IUsPTQjqD9hYbIhag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353545;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oWIhhzbEF8GtEkDmzLxeTxV6Y7keBahxeJCJHzXg+LY=;
	b=zUWbDLkTb/Mg33YD3ZRHGeQkyRKO7ktI4hebjTPTWmRHOFqeknsxqq2CPGvkEYUQKJAu
	 7Jyd964OZZmCZzfq2WOowg0+0jUIS7llGhETIcKVmxjw7mN/IWw054/LifB4ate0OvSnb
	 r6O2Z9R/w6/XeF7wvVa99vLknyIdwctcsTsN+t9dGjernsfRVvnYZPZQBEC01dz9BsnVM
	 v4L9JAQwCgRY25PVytn8Z6ZrMOfsr+fS3hGFNSH35f1g7257sLwRIhVV+o7b6I/kiI1UN
	 /sUXLHaAuV22yYRSOcFNgtiVj9dOFcEU3JB6cZ2cVPEK3+GkC/FJtJJGEGai27vP8Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0jKX5aW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246CC606A31C
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0jKX5aW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4521F00A04;
	Tue, 10 Nov 2026 23:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353545;
	bh=oWIhhzbEF8GtEkDmzLxeTxV6Y7keBahxeJCJHzXg+LY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e0jKX5aWDB5nQ+t7suU2q2ETVJAwdUrYL/DhJEXdY+dWWnKTYu4iiH4vNlmvVcL83
	 zNK1v094N+u1PTWI7SiJ6fOHCLn24kJP/YRq+8kO5s9I39j+0ngoyel/cHSm9GdgHe
	 hGJsVkSioaQlNTezneOvxkUVbTi35j3Oth2MoxskOQR1JIr11bNawAqNTNXvgdKqrE
	 MQ/1689v5qsRpSl9lnyNtVu+AjAauMa3goNpZlfLDHhso7GmqZENQxt1JEgHPwsDhS
	 ZJM4HYfE5F3XhrbicGQB6W3hNRNrB++NH+s4k5VuG6SvL9V0j9lZSgUmtAtgLLrhjf
	 16XclM6WsEjlg==
Subject:
 Re: [PATCH mptcp-next v24 8/8] mptcp: defer read_sock cleanup to mptcp_worker
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 10 Nov 2026 23:32:24 +0000
Message-ID: <179435354437.488855.2718889717172311369@kernel.org>
In-Reply-To: <c47e1e62a4cc0166578a001304309fe9cbdbfdda.1794215614.git.tanggeliang@kylinos.cn>
References: <c47e1e62a4cc0166578a001304309fe9cbdbfdda.1794215614.git.tanggeliang@kylinos.cn>
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

- [Low] The patch adds a deferred-cleanup path that nothing in the
  current tree can reach.
- [Low] The Signed-off-by address does not match the author.

--

mptcp: defer read_sock cleanup to mptcp_worker

This patch prepares __mptcp_read_sock() for a future BH context caller
(TLS over MPTCP). When the socket lock isn't owned, it defers
mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() to mptcp_worker() using
a new msk->read_copied counter and the MPTCP_WORK_READ_COMPLETE flag. It
also gates the backlog flush in mptcp_recv_skb() on sock_owned_by_user().

> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the Signed-off-by address doesn't match the commit
author:

  Author: Geliang Tang <geliang@kernel.org>
  Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

checkpatch.pl reports this as FROM_SIGN_OFF_MISMATCH. Could the From:
address be changed, or a Signed-off-by with the matching address be added?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 683ffa8f6c7a2..3f81a55e6e00a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4731,11 +4752,18 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
> +			set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
> +			mptcp_schedule_work(sk);
> +		}

[Severity: Low]
This isn't a bug, but can anything in the current tree reach this else
branch? It only runs when sock_owned_by_user(sk) is false.

Every ->read_sock caller on an MPTCP socket takes the socket lock first:

mptcp_splice_read()
    lock_sock(sk);
    __mptcp_splice_read()->mptcp_read_sock()->__mptcp_read_sock()

net/sunrpc/svcsock.c:svc_tcp_recvfrom() {
    ...
	lock_sock(sock->sk);
	len = sock->ops->read_sock(sock->sk, &desc, svc_tcp_recv_actor);
    ...
}

strparser can't be attached to an MPTCP socket either. KCM requires
csk->sk_protocol == IPPROTO_TCP, and sockmap requires sk_is_tcp().

The commit message says the same thing:

  "The BH call path does not exist in the current tree. This is
  groundwork for the upcoming TLS-over-MPTCP series."

That means MPTCP_WORK_READ_COMPLETE is never set and msk->read_copied stays
zero. As a result, mptcp_read_complete() is never called from
mptcp_worker().

Without the TLS caller, it is hard to judge whether the deferred path is
complete. For example, it skips the trailing mptcp_recv_skb() call that
eats fully consumed skbs. It also delays window updates and autotuning
until the worker runs. No test covers this path either.

Would it be better to post this patch in the same series as the
TLS-over-MPTCP changes that first use it?

>  	}
>  out:
>  	return copied;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794215614.git.tanggeliang%40kylinos.cn
