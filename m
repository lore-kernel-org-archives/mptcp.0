Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330086;
	b=bfoFcco5Yu4v2eNZk1zoyaQrdvTHgsIlGC4V/jnu+/FIFtDtw//pWhsPEgbiZAao9w/S
	 42VroszuYRLQIFIR9TQ4A+PHVyavOjlbIaybv4TVrJu6T8ubBexYjFuupmRMUwPscMsKg
	 H9a8yhSLuQ+9F/eq+sqTZOCAFrxf5WOarRw4HtyJam0JnahQAyVfbua1XNpIAljTznO+H
	 ZY0wRvrbKZJ5C2wZXPWP/Jtoh+glI+JrhpnHgLuCPSBbAdXVOJEeF5slk3BW/d85f9qO0
	 eejnnwlG6juUz0hJAygvEZ12fcJjieG9obZwddMe88Z0df7y5DxcaBbT278xTuLkavA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330086;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fT/31aHRW+tfFfII9nu9KVU5Tn1xO081+VxNWBoI/6g=;
	b=Kg7sceKs0u/HstJmcdROqZWWaJJxGX+57VbF6AVWtBnvL+LQCWlinPifoWIDyVjg85uC
	 +LZK2hz8yZlmCQaq0UzhMzuMiVXvm3AnFS5462psjmRJFT2mw+vTmtSsdUvZwiuYHvYaN
	 7xFM6/jbilc96ajrQMFD1BXiSe5Abt5pY3924UZ2cq/AdX+fuUuey2fJzh47hmkY/2A/4
	 EhSMllMKMUiEd5JVv2FHJ4hQqzSDf9yH5iJQwX+hR5SYLMSF/JiPocK5yPRGsEuMzerez
	 7byMeyFudVciJcWK1hD7qPYTRBdgrE2Mchb4K3y6uji6kwo0HCielb/QeHqDKxUkGGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuZpUJ+u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19083606A31A;
	Fri, 30 Oct 2026 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuZpUJ+u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA03A1F000C1;
	Fri, 30 Oct 2026 03:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793330085;
	bh=fT/31aHRW+tfFfII9nu9KVU5Tn1xO081+VxNWBoI/6g=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=RuZpUJ+u7rOjLuptwH7NOh9Xa2fY2M47kkeCoDMo9/nzyGV+naGWZta5XDBK7r3cs
	 gepMsSEvCYxetFn0SQjzQh2/CL8rRdqcg9hG4y/O6ZZZbFvSYjxONjiO3FzR0EDEdk
	 IKH9l/pN+KcjWtUns9us3f/kwnOVIz7imDceKk7lhGPZl2J4/br1qw7F49CVH4VTA0
	 wm/Z/wcsTgU9flgkuvxPQEglsCK5ASpv7di8+BLCRzH6eoPAZKa6fVl+fVJ8h/Z+A0
	 y/X7iliFFIHc3w0i1n7DLT2x/qzKNBFpfHKkYBlck7j/z19gUSgghxNvQofme5b1OI
	 OjG8Dg/+KYIwA==
Message-ID: <9ac7b40bab2bcec633cf3ed199022781f8f3f13e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: options: track invalid
 suboptions
From: Geliang Tang <geliang@kernel.org>
To: sashiko-reviews@lists.linux.dev, "Matthieu Baerts (NGI0)"
	 <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Date: Fri, 30 Oct 2026 11:14:40 +0800
In-Reply-To: <sashiko-outbox-190022@kernel.org>
References: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
	 <20261029-mptcp-mib-inval-opt-v3-2-428f42a35674@kernel.org>
	 <sashiko-outbox-190022@kernel.org>
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

On Thu, 2026-10-29 at 21:52 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Medium] mptcp: missing invalid option checks in
> mptcp_parse_option()
> --
> 
> commit e7e04837e80d59cf3334575f91dc516262bef4d7
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> mptcp: options: track invalid suboptions
> 
> This commit adds the MPTCP_MIB_OPTINVALID MIB counter to track
> incoming
> MPTCP options that have invalid sizes or unexpected suboption
> combinations.
> 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index cbc105199073e..10a150e2ad69e 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -20,7 +20,7 @@ static bool mptcp_cap_flag_sha256(u8 flags)
> >  	return (flags & MPTCP_CAP_FLAG_MASK) ==
> > MPTCP_CAP_HMAC_SHA256;
> >  }
> >  
> > -static void mptcp_parse_option(const struct sk_buff *skb,
> > +static void mptcp_parse_option(const struct sock *sk, const struct
> > sk_buff *skb,
> >  			       const unsigned char *ptr, int
> > opsize,
> >  			       struct mptcp_options_received
> > *mp_opt)
> >  {
> 
> [ ... ]
> 
> > @@ -175,7 +177,7 @@ static void mptcp_parse_option(const struct
> > sk_buff *skb,
> >  					    OPTION_MPTCP_PRIO |
> >  					    OPTION_MPTCP_FASTCLOSE
> > |
> >  					    OPTION_MPTCP_FAIL)) !=
> > 0)
> > -			break;
> > +			goto invalid;
> >  
> >  		pr_debug("DSS\n");
> >  		ptr++;
> > @@ -218,7 +220,7 @@ static void mptcp_parse_option(const struct
> > sk_buff *skb,
> >  			mp_opt->ack64 = 0;
> >  			mp_opt->use_ack = 0;
> >  			mp_opt->data_fin = 0;
> > -			break;
> > +			goto invalid;
> >  		}
> >  
> >  		mp_opt->suboptions |= OPTION_MPTCP_DSS;
> 
> [ ... ]
> 
> > @@ -386,10 +388,10 @@ static void mptcp_parse_option(const struct
> > sk_buff *skb,
> >  		/* Can be used with a restricted number of other
> > options */
> >  		if ((mp_opt->suboptions & ~(OPTION_MPTCP_FAIL |
> >  					   
> > OPTION_MPTCP_FASTCLOSE)) != 0)
> > -			break;
> > +			goto invalid;
> >  
> >  		if (opsize != TCPOLEN_MPTCP_RST)
> > -			break;
> > +			goto invalid;
> >  
> >  		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
> >  			break;
> 
> [ ... ]
> 
> > @@ -418,11 +420,17 @@ static void mptcp_parse_option(const struct
> > sk_buff *skb,
> >  		break;
> >  
> >  	default:
> > +		/* Not invalid: maybe used for experimentations */
> >  		break;
> >  	}
> > +
> > +	return;
> > +
> > +invalid:
> > +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OPTINVALID);
> >  }
> 
> [Severity: Medium]
> Can a couple of invalid option cases in
> net/mptcp/options.c:mptcp_parse_option()
> still read out of bounds or miss incrementing MPTCP_MIB_OPTINVALID?
> 
> First, mptcp_get_options() only rejects opsize < 2 before calling
> mptcp_parse_option():
> 
> net/mptcp/options.c:mptcp_get_options()
> 	opsize = *ptr++;
> 	if (opsize < 2) /* "silly options" */
> 		return;
> 	if (opsize > length)
> 		return;	/* don't parse partial options */
> 	if (opcode == TCPOPT_MPTCP)
> 		mptcp_parse_option(sk, skb, ptr, opsize,
> 				   mp_opt);
> 
> When opsize == 2, ptr already points past the end of the 2-byte
> option.
> At the start of mptcp_parse_option(), *ptr is dereferenced before
> checking
> opsize:
> 
> net/mptcp/options.c:mptcp_parse_option()
> 	u8 subtype = *ptr >> 4;
> 
> If the byte following the 2-byte option has an upper nibble in the
> default
> range (9..15), switch (subtype) hits default: break and returns
> without
> incrementing MPTCP_MIB_OPTINVALID. Similarly, if opsize is 2 or 3 and
> subtype is MPTCPOPT_DSS, the MPTCPOPT_DSS case advances ptr and reads
> a
> 4th byte before validating opsize against expected_opsize (minimum
> TCPOLEN_MPTCP_DSS_BASE == 4):
> 
> 	case MPTCPOPT_DSS:
> 		...
> 		ptr++;
> 
> 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;

These could be addressed by adding an "opsize < 3" check at the
beginning of mptcp_parse_option(). However, this issue wasn't
introduced by this patch - I think they can be ignored for now and
addressed in a separate patch if needed.

> 
> Second, in the MPTCPOPT_RST case:
> 
> 		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
> 			break;

Indeed, this should use goto invalid; instead of break. WDYT?

Thanks,
-Geliang

> 
> If a peer sends an MP_RST suboption on a packet without TCPHDR_RST
> set, it
> breaks out instead of jumping to invalid. Aside from not incrementing
> MPTCP_MIB_OPTINVALID, this leaves OPTION_MPTCP_RST unset in
> mp_opt->suboptions, so a packet carrying MP_RST followed by DSS on a
> non-RST segment will accept the DSS option without flagging the
> invalid
> MP_RST + DSS combination.
> 
> Should mptcp_parse_option() check for a minimum opsize (and minimum
> DSS
> size before reading flags) and jump to invalid when MPTCPOPT_RST is
> received without TCPHDR_RST?
