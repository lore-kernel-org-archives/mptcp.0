Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3024508EB
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788516599; cv=none; b=ikxUtUu/HKKurkbCzgiMEQCDW1T0exIh/vwAfMsTp5qETqXEFbSF94ud19jFWIk71hvmdQOs8Pc2g959phIcbA3fE5jK9/RlwYvUAgy6IJ2pDJ98vzwGcxRMfD82mBRRX4WJtllQPGTOjmPoizIqq7H/J9W96/sflmBO4Lwmvz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788516599; c=relaxed/simple;
	bh=8pxuu+jSSv7AvjV17whCM+uGRRZAGldEhJ5YO3xhhmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PA1L+5iSRdwQ6kc7b+g5VViNuwTZfd2dgu/iflsLw3hcfkQKTo+GRtenvgFnR3d8GqjRwyIwKu9780wZ7FZBl3oLkCbUa3KAnZtlH4XSd+O4k/FXBzvtZF6BoYGXVpRL7l+v1I8ulAWFPh58fSq7bPGCmYevFG6IfCXrokVQ1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmEuuOwa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmEuuOwa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB461F00A3E;
	Fri,  4 Sep 2026 10:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788516590;
	bh=KAFPYmuji+2R2aacFXZvAslPzcya2SsW8/31lNfGJJw=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=nmEuuOwaGjgcmwkQytwrjaNV9lvKthXC9XZ/o3TayyFY4R8PLm15L078wT1sUo0KJ
	 SuNFU3EW7SnstkJfKCi/YX6/TBnSDZHwR8TclOvopNf2X1jUk3zaCq73dwGz3Kag0m
	 2pjf+Q9dt7/XRm1pozd4YOwpesrWVtx4ZMZTwPBa4Bt7R/3K6DOCGmUdJElcFWn+li
	 f9H8csFK0Jse46KvmDutu4qbF9DwfYXy4DR3gasQGPF52iXLy8azKO8vLIR1Ju1Uyz
	 QMOzRO8gT8GK4yHmThMrgFwy5po3+cNNZywGozQOl8UYwWpMUZOA1wqbrqfwUxZH1x
	 Om0qBPqBKR2MQ==
Message-ID: <058fd36e-60a9-4132-bf51-0d76765fa561@kernel.org>
Date: Fri, 4 Sep 2026 12:09:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: shrink struct mptcp_options_received
Content-Language: fr
To: quanyeyang@proton.me, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260904-mptcp-shrink-opt-rx-v1-1-2d87ab9505ff@proton.me>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260904-mptcp-shrink-opt-rx-v1-1-2d87ab9505ff@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Quanye,

On 04/09/2026 05:08, Quanye Yang via B4 Relay wrote:
> From: Quanye Yang <quanyeyang@proton.me>
> 
> struct mptcp_options_received is allocated on the stack while parsing
> incoming MPTCP options.
> 
> The sender key, MP_JOIN fields, ADD_ADDR fields and MP_FAIL sequence
> number are mutually exclusive, as enforced by mptcp_parse_option().
> Place them in an anonymous union while keeping the existing field
> access unchanged.
> 
> This reduces the structure size from 136 to 88 bytes on x86_64.

Thank you for looking at that.

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/625
> Signed-off-by: Quanye Yang <quanyeyang@proton.me>
> ---
>  net/mptcp/protocol.h | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 739f9006c1e1..6646c428dbdf 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -142,7 +142,6 @@ static inline bool before64(__u64 seq1, __u64 seq2)
>  #define after64(seq2, seq1)	before64(seq1, seq2)
>  
>  struct mptcp_options_received {
> -	u64	sndr_key;
>  	u64	rcvr_key;

Out of curiosity, can we not also move this one with 'sndr_key' to the
union in a new anonymous struct dedicated to the MP_CAPABLE suboption? I
see it is used by an MPCAPABLE and FASTCLOSE, but maybe we could have a
new fc_recv_key field? It might be clearer to have a dedicated one for
both in the union than re-using this field in two different suboptions, no?

>  	u64	data_ack;
>  	u64	data_seq;

It might be useful to have anonymous struct with a comment to explain
that a group is linked to a suboption, e.g. here we have the DSS one,
below we have groups for MPC, MPJ, and ADD_ADDR.

> @@ -166,14 +165,22 @@ struct mptcp_options_received {
>  		    __unused:1;
>  	);
>  	u8	join_id;

Can this be moved to the MPJ group?

> -	u32	token;
> -	u32	nonce;
> -	u64	thmac;
> -	u8	hmac[MPTCPOPT_HMAC_LEN];
> -	struct mptcp_addr_info addr;
>  	struct mptcp_rm_list rm_list;
> -	u64	ahmac;
> -	u64	fail_seq;
> +	/* Options below are mutually exclusive, see mptcp_parse_option() */
> +	union {
> +		u64 sndr_key;
> +		struct {
> +			u32 token;
> +			u32 nonce;
> +			u64 thmac;
> +			u8 hmac[MPTCPOPT_HMAC_LEN];

Maybe yet another anonymous union here for thmac and hmac? I don't think
they can be used at the same time.

> +		};
> +		struct {
> +			struct mptcp_addr_info addr;
> +			u64 ahmac;
> +		};
> +		u64 fail_seq;
> +	};
>  };

Out of curiosity, did you check the other ideas suggested in the ticket?
If yes, it would be good to add them in the commit message explaining
that they are not worth it for some reason.

>  
>  static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
> 
> ---
> base-commit: 10d57dc355c99e071a198e50c45503bce944dd5c
> change-id: 20260904-mptcp-shrink-opt-rx-ef8581f125df
> prerequisite-message-id: <20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org>
> prerequisite-patch-id: 7f8decba16ce568283eaa86b23cd93b183aaa675
> prerequisite-patch-id: c8fedc4ff2b5997f716dac0c30ec7620ecf11fc0
> prerequisite-patch-id: 5abea779f2b0af347cd88d6b65bfc3b9eefff405
It looks like your patch doesn't conflict with my series. Do you mind
sending the v2 without the dependencies because it looks like both our
CI and Sashiko were not able to apply your patches. I think that's
because they use 'git am -3' and they don't find the base.

Note that for our CI, it doesn't support b4 dependencies, but it
supports the "Based-on" tag:

  https://github.com/multipath-tcp/mptcp_net-next/wiki/CI#base-patches

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

