Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415556;
	b=aQm56tVvVrdFArP3jvCIcbo+rVm2g7bs3zDpx0J0wiEh1LjpCO4Mj7AQMvoadhN5N/k5
	 KrvaauwgGSm3tmhBVIFyjN3Oo5mSfEHkk6oHL2Q1uH7sDDrMpjw/Rztd+cp6zEeWjE2yN
	 pBXHWNfsYpQgWuXYkogQKuVlZ/9/l8ZLeL6f/aCYbPhy+WqD3wvzNI7qyhl1Tf9YnhqWn
	 dG423e5eaNmvw7qKmOspAlCvdeGd7m+35kKbDcCIC09IgOCPOK0qMi+i/mzx7Ap29RUuV
	 FNgoneRMW7qoikfGj6rtDyVKuDkA14OlC18G78JNzOa/u+60bMZU0/peKRqD+Z/vZwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415556;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jJxVoZmRxuJiFA2KtTDeQRpcbdkvIPFPvvAxOx9C7To=;
	b=bGbxTnjXTaUh+98LqHPwMTsQV/91dh7jqY5U5LmLDoHzUHTu16Zcfvv9/KEZq3PVL/ce
	 oOFwR92mlwRghPRoDE7E/30rd4x1wq2ZvIwkxS0HBFP1y0FGN0K6zzJRrIYRkcE3qnufZ
	 LJuCv3tBXFx1hneCzUPcGf+r1tVzPaOj+LbTvC31gITLg53Y/P8+Z3AQR73hm3IJYmOaX
	 j75TDXFLLNmLIo7AJm78E3QDYglfNppSWp43uu7+i83NYrmGGnU6/1ITFJEGuM2GzrQQo
	 pZC072Hjx0p9v8xataC7cNzOlyR68IRlLGxNpbYbkrjBYp+HFtrEHSmj3Solj3kEF1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+m7heP9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F42606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+m7heP9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF33C1F000C0;
	Mon, 23 Nov 2026 06:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415556;
	bh=jJxVoZmRxuJiFA2KtTDeQRpcbdkvIPFPvvAxOx9C7To=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F+m7heP9XRJp9SxCBBC17MKpWQ+aVyvbVNqQdsuuHdXk3xFhRb0ngy36Os8dbF/AZ
	 Fw//ZabBgJy9jJor09Fl9vFteygvzuiPhYqMAzUfdleBkjBKwc7enP8C1KNSM2wqVC
	 wwgoDQ8QAHV61zVPR8NnsrcDQhJwQUMbGQmJxAr9RGH4WG8V7HhBvBtvChpGGKhf/o
	 RORpIA6rDK75HYaZSKidtf0pW7WqzyTOKDJYvxlM8Tq6WkUK4pCs/88nFNFU9PipeR
	 39/omCGck9jY9z3sQeoG1ylpxxuMok1xkQXigUSSOkXjoQVvQu56fXliguORVHyi04
	 AK5wtnYh4SDYQ==
Subject: Re: [PATCH mptcp-net v2 39/62] mptcp: keep room for infinite map
 after fallback
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:35 +0000
Message-ID: <179541555542.3133.1334953870830856164@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-39-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-39-00327fd1de1f@kernel.org>
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

- [Medium] The DSS reservation only lasts while
  subflow->send_infinite_map is set, and that flag is cleared before the…

--

mptcp: keep room for infinite map after fallback

After a fallback, mptcp_established_options() now keeps reserving room for
the DSS option when the MSS is computed (skb == NULL), as long as
subflow->send_infinite_map is set. Without this, the skb carrying the
infinite mapping could be sized without DSS room. Its segments would then
be bigger than the MTU and the connection would stall.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 736e55532296b..6b1a3994fb494 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -891,9 +891,11 @@ int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>  	opts->suboptions = 0;
>  
>  	/* Force later mptcp_write_options(), but do not use any actual
> -	 * option space.
> +	 * option space, except for an infinite mapping still to be sent.
>  	 */
> -	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
> +	if (unlikely(__mptcp_check_fallback(msk) &&
> +		     !mptcp_check_infinite_map(skb) &&
> +		     (skb || !subflow->send_infinite_map)))
>  		return 0;

[Severity: Medium]
Is send_infinite_map the right flag to base this reservation on? The flag
seems to be cleared before the infinite-map skb is ever sent, while
mptcp_sendmsg_frag() is still building it:

net/mptcp/protocol.c:mptcp_update_infinite_map() {
    ...
	mpext->infinite_map = 1;
	mpext->data_len = 0;

	if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
		...
	}

	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
}

After that, tcp_write_xmit(), __tcp_retransmit_skb() and
tcp_write_wakeup() all call tcp_current_mss(). That goes through
tcp_established_options(sk, NULL, ...), and this check now returns 0
MPTCP option bytes.

However, __tcp_transmit_skb() on the same skb still sees
mptcp_check_infinite_map(skb) == true. It then emits the 24 or 28 byte
DSS.

The single-segment cap from "mptcp: send the infinite map in a single
segment" (copy = mss_now) seems to hold only if nothing changes between
building the skb and its last (re)transmission. Can either of these cases
still produce segments bigger than the MTU?

(A) The PMTU drops while the infinite-map skb is not yet acked. Then
tcp_current_mss()->tcp_sync_mss() returns an MSS with no DSS room, and
__tcp_retransmit_skb() splits the skb at that cur_mss:

__tcp_retransmit_skb()
    cur_mss = tcp_current_mss(sk);
    ...
    tcp_fragment(sk, TCP_FRAG_IN_RTX_QUEUE, skb, len, cur_mss, GFP_ATOMIC)
        mptcp_skb_ext_copy(buff, skb);

Both fragments keep the infinite_map ext and emit the DSS, so each one is
the new MSS plus the DSS. If no split happens, the skb is still sized for
the old MTU.

Either way, DF is set, so IP drops the packets. The local frag-needed
reports the same MTU, so the MSS never shrinks. The subflow then keeps
retransmitting oversized packets until it times out.

(B) Timestamps are off, and SACK or DSACK blocks appear between building
the skb and sending or resending it.

At build time the 28 byte DSS is counted and there is no SACK, so
skb->len = mss_cache - 28. At transmit time only the 12 byte SACK is
counted, so mss_now = mss_cache - 12, which is larger than skb->len, and
no split happens.

The real options are 28 + 12 = 40 bytes, so the segment is 12 bytes over
the MTU. This repeats as long as the SACK state lasts, for example while
the skb is waiting on cwnd or rwnd, or is being retransmitted.

Both cases look like the same stall that the commit message says is fixed:

  "Keep room for the DSS option while the infinite mapping is still to be
  sent, when computing the MSS."

Should the reservation last as long as an infinite-map skb is still
unacked, instead of ending once that skb has been built? The code at the
end of the series appears to use the same logic, so a later patch does
not seem to address this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
