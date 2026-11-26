Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735790;
	b=NBnxvmkaWVdJcUElimV2Dvpdu4oGFdxsmvUu7go+rNLO3gr9RazI5KjKrVOy1YhvAAv3
	 OHdqK4D1D9rZK3QfiMm2TsfMeLDRNoO+13u0+v61YZxryb3fdgBQRbuE4oEnZdWpX+Sbp
	 W+makCMPsxu+BaaXk55ioTvNvGcuKGZmLeAI4oL7b7zvIkMCDB/Oaz4LDkUpBmKs29yTd
	 Y2y7dA2/0E/eK47fyCHfRorYsMRWC0nTRC2AGhVPKqKmhfPbe7c0HpczkB+i+qEbahsCL
	 MPuF3OToZolWM+zMBNBWiHXFpGw7v5Z6zXrZ+QkPDJXmcbfoZMt2pTJ2NMkvNDXUUlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735790;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bpqGJ/W35WCyBpnbs/ti5vAfcmNy/TaM+XoaTClDbco=;
	b=LO9boBqJw1JaDTehsXjLs84SBPz6kbvHMCnqhbLGmxeg6X/vjWKPM9cJERG0C2idG2Ja
	 2z3pQQMJ4/rY98D+CkxaP3+gDigMkYZLK1/iBMPAqSJcUEAV5iaw9YYsVIFrNuO0qp5Oz
	 lR8quQRGUGKkSh/ebfWw2NsLfnJSq31STvuQ0rUFsuLkeIZt3frVcCDqkaq6Lr7eNxyfx
	 teNJIN84OC4RHlTpWSQqqEQH+ltySzFb+U67QcMzbdMuKI9c7Gx+sphs6mDpKRVcC+52z
	 prvXHhgytpAEKzPm5g7ZVC5MN4XGW7K16gigpSPXdqY8Gxz6/LFeB/lids7D/KvbHqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhPHnn2Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A80606A326
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhPHnn2Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961DE1F00923;
	Thu, 26 Nov 2026 23:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735789;
	bh=bpqGJ/W35WCyBpnbs/ti5vAfcmNy/TaM+XoaTClDbco=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FhPHnn2ZlTh8FdCPlx8BuWsSy6Jz4FFOPxmZt+AH0Bx23XHGnj6GRby1irAQGmk9P
	 iCFGCPRgSKLZI+hYkZSAr8zX4PFyUoVZPHg1RSqQxhUTqUuwzujwArupzH9Vw/JYas
	 eeFN7OcfzcmmNGquwXbRQ/Ml3xuiWgbNINM//51zs2pVqEMEe7f6L+5IZIRH9uJzIr
	 iQiNsmNugxXHnYBGu5u9VvfB7Hiql7kW0SI7nW4yjgse+gkIJp1NHAtBCUYj5WlRre
	 2voMCd8mTOG469qS7lWsB7rJHtpYTuYVfAI5ZIA10TDlV80m7aK7DKljM6PN7J2xyM
	 8w6tHTwsks2uA==
Subject: Re: [PATCH mptcp-net v3 25/50] mptcp: send the infinite map in a
 single segment
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:49 +0000
Message-ID: <179573578915.3133.6767634288026914577@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-25-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-25-416c0920c73f@kernel.org>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new cap in mptcp_sendmsg_frag()
  (net/mptcp/protocol.c:1489-1490, `copy = info->mss_now` while…

--

mptcp: send the infinite map in a single segment

After an MP_FAIL with a single subflow, the skb carrying the infinite
mapping could be sized from the pre-fallback size goal. Its segments then
grew past the MTU once the post-fallback MSS stopped reserving room for
the DSS option. This patch caps the copy size to mss_now while
send_infinite_map is set, so the infinite mapping is sent in a single
segment.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c57bfedc86a84..39490ff40aa4f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1483,6 +1483,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>  	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
>  	copy = info->size_goal;
>  
> +	/* After the fallback, the MSS no longer includes the DSS option of the
> +	 * infinite mapping: send it in a single segment.
> +	 */
> +	if (unlikely(mptcp_subflow_ctx(ssk)->send_infinite_map))
> +		copy = info->mss_now;
> +
>  	skb = tcp_write_queue_tail(ssk);
>  	if (skb && copy > skb->len) {

[Severity: Medium]
Does lowering copy here stop the "Infinite map" subtest from reaching
the InfiniteMapRx check it is meant to fix?

Before this patch, an unsent write queue tail with
mss_now <= skb->len < size_goal still passed the copy > skb->len test,
and the infinite mapping was put on that tail. With the cap, such a tail
fails the test, a new skb is allocated, and mptcp_update_infinite_map()
makes the msk fall back right away.

After that, mptcp_established_options() in net/mptcp/options.c skips
every skb other than the infinite-map one:

	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
		return 0;

So the tail, whose mpext still has a normal mapping, goes out with no
DSS option.

On the receiver, get_mapping_status() in net/mptcp/subflow.c sees data
with no DSS and !map_valid, and returns MAPPING_NODSS.
subflow_check_data_avail() then falls back via MPTCP_MIB_DSSFALLBACK.

When the infinite-map segment arrives later, get_mapping_status() returns
early:

	if (mptcp_check_fallback(ssk))
		return MAPPING_DUMMY;

That return comes before the data_len == 0 branch that increments
MPTCP_MIB_INFINITEMAPRX.

The sender counts InfiniteMapTx=1 and the receiver counts
InfiniteMapRx=0. mptcp_join.sh fail_tests() still expects:

	join_fail_nr=1 join_rst_nr=0 join_infi_nr=1 \

Would this sub-case then hit the same failure the commit message quotes
as the flaky symptom?

	infi rx server       [FAIL] got 0 infinite map[s] RX expected 1

The fb_dss check would still pass, because the NODSS path uses the same
DSSFALLBACK counter.

The subtest pushes 128KB in bulk, and the trace in the commit message
shows notsent:98333. An unsent tail larger than one MSS when MP_FAIL
arrives therefore seems plausible.

The commit message does describe the side effect:

  A side effect: when the last unsent skb is bigger than one MSS, the
  infinite mapping is now put on a new skb. This unsent skb is then sent
  without DSS after the fallback, as it was already the case for the ones
  before it, and the peer falls back before receiving the infinite
  mapping.

It doesn't say that this path leaves the receiver's InfiniteMapRx at 0,
which keeps the cited selftest check failing. In this case the fallback
is also signalled on the wire by data without a DSS option, not by the
infinite mapping.

Would it make sense to keep putting the infinite mapping on such a tail,
for example by splitting it at mss_now? Alternatively, could the selftest
expectations and the commit message cover this case?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
