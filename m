Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360045;
	b=b8L/KT3J0EvannV4z/cirW8FpdfjnkstVmnw+ITnnTDU25PlA/UTOWvOk6F5enzfjWZ5
	 q9zMvs/4Txx74bfIpTB3w+EwsKetRhDvrxvpZtuFZztUSt+lPh1zWV7fSkndQB93Fh0S2
	 gKYOfeLlHStHSH8QHZdwfHPYuTPstnx2IvOfnjZwcSaiJYJ3dfR2X/t8RByj7bCrKNaY2
	 6c3CyUqpundq5duXXoJEQCCYXrBT80/5JEy5BOlIuxzgaHcz2GTeF+gQdTRj82+Gf0ATm
	 swQqHzOtTQwQETupdtuEqU4GA3wiuu8lKml40m67p7YveEA0QztQxOBJdfmwfoU+hHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360045;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Cc:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=XtU8Z3kTHQuYQZcN4K68hoGFiUpQb6sEjBgIxhn68kA=;
	b=GHxyL3aIihTa0Ne1d+b4uZ7Z/0bHZMtKwcXBDQop/sSKpS1Qitrk6OmS9zyLPpqfpSoR
	 l5oQrCmsWqUPF3jOLjK462uaojQVulhQ+TTbAjtf1pT3KJB31T5rbiSAXVVpzsdFVxpV8
	 SpbnRQ7MoAXLbANd80Hy26hB31CAMrT6zhY4Oe86fFn8gHcqDAxXydlPfVhvGnF8j6oao
	 W8E60jMvwVixCEEvFHGdxXrjZMi9KcwoG5s6E/1nCZxqL54emGb6uZUhWDUTiLXnBfS40
	 XRXiMAZsQqbo66EuouMCxONOqzRPs548Tc7jDex55W/goX7PNJSd2aAk9of97xOChzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KBPmofuu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F5606A31A;
	Fri, 30 Oct 2026 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KBPmofuu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87181F000C1;
	Fri, 30 Oct 2026 11:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793360044;
	bh=XtU8Z3kTHQuYQZcN4K68hoGFiUpQb6sEjBgIxhn68kA=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=KBPmofuu+j3fz+v1akAKpsxGfhDXcSvxHepXr5bcupc2p3Uki88BVnz43RvY3IwTZ
	 2E+9xPfYTxB57/IMuiHb8QjI8QMbAw6gs3LU7eLrz4jj9TLHma4X0vrXPIQehYgwwu
	 1kEGOOey5+nMw8g8Ow/LrlrJUi5q8PpYjMkVXXlbgw92Q9zXYIhNZJ5qGl1ae+1zcD
	 hlKfXogTGK/j87NzO05RhrPH+H2TZuFY6yxzlMXX5tv3NfozESLFu6KFcmwDWLB9Dk
	 V1cpUrnfCLnyaIBu72znqQlfosvYkvmFd6d1mWBRPUhSlM8gCCDYV3zGc6r+78p13i
	 7WRoFyrJrA8Iw==
Message-ID: <ac96b364-f395-4bfa-9fad-8e01e41a81b8@kernel.org>
Date: Fri, 30 Oct 2026 12:34:01 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: options: track invalid
 suboptions
Content-Language: fr
To: sashiko-reviews@lists.linux.dev
References: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
 <20261029-mptcp-mib-inval-opt-v3-2-428f42a35674@kernel.org>
 <sashiko-outbox-190022@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <sashiko-outbox-190022@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2026 22:52, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mptcp: missing invalid option checks in mptcp_parse_option()
> --
> 
> commit e7e04837e80d59cf3334575f91dc516262bef4d7
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> mptcp: options: track invalid suboptions
> 
> This commit adds the MPTCP_MIB_OPTINVALID MIB counter to track incoming
> MPTCP options that have invalid sizes or unexpected suboption combinations.
> 
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index cbc105199073e..10a150e2ad69e 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -20,7 +20,7 @@ static bool mptcp_cap_flag_sha256(u8 flags)
>>  	return (flags & MPTCP_CAP_FLAG_MASK) == MPTCP_CAP_HMAC_SHA256;
>>  }
>>  
>> -static void mptcp_parse_option(const struct sk_buff *skb,
>> +static void mptcp_parse_option(const struct sock *sk, const struct sk_buff *skb,
>>  			       const unsigned char *ptr, int opsize,
>>  			       struct mptcp_options_received *mp_opt)
>>  {
> 
> [ ... ]
> 
>> @@ -175,7 +177,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>>  					    OPTION_MPTCP_PRIO |
>>  					    OPTION_MPTCP_FASTCLOSE |
>>  					    OPTION_MPTCP_FAIL)) != 0)
>> -			break;
>> +			goto invalid;
>>  
>>  		pr_debug("DSS\n");
>>  		ptr++;
>> @@ -218,7 +220,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>>  			mp_opt->ack64 = 0;
>>  			mp_opt->use_ack = 0;
>>  			mp_opt->data_fin = 0;
>> -			break;
>> +			goto invalid;
>>  		}
>>  
>>  		mp_opt->suboptions |= OPTION_MPTCP_DSS;
> 
> [ ... ]
> 
>> @@ -386,10 +388,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>>  		/* Can be used with a restricted number of other options */
>>  		if ((mp_opt->suboptions & ~(OPTION_MPTCP_FAIL |
>>  					    OPTION_MPTCP_FASTCLOSE)) != 0)
>> -			break;
>> +			goto invalid;
>>  
>>  		if (opsize != TCPOLEN_MPTCP_RST)
>> -			break;
>> +			goto invalid;
>>  
>>  		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
>>  			break;
> 
> [ ... ]
> 
>> @@ -418,11 +420,17 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>>  		break;
>>  
>>  	default:
>> +		/* Not invalid: maybe used for experimentations */
>>  		break;
>>  	}
>> +
>> +	return;
>> +
>> +invalid:
>> +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OPTINVALID);
>>  }
> 
> [Severity: Medium]
> Can a couple of invalid option cases in net/mptcp/options.c:mptcp_parse_option()
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
> 				   mp_opt);
> 
> When opsize == 2, ptr already points past the end of the 2-byte option.
> At the start of mptcp_parse_option(), *ptr is dereferenced before checking
> opsize:
> 
> net/mptcp/options.c:mptcp_parse_option()
> 	u8 subtype = *ptr >> 4;
> 
> If the byte following the 2-byte option has an upper nibble in the default
> range (9..15), switch (subtype) hits default: break and returns without
> incrementing MPTCP_MIB_OPTINVALID. Similarly, if opsize is 2 or 3 and
> subtype is MPTCPOPT_DSS, the MPTCPOPT_DSS case advances ptr and reads a
> 4th byte before validating opsize against expected_opsize (minimum
> TCPOLEN_MPTCP_DSS_BASE == 4):
> 
> 	case MPTCPOPT_DSS:
> 		...
> 		ptr++;
> 
> 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;

I guess we would need a new dedicated patch to fix that first, then
increment the counter when it happens.

> Second, in the MPTCPOPT_RST case:
> 
> 		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
> 			break;
> 
> If a peer sends an MP_RST suboption on a packet without TCPHDR_RST set, it
> breaks out instead of jumping to invalid. Aside from not incrementing
> MPTCP_MIB_OPTINVALID, this leaves OPTION_MPTCP_RST unset in
> mp_opt->suboptions, so a packet carrying MP_RST followed by DSS on a
> non-RST segment will accept the DSS option without flagging the invalid
> MP_RST + DSS combination.
> 
> Should mptcp_parse_option() check for a minimum opsize (and minimum DSS
> size before reading flags) and jump to invalid when MPTCPOPT_RST is
> received without TCPHDR_RST?
Same here I think.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

