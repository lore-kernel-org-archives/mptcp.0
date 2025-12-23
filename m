Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBFD299AAA
	for <mptcp@lists.linux.dev>; Tue, 23 Dec 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507917; cv=none; b=sWilCCUicdxfDsH0cwy4z2c7uMOCZNAEG9lNvq21h4l2KsU0n0ESBE1v3egzAhQ5CI+6ovV/isSY5lvPL0fwxVmRxpYC++17G1VY9E701Yiqx3ixZsyuPycK9S3V+Lhc2FSVMtfHAFCSTCRHzEYgv3x5kcYPf08L+ZuFCz1z50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507917; c=relaxed/simple;
	bh=4yUNe6vlEg/m6eP2tv6iaqs4Zv5rov7jH85PqkFlDT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOzXnd/Cudhe2GiB2s1pACStniM+iS+e7rz78ip/CgvoU2dUdn7+gbcDMXZJhpeO9vcNaTS/EE1wI1mLGnwhW2lsa8IzM8s/hFqzgdwSU7/4y1mZsHWLJPqpOUtfgubSWHMrUzSixaZA3lU+rYPoUbYT33295ZjeIIzQwkIBCnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTmZHo+F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTmZHo+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EECC113D0;
	Tue, 23 Dec 2025 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766507917;
	bh=4yUNe6vlEg/m6eP2tv6iaqs4Zv5rov7jH85PqkFlDT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YTmZHo+FIFebzmegPphWmA4+H8bFDzlPlpW/Wul0sZbCQU/VJ80nTbUO3F33sxJZa
	 fTAnaPcdNVi0MNnjiDYNdysdSL/Zi4bPFdr29KgReOu4Kg2hJVFae2jVf7kuFSvz3V
	 HY7t74YdLqAlvbun7b5uPI57cQm/86xBCVHj/FBz66TxuRNKibx07Z7OrwQgcZvo6q
	 fAd8G5qLQfFc8Ps1AK5oEVQ9eV4uDyrXxP//199dbE4NTlZ6ixFcu/vExyvuxDtLJP
	 JHIHi0keMs51iwqWO6I0Rb55is2zQM4ZbenJnOMf5bb8MLCWHVQEcxQHKY1vOBjutR
	 exCdK38eJtwmA==
Message-ID: <b69f4303-36b6-4ae9-98e3-89ec4740c9d4@kernel.org>
Date: Tue, 23 Dec 2025 17:38:34 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mptcp-next v5 5/8] selftests: mptcp: connect: update
 sock_test_tcpulp
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
References: <cover.1766372799.git.tanggeliang@kylinos.cn>
 <6679775753c0e285b1b218b085d77d2a6208f4e7.1766372799.git.tanggeliang@kylinos.cn>
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
In-Reply-To: <6679775753c0e285b1b218b085d77d2a6208f4e7.1766372799.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/12/2025 04:15, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Update sock_test_tcpulp() to ensure the mptcp_connect.c tests are not
> broken.
> 
> fallback() helper has been implemented to verify fallback scenarios,
> ensuring that MPTCP fallback-to-TCP tests continue to pass.
> 
> Co-developed-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../selftests/net/mptcp/mptcp_connect.c       | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index b82df82e0594..e5c394ea4e11 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -266,6 +266,18 @@ static void set_mptfo(int fd, int pf)
>  		perror("TCP_FASTOPEN");
>  }
>  
> +static int fallback(int fd)
> +{
> +	int is_mptcp = 0;
> +	socklen_t optlen;
> +
> +	optlen = sizeof(is_mptcp);
> +	if (getsockopt(fd, IPPROTO_TCP, TCP_IS_MPTCP, &is_mptcp, &optlen) == -1)

Would it be OK to check SO_PROTOCOL instead? TCP_IS_MPTCP is not
available on older kernel versions.

> +		perror("TCP_IS_MPTCP");
> +
> +	return !is_mptcp;
> +}
> +
>  static int do_ulp_so(int sock, const char *name)
>  {
>  	return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
> @@ -282,7 +294,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
>  		X("getsockopt");
>  
>  	if (buflen > 0) {
> -		if (strcmp(buf, "mptcp") != 0)
> +		if (strcmp(buf, fallback(sock) ? "mptcp" : "tls") != 0)
>  			xerror("unexpected ULP '%s' for proto %d at line %u", buf, proto, line);
>  		ret = do_ulp_so(sock, "tls");
>  		if (ret == 0)
> @@ -424,8 +436,6 @@ static int sock_connect_mptcp(const char * const remoteaddr,
>  	}
>  
>  	freeaddrinfo(addr);
> -	if (sock != -1)
> -		SOCK_TEST_TCPULP(sock, proto);

When looking at f730b65c9d85 ("selftests: mptcp: try to set mptcp ulp
mode in different sk states"), it looks like this test is useful to
avoid regressions. We should not remove them then.

With KTLS being implemented, I guess "tls" should no longer be used, but
we should continue to call SOCK_TEST_TCPULP(). Maybe another ULP name
can be set instead of "tls"?

>  	return sock;
>  }
>  
> @@ -1197,8 +1207,6 @@ int main_loop_s(int listensock)
>  				xerror("can't open %s: %d", cfg_input, errno);
>  		}
>  
> -		SOCK_TEST_TCPULP(remotesock, 0);
> -
>  		memset(&winfo, 0, sizeof(winfo));
>  		err = copyfd_io(fd, remotesock, 1, true, &winfo);
>  	} else {
> @@ -1371,8 +1379,6 @@ int main_loop(void)
>  again:
>  	check_getpeername_connect(fd);
>  
> -	SOCK_TEST_TCPULP(fd, cfg_sock_proto);
> -
>  	if (cfg_rcvbuf)
>  		set_rcvbuf(fd, cfg_rcvbuf);
>  	if (cfg_sndbuf)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

