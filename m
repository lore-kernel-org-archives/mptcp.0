Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E6A1E9B22
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735916; cv=none; b=Zz/DBVTu9lfdgY54d4KAtdwHUCfbCU5Aodh8b08NMlM3NPWsojSmROdh/Wie4fZTJErGzKveMdWX1Qav6l864ixtL0CPZgr6Q0zFHtELZHsQwXOL9k5uNXZ12oPIUD3ffQY3SpAJ7x9rWSiU+YqTd+IWtOfu6bOEi/XAyslXG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735916; c=relaxed/simple;
	bh=kENmoYwq2MK9sHJuY8J0QHuZVdAaUsZNgcbUCzXWka8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZM3BKBWCriySetV9Y1R3bNhRr9s2cvALpj2pjAbztVBneBLkJzJFGnTLaE79gwTxZFxBVWaDDSlqrZFF1mlk9+4h9lV3A5h2YVg3ay2n54v4zHx5lk9J3cEfbSo1ubRRXJrbOPJ1cj37XvFdPEYylLfleesjQYBbN8th4HIboXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2Hw+xFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2Hw+xFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9535EC4CEE9;
	Tue, 11 Mar 2025 23:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741735916;
	bh=kENmoYwq2MK9sHJuY8J0QHuZVdAaUsZNgcbUCzXWka8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J2Hw+xFnFVCShOkSVJRvYcN97UW/uP57k4nxFWjqb3K3OQed7PhEo5g396gtIkpwi
	 2+P3u2wk87WY+8cpeV/NkvoDHYX09HEhb1UunqMnnwj5VNziHDsihSKYG/sKztM9TE
	 jrZ8y6cz5hA2szU/NUbwANkr/WK2ixBVgCGjKGaX2ds/Krq5iynswG/XXL9mJaRPg8
	 Wa+Kq+ihaSfpXqiP3RpCTdjJdfWqoCkqGHHfF4t9g4z1qONBHJVAQJlIE5+e6ICwps
	 EPPStxBhY3oXauurBXUvtqluJGTUNxcdtOZzsnstWb0TKP60rzCMh17h5eIc5Zqrce
	 g1oBzpefHsIaQ==
Message-ID: <d5e69afe-c025-42f4-b477-39ba08b4dab4@kernel.org>
Date: Wed, 12 Mar 2025 00:31:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1 4/6] mptcp: pm: add add_addr_echo()
 interface
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741685260.git.tanggeliang@kylinos.cn>
 <a550107394e989fb5557ce16fbb54050f4a20551.1741685260.git.tanggeliang@kylinos.cn>
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
In-Reply-To: <a550107394e989fb5557ce16fbb54050f4a20551.1741685260.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 11/03/2025 10:32, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The helper mptcp_pm_is_userspace() is used to distinguish userspace PM
> operations from in-kernel PM in mptcp_pm_add_addr_received(). It seems
> reasonable to add a mandatory .add_addr_echo interface for struct
> mptcp_pm_ops.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h      |  2 ++
>  net/mptcp/pm.c           | 36 ++++++++++++++++++------------------
>  net/mptcp/pm_kernel.c    |  7 +++++++
>  net/mptcp/pm_userspace.c | 12 ++++++++++++
>  net/mptcp/protocol.h     |  2 ++
>  5 files changed, 41 insertions(+), 18 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 5f2d94b2f97f..1f4d0d3988c1 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -128,6 +128,8 @@ struct mptcp_pm_ops {
>  	bool (*accept_new_subflow)(const struct mptcp_sock *msk);
>  	void (*subflow_check_next)(struct mptcp_sock *msk,
>  				   const struct mptcp_subflow_context *subflow);
> +	void (*add_addr_echo)(struct mptcp_sock *msk,

add_addr_received instead?

> +			      const struct mptcp_addr_info *addr);
>  
>  	char			name[MPTCP_PM_NAME_MAX];
>  	struct module		*owner;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d8a5c2c06500..dc7ab696c24b 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -529,6 +529,22 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
>  	msk->pm.ops->subflow_check_next(msk, subflow);
>  }
>  
> +void mptcp_pm_add_addr_echo(struct mptcp_sock *msk,
> +			    const struct mptcp_addr_info *addr)

Why is this here if it is only used by the kernel PM?

> +{
> +	struct mptcp_pm_data *pm = &msk->pm;
> +
> +	if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
> +	    (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
> +		mptcp_pm_announce_addr(msk, addr, true);
> +		mptcp_pm_add_addr_send_ack(msk);
> +	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
> +		pm->remote = *addr;
> +	} else {
> +		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
> +	}
> +}
> +
>  void mptcp_pm_add_addr_received(const struct sock *ssk,
>  				const struct mptcp_addr_info *addr)
>  {
> @@ -543,23 +559,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
>  
>  	spin_lock_bh(&pm->lock);
>  
> -	if (mptcp_pm_is_userspace(msk)) {
> -		if (mptcp_userspace_pm_active(msk)) {
> -			mptcp_pm_announce_addr(msk, addr, true);
> -			mptcp_pm_add_addr_send_ack(msk);
> -		} else {
> -			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
> -		}
> -	/* id0 should not have a different address */
> -	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
> -		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
> -		mptcp_pm_announce_addr(msk, addr, true);
> -		mptcp_pm_add_addr_send_ack(msk);
> -	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {

Here as well, I think the worker scheduling should be done from pm.c if
an optional callback is set, and this callback should be called from the
worker.

Maybe we need 2 callbacks here? One to know if there is a need to be
called from a worker, then add_addr_received? Or: can we not always send
the ADD_ADDR echo here, and schedule the worker if there is a need to?
So we would drop the "if (mptcp_userspace_pm_active(msk))" condition
above, but maybe that's OK? (We would need a dedicate patch for that)

> -		pm->remote = *addr;
> -	} else {
> -		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);

I think this MIB counter should be incremented from here, not from each PM.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

