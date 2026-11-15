Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739994;
	b=dA56obeCSW7cye4xo1HnyJwqCLDpUkips1qJsO3i0xEbEZIqFOoSb5+eiMtNHO0esVS8
	 YsDQFhjs2Egzf3i1oCL44HzCPLh5GfxSbOphX8/ed0WxDLCrb6WI+lvh8hobMrzdH95JN
	 R1K2/+9JG53OUUxPhfb1f+0nFOWVbI2RK7ISTET97Ka+LFuGgRmWqN3xpXg/S1fvSvEUT
	 vPAYBK9yVYkVLQzjdsRkh6aBM2fAz+9IAUIxxxa3uEG5TX+hpLsv6p0fvlva4wAp8ONI4
	 7lYybf4bI6kRYgFVQ+sv9QRdWB+tqjHBVbTkw7cJCtLV3C0EPE2M36wDKGhOijFOO5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739994;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=prK7Q4kALKUb31VOWLKs0XD390ziw7dvyk1iBtvg5yc=;
	b=lNQcqgK7DxL3y4srBJvfQUEh1mRQXD4XqEKj/MUDiI2cRnCtkuyUOF0oxgnWF2LfyphI
	 b4PxAiGfTu7XVlDfRZSWFYK57kP3s6M8SOfCrNY8RMxhwKod3/jN6f4b2h9uLirEhoeYR
	 v1PTJtQ4xHLs2dUu3MxGdm7XtjURBL/OqkUaeVSRwVXHaWzHehZVUUhpVLoU4g0NOOWKj
	 Q5m7TyQH/LZmrKLPalo9Q30JbLekweV6Wc0pGQD55aFE76Rk0JnONTJQSVVr3i+GirGb+
	 MAMQhTYAPk2mplzSR0Yzkys2I++we2jSepjwDhpJ9Fy0RfMTra8lWwc15TDqRDWj20A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CamBC5Ii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4780606A32D
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CamBC5Ii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFF31F000CC;
	Sun, 15 Nov 2026 10:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794739994;
	bh=prK7Q4kALKUb31VOWLKs0XD390ziw7dvyk1iBtvg5yc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CamBC5IiJ53TazR+Ixe+pBFsfCnNKkEWtsdmYyYsrvtxZbbn5F1N8U40pQxTi7wyt
	 K/nQ/6TRcj/4eABgXxXDEmj3rQYK5RvqkKCAQvn6luqir7F1gDRnq3vdtef3wy1BAP
	 zVWv/0SXP655O9eVwlWb3LCE6aiDVSXj/SsahUKqls8jsseYdI7qKFl9vtCKm3EttB
	 8tq/Fr6TYIn0Xif2sxa1fKamXONYXy4NNnYHXe4JuvA9M0pQhmg4GKrFy1Za8nVEuk
	 spTTwghAazFC58PtWI0h7WUGfVYt+AENJh67JBhlIzEvyf+x+AAx5W6FNjP2sbHH1Y
	 Rd0f4KPBbfgLw==
Subject: Re: [PATCH RFC mptcp-next mptcp-net 34/34] mptcp: reset when the DSS
 disappears after a DATA_ACK
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc:
 mptcp@lists.linux.dev, mason@kernel.org, pabeni@redhat.com, kuba@kernel.org
Date: Sun, 15 Nov 2026 10:53:13 +0000
Message-ID: <179473999399.488855.4522554783315767219@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-34-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-34-9205b77e9a2f@kernel.org>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] subflow_nodss_is_fatal() (net/mptcp/subflow.c) treats any
  MAPPING_NODSS as fatal once subflow->dss_confirmed is set and…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  still leaves it reachable.

--

mptcp: reset when the DSS disappears after a DATA_ACK

This patch resets a subflow with MPTCP_RST_EMIDDLEBOX, instead of falling
back to TCP, when data without DSS arrives after a DATA_ACK on that
subflow has acknowledged locally sent data, following RFC 8684 section 3.7.
A new dss_confirmed bit tracks this condition. An MP_FAIL exchange, which
clears allow_subflows, still allows the fallback.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/519

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index c56ca5e4df14b..ccd30e110934c 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c

[ ... ]

> @@ -1335,8 +1338,8 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  	/* we can't wait for recvmsg() to update the ack_seq, otherwise
>  	 * monodirectional flows will stuck
>  	 */
> -	if (mp_opt.use_ack)
> -		ack_update_msk(msk, sk, skb, &mp_opt);
> +	if (mp_opt.use_ack && ack_update_msk(msk, sk, skb, &mp_opt))
> +		subflow->dss_confirmed = 1; /* MPTCP opts pass both ways */

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but the
patch still leaves it reachable. What happens on a host that only receives
data on this subflow?

dss_confirmed is only set when ack_update_msk() advances msk->snd_una. A
pure receiver never sets it. In that case subflow_nodss_is_fatal() returns
false, and subflow_check_data_avail() still calls mptcp_try_fallback(). On
a single subflow with map_old and old_data_pending clear, that call
succeeds.

Once the receiver has fallen back, it sends no MPTCP options:

net/mptcp/options.c:mptcp_established_options() {
    ...
	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
    ...
}

So the sender gets no DATA_ACK and does not notice the fallback.
check_fully_established() returns early for it, and
mptcp_incoming_options() returns at the
!(mp_opt.suboptions & OPTION_MPTCP_DSS) check.

The sender's msk snd_una then stops moving. __mptcp_retrans() resends on
the same subflow, because allow_subflows is still true there. The check in
mptcp_sendmsg_frag() only stops resending on the next old-data send, after
the first retransmission has been TCP-acked:

net/mptcp/protocol.c:mptcp_sendmsg_frag() {
    ...
	if (unlikely(before64(data_seq, msk->snd_nxt) &&
		     subflow->old_data_pending &&
		     !before(tcp_sk(ssk)->snd_una, subflow->old_data_end))) {
    ...
}

On the receiver that has fallen back, get_mapping_status() returns
MAPPING_DUMMY. The retransmitted bytes are then mapped at
dsn_base + SSN - 1, which is past ack_seq.

Could the receiving application then read this first MPTCP-level
retransmission as new data, so the stream contains duplicated bytes?

The commit message notes this limit ("closes the case above, but only for
a receiver whose data has been acknowledged"). The duplicated-data path is
still open for pure receivers, though.

>  	rwin_update(msk, sk, skb);
>  
>  	/* Zero-data-length packets are dropped by the caller and not

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 728b27be1ad04..68a9fe29a5e88 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1447,6 +1447,22 @@ static void subflow_update_dsn_base(struct mptcp_subflow_context *subflow)
>  		subflow->dsn_end = end;
>  }
>  
> +/* RFC 8684, 3.7: no fallback once a DATA_ACK acked our data, except MP_FAIL */
> +static bool subflow_nodss_is_fatal(struct mptcp_sock *msk,
> +				   const struct mptcp_subflow_context *subflow)
> +{
> +	bool fatal;
> +
> +	if (!subflow->dss_confirmed)
> +		return false;
> +
> +	/* before a fallback, only an MP_FAIL clears allow_subflows */
> +	spin_lock_bh(&msk->fallback_lock);
> +	fatal = msk->allow_subflows;

[Severity: Medium]
Is a true allow_subflows enough to know that the peer has not fallen back
on its own?

A Linux peer with allow_infinite_fallback set can fall back silently, with
no MP_FAIL and no infinite mapping, when get_mapping_status() returns
MAPPING_INVALID. For example:

net/mptcp/subflow.c:get_mapping_status() {
    ...
	if (!validate_mapping(ssk, skb)) {
		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSTCPMISMATCH);
		return MAPPING_INVALID;
	}
    ...
}

The DSSNOMATCH and csum_reqd mismatch cases also return MAPPING_INVALID.
mptcp_dss_corruption() is another silent path.

On the peer, all of these go through the unchanged
!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK) branch. After that,
mptcp_established_options() sends the peer's data without DSS.

On this side, dss_confirmed was set permanently when the peer earlier
DATA_ACKed our data, and allow_subflows is still true. So the new check
skips mptcp_try_fallback() and resets the subflow with
MPTCP_RST_EMIDDLEBOX.

Before this patch, the fallback would have succeeded here and the
connection would have continued as plain TCP. Now, on a single subflow,
the msk can be left without a subflow until net.mptcp.close_timeout.

Does this contradict this part of the commit message?

  "Except after an MP_FAIL, Linux falls back without sending an infinite
  mapping, then sends data without DSS: the other side can only fall back
  too, as before."

That statement only seems to hold when the peer's earlier DATA_ACKs
acknowledged none of our data.

A related question: only MAPPING_NODSS consults dss_confirmed. Suppose a
MAPPING_INVALID arrives after confirmation, for example because a middlebox
resegments the data. Could a receiver whose data was acknowledged still
fall back alone? It could then deliver the sender's first MPTCP-level
retransmission as new data, which is the case the commit message says is
closed for such receivers.

> +	spin_unlock_bh(&msk->fallback_lock);
> +	return fatal;
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f%40kernel.org
