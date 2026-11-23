Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415557;
	b=kVwXpP+D4QARyEHAnGKV4WAaoWC/wSH30ebPpBf39Yh1YVk8FDcklHRHyoqLPRXvJ3EZ
	 93aOzL5trTdFHhFQkXuSyKelHcqgVneEQvy5KBhNauqR0swk/B+mvaiT0jFIicIdDAByg
	 3uuc7MggybNSL0lK+4oqxHdK5ymqEMP8hEkT7NHjjozbeJzS4K6sdpyj5VtuJwgj6N6up
	 +vr0lsrxDFR6sDEu2Z87ddJGBAAn8vWPxd9K68D2bqfbJHKnOGGGEx7odS5Nuwdme8KpP
	 ml/+M4J9lClz9EA8HHnDGcG55c5KohG+HDYyEHzyxHm+dbQl7BysD5Ikyaz1C/L3OrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415557;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=L/xeqxjlXAddYFJaEndYC4GELMcrPXXuTTumc77uhPY=;
	b=u1N4+jPSt7APQ9cmrK/LGXBfwwIM9wL8eYCMIe+dMth5mEJtpnMsNMWtq/SdUqQdoOtH
	 /kPykiRkQtizix7ZJOg344OZmeT+7zrdxPpCHpRKHnDZlfcLLhKN8HDxvrAWfPf10zrCj
	 qUVeiCXeD/76NznIETnWNXg7KisWyI+BEbsEIt0drRtKndJQlo91zrxL+4E1kJ8FMFqB4
	 0M1RQVW4ki1YahI0VS3CPVdIzHOrSB4pNJcx5sA4EQC1WyTZzes3n3aKD9WoDwbcnSl+b
	 zXcHRpNtSED0Gjj5qkLTcwyqhx+7mrBtbkYQ9AXqXknm5LIfhhpBjLquRv6kdr+fKJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LL+bw/p8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DDC606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LL+bw/p8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285981F000EB;
	Mon, 23 Nov 2026 06:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415557;
	bh=L/xeqxjlXAddYFJaEndYC4GELMcrPXXuTTumc77uhPY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LL+bw/p8N0lUj7tYJ9Q5WPqcMK+gbqK+1nuVyguNPjgFJtLaeIU2c/mPb74lEvwDp
	 uYxxZBh/9/Wza0VGx1YiD3RT2XwBkeWUHyUbDuP97Eluz/7uTPqeIiy5nLzbtr3VcT
	 GOgIi0aqmJwPbdXUvVcyEEDhWYSXv8sTP7cNFlDK2Hy4HuC2XwClQgDeUpTW4RO6Xj
	 YRWI/yWfQOct2E3rSpYl74ENoYS1rESvX2Zv3IY2AK0c/fkUzH5HOtDOZvYRM6Mb+q
	 IYCXoybuC+eBAAzCE+BwjJeW9nKAq0Jd+RUqtVf+75lleyfKqp/Y7jQ55q7D5WZf5f
	 mF5ClaTVadW+A==
Subject: Re: [PATCH mptcp-net v2 45/62] tcp: do not pass a BPF reqsk to an
 MPTCP listener
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:36 +0000
Message-ID: <179541555672.3133.11473610487670710088@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-45-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-45-00327fd1de1f@kernel.org>
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

- [Low] The patch fixes the slab-out-of-bounds write: cookie_bpf_check()
  now frees the BPF reqsk and returns NULL whenever reuseport re-…

--

tcp: do not pass a BPF reqsk to an MPTCP listener

This commit fixes a slab-out-of-bounds write in
mptcp_subflow_init_cookie_req(). The write happens when a plain TCP
request sock assigned by BPF reaches an MPTCP listener, because
inet_steal_sock() selects again from the SO_REUSEPORT group. With the
fix, cookie_bpf_check() frees the reqsk and drops the segment when the
listener is MPTCP.

> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 89169c82431c1..f39600ee3f172 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -312,7 +312,8 @@ struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb)
>  	skb->sk = NULL;
>  	skb->destructor = NULL;
>  
> -	if (cookie_tcp_reqsk_init(sk, skb, req)) {
> +	/* reuseport can pick an MPTCP listener: req is too small for it */
> +	if (sk_is_mptcp(sk) || cookie_tcp_reqsk_init(sk, skb, req)) {
>  		reqsk_free(req);
>  		req = NULL;
>  	}

[Severity: Low]
This closes the out-of-bounds write. Is the resulting drop persistent for
the affected flows, though?

When cookie_bpf_check() returns NULL, cookie_v4_check() drops the segment
without sending a RST:

net/ipv4/syncookies.c:cookie_v4_check() {
    ...
	if (!req) {
		SKB_DR_SET(reason, NO_SOCKET);
		goto out_drop;
	}
    ...
}

With the default hash-based reuseport selection, the BPF program and
inet_steal_sock() can pick different listeners. This mismatch looks fixed
for a given 4-tuple.

The selftest program finds its listener like this:

bpf_skc_lookup_tcp()
  __inet_lookup(skb == NULL)
    __inet_lookup_listener()

For listeners bound to a wildcard address, the second lookup pass in
__inet_lookup_listener() hashes with INADDR_ANY as daddr:

	result = inet_lhash2_lookup(net, ilb2, skb, doff,
				    saddr, sport, htonl(INADDR_ANY), hnum,
				    dif, sdif);

inet_steal_sock() then selects again using the real daddr:

	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff,
					 saddr, sport, daddr, ntohs(dport),
					 ehashfn);

The two hashes differ. Wouldn't a fixed set of 4-tuples always get the TCP
listener from the program and the MPTCP listener from the second
selection? A reuseport BPF program that only acts when skb != NULL would
split flows the same way.

For these flows the client has already received a SYN-ACK and thinks the
connection is established. Each retransmitted ACK carries the same valid
cookie. bpf_sk_assign_tcp_reqsk() returns 0, inet_steal_sock() picks the
MPTCP listener again, and the segment is dropped again. The client waits
until its retransmission timeout, and the BPF program never gets an error.

In inet_steal_sock(), the original sk is still the compatible TCP listener
that the program chose. Could the code fall back to that listener when the
newly selected socket is MPTCP, so these connections can complete?

If the drop is intended, could the commit message say that the fix turns
the memory corruption into a connection failure for these 4-tuples?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
