Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA63E5908BB
	for <mptcp@lists.linux.dev>; Tue,  8 Sep 2026 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889149; cv=none; b=MHojC9etFxaR0ij0BG/RYgsMKj5CMMGUEQSWgPezI5Nl4uXIVsz8GpLKVGOp98kSwW1zEOcnG6gE7S9CZLal+/KO73xrSQMhEQEZNNG5iI59qK/pJ9Q1glRdydgz64xAHDdOKmm/deGyRg7va5UxmKHofWKNGthubLL9pGRSA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889149; c=relaxed/simple;
	bh=LaGTbNDb2K5u+vPoNxardYbHgdq8qstgnvcGI9pX5pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iYO5zDMJjICD3YIy1VEhz1Cw4feM3lunn2iyMO3DT1zUb4bdzU+dgflYDBxoWFN00aUfk5AdsKXIQLhniFwhGUbd/d/7sDoIblhJyAJ9584DfoyVcpyCgUAd4WfyPAwh/iiWUp2CSNtCzteKOryf9DXjCLYbygA6dwHXB647+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO1dvLxr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO1dvLxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7675B1F00A3A;
	Tue,  8 Sep 2026 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788889147;
	bh=mDYyk3EjHsuKG0zaEo1x897vfEDp+T18Ep1Nsz5eBk4=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=WO1dvLxr9AUbcbXOexwQ5oPYIt9A4sz5FWh1eNUxO8sIjNbR5bTrBjuJBCm3WaIzD
	 PzkwjL4ilLmwYbE/1MfCV/n0or2UKs8VOFsEcbE5VZZ5pcRKY/sroEQpGmCOT/DdVg
	 56VzmZfAJ8ea0rSvNNEuf1yJLa7W+FBjTIwYKbArUshee5owYaqBD0kyBrzvEgd9lz
	 O2dBVchbDirzJ4HOYIngL++l9NSFuhpzEMK4rC1vGtLPFvdIUUNfTO7vVgSagNMjnu
	 QX9njsRjQxMcIOiNr+JlkK0pGDDbmRmWlIdtXZpUJfq84AqoFfbTRWc249iaOf64Rz
	 LXNG9LydfzYvQ==
Message-ID: <7ebf53f7-b09d-4d38-a1e5-8f4853627386@kernel.org>
Date: Tue, 8 Sep 2026 19:39:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2] mptcp: shrink struct mptcp_options_received
Content-Language: fr
To: quanyeyang@proton.me, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260904-mptcp-shrink-opt-rx-v2-v2-1-d8662bb18ef2@proton.me>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260904-mptcp-shrink-opt-rx-v2-v2-1-d8662bb18ef2@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Quanye,

On 04/09/2026 13:22, Quanye Yang via B4 Relay wrote:
> From: Quanye Yang <quanyeyang@proton.me>
> 
> struct mptcp_options_received is allocated on the stack while parsing
> incoming MPTCP options. Several suboptions are mutually exclusive, as
> enforced by mptcp_parse_option(), so their payloads can overlap.
> 
> Group fields by suboption and place the mutually exclusive payloads in
> an anonymous union: MP_CAPABLE keys, MP_JOIN, ADD_ADDR, MP_FAIL and
> MP_FASTCLOSE. Keep DSS and rm_list outside the union: they can be
> combined with other suboptions. Split the former shared rcvr_key into
> rcvr_key (MP_CAPABLE) and fc_recv_key (MP_FASTCLOSE). Move join_id into
> the MP_JOIN group, and overlap token, thmac and hmac inside that group.
> 
> Further shrinking would require changing the parser so currently
> coexisting fields (DSS mapping vs ACK, rm_list, status flags) can
> overlap. That adds complexity for little gain, since the outer union is
> already dominated by the MP_JOIN / ADD_ADDR members.
> 
> This reduces the structure size from 136 to 72 bytes on x86_64.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/625
> Signed-off-by: Quanye Yang <quanyeyang@proton.me>
> ---
> Changes in v2:
> - Group fields by suboption and move join_id into the MP_JOIN group
> - Split rcvr_key into rcvr_key (MP_CAPABLE) and fc_recv_key (MP_FASTCLOSE)
> - Overlap MP_JOIN token, thmac and hmac
> - Drop the dependency on the invalid-option series
> - Link to v1: https://patch.msgid.link/20260904-mptcp-shrink-opt-rx-v1-1-2d87ab9505ff@proton.me

Thank you for the new version. It looks good to me, just a few "details"
if you don't mind.

> ---
>  net/mptcp/options.c  |  6 +++---
>  net/mptcp/protocol.h | 44 +++++++++++++++++++++++++++++---------------
>  2 files changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index f87707110c75..943b2b37eaae 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -374,10 +374,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  			break;
>  
>  		ptr += 2;
> -		mp_opt->rcvr_key = get_unaligned_be64(ptr);
> +		mp_opt->fc_recv_key = get_unaligned_be64(ptr);
>  		ptr += 8;
>  		mp_opt->suboptions |= OPTION_MPTCP_FASTCLOSE;
> -		pr_debug("MP_FASTCLOSE: recv_key=%llu\n", mp_opt->rcvr_key);
> +		pr_debug("MP_FASTCLOSE: fc_recv_key=%llu\n", mp_opt->fc_recv_key);
>  		break;
>  
>  	case MPTCPOPT_RST:
> @@ -1259,7 +1259,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  
>  	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
>  		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
> -		    READ_ONCE(msk->local_key) == mp_opt.rcvr_key) {
> +		    READ_ONCE(msk->local_key) == mp_opt.fc_recv_key) {
>  			WRITE_ONCE(msk->rcv_fastclose, true);
>  			mptcp_schedule_work((struct sock *)msk);
>  			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSERX);

Could you please do this split in a dedicated commit: it would be easier
for the reviewer (and to have a shorter patch), and could help in case
of conflicts with the backports. You can use a union in struct
mptcp_options_received.

You can simply mention in the commit message that it will help to reduce
the structure size in the next commit.

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index b3121c8c766b..11adb2d67bb6 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -145,13 +145,13 @@ static inline bool before64(__u64 seq1, __u64 seq2)
>  #define after64(seq2, seq1)	before64(seq1, seq2)
>  
>  struct mptcp_options_received {
> -	u64	sndr_key;
> -	u64	rcvr_key;
> -	u64	data_ack;
> -	u64	data_seq;
> -	u32	subflow_seq;
> -	u16	data_len;
> -	__sum16	csum;
> +	struct { /* DSS, also used by MP_CAPABLE with data */
> +		u64	data_ack;
> +		u64	data_seq;
> +		u32	subflow_seq;
> +		u16	data_len;
> +		__sum16	csum;
> +	};
>  	struct_group(status,
>  		u16 suboptions;
>  		u16 use_map:1,
> @@ -167,15 +167,29 @@ struct mptcp_options_received {
>  		    deny_join_id0:1,
>  		    __unused:2;
>  	);
> -	u8	join_id;
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
> +		struct {

I suggest adding a short comment on each anonymous struct here to make
it clearer that it is linked to a specific option:

 struct {  /* MP_CAPABLE */

> +			u64 sndr_key;
> +			u64 rcvr_key;
> +		};
> +		struct {

 struct {  /* MP_JOIN */

> +			u32 nonce;
> +			u8 join_id;
> +			union {
> +				u32 token;
> +				u64 thmac;
> +				u8 hmac[MPTCPOPT_HMAC_LEN];

Maybe adding comments here too on each line?

  /* SYN */
  /* SYN + ACK */
  /* ACK */

> +			};
> +		};
> +		struct {

 struct {  /* ADD_ADDR */

> +			struct mptcp_addr_info addr;
> +			u64 ahmac;
> +		};
> +		u64 fail_seq;
> +		u64 fc_recv_key;
> +	};
>  };
>  
>  static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
> 
> ---
> base-commit: d5a4e55ccfb893614646d0f0e5c440daa92b7467
> change-id: 20260904-mptcp-shrink-opt-rx-v2-d8e0c6951294
> 
> Best regards,
> --  
> Quanye Yang <quanyeyang@proton.me>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

