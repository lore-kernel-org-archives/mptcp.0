Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890FD277007
	for <mptcp@lists.linux.dev>; Tue, 22 Apr 2025 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320830; cv=none; b=b/oLsX+RasWuWlIHRbwgoZSna10z4XZYUc3Gen20UHJFun6czxQzz0bOe8ikodr6jtfuqazxwgr9UDWvDwDxg8Fo7vkHqcy77GOMU6h3Sq5sZX+5HbMa2+Q/540OlNqMevW1CxZa4sxj/fDnUU5cJ+KZLCXlRMalGcV02mRXSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320830; c=relaxed/simple;
	bh=tTx48a29sCs4pTWub8SadqaAnFcOE+kziZgZDI1mRJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUAj6KHFc3J38A5GwJpm1k3oC6DCBqPgjL2K5rZJXhcdFZVIb+dZ29Xc59xiEVkSE/aZKue+yD+RxOogoYGucUtM0jy+uR8xf5Ast14nyLO4q6gFdg18FijN3iHw7c4P2Irag/jOpLZNSR7Iq1O2olh05XzNK+L4phNQg/zSUHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUNNqJfO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUNNqJfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EF4C4CEE9;
	Tue, 22 Apr 2025 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745320830;
	bh=tTx48a29sCs4pTWub8SadqaAnFcOE+kziZgZDI1mRJo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qUNNqJfOR0RfRGI/b9jJhVeGECXsB2aZKX3wnfDtVWDw/cyFVqMaxdBG0M77E5eH2
	 k1pRFPlErM7px/1NxCLZGLSYspqHhgK2y+WUB7UKPXEXOYPTWpU4UDF6nxgYwvictl
	 wzFJ2QlQgjPVLdLxhCk+DwDlKsojf8B5sTpDuBfvFi7owwJzEl7FZEI52uOuXxhZgL
	 Wi+xoC85EfA34Q7BFjYTQmvsk6D+tgqGYjFFkrwSboLo8SvXfwED7ChSu3FB87kcj1
	 QnEv1vKUwRYeWA/98E5yOi5EmDO9zEaqM5tacgQ6GhnMU3xDYtuuP/PtmkFb3tAgAn
	 ERqKcRIqihqlA==
Message-ID: <1d68fc7d-06e7-493c-a207-658035c37af9@kernel.org>
Date: Tue, 22 Apr 2025 13:20:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1 2/2] selftests: mptcp: sockopt: add
 TCP_MAXSEG sockopt tests
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1745314165.git.tanggeliang@kylinos.cn>
 <98b1b574823f8447f8418b5567800ec01faba529.1745314165.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <98b1b574823f8447f8418b5567800ec01faba529.1745314165.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/04/2025 11:30, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds the TCP_MAXSEG sockopt tests in mptcp_sockopt.c. Since
> in getsockopt TCP_MAXSEG, the "user_mss" value can be obtained only in
> the LISTEN state (see do_tcp_getsockopt in net/ipv4/tcp.c), the test
> items are added to server() instead of client().

I think it is better to use packetdrill to do such validation, similar
to what was done with other socket options. No?

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../selftests/net/mptcp/mptcp_sockopt.c       | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index 926b0be87c99..e2043c0261bd 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -689,6 +689,26 @@ static int xaccept(int s)
>  	return fd;
>  }
>  
> +static void test_tcp_maxseg_sockopt(int fd)
> +{
> +	int maxseg = 1000;
> +	socklen_t s;
> +	int r;
> +
> +	s = sizeof(maxseg);
> +	r = setsockopt(fd, IPPROTO_TCP, TCP_MAXSEG, &maxseg, s);
> +	if (r != 0)
> +		die_perror("setsockopt TCP_MAXSEG");
> +
> +	maxseg = 0;
> +	r = getsockopt(fd, IPPROTO_TCP, TCP_MAXSEG, &maxseg, &s);
> +	if (r != -1 && errno != EINVAL)
> +		die_perror("getsockopt TCP_MAXSEG did not indicate -EINVAL");
> +
> +	if (maxseg != 1000)
> +		xerror("maxseg=%d", maxseg);
> +}

Here, you set and get the value, but you don't really check the
behaviour is the one we expect.

It is important to check the behaviour. It would be easier to do that
with packetdrill I think.

> +
>  static int server(int pipefd)
>  {
>  	int fd = -1, r;
> @@ -713,6 +733,8 @@ static int server(int pipefd)
>  
>  	process_one_client(r, pipefd);
>  
> +	test_tcp_maxseg_sockopt(fd);
> +
>  	return 0;
>  }
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

