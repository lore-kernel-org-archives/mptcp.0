Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239B18024
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494069; cv=none; b=qep1zSamxhbYLnmSiWd7MH/AVl/jc9whXb22PUCpQmy3FqbFixJExRhBF2UB5ZNbwVflUvszMG98vpSUpefpVFfbynMqrxlqchymEgfD5ryinBxaqxq10YNYRjINn5mM/X+yUsqRkxXd8KYJahgiXAyFK9nczsyjGosIQasQMNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494069; c=relaxed/simple;
	bh=RF5RmcmJ6qhoayOP/xM2wf27z1sm9yo0jTfPmpaxTUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0Cs1gFt8r9XCUJNQ/J2I+j6EyZXdD+LmaEQEI/NwHnVhvAQF9M7qPqHpSocIInzu5EK0fxVXupvdiMRlgoRlfjcFUGblsyMYoZTbDY9sIBo2lAcANLQPzgBVT8J9fJJHMIDOTEXF3gP0M0Ze4eA3bnLuk2Q7wm2To6IhpFpsmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwOfwx1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwOfwx1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86E4C4CEE7;
	Wed,  6 Aug 2025 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754494068;
	bh=RF5RmcmJ6qhoayOP/xM2wf27z1sm9yo0jTfPmpaxTUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gwOfwx1QbD4z6ruZxAkjVqRDQcx/nanbZDUDZCVSPYhujHOhqc1J3snEjiUF8TKkB
	 Y4CdoUd8gHWikJJo6ylwB9st372PFCs/cVS2siCK/f8SkfVacdRmvDtKwcuH+PtNnz
	 TQj/3Nnw8x/igKPmtE46bn3A70tQ7Li6+a4Tg0iz0EAuIN6gYbUAp8whmUREt4hJPY
	 ZGXs6B9mVs4/7HDNB3rQnJaOC0tdU2QU61hjy6xehYTFd37O52Jt//GXEc/G/5BBZo
	 qwasT/NMOvplceKYVoK2GyOCbkSRLCuweXPtlvSdjXmw3+jc+fy6il6iwASYF4Ynb6
	 w7o5VJzapFFeg==
Message-ID: <026cc9b6-4a9e-4f7a-9ff1-3f974f144912@kernel.org>
Date: Wed, 6 Aug 2025 17:27:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 1/2] mptcp: disable add_addr retransmission when
 timeout is 0
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1754449726.git.tanggeliang@kylinos.cn>
 <3e852490c11a12a42cb15712305be368372bd078.1754449726.git.tanggeliang@kylinos.cn>
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
In-Reply-To: <3e852490c11a12a42cb15712305be368372bd078.1754449726.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for looking at that!

On 06/08/2025 05:11, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> When add_addr_timeout is set to 0, it indicates that ADD_ADDR
> retransmissions should be disabled. This patch implements the logic to skip
> retransmissions when the timeout value is zero.

I think the description should show there was an issue when previously
set to 0, e.g.

  When add_addr_timeout was set to 0, this caused the ADD_ADDR to be
  retransmitted immediately, which looks like a buggy behaviour.
  Instead, interpret 0 as "no retransmissions needed".

> The documentation is updated to explicitly state that setting the timeout
> to 0 disables retransmission.

Good idea!

> Suggested-by: Matthieu Baerts <matttbe@kernel.org>

Thanks!

If it is seen as a fix, you can add a Fixes tag corresponding to the
introduction of this sysctl knob.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  Documentation/networking/mptcp-sysctl.rst | 2 ++
>  net/mptcp/pm.c                            | 7 ++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index 5bfab01eff5a..1683c139821e 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -12,6 +12,8 @@ add_addr_timeout - INTEGER (seconds)
>  	resent to an MPTCP peer that has not acknowledged a previous
>  	ADD_ADDR message.
>  
> +	Do not retransmit if set to 0.
> +
>  	The default value matches TCP_RTO_MAX. This is a per-namespace
>  	sysctl.
>  
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 687dbb59d084..5dec018fdda2 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -274,6 +274,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
>  							      add_timer);
>  	struct mptcp_sock *msk = entry->sock;
>  	struct sock *sk = (struct sock *)msk;
> +	unsigned int timeout;
>  
>  	pr_debug("msk=%p\n", msk);
>  
> @@ -291,6 +292,10 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
>  		goto out;
>  	}
>  
> +	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
> +	if (!timeout)
> +		goto out;

I think it would be better to patch mptcp_pm_alloc_anno_list(): without
that, it means sk_reset_timer() will cause mptcp_pm_add_timer() to be
called for no reasons. It looks better to prevent this, no?

(In fact, it is maybe enough to only patch mptcp_pm_alloc_anno_list(), no?)

> +
>  	spin_lock_bh(&msk->pm.lock);
>  
>  	if (!mptcp_pm_should_add_signal_addr(msk)) {
> @@ -302,7 +307,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
>  
>  	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
>  		sk_reset_timer(sk, timer,
> -			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
> +			       jiffies + timeout);
>  
>  	spin_unlock_bh(&msk->pm.lock);
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

