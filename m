Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955276;
	b=rlZ4rU8nLKh1aJTreDgFrIxgSJi5ZAk0Dbgubk+JsgbCPxbysw+OHvaOlnH5ycHVLqlW
	 Kbp/3/yuvakNk8GicPoP4910R3w7bLCVhrkWtXBhOa/u6caPu2NBq54LYbEhd2qHe09BX
	 inq73lZaIldTWqxFNQAqqL2X7yfJlfLZ/vCdjoV3xqKXYE3S2GB6kSLrZzrP1FdyQGsJ9
	 m38XWPcE+fyVQfG1FdKjQCq1VvtTKXX/+p7J1yLhSq6Y/R8WmSxIi8TvCZlFApAXmqhB5
	 s/Cx5fl/UuuO/yZm95vyAfH6bChomlF4B56R0q74ESuAlFX444nnVuy9yB4f8ssZrww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955276;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OJ4S6Dn5Gatk35oA5Rvm1euPBbNUAXuvECdEwXe+XVM=;
	b=OQSDPcGQnHDrV9hwvxuX8knZj/S+t89glbyFqXsMu1GRve+Em66vM6+Hz/YHyeeIE1EM
	 uQHtjOTX6IAaqVYlv4Gzwt7IS0y5e5ELT1dRgwN9FsRiJFF472gmpfZx8e1hwTVlZIiJL
	 5OHerJCFyXi0XjpXFu4ipfwelhGjrLs16eAZ+NcGjA8ZSzfJoDjlenSfxx2Ab0BzQEyn+
	 UoBTkdwPxrlhXZgyEtzjOiiQK6DLl87TiYiiOz72aDHw3HfSVF0qnFHRgOQhg3CJ1Y2C5
	 V/9mcidX2v08/OHkTcEStJXtwErQy6t/LYWnASjRRN6mDqjH63L4Tn8JfWxWoSvJ2Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCKqfShL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB89606A31C
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCKqfShL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C9D1F000C4;
	Tue, 17 Nov 2026 22:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794955276;
	bh=OJ4S6Dn5Gatk35oA5Rvm1euPBbNUAXuvECdEwXe+XVM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XCKqfShLDu2TaXgOE61zFL7Izrr3PmdP6QEsvtWPK9O77yIK5vrRdgSL0eIR+otBr
	 yXY4Vv62ZqGqKbW9LX4IfLA3/KEEL2imxkq/Sc3WCZvyQTQ1zeEZHX0bEQG95EzzkC
	 IQHKw0PndaDkwqpW3hrQjTLIqIgQJ3mFHCKbXiGY1g4oGLyQFyGrrPsQvbB5vl7y8O
	 AFiwRrp0bnfUNDO+mX+TL57XI2LXyIH5xm0WqCeUftjvhZ7Ha8a/Li9KGNpu6NJseH
	 SVTzsrrh0AuHOnfoEgHEhiGti+NODACmkgWNyrABcAHfoWgWaBFbuMUU1FqQw8+ru/
	 QcZ4k40ZwgJpw==
Subject: Re: [PATCH mptcp-next v28 11/11] mptcp: defer read_sock cleanup to
 mptcp_worker
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 17 Nov 2026 22:41:15 +0000
Message-ID: <179495527523.3133.17105885875026800695@kernel.org>
In-Reply-To: <f2ed3479f40b044646d03ccbfe0347c7f6a40dc7.1794810809.git.tanggeliang@kylinos.cn>
References: <f2ed3479f40b044646d03ccbfe0347c7f6a40dc7.1794810809.git.tanggeliang@kylinos.cn>
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

- [Low] The patch adds code that nothing in the current tree can run.

--

mptcp: defer read_sock cleanup to mptcp_worker

This prepares __mptcp_read_sock() to be called from BH context for a
future MPTCP TLS series. When the caller does not own the socket lock,
it defers mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() to
mptcp_worker() through msk->read_copied and MPTCP_WORK_READ_COMPLETE.
It also gates the backlog flush in mptcp_recv_skb() on
sock_owned_by_user().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 50ae8cdec8a4a..6988f6128368e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4669,6 +4689,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
>  /*
>   * Note:
>   *	- It is assumed that the socket was locked by the caller.
> + *	- Can be invoked in BH scope.
>   */
>  static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  			     sk_read_actor_t recv_actor, bool noack)

[ ... ]

> @@ -4710,11 +4731,18 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
This isn't a bug, but can this else branch be reached by anything in the
current tree?

The only direct caller of __mptcp_read_sock() is mptcp_read_sock(). That
is reached from mptcp_splice_read() and from the generic
proto_ops->read_sock users. Each of them either holds lock_sock() or
cannot attach to an MPTCP socket:

  mptcp_splice_read()  - holds lock_sock()
  nvme_tcp_try_recv()  - calls lock_sock() before ops->read_sock()
  svc_tcp_read_msg()   - calls lock_sock() before ops->read_sock()
  strparser BH users   - KCM rejects csk->sk_protocol != IPPROTO_TCP

So sock_owned_by_user(sk) looks to be always true here. That would make
the BH branch, mptcp_read_complete(), the MPTCP_WORK_READ_COMPLETE bit,
and the msk->read_copied init and reset in __mptcp_init_sock() and
mptcp_disconnect() all unused for now.

The new "Can be invoked in BH scope" comment above __mptcp_read_sock()
also describes something no current caller does.

The commit message says this is groundwork for the MPTCP TLS series.
Would it make sense to merge this together with the first BH caller, so
the deferred cleanup can be tested and reviewed against that caller's
locking rules?

>  	}
>  out:
>  	return copied;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794810809.git.tanggeliang%40kylinos.cn
