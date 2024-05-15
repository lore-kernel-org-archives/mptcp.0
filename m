Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8241C84
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758373; cv=none; b=ZtVfBP/UBXhY89Mmtxj+y/VdRbrb+gsXlH7dzfAFf5xnwS7KsTMbESjkhO1P7K6PpE6UkeGeH+8x1cNGUMw9AJZ9tcRbjHRlbZTN/ah58hpJGObgghs3k5tiY6CP70pzztr6+dDEz+ffkj9CBiPe709/ZKQi9KORSO8f882sraw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758373; c=relaxed/simple;
	bh=TVaWFQzTN+Ywanc9/lc3VbKBoe06e0d7eArNffCu5NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hr39LQlAkcPxzWyL5Jp8tlJCu/PmE66jz/qOYKz7abjq1DJ3QryKX167VxFGjFRVfWZqkyoJoE2+xAVaZQIoMiePyFCrOaQaCC6QcNH3g0bIdw+k8vDZMqRTVd9g4ja8X/ak67B0jSi4WjsJjqX8pdOTNSn/+GHrWh4Z+APxXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgniMw4r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgniMw4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD0FC116B1;
	Wed, 15 May 2024 07:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715758372;
	bh=TVaWFQzTN+Ywanc9/lc3VbKBoe06e0d7eArNffCu5NA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pgniMw4rV0MddFD2WU/kYkfRGsf/XFRxloK8JHutHp9bWxhQkwrTwxcjSKHdX3s/c
	 xTZME16wYzxN/LAkAt9J+eI61+/8Mc7R6V9TmaFMr1vkpjmcGDTSI3wP7Pgi3+7F3a
	 v4Vbr1ic/5fTK+TROxcs6znCARnBgbb1/0Ipn5/MrtXOMbdIGdTm8gcDfugSTbzPXe
	 WfJkviP/aCRMZCcD7W8+U7F8og55JG6yqazqv5D2VOCcAu8A7A0CYSSDJkKP57RVLk
	 j6P8ahp7gCbNLgZ2CEYuZKiY/pQ1G/00KeXjtKB11w4RtLQQEYKCH59PidP6eKJF6r
	 zH2Y2/mPm7kHA==
Message-ID: <774d7113-3517-45b9-b0fa-606a92914b70@kernel.org>
Date: Wed, 15 May 2024 09:32:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/3] selftests/bpf: Handle SIGINT when creating
 netns
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1715755275.git.tanggeliang@kylinos.cn>
 <8c4198e7855045559ab746be7d90f72fd550a857.1715755275.git.tanggeliang@kylinos.cn>
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
In-Reply-To: <8c4198e7855045559ab746be7d90f72fd550a857.1715755275.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 15/05/2024 08:44, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> It's necessary to delete netns during BPF selftests interrupt, otherwise
> the next tests run will fail due to unable to create netns.

I think this patch can be part of the series you sent to BPF
maintainers, because that's not specific to MPTCP, no?
(If yes, don't forget to wait 24h between posting).

Or do you send it here to have a pre-review? If yes, please see below:

> This patch adds a new SIGINT handle netns_sig_handler() in create_netns(),
> and deletes NS_TEST in this handler.
> 
> For passing argument to signal handler, a trick mentioned in [1] is
> used.
> 
> [1]
> https://stackoverflow.com/questions/6970224/providing-passing-argument-to-signal-handler

Interesting!

I guess you are referring to this answer, right?

  Link: https://stackoverflow.com/a/43400143 [1]

(instead of sharing the link to the question with multiple answers)

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/network_helpers.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 0b25b008f4f6..7e233b8c75d9 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -519,6 +519,16 @@ void cleanup_netns(struct nstoken *token)
>  	close_netns(token);
>  }
>  
> +static int netns_sig_handler(const int sig, void *ptr)
> +{
> +	struct nstoken *token = (struct nstoken *)ptr;
> +
> +	signal(sig, SIG_IGN);
> +	if (sig == SIGINT)
> +		cleanup_netns(token);
> +	return 0;
> +}
> +
>  struct nstoken *create_netns(const char *name)
>  {
>  	struct nstoken *token = NULL;
> @@ -539,6 +549,8 @@ struct nstoken *create_netns(const char *name)
>  		goto fail;
>  	}
>  
> +	signal(SIGINT, (__sighandler_t)netns_sig_handler);
> +	netns_sig_handler(SIGUSR1, (void *)token);

It doesn't look like it will work with multiple netns per test, right?
It sounds a bit restricting to limit to only one netns. Or the helper
name should be clearer about that: create_netns_single()? (not even sure
people will understand this helper can only be used if there is only one
netns to create...)

Can you not use an array (xfrm_info.c seems to be the one creating the
maximum: 3) or a list in a global variable instead?

>  	return token;
>  
>  fail:

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

