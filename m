Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505924B238
	for <mptcp@lists.linux.dev>; Sat, 11 Jan 2025 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736595686; cv=none; b=gX8imKlWpBd6n5k1Htcffyb8Owq1Qa0o8MYpef85IDBXbxXvgPCYzgc5rm4nGSR/k/UOZ1Y+OTe0DgkWjqBftN1DKqNhwM6ZqRVae63uUQxmijx6JGknm49acBut7GYcuPFpFY+UEqeOPYCvx4NsY+sJZHN6gXil8yuatSWNcrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736595686; c=relaxed/simple;
	bh=C3CLhAQm4FWKVehiI/8075JVye8famCNSvGKlhiEZ7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BmssAkhaAh4VUDxH6NuO1MJKWOU7Q8ZWjeTEaOjFTmaryclfgLRIDh2/ymfT+evxgbsa7jpHZl14b8pCFvjYkHP49Nzxj7q1uR23RhR6XjAepPh0X1tAXnm0eHuZkfW6L1ov05pQdbU7VpboFjn/BXctuE/612MbuSZ5sqgm7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ+BWC3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ+BWC3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7CAC4CED2;
	Sat, 11 Jan 2025 11:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736595685;
	bh=C3CLhAQm4FWKVehiI/8075JVye8famCNSvGKlhiEZ7A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lQ+BWC3QZb0tfML2QDb7h/o15ql5DDShGA/6IbGAhCmQyHRsSpcZiNwyXB5dSjQua
	 /p9ArOZR7xWlG3JcL/tSq5SAik+V0fQadIiu2jphBLZvNTcD+c/JoW4sGndfKgpMAo
	 r7lR/XKeheVYrrPRLiUmpyzSg1kaZt9Wjo1fOxb7w/oMVo6vGrRF46D0Za0u+2y1ij
	 O5a6CEHwx00A3ruuYCZwKwKBD+1dJLKnA4e1Rca5BPzBskOhR/NPI8RKha48oettog
	 mMqj8F3Slao9f8yKl0RCiCDGvyeKszhSrktxY5/+OnLKdOJk9Jn0yX0uFh86qM9cRl
	 8aECr8hAigqhw==
Message-ID: <1a55fc38-7e9a-455b-803a-7760405c2d0e@kernel.org>
Date: Sat, 11 Jan 2025 12:41:23 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 3/3] selftests: mptcp: avoid spurious errors on
 disconnect
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1736527092.git.pabeni@redhat.com>
 <be1fa3944536edc745e897234a38ace68e912e55.1736527092.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <be1fa3944536edc745e897234a38ace68e912e55.1736527092.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 10/01/2025 17:43, Paolo Abeni wrote:
> The disconnect test-case generates spurious errors:
> 
> NFO: disconnect
> INFO: extra options: -I 3 -i /tmp/tmp.r43niviyoI
> 01 ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP     Unexpected revents: POLLERR/POLLNVAL(19)
> (duration   140ms) [FAIL] file received by server does not match (in, out):
> -rw-r--r-- 1 root root 10028676 Jan 10 10:47 /tmp/tmp.r43niviyoI.disconnect
> Trailing bytes are:
> ��\����R���!8��u2��5N%w------- 1 root root 9992290 Jan 10 10:47 /tmp/tmp.Os4UbnWbI1
> Trailing bytes are:
> ��\����R���!8��u2��5N%2 ns1 MPTCP -> ns1 (dead:beef:1::1:10001) MPTCP     (duration   206ms) [ OK ]
> 03 ns1 MPTCP -> ns1 (dead:beef:1::1:10002) TCP       (duration    31ms) [ OK ]
> 04 ns1 TCP   -> ns1 (dead:beef:1::1:10003) MPTCP     (duration    26ms) [ OK ]
> [FAIL] Tests of the full disconnection have failed
> Time: 2 seconds
> 
> The root cause is actually in the user-space bits: the test program
> currently disconnects as soon as all the pending data has been spooled,
> generating an FASTCLOSE. If such option reaches the peer before that
> the latter has reached the closed status, the msk socket will report an
> error to the user-space, as per protocol specification, causing the above
> failure.

Good catch!

> Address the issue explicitly waiting for all the relevant sockets to reach
> a closed status before performing the disconnect.
> 
> Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  .../selftests/net/mptcp/mptcp_connect.c       | 44 ++++++++++++++-----
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 4209b9569039..5cfea1760431 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -25,6 +25,8 @@
>  #include <sys/types.h>
>  #include <sys/mman.h>
>  
> +#include <arpa/inet.h>
> +
>  #include <netdb.h>
>  #include <netinet/in.h>
>  
> @@ -1211,23 +1213,43 @@ static void parse_setsock_options(const char *name)
>  	exit(1);
>  }
>  
> -void xdisconnect(int fd, int addrlen)
> +void xdisconnect(int fd)
>  {
> -	struct sockaddr_storage empty;
> +	socklen_t addrlen = sizeof(struct sockaddr_storage);
> +	struct sockaddr_storage addr, empty;
>  	int msec_sleep = 10;
> -	int queued = 1;
> -	int i;
> +	void *raw_addr;
> +	int i, cmdlen;
> +	char cmd[128];
> +
> +	/* get the local address and convert it to string */
> +	if (getsockname(fd, (struct sockaddr *)&addr, &addrlen) < 0)
> +		xerror("getsockname");
> +
> +	if (addr.ss_family == AF_INET)
> +		raw_addr= &(((struct sockaddr_in *)&addr)->sin_addr);
> +	else if (addr.ss_family == AF_INET6)
> +		raw_addr = &(((struct sockaddr_in6 *)&addr)->sin6_addr);
> +	else
> +		xerror("bad family");
> +
> +	strcpy(cmd, "ss -M | grep ");
> +	cmdlen = strlen(cmd);
> +	if (!inet_ntop(addr.ss_family , raw_addr, &cmd[cmdlen],
> +		       sizeof(cmd) - cmdlen))
> +		xerror("inet_ntop");
> +	strcat(cmd, " >/dev/null");

Detail: we can use 'grep -q', so no need to add ">/dev/null".

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

