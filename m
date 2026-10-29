Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310771;
	b=HBQ5maUEOlbsjE5bsAz+ovtPDfWLcqshX2UboT7AJdrDz49k4iqhwEmsrqQaROqP4zQ3
	 hLiW15Lg/ssTmT9Yep0boemjR2E6eUK3cHALb1cs5JKnqyEMKpYzStKvxvxXaiuqfAKN8
	 l37/TO/xgHctcEloPTx+uKxl4HUbKDNfypwJSrbfjCmskZxhr1p89wSLgb30y5RRa+5HO
	 kaCyvNXmujJGDuLrbOiwABG0EgGLnYS5xWYPWP7kmuQCIOobjioj9dvqbxCXGa8X7ZVUB
	 4EF71SFIGqHEMvYpWINtRtbdS5Ug35JZX3vVFOApll6HuBL7oWyJyQZgsv9arc45mjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KsHJKATWWJcADk0Y4JliS/ouXqFCdKnJ/1bktzfeDOA=;
	b=GObYQEM1I7+MyN6p3aNu7zZjmZbnDN7kyUYrtnWdQib2/ACgp673ICbfssrqa7BDrQ5D
	 vakfy6AUAUrQjc1WwnuSsVFA+kGJr8fVy3fW2JLEqvThuKX9InJSr85wD+q6ZXTuZeJWs
	 N3tvPpqSn1Wjrl91W/Hj/VM9GB8lBfRoOXgedtLaayaehhTcsETpn3nILU6PqzoPpKoJ/
	 e14KfwGePnW0F9LzwNax8i7cfyniDAesOaoI1ubKOf2srtox2xakDmCzESqZjZBwrqBA2
	 55WdFwlY6G9G5XOTTOYhQ47GuYvBi1XINZsDeeBzy+e6G+X0RJovWOwHJ9iwXJIDYEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b4bGz7Td;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAA4606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b4bGz7Td
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37BC1F01816;
	Thu, 29 Oct 2026 21:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793310770;
	bh=KsHJKATWWJcADk0Y4JliS/ouXqFCdKnJ/1bktzfeDOA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=b4bGz7Tdsb6X1UgGkf2DCVp1JxEGMgzhZ8q6xRn2Uo/2F6guwWwlohc+GCTAAuoGA
	 bHWqcZdVDygjFdhzqcmdFJ4kq7/GDS5SaSKY8MXR0quhp+r2KQMKLlH6TJdNcfouAi
	 pX9vZZPXkC+UQAxiMmqCpOWdwMhxyxATuog45U7uMwR+s7F4lPrEXwAPUNmkmqu3H4
	 zmtLTiZzVppyKtGVslbuZAPezrtKPbjj2xjCyHPQsunos/6Omb55GQ8o9ufzR9CxWj
	 hLB8UTGkHxon9z0vYfilzUbdY3YvIwIcUOnJYzp9RK7HB08q/RsYwnXCMnRlPgh6lh
	 Txc3Sjmg1jauA==
Message-ID: <sashiko-outbox-190022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: options: track invalid
 suboptions
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261029-mptcp-mib-inval-opt-v3-2-428f42a35674@kernel.org>
References: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
 <20261029-mptcp-mib-inval-opt-v3-2-428f42a35674@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 21:52:50 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: missing invalid option checks in mptcp_parse_option()
--

commit e7e04837e80d59cf3334575f91dc516262bef4d7
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: options: track invalid suboptions

This commit adds the MPTCP_MIB_OPTINVALID MIB counter to track incoming
MPTCP options that have invalid sizes or unexpected suboption combinations.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cbc105199073e..10a150e2ad69e 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -20,7 +20,7 @@ static bool mptcp_cap_flag_sha256(u8 flags)
>  	return (flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA256;
>  }
> =20
> -static void mptcp_parse_option(const struct sk_buff *skb,
> +static void mptcp_parse_option(const struct sock *sk, const struct sk_bu=
ff *skb,
>  			       const unsigned char *ptr, int opsize,
>  			       struct mptcp_options_received *mp_opt)
>  {

[ ... ]

> @@ -175,7 +177,7 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
>  					    OPTION_MPTCP_PRIO |
>  					    OPTION_MPTCP_FASTCLOSE |
>  					    OPTION_MPTCP_FAIL)) !=3D 0)
> -			break;
> +			goto invalid;
> =20
>  		pr_debug("DSS\n");
>  		ptr++;
> @@ -218,7 +220,7 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
>  			mp_opt->ack64 =3D 0;
>  			mp_opt->use_ack =3D 0;
>  			mp_opt->data_fin =3D 0;
> -			break;
> +			goto invalid;
>  		}
> =20
>  		mp_opt->suboptions |=3D OPTION_MPTCP_DSS;

[ ... ]

> @@ -386,10 +388,10 @@ static void mptcp_parse_option(const struct sk_buff=
 *skb,
>  		/* Can be used with a restricted number of other options */
>  		if ((mp_opt->suboptions & ~(OPTION_MPTCP_FAIL |
>  					    OPTION_MPTCP_FASTCLOSE)) !=3D 0)
> -			break;
> +			goto invalid;
> =20
>  		if (opsize !=3D TCPOLEN_MPTCP_RST)
> -			break;
> +			goto invalid;
> =20
>  		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
>  			break;

[ ... ]

> @@ -418,11 +420,17 @@ static void mptcp_parse_option(const struct sk_buff=
 *skb,
>  		break;
> =20
>  	default:
> +		/* Not invalid: maybe used for experimentations */
>  		break;
>  	}
> +
> +	return;
> +
> +invalid:
> +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OPTINVALID);
>  }

[Severity: Medium]
Can a couple of invalid option cases in net/mptcp/options.c:mptcp_parse_opt=
ion()
still read out of bounds or miss incrementing MPTCP_MIB_OPTINVALID?

First, mptcp_get_options() only rejects opsize < 2 before calling
mptcp_parse_option():

net/mptcp/options.c:mptcp_get_options()
	opsize =3D *ptr++;
	if (opsize < 2) /* "silly options" */
		return;
	if (opsize > length)
		return;	/* don't parse partial options */
	if (opcode =3D=3D TCPOPT_MPTCP)
		mptcp_parse_option(sk, skb, ptr, opsize,
				   mp_opt);

When opsize =3D=3D 2, ptr already points past the end of the 2-byte option.
At the start of mptcp_parse_option(), *ptr is dereferenced before checking
opsize:

net/mptcp/options.c:mptcp_parse_option()
	u8 subtype =3D *ptr >> 4;

If the byte following the 2-byte option has an upper nibble in the default
range (9..15), switch (subtype) hits default: break and returns without
incrementing MPTCP_MIB_OPTINVALID. Similarly, if opsize is 2 or 3 and
subtype is MPTCPOPT_DSS, the MPTCPOPT_DSS case advances ptr and reads a
4th byte before validating opsize against expected_opsize (minimum
TCPOLEN_MPTCP_DSS_BASE =3D=3D 4):

	case MPTCPOPT_DSS:
		...
		ptr++;

		flags =3D (*ptr++) & MPTCP_DSS_FLAG_MASK;

Second, in the MPTCPOPT_RST case:

		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
			break;

If a peer sends an MP_RST suboption on a packet without TCPHDR_RST set, it
breaks out instead of jumping to invalid. Aside from not incrementing
MPTCP_MIB_OPTINVALID, this leaves OPTION_MPTCP_RST unset in
mp_opt->suboptions, so a packet carrying MP_RST followed by DSS on a
non-RST segment will accept the DSS option without flagging the invalid
MP_RST + DSS combination.

Should mptcp_parse_option() check for a minimum opsize (and minimum DSS
size before reading flags) and jump to invalid when MPTCPOPT_RST is
received without TCPHDR_RST?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-mptcp-mib-=
inval-opt-v3-0-428f42a35674@kernel.org?part=3D2
