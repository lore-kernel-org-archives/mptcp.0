Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8443266B46
	for <mptcp@lists.linux.dev>; Thu, 26 Mar 2026 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549746; cv=none; b=Zj/+QoC3PrHo3wQzgB7GdD9EIs5pUKLuWIZIF+G/NLQtJ0s3wrC3hHn1ALAHmmPYY5B0NhkFfwJK2XWWJKaTWN3/a7K2Sl9M8KodFvbOM61I8EGT/9cqGZahSBnd6190/DraU/81/ys2r04Z77/QeXXHuAPLaBsC5mahanDcWag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549746; c=relaxed/simple;
	bh=J9Dl7B6KrT4n7yMEu/xwO+o2Pa7/xBn/1VLU3g3Y6HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYnB3cPXW0SVH16eeWZ4JcMOFvb3rxQudwXxR5wGSo3IFrUAedaUN02co1Ks67nrB+XnR814F/QveAf3tXRDCaZ7NTYUjCfvtaWRZvwaWXCp7tuwm/IvWxYs4uCfK9b2HsEjzUmjSc6SSDOcc/q4M6ATXaDDorQ4DBKxW9ZDFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc3iKFGi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc3iKFGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A53FC116C6;
	Thu, 26 Mar 2026 18:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774549746;
	bh=J9Dl7B6KrT4n7yMEu/xwO+o2Pa7/xBn/1VLU3g3Y6HM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zc3iKFGiQpyWaJdj8YZJ5tosmqrxx6O1LNz4V8OWVWm54ZLiybXdgr4hM5Qt6TAZ2
	 VQ4mthXqXByT8I7zPpEOQsOzV0aSfi5X58fC96tB+uoAB2tCPdpJtIBLkQ9CozbmcS
	 qYY4EHArmcfAThroesX/g18k+yGDliD/vMuFOZYHbOBW0MlYSKwVCDPO7xbKPLOBG+
	 53z/ck6voQTw4VLFMUvz2Zp0qd/OwM2FEjfUTci2XDymCAvi5l0gzTlhv2yy4PTs+N
	 vPp4hxSzDg5QvsopdIyrqfscyLq4cxgETSeZ22YUlpv15jtD3PguScF/4IIk53DiR2
	 lX1XCe0x3SEPw==
Message-ID: <d72915b0-a473-47c4-96c0-d7a0075619b5@kernel.org>
Date: Thu, 26 Mar 2026 19:29:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RESEND mptcp-next v2 2/2] tcp: add recv_should_stop helper
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <martineau@kernel.org>
References: <cover.1773740635.git.tanggeliang@kylinos.cn>
 <2c01b49782e2f648813389caa6138a1b1540f64b.1773740635.git.tanggeliang@kylinos.cn>
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
In-Reply-To: <2c01b49782e2f648813389caa6138a1b1540f64b.1773740635.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 17/03/2026 10:44, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Factor out a new helper tcp_recv_should_stop() from tcp_recvmsg_locked()
> and tcp_splice_read() to check whether to stop receiving. And use this
> helper in mptcp_recvmsg() and mptcp_splice_read() to reduce redundant code.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Acked-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/tcp.h    |  9 +++++++++
>  net/ipv4/tcp.c       | 10 ++--------
>  net/mptcp/protocol.c | 10 ++--------
>  3 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index f87bdacb5a69..229613b56f73 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -3069,4 +3069,13 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
>  		const void *saddr, const void *daddr,
>  		int family, int dif, int sdif);
>  
> +static inline int tcp_recv_should_stop(struct sock *sk, long timeo)
> +{
> +	return sk->sk_err ||
> +	       sk->sk_state == TCP_CLOSE ||
> +	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
> +	       signal_pending(current) ||
> +	       !timeo;
> +}
> +
>  #endif	/* _TCP_H */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index dfd677c689ef..b0df7c4a0e20 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -895,9 +895,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
>  		release_sock(sk);
>  		lock_sock(sk);
>  
> -		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
> -		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
> -		    signal_pending(current))
> +		if (tcp_recv_should_stop(sk, timeo))

Here, you are changing the behaviour, that's then not a simple
refactoring like what you are describing in the commit message. Same in
mptcp_splice_read(). If checking 'timeo' here is better for some reason,
please add these two checks in a dedicated commit clearly explaining
this reason.

The alternative is not to include 'timeo' in the new helper, so here you
would have:

  if (tcp_recv_should_stop(sk))

and in tcp_recvmsg_locked():

  if (!timeo || tcp_recv_should_stop(sk))

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

