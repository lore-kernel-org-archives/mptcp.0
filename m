Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9F61E515
	for <mptcp@lists.linux.dev>; Tue, 29 Apr 2025 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745925445; cv=none; b=KknRYdgwxlxOutbYpKsClBBzg9D2SPQ4bOMIqlBdsm8ktyZcVbXTFD3ccmu1oYZND1NXwMzFmmLGvJZK3YOfx/zSWK1GLKhEBCMYRtUDkqDQFxB6YxgYvnsxqUXmHlYgcldkQw2GAVdi/EwgLxh1wqdrpAbo1Km+R/Nkq1qdtlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745925445; c=relaxed/simple;
	bh=oaUpCyQX5XLDZBYxX0hoQSAzBfEwYh3JtkC0ewPqaoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RU5dlYO/mbqtaOHHsO/MMOkO8Hz1l16nDoMNgVSxbDfZ9AWKVXlOdjxq3eLp+qbqjpNhJTC1l4bKBedbatvhNkQqBWHEHyB1qckB2ltx6fzI5v9bD1yLk+YuuDm98s89b5chAKO/lsntfY0xIe2GmrJJet+OeAnlu15ZblN12y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx/q19Ho; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx/q19Ho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7133BC4CEE3;
	Tue, 29 Apr 2025 11:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745925445;
	bh=oaUpCyQX5XLDZBYxX0hoQSAzBfEwYh3JtkC0ewPqaoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cx/q19Ho8N1NYdBdmWztWLbjxKiLqHDCOxclwjblP7Sn3TPQsipaa14uvExeEKtuA
	 u8B/ZjM8QIcECve+u+DGPE/kqta0R1npOUh+pc075s9yhfP1mrkNqvfRbWCQJ8yZQy
	 6IuOBByZG7vWi3zitvDDlfL+6GdDT/9K66ciW3axcy2IqU3OTmOrVPoPedoOstmoKC
	 j9o03wc7rA4IvY02NO4w23qdNrVyZ5iO8bv+TghQCc/OMPNhBo41vMMh0DAFqHlnDB
	 qLOA4Qqq+lVIQ55vBFsB0Wlg2jEHtIcuWO+p+nVl7SgqVrSYAYfTSExpRJOh5TnS2Y
	 HT8OMPqwG7+Mg==
Message-ID: <e2c67415-d1e4-4ec5-8e8a-3d2d3daf2250@kernel.org>
Date: Tue, 29 Apr 2025 13:17:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 1/3] tcp: add tcp_sock_set_maxseg
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1745401025.git.tanggeliang@kylinos.cn>
 <e23dcab208b4fd8208c9d3f43e69dbc091455917.1745401025.git.tanggeliang@kylinos.cn>
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
In-Reply-To: <e23dcab208b4fd8208c9d3f43e69dbc091455917.1745401025.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/04/2025 11:40, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Add a helper tcp_sock_set_maxseg() to directly set the TCP_MAXSEG sockopt
> from kernel space.

Probably clearer to add:

  This new helper will be used in the following patch.

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/linux/tcp.h |  1 +
>  net/ipv4/tcp.c      | 24 +++++++++++++++---------
>  2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 1669d95bb0f9..0041bc0aaee9 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -623,6 +623,7 @@ void tcp_sock_set_nodelay(struct sock *sk);
>  void tcp_sock_set_quickack(struct sock *sk, int val);
>  int tcp_sock_set_syncnt(struct sock *sk, int val);
>  int tcp_sock_set_user_timeout(struct sock *sk, int val);
> +int tcp_sock_set_maxseg(struct sock *sk, int val);
>  
>  static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
>  {
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 4516f93f6cd2..402f4a9b3fd1 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3725,6 +3725,20 @@ int tcp_set_window_clamp(struct sock *sk, int val)
>  	return 0;
>  }
>  
> +int tcp_sock_set_maxseg(struct sock *sk, int val)
> +{
> +	/* Values greater than interface MTU won't take effect. However
> +	 * at the point when this call is done we typically don't yet
> +	 * know which interface is going to be used
> +	 */
> +	if (val && (val < TCP_MIN_MSS || val > MAX_TCP_WINDOW))
> +		return -EINVAL;
> +
> +	tcp_sk(sk)->rx_opt.user_mss = val;
> +	return 0;
> +}
> +EXPORT_SYMBOL(tcp_sock_set_maxseg);

This export is not needed: it is only needed when used from a module.

The rest looks OK to me:

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

> +
>  /*
>   *	Socket option code for TCP.
>   */
> @@ -3857,15 +3871,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
>  
>  	switch (optname) {
>  	case TCP_MAXSEG:
> -		/* Values greater than interface MTU won't take effect. However
> -		 * at the point when this call is done we typically don't yet
> -		 * know which interface is going to be used
> -		 */
> -		if (val && (val < TCP_MIN_MSS || val > MAX_TCP_WINDOW)) {
> -			err = -EINVAL;
> -			break;
> -		}
> -		tp->rx_opt.user_mss = val;
> +		tcp_sock_set_maxseg(sk, val);
>  		break;
>  
>  	case TCP_NODELAY:

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

