Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4572DECBA
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 05:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779860267; cv=none; b=E17qCBDS3Y99gWG7DUTA9YTkqE3uxB/I0jZEqbpJa16a4oz58Xlw2twwLfr9yMHIaPiaC9IIN9PslNJGF9fAU771P4L8sxlut2nxETIGodKYE2k4kL/rgavncO7B4aU3qvcDf6RqF7aew+8J158SHJCO+y4yZMlF/L3Q4AL0usM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779860267; c=relaxed/simple;
	bh=LizTBe6KU57WlHsCqvzL4a8ktEqk7CvxyYmMkSti8v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tK1rofUbNzV5f6MzeHAz7gYpxhdpQfng92ZAonE8mC9aYRIg3zRqvX9hVLHxVPYZB1+zEElat0qKOqAB1NWp9ikJQ8gg+S4U/qyAJoN04kzd2fF+VCLuPHkddFY+siytKQEs/r5zD4pocCvc0TLlq94Rm+MkSrZ5BQY2P65FgOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/ViSJUH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/ViSJUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EFB1F000E9;
	Wed, 27 May 2026 05:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779860266;
	bh=Ij3DNRVCCTxJmG7hb7pWj0Z8uol//qTLA3sfEw01MZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y/ViSJUHvISbUeih/RLa4rZqEk0foG+d2+fLfMmSuquRMV+QrPYuTsG75xpnxYiUt
	 7fXuBY1BoU55GMLcGKIYr1xtYZHJ2nsQdOhh/tz4L1DV7NGQmjqsuxWc5AOebPCdYj
	 fhvj5MgcZUax5FS3rdwLxW7chF65d/25RApV7mto4wVqIzYGP6LcxuK5g+cLP/KM0w
	 2clBcmEPCKi+8cy7PH758TF/e5OgzGbjvAUhA1PEx7EJpe3G9lR/1Xh1j1toS/gwq3
	 SounjOIl8jMQdLINtTj6Ze9ouDLX7E+jcz4PyFrh88gsghEKr6FsD4wQl6LTMCd5xk
	 cyZGk49AGBa0Q==
Message-ID: <2390d31c-096d-43d2-8300-dea2531ce6ac@kernel.org>
Date: Wed, 27 May 2026 15:37:41 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 2/4] mptcp: propagate RECVERR sockopts to
 subflows
Content-Language: fr
To: David Carlier <devnexen@gmail.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com
References: <20260509211651.104934-1-devnexen@gmail.com>
 <20260509211651.104934-3-devnexen@gmail.com>
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
In-Reply-To: <20260509211651.104934-3-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

On 10/05/2026 07:16, David Carlier wrote:
> Propagate IP_RECVERR/IP_RECVERR_RFC4884 and
> IPV6_RECVERR/IPV6_RECVERR_RFC4884 from the MPTCP socket to existing
> and future subflows.
> 
> mptcp_setsockopt_recverr() snapshots optval into a local int, applies
> it to the parent socket via ip_setsockopt() / ipv6_setsockopt(), bumps
> msk->setsockopt_seq, and forwards to every subflow via
> mptcp_setsockopt_all_sf(). Newly-joining subflows pick up the four
> RECVERR bits through sync_socket_options() now that
> MPTCP_INET_FLAGS_MASK covers them.
> 
> mptcp_setsockopt_all_sf() skips IPv4 subflows when called with
> SOL_IPV6 to avoid the -ENOPROTOOPT that ip_setsockopt() returns on
> level mismatch in AF_INET6 msks carrying IPv4 subflows.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Assisted-by: Codex:gpt-5
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  net/mptcp/sockopt.c | 133 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 109 insertions(+), 24 deletions(-)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 114436d2e401..fbbd1692af7e 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -8,6 +8,8 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <net/ip.h>
> +#include <net/ipv6.h>

Are these new "include" really needed?

>  #include <net/sock.h>
>  #include <net/protocol.h>
>  #include <net/tcp.h>
> @@ -19,7 +21,11 @@
>  #define MPTCP_INET_FLAGS_MASK \
>  	(BIT(INET_FLAGS_TRANSPARENT) | \
>  	 BIT(INET_FLAGS_FREEBIND) | \
> -	 BIT(INET_FLAGS_BIND_ADDRESS_NO_PORT))
> +	 BIT(INET_FLAGS_BIND_ADDRESS_NO_PORT) | \
> +	 BIT(INET_FLAGS_RECVERR) | \
> +	 BIT(INET_FLAGS_RECVERR_RFC4884) | \
> +	 BIT(INET_FLAGS_RECVERR6) | \
> +	 BIT(INET_FLAGS_RECVERR6_RFC4884))
>  
>  static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
>  {
> @@ -394,6 +400,81 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>  	return -EOPNOTSUPP;
>  }
>  
> +static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
> +				   int optname, sockptr_t optval,
> +				   unsigned int optlen)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	int ret = 0;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		if (level == SOL_IPV6 && ssk->sk_family != AF_INET6)
> +			continue;

This new check looks strange:

- Was it required before this patch? If yes, please create a dedicated
patch. If no, explain how it can happen in the commit message (+ here in
a short comment?).

- if the msk is in v6, all subflows are in v6 as well, no? Or did I miss
a case (easy to miss with v6-mapped-in-v4 sockets...)?

> +		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (!ret)
> +		sockopt_seq_inc(msk);
> +
> +	return ret;
> +}
> +
> +static int mptcp_setsockopt_recverr(struct mptcp_sock *msk, int level,
> +				    int optname, sockptr_t optval,
> +				    unsigned int optlen)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +	int val, ret;
> +
> +	/* Let ip_setsockopt() / ipv6_setsockopt() validate optval and optlen
> +	 * (so 1-byte boolean writes keep the same ABI as plain TCP) and update
> +	 * the parent's RECVERR bit. Re-read that bit under lock_sock() and
> +	 * push it to the subflows: concurrent setsockopt callers cannot leave
> +	 * parent and subflows desynchronized this way.
> +	 */
> +	if (level == SOL_IP)
> +		ret = ip_setsockopt(sk, level, optname, optval, optlen);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	else if (level == SOL_IPV6)
> +		ret = ipv6_setsockopt(sk, level, optname, optval, optlen);
> +#endif
> +	else
> +		return -EOPNOTSUPP;
> +	if (ret)
> +		return ret;
> +
> +	lock_sock(sk);
> +	switch (optname) {
> +	case IP_RECVERR:
> +		val = inet_test_bit(RECVERR, sk);
> +		break;
> +	case IP_RECVERR_RFC4884:
> +		val = inet_test_bit(RECVERR_RFC4884, sk);
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case IPV6_RECVERR:
> +		val = inet6_test_bit(RECVERR6, sk);
> +		break;
> +	case IPV6_RECVERR_RFC4884:
> +		val = inet6_test_bit(RECVERR6_RFC4884, sk);
> +		break;
> +#endif
> +	default:
> +		release_sock(sk);
> +		return -EOPNOTSUPP;

When lock are used, we usually try to have one exit path: could you set
'ret' and use a "goto" here?

Also, this "default" case should never be used, right? Do we need it? Or
use a WARN?

> +	}
> +
> +	ret = mptcp_setsockopt_all_sf(msk, level, optname,
> +				      KERNEL_SOCKPTR(&val), sizeof(val));
> +	release_sock(sk);
> +	return ret;
> +}
> +
>  static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
>  			       sockptr_t optval, unsigned int optlen)
>  {
> @@ -436,6 +517,10 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
>  
>  		release_sock(sk);
>  		break;
> +	case IPV6_RECVERR:
> +	case IPV6_RECVERR_RFC4884:
> +		ret = mptcp_setsockopt_recverr(msk, SOL_IPV6, optname, optval, optlen);
> +		break;
>  	}
>  
>  	return ret;
> @@ -781,6 +866,9 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
>  		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
>  	case IP_TOS:
>  		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
> +	case IP_RECVERR:
> +	case IP_RECVERR_RFC4884:
> +		return mptcp_setsockopt_recverr(msk, SOL_IP, optname, optval, optlen);
>  	}
>  
>  	return -EOPNOTSUPP;
> @@ -808,27 +896,6 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>  	return ret;
>  }
>  
> -static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
> -				   int optname, sockptr_t optval,
> -				   unsigned int optlen)
> -{
> -	struct mptcp_subflow_context *subflow;
> -	int ret = 0;
> -
> -	mptcp_for_each_subflow(msk, subflow) {
> -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> -
> -		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
> -		if (ret)
> -			break;
> -	}
> -
> -	if (!ret)
> -		sockopt_seq_inc(msk);
> -
> -	return ret;
> -}
> -
>  static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  				    sockptr_t optval, unsigned int optlen)
>  {
> @@ -932,8 +999,11 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
>  	if (level == SOL_IP)
>  		return mptcp_setsockopt_v4(msk, optname, optval, optlen);
>  
> -	if (level == SOL_IPV6)
> +	if (level == SOL_IPV6) {
> +		if (sk->sk_family != AF_INET6)
> +			return -ENOPROTOOPT;

Same here: Was it required before this patch? If yes, please create a
dedicated patch. If no, explain how it can happen in the commit message
(+ here in a short comment?).

>  		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
> +	}
>  
>  	if (level == SOL_TCP)
>  		return mptcp_setsockopt_sol_tcp(msk, optname, optval, optlen);
> @@ -1473,6 +1543,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
>  	case IP_LOCAL_PORT_RANGE:
>  		return mptcp_put_int_option(msk, optval, optlen,
>  				READ_ONCE(inet_sk(sk)->local_port_range));
> +	case IP_RECVERR:
> +		return mptcp_put_int_option(msk, optval, optlen,
> +				inet_test_bit(RECVERR, sk));
> +	case IP_RECVERR_RFC4884:
> +		return mptcp_put_int_option(msk, optval, optlen,
> +				inet_test_bit(RECVERR_RFC4884, sk));
>  	}
>  
>  	return -EOPNOTSUPP;
> @@ -1493,6 +1569,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
>  	case IPV6_FREEBIND:
>  		return mptcp_put_int_option(msk, optval, optlen,
>  					    inet_test_bit(FREEBIND, sk));
> +	case IPV6_RECVERR:
> +		return mptcp_put_int_option(msk, optval, optlen,
> +					    inet6_test_bit(RECVERR6, sk));
> +	case IPV6_RECVERR_RFC4884:
> +		return mptcp_put_int_option(msk, optval, optlen,
> +					    inet6_test_bit(RECVERR6_RFC4884, sk));
>  	}
>  
>  	return -EOPNOTSUPP;
> @@ -1537,8 +1619,11 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
>  
>  	if (level == SOL_IP)
>  		return mptcp_getsockopt_v4(msk, optname, optval, option);
> -	if (level == SOL_IPV6)
> +	if (level == SOL_IPV6) {
> +		if (sk->sk_family != AF_INET6)
> +			return -ENOPROTOOPT;

Same here.

>  		return mptcp_getsockopt_v6(msk, optname, optval, option);
> +	}
>  	if (level == SOL_TCP)
>  		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
>  	if (level == SOL_MPTCP)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

