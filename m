Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD01149C7B
	for <mptcp@lists.linux.dev>; Fri,  1 Aug 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060974; cv=none; b=ZhHVs56GIbzlfyR5iJmpBLrpoVYTFRoCFPBPuQeqJUMKGT0GKeLvuJevBGR9PXr1Lrf53vHVIaZup9QzuN9EnAXcYLFyy9N5zMsD+HTv/Paw2mEeNoJYozvGcvQY4IWj5XdJ5kve++s2zw2DSS1ExZBNcRrw9Njdw7i90iJcn6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060974; c=relaxed/simple;
	bh=ZLNF8f/Grtk1YXub9diUO19DCW+j8DQyPw/33G8rfM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aix465bOtCpMCdoF1Lm8lfufCUfFM63pcNP3CN3sI/u44nJjbku1xRbVmiNYxd8yRUZUYD0j+Gz9IrrspLe8x/azjdkMjw7x4l3AWuZfPbUtPIFmKRdsZ7wD6wi9iwvy+FfFUk4hCxK+eMxeFFGsg8EwoM28PBy4L6Kkp+TwYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osReMqSw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osReMqSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8E6C4CEE7;
	Fri,  1 Aug 2025 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754060974;
	bh=ZLNF8f/Grtk1YXub9diUO19DCW+j8DQyPw/33G8rfM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=osReMqSwOKD1rxuOhtZTaHe/DhS0O/KfsE6GmGGAW09FBk9z2h0lfAfL9abPqkqZs
	 z1JFjFwhFE2qEDY9RgenKm2QM45NomXm/hXg8jXO7N3MaeiV2roMgvGQMUUcE3tEj8
	 41qOM+iVSt8dJCbZVJ8FFt/8QPTIb6wgasNYwznfYlSzdhR7tfZoiF+ZEJf/i6l66t
	 ojGV/oWDz3IyMCMYXiZeHtudPoXFF7EyDGD9wSmond4dQVbB6D7rfrlkuPAVUcp9OH
	 BMgsFPWR5QgQ7o1A19Ika/2ixQY+Z59JSUNS5t56EBKo3WgePFplvpn1NWmXld7PDe
	 jdsFuz9KDQu8w==
Message-ID: <90483931-6902-495a-9ea2-51d0a72ac004@kernel.org>
Date: Fri, 1 Aug 2025 17:09:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] Squash-to "mptcp: setsockopt support for
 TCP_MD5SIG"
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <684f802c11ee237dd54b4922edeb5d31a2d364b8.1754028954.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <684f802c11ee237dd54b4922edeb5d31a2d364b8.1754028954.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 01/08/2025 08:16, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Based-on: <cover.1753946671.git.tanggeliang@kylinos.cn>
> 
> Please update the commit log:
> '''
> Supporting TCP_MD5 socket option is required when MPTCP is used by
> default when creating a socket, to keep the same behaviour as with
> TCP. TCP_MD5 is not compatible with MPTCP, and it will cause a
> fallback to TCP at the connection request, if MPTCP was requested.
> This then fixes a "regression" compared to TCP.
> 
> This adds setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT options.
> The implementation:
> - Allows setting these options (getsockopt remains unsupported)
> - Applies them only to the first subflow
> - Forces fallback to TCP (since MD5 isn't compatible with MPTCP)
> 
> Setting these options triggers fallback to TCP to maintain MD5
> compatibility.
> 
> Note that TCP_MD5SIG and TCP_MD5SIG_EXT getsockopts are unsupported for
> TCP too.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575
> Fixes: d9e4c1291810 ("mptcp: only admit explicitly supported sockopt")
> '''
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/sockopt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 3ffdeca694be..55925ffc9051 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -835,7 +835,9 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  #ifdef CONFIG_TCP_MD5SIG
>  	case TCP_MD5SIG:
>  	case TCP_MD5SIG_EXT:
> -		__mptcp_try_fallback(msk, MPTCP_MIB_MD5SIGFALLBACK);
> +		if (!((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
> +		    !__mptcp_try_fallback(msk, MPTCP_MIB_MD5SIGFALLBACK))
> +			return 0;

Should we not call __mptcp_try_fallback() only if
mptcp_setsockopt_first_sf_only() was successful?

Do not forget the Packetdrill test. Probably better to have this test
before applying these patches.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

