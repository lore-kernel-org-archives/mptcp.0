Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A821F377031
	for <mptcp@lists.linux.dev>; Mon, 11 May 2026 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500625; cv=none; b=LiQdFg4btJdy8AU1iKJKVIm8KNw7iKrLWJtcFOFOF1l4fl71rb2NBeCNJTD6XpnrVaxPZk9Ol7q9Y9Df/7g6ihDZSck90MYXH/Dofmwg2yQND7bJS0CrQR+io2XVszqf1ztyKGQ7UVXqCKW/ZH7B+IRpLQxYHnR5DK1IFZOd7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500625; c=relaxed/simple;
	bh=5eKcvaP/TMGSNSOfCRoucS6Ur1m0WXOr/MTZrkI17VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeersMktywqhCBL4VI55S0P3Sdqk6lGYvtyC4Aive40eyaoByGbn/kNNJ0fjBkciEAV/7gQc4TENQXC8/j55H5fj12yKfj5s46/kBmwieUrCF7H6f/7xMxO/s2eg+06DcO9fV5ugXY5XBrnSZWU0x4qYLwXh2o6+ME9Lr3bikiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjwU++2K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjwU++2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B57C2BCF7;
	Mon, 11 May 2026 11:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500625;
	bh=5eKcvaP/TMGSNSOfCRoucS6Ur1m0WXOr/MTZrkI17VU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WjwU++2K00HLXCs6A/PZyg2kVWStAFu1GgPYt15QrCgWVsSe2vU6c3PhLi29jPBQw
	 +oTbds+usjNUZ58RYExfgKN87IyiJhfKbIkG/KnFIPwDVjF2NqyAFaC4RANukLM946
	 rQsLYXrwnsW9757QSfUPRmDvJDZV3ohPv6N723c3Xy+Q7QLNFBMIvQTpjIbLa8Ca0V
	 ugdjZEqAIzW+YmepzqWuwj5FNiTcEIBUkTmru2ccfkUSooIjYpSxYGqc9TbDyAMrRt
	 F51lJwd8ebOrADnq1xclM/uwsatT2BN2y2mLZqivquTWuWN4p5SKabTTaPJFRW31R6
	 sePGJmUtPFkfQ==
Message-ID: <e6287703-53ad-48e8-9428-b19d5f9f902c@kernel.org>
Date: Mon, 11 May 2026 13:57:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 1/2] mptcp: add per-event MIB counters for
 MPTCP_RST_EMPTCP resets
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com,
 janak@mpiric.us, kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com
References: <20260509183335.969018-1-shardul.b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260509183335.969018-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

On 09/05/2026 20:33, Shardul Bankar wrote:
> MPTCP_RST_EMPTCP (reset reason 1) is used as a catch-all for several
> distinct error conditions across subflow setup, authentication, and
> data-path validation.  The existing MPRstTx/MPRstRx counters only
> track aggregate reset volume, making it difficult to diagnose which
> code path is triggering subflow resets in production.
> 
> Add per-event MIB counters covering each MPTCP_RST_EMPTCP use site
> that is not already covered by an existing counter, named after the
> underlying event or condition rather than the reset action:
> 
>   MD5SigReset           MD5SIG enabled on listener (incompatible)
>   MPJoinSynAckNoMPJoin  SYN/ACK missing MP_JOIN option
>   MPJoinAckNoMPJoin     server-side ACK missing MP_JOIN option
>                           (fallback path, MPJoin required)
>   MPJoinAckNoCtx        server-side ACK with no subflow context
>   DssReset              data mapping invalid (also fires on
>                           MAPPING_NODSS / EMIDDLEBOX path)
>   MPJoinNotEstablished  JOIN attempted on a not-fully-established msk
> 
> The aggregate MPRstTx/MPRstRx counters are unchanged.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/511
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
> v2:
>   - Drop MPRstNoToken (use MPTCP_MIB_JOINNOTOKEN)
>   - Drop MPRstHMAC (use MPJoinSynAckHMacFailure; SynAck site
>     fixed in c4a99a921949)
>   - Rename MPRstMD5SIG -> MD5SigReset
>   - Rename MPRstNoMPJ -> MPJoinSynAckNoMPJoin
>   - Rename MPRstBadMap -> DssReset; also fire on EMIDDLEBOX branch
>   - Split MPRstFatalFallback into MPJoinAckNoMPJoin (fallback)
>     and MPJoinAckNoCtx (!ctx)
>   - Rename MPRstNotEstablished -> MPJoinNotEstablished
>     (mptcp_finish_join is reached from both SYN/ACK and ACK paths)
> v1: https://lore.kernel.org/all/20260421095646.3741956-1-shardul.b@mpiricsoftware.com/

Thank you for the v2.

For next time, do you mind always adding a cover-letter when you have
more than one patch, please? That's what is usually done here, and some
automated tools expect one, and wait for it before validating the series
(e.g. our CI).

(...)

> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index f23fda0c55a7..e44ae95c3e7e 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -71,6 +71,12 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
>  	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
>  	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
> +	SNMP_MIB_ITEM("MD5SigReset", MPTCP_MIB_MD5SIGRESET),
> +	SNMP_MIB_ITEM("MPJoinSynAckNoMPJoin", MPTCP_MIB_MPJOINSYNACKNOMPJOIN),
> +	SNMP_MIB_ITEM("MPJoinAckNoMPJoin", MPTCP_MIB_MPJOINACKNOMPJOIN),
> +	SNMP_MIB_ITEM("MPJoinAckNoCtx", MPTCP_MIB_MPJOINACKNOCTX),
> +	SNMP_MIB_ITEM("DssReset", MPTCP_MIB_DSSRESET),
> +	SNMP_MIB_ITEM("MPJoinNotEstablished", MPTCP_MIB_MPJOINNOTESTABLISHED),

Do you mind moving the declaration next to similar ones, please?

e.g. MD5SigReset after MD5SigFallback, MPJoinSynAckNoMPJoin after all
the MPJoinSynAck(...) ones, etc.

>  	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
>  	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
>  	SNMP_MIB_ITEM("SndWndShared", MPTCP_MIB_SNDWNDSHARED),
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 812218b5ed2b..da0b08cfd35f 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -70,6 +70,12 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
>  	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
>  	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
> +	MPTCP_MIB_MD5SIGRESET,		/* MP_RST: MD5SIG enabled on listener */
> +	MPTCP_MIB_MPJOINSYNACKNOMPJOIN,	/* MP_RST: missing MP_JOIN in SYN/ACK */
> +	MPTCP_MIB_MPJOINACKNOMPJOIN,	/* MP_RST: missing MP_JOIN in ACK */
> +	MPTCP_MIB_MPJOINACKNOCTX,	/* MP_RST: no subflow context on ACK */
> +	MPTCP_MIB_DSSRESET,		/* MP_RST: bad data mapping */
> +	MPTCP_MIB_MPJOINNOTESTABLISHED,	/* MP_RST: JOIN on not-fully-established msk */

Same here for the order.

The rest looks good to me!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

