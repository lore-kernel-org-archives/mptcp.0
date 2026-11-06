Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006430;
	b=z1Nh5pbvJK0EmOU7/VAf5kKxi9GlpQH67sA7as7uiUj06Dqa7+hON+0HXe3oNSOSrdwF
	 4oL69lNXbeR0mu50QHxWWfI6r8GA6nszxiGOvZoXAEXuK+ngYxj7jXFmmH3bs34dXTSXc
	 dCWbS89XcQC+e6LJ+BYeYm+DP8ac35yfN3FXpBBWV/Tgk8xHs8waErBRp8+pAc36zIsP2
	 o5eA6lWw6oo0MnXJu4IYuzcIL3x37tNmy0YZcOHlLGzZL8Df2jf3DCS0ThmTtq/w5Ccgt
	 aL2X+PD5jIUezS/IG1w3kdqJFaTMJxve62kiZxTNNz+j+mmcFiBVuDEu7vKtJa8vscg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006430;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=J76HHSQiaRdhCKZTJ8GLZawdu0iYEewbK8upvVxbwsw=;
	b=dftAn7KTxsdp+THFFPIHyF8ktY9+8PNASB+Iesg2uSJx2lfGlvfIosHOIGA5DI12bZlv
	 HANjVz1Pncv3iqJz2kIWSs5+bdqs/3uafXF76rH/8MhJXWm49qUMQkkgZYVeeM/pWScxq
	 imkF1iN7gyjvDfstf0WB4uJRJXxt3YZ6LXmw0aVCKelj9u5MpaEwszx/U73QzL/7odHz4
	 Y9ROPXi2Jj38pZkl6AF+yA7UGS09Y4fbN6Bciv2OfwOGVM08aXHH3aDxDum/IAHdvk6DK
	 OWmb5lPgzSDXDyzrtNbrbgem5Meu5H0b2KYp715t1/BGWeAI8X9XChgHbKwm1AYPCiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5u33Xia;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1DF606A330
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5u33Xia
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07511F008A1;
	Fri,  6 Nov 2026 23:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794006430;
	bh=J76HHSQiaRdhCKZTJ8GLZawdu0iYEewbK8upvVxbwsw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q5u33XiadIIi8XSLhxJ9k3T9RjCd667N8kueab+luVV6k9w7G1FiHOxnjrlgryWXE
	 9ySBjG6G2roi7XJ9Skx/5NK+YIt6SwbQf8UFOK6mBQzjY4NCOYFyfaBQPC19uyvVvD
	 fSdsAY+qMTb8VzWCja13sm2r0zFw27wOwHVxOMGGPMnoIWwTzO6eB+HWUsfYCkBejV
	 vHfZhn+EomP5tgEuocN0UFIH9okSwMKKTX7jScpnKGFO/W6qpHQZ+MWbhP24Yo6AAw
	 DHA8ZIPqPJParPOQ7Q7Vv+84r/6JBGAS5li4dFcIKEi8Nr0e7NkVY5pF3yrrLALxBY
	 FO53WEN2UWRSQ==
Subject:
 Re: [PATCH mptcp-next v21 8/9] mptcp: sync mptcp skb cb layout with tcp one
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 23:07:09 +0000
Message-ID: <179400642943.488855.8584773260516372310@kernel.org>
In-Reply-To: <d32bc6dca481d024c23d92e2ef2e51de4eca523c.1793870710.git.tanggeliang@kylinos.cn>
References: <d32bc6dca481d024c23d92e2ef2e51de4eca523c.1793870710.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] A remote peer can trigger a kernel BUG() in mptcp_init_skb()
  (net/mptcp/protocol.c:443) by sending crafted segments.
- [High] The mapping-boundary check in mptcp_init_skb()
  (net/mptcp/protocol.c:432-434) compares wrapping u32 relative subflow…
- [Low] The commit message of "mptcp: sync mptcp skb cb layout with tcp
  one" describes a change this diff does not make: "A mapping boundary…

--

mptcp: sync mptcp skb cb layout with tcp one

This commit changes the MPTCP skb control block layout. map_seq and end_seq
become u32 and sit at the same offsets as the matching tcp_skb_cb fields. A
map_seq64 field is added to carry the full 64-bit DSN, along with a flags
field and a build-time layout check.

The receive path now uses 32-bit before()/after() for most comparisons. It
keeps map_seq64 for window admission and coalescing.

> In mptcp_init_skb(), map_seq64 is computed as mptcp_subflow_get_mapped_dsn()
> minus offset, and map_seq is the lower 32 bits. A mapping boundary check
> detects when the skb spans multiple DSS mappings (offset > 0 and skb starts
> before the current mapping). In that case, the consumed prefix bytes belong
> to an old mapping and are removed via skb_pull() before setting map_seq.

[Severity: Low]
Is this paragraph accurate for this patch?

The mapping boundary check, the pr_debug("spans mappings ...") and the
skb_pull(skb, offset) in mptcp_init_skb() are unchanged context in this diff.
They were added by the preceding commit "mptcp: remove CB offset field",
whose changelog has almost the same paragraph.

In this diff, mptcp_init_skb() only gains the map_seq64, map_seq and flags
assignments and the comment update.

Could this paragraph be dropped, or limited to the map_seq64/map_seq split?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0666bbfdf2cb8..705b28219883f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -437,11 +446,13 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
>  
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
> -	 * value
> +	 * value; note that end seq number is only available in 32bits format.
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
> -				     offset;
> +	MPTCP_SKB_CB(skb)->map_seq64 = mptcp_subflow_get_mapped_dsn(subflow) -
> +				       offset;
> +	MPTCP_SKB_CB(skb)->map_seq = (u32)MPTCP_SKB_CB(skb)->map_seq64;

[Severity: Critical]
This computation depends on the skb_pull() just above it. That code came from
"mptcp: remove CB offset field" and is not part of this diff, but the
changelog here describes it:

net/mptcp/protocol.c:mptcp_init_skb() {
    ...
	if (unlikely(offset > 0 &&
		     TCP_SKB_CB(skb)->seq - subflow->ssn_offset <
		     subflow->map_subflow_seq)) {
		...
		WARN_ON_ONCE(offset >= skb->len);
		skb_pull(skb, offset);
		offset = 0;
	}
    ...
}

Can a remote peer reach the BUG() in __skb_pull() through this path?
skb_pull() only handles the linear area, and __skb_pull() does:

	skb->len -= len;
	if (unlikely(skb->len < skb->data_len)) {
		...
		BUG();
	}

After TCP pulls its header, the payload of an rx skb is often in page frags
(header split, GRO, loopback/veth). So skb_headlen() can be smaller than
offset. The caller, __mptcp_move_skbs_from_subflow(), only checks offset
against skb->len.

One possible sequence:

1. The peer sends subflow data [0,1000) with mapping M1. MPTCP consumes it,
   so copied_seq = rcv_nxt = 1000.

2. The peer sends a segment with subflow seq 500 and length 1500. Its DSS
   mapping starts at relative ssn 1000.

3. tcp_data_queue() takes the "Partial packet, seq < rcv_next < end_seq"
   branch and queues the skb without trimming it.

4. validate_mapping() checks copied_seq against the mapping but not
   TCP_SKB_CB(skb)->seq, so it accepts the mapping.

5. __mptcp_move_skbs_from_subflow() computes offset = 500 and calls
   mptcp_init_skb(). The check 500 < 1000 is true, so skb_pull(skb, 500)
   runs on an skb whose headlen is below 500.

This code is still the same at the end of the series ("mptcp: defer
read_sock cleanup to mptcp_worker").

Would pskb_pull() with a NULL check, a frag-aware head trim, or keeping the
offset instead of pulling be safer here?

[Severity: High]
Separately, the same boundary check uses a plain '<' on wrapping u32
relative subflow sequence numbers:

	TCP_SKB_CB(skb)->seq - subflow->ssn_offset <
	subflow->map_subflow_seq

validate_mapping() compares the same values with the wrap-safe helper:

	if (unlikely(before(ssn, subflow->map_subflow_seq))) {

Does this check go wrong once the relative subflow sequence wraps past 2^32
(4 GiB on one subflow)? The map_seq64 and map_seq values set here are only
correct if the check decides properly whether the prefix belongs to the
current mapping.

First case: the mapping starts at rel 0x50 and an overlapping skb starts at
rel 0xFFFFFF00. Then 0xFFFFFF00 < 0x50 is false. The old-mapping prefix is
kept, and map_seq64 = mapped_dsn - offset gives those bytes DSNs they do not
carry.

If that skb goes to the msk OFO queue, mptcp_data_queue_ofo() can drop the
real data for that range as MPTCP_MIB_DUPDATA. Alternatively,
__mptcp_ofo_queue() can later deliver the wrong prefix bytes to the reader.

Second case: the mapping starts at rel 0xFFFFFF00 and spans the wrap, and a
partially overlapping skb inside it starts at rel 0x10. Then
0x10 < 0xFFFFFF00 is true. skb_pull() runs on an skb that needs no pull and
can hit the __skb_pull() BUG() described above, even with a well-behaved
peer.

Should this be before(TCP_SKB_CB(skb)->seq - subflow->ssn_offset,
subflow->map_subflow_seq) instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793870710.git.tanggeliang%40kylinos.cn
