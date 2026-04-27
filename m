Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17191125AA
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319060; cv=none; b=B4Jw4TfFQeCePdA7I1LxnOhap0ILRPG8UEX5yiNyw7w2Geaqlz8kd16xugIbLKjH+YPD+k/fWPDH0lvPyabypeMpI4XF7AN4ACvq6ElCIpbQaXZGciJBhOD55pWm0SZ3odvT66+eqbkGCgINwDegkMVA/gpe+tQXGfYZwcL3clw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319060; c=relaxed/simple;
	bh=jBHZd6c3c5Qk55L2E8ce36xk84WvGeMbJyXlQp3shDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QruFxf6uCsDkp+tc48dzFL/5UNI0lsOwkF6OvQZDtJ1uceMrY4Bez9s6nL0QzoFgBSonP1tarINhOLkDVIA3CCtQraMbjymfyIpyoOGVkTCO27s82XZus208CQj9c7cxx+7sE/7A4qjE6Db0qOT8Y0yFQsC/WLA16VPlAvkflqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWi2CZca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWi2CZca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A11C19425;
	Mon, 27 Apr 2026 19:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777319059;
	bh=jBHZd6c3c5Qk55L2E8ce36xk84WvGeMbJyXlQp3shDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qWi2CZcaIVrendRNxk0KemSaccQwhbXkfQe7kZY42NPEYzgcnqwO+TNHviWqtaQtZ
	 vy1RXQWzcLgZ3+T5VoWnQQRZbhDQy1z5KHRxm4zm61ZP2th2mvdmmN0FeX/P/tsHBG
	 P5k+VZkfNTW6BMFeTyyw0v+R35LyC29kgtZDW/r3l6wojZ2mgcMNQjHLPS1kjzb7V4
	 xmO57sjZ9iv4lUX8eJjjWu1J1ljDNiFdNcTpP3mb00xKnFWUEdacw1Xg3+mpt3GLSn
	 vDfP0PToizy16e8A2D/eiKhOBgF/jfp+wJUmYKsQ/o9QxLZcyz8r2QDpCAss38cXSQ
	 lGR6S9v8Uz0lQ==
Message-ID: <b6e9028f-e576-4a51-88d9-7ef07e54e15f@kernel.org>
Date: Mon, 27 Apr 2026 21:44:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] mptcp: add per-reason MIB counters for MPTCP_RST_EMPTCP
 resets
Content-Language: fr
To: Shardul Bankar <shardulsb08@gmail.com>, martineau@kernel.org
Cc: geliang@kernel.org, mptcp@lists.linux.dev, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <20260421095646.3741956-1-shardul.b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260421095646.3741956-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Shardul,

(-cc: Netdev)

On 21/04/2026 11:56, Shardul Bankar wrote:
> MPTCP_RST_EMPTCP (reset reason 1) is used as a catch-all for seven
> distinct error conditions across subflow setup, authentication, and
> data path validation.  The existing MPRstTx/MPRstRx counters only
> track aggregate reset volume, making it difficult to diagnose which
> code path is triggering subflow resets in production.
> 
> Add per-reason MIB counters for each MPTCP_RST_EMPTCP use site:
> 
>   MPRstMD5SIG         - MD5SIG on listener, incompatible with MPTCP
>   MPRstNoToken        - JOIN token lookup failed, no matching conn
>   MPRstNoMPJ          - SYN/ACK missing MP_JOIN option
>   MPRstHMAC           - HMAC validation failed during subflow join
>   MPRstFatalFallback  - fatal fallback during child socket creation
>   MPRstBadMap         - invalid data mapping on established subflow
>   MPRstNotEstablished - JOIN on not-fully-established msk

When looking at the other MIB counters we have where RST are sent in
some cases, it might be better to link them to the event (e.g. MPJoin)
or the issue (DSS issue), rather than the action (MPRst) I think. See below.
> These counters are incremented alongside the existing reset_reason
> assignment and are visible via nstat as MPTcpExtMPRst*.  The
> aggregate MPRstTx/MPRstRx counters remain unchanged.

Do you mind also modifying the selftests in a separated patch to check
these counters (if available -- if not, they can be ignored), please?

e.g. by checking them in mptcp_join.sh, in chk_rst_nr(), assuming they
are all at 0 except set → check how chk_join_nr() is used where specific
errors need to be set explicitly:

  join_syn_rej=1 \
      chk_join_nr (...)

But I guess most/all these errors are not produced in the mptcp_join.sh
selftest, right?. But I guess some can be seen in packetdrill tests:


https://github.com/multipath-tcp/packetdrill/tree/mptcp-net-next/gtests/net/mptcp

It would be good to check these counters are incremented there when
expected, see how MPTcpExtMPCapableFallbackACK is checked for example.

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/511
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>  net/mptcp/mib.c      |  7 +++++++
>  net/mptcp/mib.h      |  7 +++++++
>  net/mptcp/protocol.c |  1 +
>  net/mptcp/subflow.c  | 14 +++++++++++---
>  4 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index f23fda0c55a7..ec42583c59cf 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -71,6 +71,13 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
>  	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
>  	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
> +	SNMP_MIB_ITEM("MPRstMD5SIG", MPTCP_MIB_MPRSTMD5SIG),

We already have MD5SigFallback, should we have MD5SigReset?

> +	SNMP_MIB_ITEM("MPRstNoToken", MPTCP_MIB_MPRSTNOTOKEN),

Maybe clearer if you add 'Found'. But this counter doesn't seem to be
needed, see below.

> +	SNMP_MIB_ITEM("MPRstNoMPJ", MPTCP_MIB_MPRSTNOMPJ),

It doesn't seem very clear. Perhaps clearer to add that one with the
other MPJoin? Possibly MPJoinSynAckNoMPJoin, or is it confusing?

> +	SNMP_MIB_ITEM("MPRstHMAC", MPTCP_MIB_MPRSTHMAC),

Not needed I think, see below.

> +	SNMP_MIB_ITEM("MPRstFatalFallback", MPTCP_MIB_MPRSTFATALFALLBACK),

That's a bit vague. See below.

> +	SNMP_MIB_ITEM("MPRstBadMap", MPTCP_MIB_MPRSTBADMAP),

Should it be linked to DSS? We have DssFallback, DSSCorruptionReset and
DSSCorruptionFallback. Should we have DssReset for this one?

> +	SNMP_MIB_ITEM("MPRstNotEstablished", MPTCP_MIB_MPRSTNOTESTABLISHED),

Here, it is a bit to vague: see below.

>  	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
>  	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
>  	SNMP_MIB_ITEM("SndWndShared", MPTCP_MIB_SNDWNDSHARED),
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 812218b5ed2b..0ac109b52d35 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -70,6 +70,13 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
>  	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
>  	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
> +	MPTCP_MIB_MPRSTMD5SIG,		/* MP_RST: MD5SIG enabled on listener */
> +	MPTCP_MIB_MPRSTNOTOKEN,		/* MP_RST: JOIN token not found */
> +	MPTCP_MIB_MPRSTNOMPJ,		/* MP_RST: missing MPJ in SYN/ACK */
> +	MPTCP_MIB_MPRSTHMAC,		/* MP_RST: HMAC validation failed */
> +	MPTCP_MIB_MPRSTFATALFALLBACK,	/* MP_RST: fatal fallback on child */
> +	MPTCP_MIB_MPRSTBADMAP,		/* MP_RST: bad data mapping */
> +	MPTCP_MIB_MPRSTNOTESTABLISHED,	/* MP_RST: JOIN on not-established msk */
>  	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
>  	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
>  	MPTCP_MIB_SNDWNDSHARED,		/* Subflow snd wnd is overridden by msk's one */
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 17b9a8c13ebf..b06cbcf983f4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3836,6 +3836,7 @@ bool mptcp_finish_join(struct sock *ssk)
>  
>  	/* mptcp socket already closing? */
>  	if (!mptcp_is_fully_established(parent)) {
> +		MPTCP_INC_STATS(sock_net(parent), MPTCP_MIB_MPRSTNOTESTABLISHED);

As you mentioned above in a comment, it is linked to a Join: then I
think this should be reflected in the name. It might be better with
something like: MPJoinSynAckClose? (or with the Rst suffix?)

>  		subflow->reset_reason = MPTCP_RST_EMPTCP;
>  		return false;
>  	}
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e2cb9d23e4a0..71bffcda0138 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -160,6 +160,7 @@ static int subflow_check_req(struct request_sock *req,
>  	 * TCP option space.
>  	 */
>  	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info)) {
> +		MPTCP_INC_STATS(sock_net(sk_listener), MPTCP_MIB_MPRSTMD5SIG);

MD5SigReset?

>  		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
>  		return -EINVAL;
>  	}
> @@ -227,6 +228,7 @@ static int subflow_check_req(struct request_sock *req,
>  
>  		/* Can't fall back to TCP in this case. */
>  		if (!subflow_req->msk) {
> +			MPTCP_INC_STATS(sock_net(sk_listener), MPTCP_MIB_MPRSTNOTOKEN);

Do we not already have MPTCP_MIB_JOINNOTOKEN sent in this case?

I was initially going to say that NoToken was confusing, NoTokenFound
would be clearer, but it looks like we already have one for that.

>  			subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
>  			return -EPERM;
>  		}
> @@ -568,6 +570,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>  		u8 hmac[SHA256_DIGEST_SIZE];
>  
>  		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYNACK)) {
> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTNOMPJ);

MPJoinSynAckNoMPJoin?

>  			subflow->reset_reason = MPTCP_RST_EMPTCP;
>  			goto do_reset;
>  		}
> @@ -582,6 +585,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>  
>  		if (!subflow_thmac_valid(subflow)) {
>  			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMAC);
> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTHMAC);

Do we need this one if we already have MPJoinAckHMacFailure just above?
This other MIB counter is only used in case of HMAC issues and an MP_RST
will be sent.

Note that I see that at the other place where it is used, the reset
reason looks wrong (Administratively prohibited), it should also be an
MPTCP-specific error like here. Do you mind creating another patch
fixing that please? That's not urgent, so also only to the MPTCP ML,
with the 'mptcp-net' prefix this time, and a Fixes tag, please?

Also, here, should it not be MPJoinSynAckHMacFailure instead (SynAck,
not Ack)? If yes, we will need another patch with probably another Fixes
tag.

>  			subflow->reset_reason = MPTCP_RST_EMPTCP;
>  			goto do_reset;
>  		}
> @@ -870,6 +874,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
>  		 */
>  		if (!ctx || fallback) {
>  			if (fallback_is_fatal) {
> +				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTFATALFALLBACK);

Here, we should send a reset only for the MPJoin, so probably best to
link it to that. Then there are two conditions:

- fallback == true: MPJoin options are missing → MPJoinAckNoMPJoin?
- !ctx == no ULP: so I guess alloc failure (or a fallback happened
before? Not sure...) → MPJoinAckNoCtx?

>  				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
>  				goto dispose_child;
>  			}
> @@ -1421,9 +1426,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  			 * subflow_error_report() will introduce the appropriate barriers
>  			 */
>  			subflow->reset_transient = 0;
> -			subflow->reset_reason = status == MAPPING_NODSS ?
> -						MPTCP_RST_EMIDDLEBOX :
> -						MPTCP_RST_EMPTCP;
> +			if (status == MAPPING_NODSS) {
> +				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> +			} else {
> +				MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPRSTBADMAP);
> +				subflow->reset_reason = MPTCP_RST_EMPTCP;
> +			}

It sounds better to increment the MIB counter (DssReset?) even if it is
due to a middlebox, no?

>  reset:
>  			WRITE_ONCE(ssk->sk_err, EBADMSG);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

