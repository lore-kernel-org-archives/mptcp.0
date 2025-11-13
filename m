Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65960257824
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023677; cv=none; b=GsSMKasqE6m2creyyGeqaWLl21OKsV9DkRcSDjUO4PX/58iBayMCjEYQQmdBnrfUhZP3O8FHgz2MhooxUYYEmJvJOYOpnzh2Vem3IbN51piDyiBWCmTDCBoFiwEtHBh/RjrKEi3XZ81Wbf55VwJrCrr+rB4lciwmxUaGyOtq9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023677; c=relaxed/simple;
	bh=RmKNA6H3doE5+IR1gbtiers6aYu4NZKwetGeD2EFal8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=F4I04yf/tzb40TEeSj3omhx6RxZfKZA+bjLTIHSg6Bo7M276jJ1z1Sf+GH47ZftGnETcnigik9JZ/gIbAPQGYaycnejM4pvZrjXksvzVK5wPoTGUuBuZUOV7fKHmcFAB8VeYvibsTocFJjZGF3MOZZ4daA+Jeu9M3nPtH6rP53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLbZJUt0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLbZJUt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7C5C16AAE;
	Thu, 13 Nov 2025 08:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763023676;
	bh=RmKNA6H3doE5+IR1gbtiers6aYu4NZKwetGeD2EFal8=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=cLbZJUt0QOKXjFyKW08MZQs1ghQtVDddjFacX6KMyXRYGCEdlN6fjKORHc19nXrck
	 vdgzdoU46Fc7Tvlq3PvN9c1yNAJAInaMB/7Y7j97lEMRDMov6s0aT1niltFupZ7t31
	 Hcav2WHsNt3oZjMdbJyh28yaylB7MghYsPr1eE7VHpccijRADnPGW+r6oHmNWtkgC1
	 LtI4F6EvPSOncy7sFJ26Eq6pvP6pA4Qp2oPc7wTPCUgDWNRbJhJk4nD8IaiZiqp533
	 1YpuY9qmwJDVPlKfWY90skIkhhD6LF19Ejf5Ugo5jw6z2QQd9Rxgy0CyFKsRFmsE6H
	 HYo4XUy0VR7/w==
Message-ID: <49c300cc-e000-420d-82ad-aa59e5f1cd76@kernel.org>
Date: Thu, 13 Nov 2025 09:47:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 mptcp-net 1/3] mptcp: fix grafting corner case
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1762992570.git.pabeni@redhat.com>
 <4696be966622c9d340e8bfa4728b219b7cac1d1b.1762992570.git.pabeni@redhat.com>
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
Cc: mptcp@lists.linux.dev
In-Reply-To: <4696be966622c9d340e8bfa4728b219b7cac1d1b.1762992570.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 13/11/2025 01:10, Paolo Abeni wrote:
> If a passive MPTCP socket creates active subflows while still unaccepted,
> __mptcp_subflow_connect() will try to graft such subflows to the msk,
> but the msk struct socket is not yet initialized at that point:
> the subflows will misbehave.

What kind of errors were visible?

> Address the issue always trying to graft the subflow in
> mptcp_finish_join(), regardless of the subflow itself being active or
> passive. To avoid races with accept(), access the msk->sk_socket under
> the callback lock.

Thank you for addressing this issue!

> 

By chance, do you have a Fixes tag to add here? (if it is for -net)

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8965abb94b81..1b3c5fd01600 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -913,12 +913,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
>  	mptcp_subflow_joined(msk, ssk);
>  	spin_unlock_bh(&msk->fallback_lock);
>  
> -	/* attach to msk socket only after we are sure we will deal with it
> -	 * at close time
> -	 */
> -	if (sk->sk_socket && !ssk->sk_socket)
> -		mptcp_sock_graft(ssk, sk->sk_socket);
> -
>  	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
>  	mptcp_sockopt_sync_locked(msk, ssk);
>  	mptcp_stop_tout_timer(sk);
> @@ -3734,6 +3728,20 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent)
>  	write_unlock_bh(&sk->sk_callback_lock);
>  }
>  
> +static void mptcp_check_graft(struct sock *sk, struct sock *ssk)
> +{
> +	struct socket *sock;
> +
> +	if (ssk->sk_socket)
> +		return;
> +
> +	write_lock_bh(&sk->sk_callback_lock);
> +	sock = sk->sk_socket;
> +	write_lock_bh(&sk->sk_callback_lock);

The build job failed because here it should be the unlock version
(write_unlock_bh()).
(and probably an empty line just after).

If there is only that, I can fix that when applying the patches.

> +	if (sock)
> +		mptcp_sock_graft(ssk, sock);
> +}
> +
>  bool mptcp_finish_join(struct sock *ssk)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> @@ -3758,6 +3766,7 @@ bool mptcp_finish_join(struct sock *ssk)
>  		}
>  		mptcp_subflow_joined(msk, ssk);
>  		spin_unlock_bh(&msk->fallback_lock);
> +		mptcp_check_graft(parent, ssk);
>  		mptcp_propagate_sndbuf(parent, ssk);
>  		return true;
>  	}
> @@ -3767,6 +3776,8 @@ bool mptcp_finish_join(struct sock *ssk)
>  		goto err_prohibited;
>  	}
>  
> +	mptcp_check_graft(parent, ssk);

Is it OK to graft it even in case of errors in __mptcp_finish_join()?
i.e. not in an established state or !msk->allow_subflows.

Should it not be done after the block below, if there was no error?

> +
>  	/* If we can't acquire msk socket lock here, let the release callback
>  	 * handle it
>  	 */

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

