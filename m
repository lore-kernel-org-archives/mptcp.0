Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793328934;
	b=LnRCjUHXi9jZkEXFuI6TwqltcLTAC7wQqH+IUkbNcbsVBcQrZHmt9tn7Noxx5UhhA+a0
	 TL3oB2YYiflydEdJyXRJi4vCd8PGlpJukz3Umg1tQmKfJc167AKF68eaU5zFRsBw7CxUG
	 TjE9RiMT8n+0nQHo3YTQnoPzwRzsiH6vSbt+97wrQEna5j8JwfmdDqO6o+b7oJV+qh2fu
	 ltq7G2xnK+4vJvIzlh6r/sgocjEOHTSlv5i8EYjZbX+ltvKw+rItVG7yfNaWfAe/jjgiR
	 1xRyk/H5Rcs9YDlEJ6RIfk6M0W0Gj6bkcRxar4cDykS+O3A8dHHX3paQRQW3PVzZo5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793328934;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JiWIt0CLiCuMv593It2MK1tGGwVasZI5ukWgqDYa8to=;
	b=5ZVLJem81b6k47JilynF8eRk+0D58Nx00/FsLmAS90aMnHyeI+kR5IqXS7H1+/rjgIDN
	 NqkmA3Cvvx1HhQUwjZwDEWGJ+nJgF1UdroIYDjoDI7zcL4EjX53hop1zx+8pu4RHTtjQK
	 UTd5zAtHGr9dqeCU17b/Jify6pXY77jVQlnwNasmOvs1DzV/XdicjA3XMgPRBUSTYOJsN
	 Wrb2rNNvb/aJDho/lOMqVgFwH1LPDayglfm+oH1WaUUnsNi53z9tGdx0mQvsZnJ4raVPW
	 pe2QAxHEvsbaguyCQjU9GcRbRa1Ny8HUC+vHyxfYVLZyaZDFfTk9pRQpIC3tgieEs4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKrfl5Ho;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D51606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKrfl5Ho
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A341F000C1;
	Fri, 30 Oct 2026 02:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793328934;
	bh=JiWIt0CLiCuMv593It2MK1tGGwVasZI5ukWgqDYa8to=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=IKrfl5Ho00X45xQ4U4HpN9GiQAOL19dkxgE6cBWW/i3prYjsyFq6SApuoyNCBDtiQ
	 bNRZHjbnQYpW/s/NF/NDy6x1BeWCegDPD2P2MTAg/3NPowLEEeKpMHgg7daToZ+w9b
	 0DvmEiLVcHfhMsxOJfYBqjzGBYJPVFQTxxLFpz3PoEqBo+7TTFncGefhzrY0lIljf3
	 C6kleFM+5KjRtW4aEIkPGpUUCFCbJUvWLizyWGZoPTqmRlGQux8kT1cb+TqFSq+Bta
	 Ucbb8pZoQ7YjSJOpHktqjNQb4Sif744dg7sm182juKDCwIXFCwI9RiAKD+aeM582kF
	 YqyMxilZmU51g==
Message-ID: <43ba36c46a881b53ab60aed2c431ac93a2c69a70.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 1/3] mptcp: options: use a dedicated bit
 for csum reqd
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Fri, 30 Oct 2026 10:55:25 +0800
In-Reply-To: <20261029-mptcp-mib-inval-opt-v3-1-428f42a35674@kernel.org>
References: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
	 <20261029-mptcp-mib-inval-opt-v3-1-428f42a35674@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2026-10-29 at 22:05 +0100, Matthieu Baerts (NGI0) wrote:
> Instead of mixing that with suboptions: that's the only non-
> suboptions
> that is present in the 'suboptions' field.
> 
> This even cause a workaround with OPTIONS_MPTCP_DSS to exclude this
> non-suboptions when checking which other ones are set.

I initially thought about splitting this patch into two: one to remove
OPTION_MPTCP_CSUMREQD, and another to remove OPTIONS_MPTCP_DSS. But on
second thought, it's better to keep them together as is.

> 
> Move it to a dedicated free bit, and adapt the corresponding code.
> 
> This is clearer like that.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good!

	Reviewed-by: Geliang Tang <geliang@kernel.org>

> ---
>  net/mptcp/options.c  | 25 ++++++++++++-------------
>  net/mptcp/protocol.c |  2 +-
>  net/mptcp/protocol.h |  6 ++----
>  net/mptcp/subflow.c  |  2 +-
>  4 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index adbf8e0773db..cbc105199073 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -93,9 +93,8 @@ static void mptcp_parse_option(const struct sk_buff
> *skb,
>  		 * In other words, the only way for checksums not to
> be used
>  		 * is if both hosts in their SYNs set A=0."
>  		 */
> -		if ((flags & MPTCP_CAP_CHECKSUM_REQD) &&
> -		    opsize < TCPOLEN_MPTCP_MPC_ACK_DATA)
> -			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
> +		mp_opt->csum_reqd = (flags &
> MPTCP_CAP_CHECKSUM_REQD) &&
> +				    opsize <
> TCPOLEN_MPTCP_MPC_ACK_DATA;
>  
>  		mp_opt->deny_join_id0 = !!(flags &
> MPTCP_CAP_DENY_JOIN_ID0);
>  
> @@ -122,7 +121,7 @@ static void mptcp_parse_option(const struct
> sk_buff *skb,
>  		}
>  		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM) {
>  			mp_opt->csum = get_unaligned((__force
> __sum16 *)ptr);
> -			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
> +			mp_opt->csum_reqd = 1;
>  			ptr += 2;
>  		}
>  		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d
> sndr=%llu, rcvr=%llu len=%d csum=%u\n",
> @@ -251,22 +250,22 @@ static void mptcp_parse_option(const struct
> sk_buff *skb,
>  			ptr += 2;
>  
>  			if (opsize == expected_opsize +
> TCPOLEN_MPTCP_DSS_CHECKSUM) {
> -				mp_opt->suboptions |=
> OPTION_MPTCP_CSUMREQD;
>  				mp_opt->csum =
> get_unaligned((__force __sum16 *)ptr);
> +				mp_opt->csum_reqd = 1;
>  				ptr += 2;
>  			}
>  
>  			pr_debug("data_seq=%llu subflow_seq=%u
> data_len=%u csum=%d:%u\n",
>  				 mp_opt->data_seq, mp_opt-
> >subflow_seq,
> -				 mp_opt->data_len, !!(mp_opt-
> >suboptions & OPTION_MPTCP_CSUMREQD),
> -				 (mp_opt->suboptions &
> OPTION_MPTCP_CSUMREQD) ? mp_opt->csum : 0);
> +				 mp_opt->data_len, mp_opt-
> >csum_reqd,
> +				 mp_opt->csum_reqd ? mp_opt->csum :
> 0);
>  		}
>  
>  		break;
>  
>  	case MPTCPOPT_ADD_ADDR:
>  		/* Can be used with a restricted number of other
> options */
> -		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
> +		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
>  					    OPTION_MPTCP_RM_ADDR |
>  					    OPTION_MPTCP_PRIO)) !=
> 0)
>  			break;
> @@ -333,7 +332,7 @@ static void mptcp_parse_option(const struct
> sk_buff *skb,
>  		/* Can be used with a restricted number of other
> options */
>  		if ((mp_opt->suboptions & ~(OPTION_MPTCP_MPC_ACK |
>  					    OPTIONS_MPTCP_MPJ |
> -					    OPTIONS_MPTCP_DSS |
> +					    OPTION_MPTCP_DSS |
>  					    OPTION_MPTCP_ADD_ADDR |
>  					    OPTION_MPTCP_PRIO)) !=
> 0)
>  			break;
> @@ -354,7 +353,7 @@ static void mptcp_parse_option(const struct
> sk_buff *skb,
>  	case MPTCPOPT_MP_PRIO:
>  		/* Can be used with a restricted number of other
> options */
>  		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_MPJ |
> -					    OPTIONS_MPTCP_DSS |
> +					    OPTION_MPTCP_DSS |
>  					    OPTION_MPTCP_ADD_ADDR |
>  					    OPTION_MPTCP_RM_ADDR))
> != 0)
>  			break;
> @@ -369,7 +368,7 @@ static void mptcp_parse_option(const struct
> sk_buff *skb,
>  
>  	case MPTCPOPT_MP_FASTCLOSE:
>  		/* Can be used with a restricted number of other
> options */
> -		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
> +		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
>  					    OPTION_MPTCP_RST)) != 0)
>  			break;
>  
> @@ -405,7 +404,7 @@ static void mptcp_parse_option(const struct
> sk_buff *skb,
>  
>  	case MPTCPOPT_MP_FAIL:
>  		/* Can be used with a restricted number of other
> options */
> -		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
> +		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
>  					    OPTION_MPTCP_RST)) != 0)
>  			break;
>  
> @@ -1352,7 +1351,7 @@ bool mptcp_incoming_options(struct sock *sk,
> struct sk_buff *skb)
>  		}
>  		mpext->data_len = mp_opt.data_len;
>  		mpext->use_map = 1;
> -		mpext->csum_reqd = !!(mp_opt.suboptions &
> OPTION_MPTCP_CSUMREQD);
> +		mpext->csum_reqd = mp_opt.csum_reqd;
>  
>  		if (mpext->csum_reqd)
>  			mpext->csum = mp_opt.csum;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8..c85401952bf1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3798,7 +3798,7 @@ struct sock *mptcp_sk_clone_init(const struct
> sock *sk,
>  	WRITE_ONCE(msk->token, subflow_req->token);
>  	msk->in_accept_queue = 1;
>  	WRITE_ONCE(msk->fully_established, false);
> -	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
> +	if (mp_opt->csum_reqd)
>  		WRITE_ONCE(msk->csum_enabled, true);
>  
>  	WRITE_ONCE(msk->write_seq, subflow_req->idsn + 1);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3be60da12924..cb1862ca5cb3 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -31,13 +31,10 @@
>  #define OPTION_MPTCP_DSS	BIT(11)
>  #define OPTION_MPTCP_FAIL	BIT(12)
>  
> -#define OPTION_MPTCP_CSUMREQD	BIT(13)
> -
>  #define OPTIONS_MPTCP_MPC	(OPTION_MPTCP_MPC_SYN |
> OPTION_MPTCP_MPC_SYNACK | \
>  				 OPTION_MPTCP_MPC_ACK)
>  #define OPTIONS_MPTCP_MPJ	(OPTION_MPTCP_MPJ_SYN |
> OPTION_MPTCP_MPJ_SYNACK | \
>  				 OPTION_MPTCP_MPJ_ACK)
> -#define OPTIONS_MPTCP_DSS	(OPTION_MPTCP_DSS |
> OPTION_MPTCP_CSUMREQD)
>  
>  /* MPTCP option subtypes */
>  #define MPTCPOPT_MP_CAPABLE	0
> @@ -165,7 +162,8 @@ struct mptcp_options_received {
>  		    echo:1,
>  		    backup:1,
>  		    deny_join_id0:1,
> -		    __unused:2;
> +		    csum_reqd:1,
> +		    __unused:1;
>  	);
>  	struct mptcp_rm_list rm_list;
>  	/* Options below are mutually exclusive, see
> mptcp_parse_option() */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b20258..b1aa772a2519 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -592,7 +592,7 @@ static void subflow_finish_connect(struct sock
> *sk, const struct sk_buff *skb)
>  			goto fallback;
>  		}
>  
> -		if (mp_opt.suboptions & OPTION_MPTCP_CSUMREQD)
> +		if (mp_opt.csum_reqd)
>  			WRITE_ONCE(msk->csum_enabled, true);
>  		if (mp_opt.deny_join_id0)
>  			WRITE_ONCE(msk->pm.remote_deny_join_id0,
> true);
