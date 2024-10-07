Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD91C1AAA
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325335; cv=none; b=MH9Eo/beqSUI/h7V1yum2imU1d6u0MF/YHgPrBDR0Sk8ivKVS+4xtSgKpgfdQ5t2vLkncjbLCkWxS6uO3Ff4F0+mIIWPaKhEN/i8vyu9LWnyizcUtt2XjhdfrrDWktmHiJFpuWZB35oxr7/sWH7qSh5LqXppjb2sWFz4GC3Je20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325335; c=relaxed/simple;
	bh=YTQ/xf1TL1ClrPwThJDutLeCnJIOac6v5giUJhoyZWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8mjOF682m8Gy/zxC3C7A2TOaV1XI/CMiYRhL9WjebY28LS6swp9wkVjprv9v+N4xesTVJfcpGHHufQORQYGDICg4UW+DW2eZX0N5trKj/0fKU04KbM/8Mx7FVha+rQNFhU1JnVk39BqNGaxlgoHgyv8gsHXNNArGv5YD7YqXk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdDB5ZCf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdDB5ZCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C96C4CEC6;
	Mon,  7 Oct 2024 18:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728325334;
	bh=YTQ/xf1TL1ClrPwThJDutLeCnJIOac6v5giUJhoyZWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LdDB5ZCfcNYDNSd6Wqi05fkYDjbkY/WF8amG5ui8JnK+8yoXrVMR2BC6cf15SNoQB
	 jcMQOeGBeh+eS8GfGLVUZk23zI6NFo6bLosn/58hSFLjiNBljgyV0jH5bgcec+FqvN
	 NSuBd9eHFc4tKSE0rxQs5xUX6tb1AOcP8pETwVvKIb4x2n6CIkPhIn0nQ+mVl3dlJS
	 arfu9L7y+QQRxZAvouHWcWDAI2tto3AbXc68JG95e36FVBEuPxsQUFak/oy1O8t5a5
	 cOJniBuvIlbdxpXxAxvWpVLBvn3tuMi0yaWvZo5iX4wx0WTSBflD9Bf+WbnRveA6kg
	 HzWvBkMePptAQ==
Message-ID: <11f4a475-02d4-4a5e-bf49-4eb235a6e645@kernel.org>
Date: Mon, 7 Oct 2024 20:22:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 1/2] mptcp: prevent MPC handshake on port-based
 signal endpoints
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Cong Wang <xiyou.wangcong@gmail.com>
References: <833cae5982ac5d5b3236845c6db4315e634f5705.1727974826.git.pabeni@redhat.com>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <833cae5982ac5d5b3236845c6db4315e634f5705.1727974826.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 03/10/2024 19:02, Paolo Abeni wrote:
> Syzkaller reported a lockdep splat:

(...)

> As noted by Cong Wang, the splat is false positive, but the code
> path leading to the report is an unexpected one: a client is
> attempting an MPC handshake towards the in-kernel listener created
> by the in-kernel PM for a port based signal endpoint.
> 
> Such connection will be never accepted; many of them can make the
> listener queue full and preventing the creation of MPJ subflow via
> such listener - its intended role.
> 
> Explicitly detect this scenario at initial-syn time and drop the
> incoming MPC request.

Thank you for this patch!

The code looks good to me! I have some small suggestions here below. I
can send them in a new version of the patch if that's easier and OK for you.

> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index ad88bd3c58df..c1455ec8d3db 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -78,6 +78,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
>  	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
>  	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
> +	SNMP_MIB_ITEM("MPCAttemptOnEndpoint", MPTCP_MIB_ENDPOINTMPC),

I suggest moving it above with the other ones related to MPC, also to
ease the backports.

While at it, I suggest this name, similar to others:

  SNMP_MIB_ITEM("MPCapableEndpAttempt", MPTCP_MIB_MPCAPABLEENDPATTEMPT),


>  	SNMP_MIB_SENTINEL
>  };
>  
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 3206cdda8bb1..cb899d26c415 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -79,6 +79,9 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
>  	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
>  	MPTCP_MIB_BLACKHOLE,		/* A blackhole has been detected */
> +	MPTCP_MIB_ENDPOINTMPC,		/* A peer attmpted MPC towards a port-based signal
> +					 * endpoint (not allowed)
> +					 */

Same here to move it above. The comment could go on one line I think:

  /* Prohibited MPC attempted towards a port-based signal endp */

>  	__MPTCP_MIB_MAX
>  };
>  

(...)

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index c3942416fa3a..e0b3c297ca7c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -532,6 +532,9 @@ struct mptcp_subflow_context {
>  		close_event_done : 1,       /* has done the post-closed part */
>  		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
>  		__unused : 9;
> +	bool	pm_listener;	    /* subflow is a listener managed by the
> +				     * in-kernel PM
> +				     */

The comment could go on a single line.

>  	bool	data_avail;
>  	bool	scheduled;
>  	bool	fully_established;  /* path validated */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index a1e28e1d8b4e..c022a39d7160 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -132,6 +132,14 @@ static void subflow_add_reset_reason(struct sk_buff *skb, u8 reason)
>  	}
>  }
>  
> +static int subflow_reset_req(struct request_sock *req,
> +			      struct sk_buff *skb)

Checkpatch is complaining about the alignment: I guess the parameters
could go on a single line.

Maybe the helper could be called "subflow_reset_req_endp()" (or similar)
as it is specific to this case?

> +{
> +	SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_ENDPOINTMPC);
> +	subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);

Maybe we can use: MPTCP_RST_EPROHIBIT?

> +	return -EPERM;
> +}
> +
>  /* Init mptcp request socket.
>   *
>   * Returns an error code if a JOIN has failed and a TCP reset
> @@ -165,6 +173,8 @@ static int subflow_check_req(struct request_sock *req,
>  	if (opt_mp_capable) {
>  		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
>  
> +		if (unlikely(listener->pm_listener))
> +			return subflow_reset_req(req, skb);
>  		if (opt_mp_join)
>  			return 0;
>  	} else if (opt_mp_join) {
> @@ -172,7 +182,8 @@ static int subflow_check_req(struct request_sock *req,
>  
>  		if (mp_opt.backup)
>  			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNBACKUPRX);
> -	}
> +	} else if (unlikely(listener->pm_listener))

(I don't know if a '{' is needed on this line, Checkpatch didn't
complain, but I thought it was doing that before.)

> +		return subflow_reset_req(req, skb);
>  
>  	if (opt_mp_capable && listener->request_mptcp) {
>  		int err, retries = MPTCP_TOKEN_MAX_RETRIES;

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

