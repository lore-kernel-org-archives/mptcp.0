Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459577;
	b=PEc3U+CJpj0elpvrLL4YV+1ZZ+52uXc43QaSAzjTRxwJe7ID+RDvNLb3TmtnvhnXIjK8
	 bNKR3k3uAM11SXzT/IxYDMnVt23X3ENtUdy5Iyqn8uL2iRsz/7D2nyuM33EUh/c/w/yqk
	 hasJ71orQ+fsj1j4tR/pHC+J8iDk78EAz4DDSJv14/8fEtv6Auel3+MzydsdD5gt/5lmD
	 U0PU0Ym77xHiBuFe3cGilpW9MPJZYjMZ3BFddaDvq+5QLBjZXgvVapmLlq0svmpiKdJSH
	 UyNUX8kiEtTAOvbYfuwj89GdCg6EmVI2uuVvGlz0/jadtMwZ+bdIGetmgb/OnUfqDiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459577;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R8T6/lRGFFAchc8P7lE50tYeAbtsKxMgk5HMrsCkV3Y=;
	b=MzmuEqyAV8vEAWX6TmqcKw/ljhcxuauagLDlTQO0JzqV7gwhvBZaeejRu0H0xYwwyUqJ
	 lCZcBZSDXVXigI+hwKHtec0vKPVw0cxmX/sT9YptkxwKpbY4pKNIv0asxf1CAoh92bi4o
	 A92B+CaVBAZalM0tHG6sd3/+yeuLzql5mEJ3ECb9O9x1KDYdURlwI4VMMZy+lUYRoHcIt
	 zsaCKGorp3QWwEMbkgxW1yvMb3DoqXz8xHlDPY/fm32DIpRxXXgLziAGfEgZc/xif3ZXS
	 BNDHrcusLoxnmkP+uVa+B5ZyX0pz6/E9JmnmtvJd22zZjaV7TM1XrZUbtX34N1w4l/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UH5B7KHv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB8606A323
	for <mptcp@lists.linux.dev>; Thu, 12 Nov 2026 04:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UH5B7KHv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA201F00A05;
	Thu, 12 Nov 2026 04:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794459577;
	bh=R8T6/lRGFFAchc8P7lE50tYeAbtsKxMgk5HMrsCkV3Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UH5B7KHv7CtBbtNQ65k6EqsgVpxcGfR5qMQbMghtjiul7+6CGz//Wwe0Nx8B5AzA/
	 E6HvYDJTUJ5tnyKjCqcH6EyIM85VgVBlDRj/LnC2I+VfF6ybYyz/29RCziAGbS9uAW
	 4L+7TA+BBLFr/teXGxB6ENroemB55rcVYd7biU7m3E1deb9/zrvVAOdgW2bf6IlXrD
	 6eTSLeesOVDTCs427OlQPOyjz+4eeWr6pd6Z5GtI78lZnSmeLGjJFoHIgh8OAeuUvc
	 EOV0RfXrxpYscXZO9qWqbKMaQYJMWMo5+ducyJA6GQiFMzItMk/rrYkVZ69esu37Jx
	 m4MHCRHdUGwPQ==
Subject: Re: [PATCH mptcp-next v25 2/8] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 12 Nov 2026 04:59:36 +0000
Message-ID: <179445957634.488855.13661562039649445742@kernel.org>
In-Reply-To: <58a7c022d24c1fcbcba1dcafc62182ada49f5f35.1794304840.git.tanggeliang@kylinos.cn>
References: <58a7c022d24c1fcbcba1dcafc62182ada49f5f35.1794304840.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In tools/testing/selftests/net/mptcp/mptcp_connect.c,
  wait_for_remote_key() returns -1 for three different failures: (1)…

--

selftests: mptcp: connect: check TFO SIOCINQ overflow

This adds a SIOCINQ check to mptcp_connect's server mode when the MPTFO
socket option is enabled. After a TFO connection is accepted, the test
uses poll() and getsockopt(MPTCP_INFO) to wait for
MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED. It then fails if SIOCINQ returns
INT_MAX.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..5b002dad25d7a 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

[ ... ]

> @@ -1176,6 +1180,41 @@ static void maybe_close(int fd)
>  		close(fd);
>  }
>  
> +static int wait_for_remote_key(int fd)
> +{

[ ... ]

> +	while (elapsed < poll_timeout || poll_timeout < 0) {
> +		ret = poll(&pfd, 1, timeout_ms);
> +		if (ret < 0)
> +			return -1;
> +
> +		if (pfd.revents & (POLLHUP | POLLERR))
> +			return -1;
> +
> +		olen = sizeof(info);
> +		if (getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &olen) < 0) {
> +			/* Not an MPTCP socket (TCP or fallback), skip wait */
> +			if (errno == ENOPROTOOPT || errno == EOPNOTSUPP)
> +				return 0;
> +			return -1;
> +		}

[ ... ]

> @@ -1207,6 +1246,27 @@ int main_loop_s(int listensock)
>  		check_sockaddr(pf, &ss, salen);
>  		check_getpeername(remotesock, &ss, salen);
>  
> +		if (cfg_sockopt_types.mptfo) {
> +			int ret = wait_for_remote_key(remotesock);
> +			int avail;
> +
> +			if (ret < 0) {
> +				perror("TFO: getsockopt(MPTCP_INFO)");

[Severity: Low]
Is this diagnostic accurate for every -1 that wait_for_remote_key()
returns?

wait_for_remote_key() returns -1 in three cases:

  - poll() fails, for example with EINTR from the SIGUSR1 handler
  - poll() succeeds but pfd.revents has POLLHUP or POLLERR set
  - getsockopt(SOL_MPTCP, MPTCP_INFO) fails with some other errno

In the POLLHUP/POLLERR case, poll() succeeded and getsockopt() was never
called. That means errno is left over from an earlier call, and perror()
would print a getsockopt(MPTCP_INFO) failure with unrelated strerror text.

mptcp_poll() sets EPOLLHUP when the socket is fully shut down or in
TCP_CLOSE, and EPOLLERR when sk_err is set. Those are the "connection is
reset or the client exits early" cases the commit message says this
poll()-based wait is meant to catch.

The test still fails correctly, but the log would point at the wrong cause.
Could the hangup/error path print its own message, or return a distinct
value that main_loop_s() reports separately? A poll() failure would also
get the "getsockopt" label, although its errno is correct.

> +				close(remotesock);
> +				return 1;
> +			}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794304840.git.tanggeliang%40kylinos.cn
