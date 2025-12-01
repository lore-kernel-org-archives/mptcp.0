Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51AB3191A2
	for <mptcp@lists.linux.dev>; Mon,  1 Dec 2025 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610530; cv=none; b=j+DUp667Udy+H8LeANL1emVwgM51FWfSNjfsw8jf5RcwDZNpiZlF+jhiZ//yT5rMsObsFyH2W9F4RAYz/meaK2O4XafGhWGKcKJNeSMbz8y4/YjFfjs7oQkwXzvXqtPUT95KKWQzxEeFw+qQJ6oJBIMWWHQakR0vAdRkTNNProM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610530; c=relaxed/simple;
	bh=uSro7YEMHJZkc6LlOHfCBZvynw2U+zX9wfT29oOyTPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V2q0oHXYQCIKfpbKtA6pSulOfO7QohGq0ZuuYTGCz8aZVGkD5z3L8YyL43Nzb7+1FSAfQ46ethwU5IjiC86gqvS7FO34xdEASFswy6ldJVAO9cUBwtoDtEtBW59S384gE0TuYCd2C9fzZs/H6pUK7o0KeqtUaztZJr+rzshkLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rmn9CB50; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rmn9CB50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7088AC4CEF1;
	Mon,  1 Dec 2025 17:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764610530;
	bh=uSro7YEMHJZkc6LlOHfCBZvynw2U+zX9wfT29oOyTPI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Rmn9CB50SFsUBTRn82NvjNXExBC7akCouPJJR8ZbJkAEHeWoSRmqb4tvRKh+5Hxxs
	 TE8IBBI/sywddZGfgcOYEqbo5G8RyBRwK+4b7CdvOX43/MVculoCjIDoPYdVzZQ9kv
	 6sB/eOV63OsKnZ1lYUaYZyof+1bt3ryGw5caq/t1Lp4/v+3hlJXnHv7k2iYqDpfeDu
	 Pa/bWvgqqydCqTEYIVhl1gL8ovrvzD16UeRE/oTcy9PYEVMFdULwa5gGLwTWy3A6zL
	 5yOKcTadUJr+9A3JlfktU6H26t9PCH+zOrzb6HudnNMsmoiVZaf10OKWmYpsnpNSRt
	 ESKTTy4T6i1cQ==
Message-ID: <fdf749ae-ec10-4809-957e-be2737241650@kernel.org>
Date: Mon, 1 Dec 2025 18:35:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: fallback earlier on simult connection
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <36b926c5d55933a6f2d2a7f6ff8d8a091c0de719.1764332508.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
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
In-Reply-To: <36b926c5d55933a6f2d2a7f6ff8d8a091c0de719.1764332508.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 28/11/2025 13:22, Paolo Abeni wrote:
> Syzkaller reports a simult-connect race leading to inconsistent fallback
> status:

(...)

> The TCP subflow can process the simult-connect syn-ack packet after
> transitioning to TCP_FIN1 state, bypassing the MPTCP fallback check,
> as the sk_state_change() callback is not invoked for * -> FIN_WAIT1
> transitions.
> 
> That will move the msk socket to an inconsistent status and the next
> incoming data will hit the reported splat.
> 
> Close the race moving the simult-fallback check at the earliest possible
> stage - that is at syn-ack generation time.

Good idea!

> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().")

From what I understand, the modification on TCP side is needed for this
fix. When reading its commit message, it sounds it should have contained
a Fixes tag, but net-next was chosen to delay the fix. Is that correct?

If yes, should I ask to backport this other commit with this patch? Or
should this patch be backported only up to stable trees already having
this other commit?

> Fixes: 4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
> Fixes: 1e777f39b4d7 ("mptcp: add MSG_FASTOPEN sendmsg flag support")> Reported-by: syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/586
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> @mattbe: could you please test vs yours syz repro?

In progress!
> simult connect pkt drill test will need a paired change; not reporting
> the full diff to avoid confusing the patch importer:
> 
>  +0  >  S  0:0(0)                    <mss 1460, sackOK, TS val 100 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>  +0  <  S  0:0(0)         win 1000   <mss 1460, sackOK, TS val 407 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
> -+0  >  S. 0:0(0)  ack 1             <mss 1460, sackOK, TS val 330 ecr 407, nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
> -+0  <  S. 0:0(0)  ack 1  win 65535  <mss 1460, sackOK, TS val 507 ecr 100, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey=2]>
> ++0  >  S. 0:0(0)  ack 1             <mss 1460, sackOK, TS val 330 ecr 407, nop,wscale 8>
> ++0  <  S. 0:0(0)  ack 1  win 65535  <mss 1460, sackOK, TS val 507 ecr 100, nop,wscale 8>
>  +0  >   . 1:1(0)  ack 1             <nop,      nop,    TS val 430 ecr 507, nop, nop, sack 0:1>

Thank you! Confirmed!

(...)

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index bc470254bd6b..b995b009f31d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1325,19 +1325,12 @@ static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
>  	return false;
>  }
>  
> -static inline bool is_active_ssk(struct mptcp_subflow_context *subflow)
> -{
> -	return (subflow->request_mptcp || subflow->request_join);

Out of curiosity, was this "subflow->request_join" not there to catch
simultaneous MPJoin connect?

Is it not needed to catch this case, and drop the second join?

https://datatracker.ietf.org/doc/html/rfc8684#section-3.9.2-8

(Or maybe the TCP code handles that as mentioned in the RFC?)

> -}
> -
>  static inline bool subflow_simultaneous_connect(struct sock *sk)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>  
> -	return (1 << sk->sk_state) &
> -	       (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING) &&
> -	       is_active_ssk(subflow) &&
> -	       !subflow->conn_finished;
> +	/* Note that the sk state implies !subflow->conn_finished. */
> +	return sk->sk_state == TCP_SYN_RECV && subflow->request_mptcp;

Detail: do we still require this helper? It is only used in one place,
already under "subflow->request_mptcp". But we can keep it if it is
easier / clearer.

>  }
>  
>  #ifdef CONFIG_SYN_COOKIES
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 86ce58ae533d..96d54cb2cd93 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1878,12 +1878,6 @@ static void subflow_state_change(struct sock *sk)
>  
>  	__subflow_state_change(sk);
>  
> -	if (subflow_simultaneous_connect(sk)) {
> -		WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));
> -		subflow->conn_finished = 1;
> -		mptcp_propagate_state(parent, sk, subflow, NULL);
> -	}
> -
>  	/* as recvmsg() does not acquire the subflow socket for ssk selection
>  	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
>  	 * the data available machinery here.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

