Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDE22AD25
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506703; cv=none; b=sWIzLDPxWplzUT9kGR1RiWsTMP2JiT3qWyeQI4pDmYWE/IHgBXzBR7c4JiUwvsu2gcE24bKKkVxqPDhD4aN0SGYvCSjNXQgq5hXfaA5cm3Towcz2bvQtkRrm+tTHwMxHj+R/+OIf8rRGhhKMTRnxN3DD3miPKzw3W+g77m6yKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506703; c=relaxed/simple;
	bh=bkovePIc6+8YQ0sx4OLcataH/ZkEES09xEkcJLDfX0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktGqDPtV5FL/LMQBnqId0gqad0vrdMwKEXzedL5+FOa61aPmfKJpHhDv7D/BoR2TOOgnVsz6fbcSSg2hMzcsBZXhBt/vUL+sP+2THN4DscrKGdUHERraCn2Ficr2oYCRhBCf7I2tL+sbIJnplroLbutEp6hclZgBCFU1admob+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5Zs0K7c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5Zs0K7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AEEC32786;
	Thu,  1 Aug 2024 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722506703;
	bh=bkovePIc6+8YQ0sx4OLcataH/ZkEES09xEkcJLDfX0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o5Zs0K7cxJHdXQbhABwDKfieQi1OAgOtlRn5q5CC+NYKNN5RycApKagAkHo629ye/
	 sTcQiLohe4GveqUP4tDZCB/A1aUb7k4qIyheL3wIn0LJa1d4EgKfcHd13mB6Lj4hRq
	 pDzHyAIBOSH42vDBKFVB5SQ2/Zf9zZ2iEb95NuextSbN+/RdcO5mIUCWXGoKw7/829
	 YFkraPgc1EC06hbP/tJ2rCLnmD+uHEvfXOGd5IpFXrCo4/a8MXCZCxFnV41koJxhf7
	 zhn8UIjcPYmvnlNOzlzgykEchWzPsgLWcbwNZYupHKNhE8s9Gi8hdWHPpE6lWvR71J
	 yHgwwXS9L5XGg==
Message-ID: <ebbfef1f-e21c-4fbf-b7e8-ff30f62e45c3@kernel.org>
Date: Thu, 1 Aug 2024 12:05:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 3/4] selftests: mptcp: enable io thread mode
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1722502941.git.tanggeliang@kylinos.cn>
 <fde5c2d7de9816aab48637225fc2c9a9df94bd20.1722502941.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fde5c2d7de9816aab48637225fc2c9a9df94bd20.1722502941.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 01/08/2024 11:21, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch adds a new parameter "listensock" for the client main_loop()
> to support io thread mode tests. In it, invoke accept() to get the peer
> socket and pass it to copyfd_io(), then to copyfd_io_thread().

Please add the reason why this is needed.

Also, it is not clear that this will cause the same app to send and
receives data. Is it really required to reproduce the bug? Can we not do
the usual client-server thing? e.g.

  ./mptcp_connect.sh -m thread

Or at least an explicit option.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../selftests/net/mptcp/mptcp_connect.c       | 25 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 477969ba9653..bd61cf203501 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1372,9 +1372,9 @@ void xdisconnect(int fd, int addrlen)
>  		xerror("can't disconnect: %d", errno);
>  }
>  
> -int main_loop(void)
> +int main_loop(int listensock)
>  {
> -	int fd = 0, ret, fd_in = 0;
> +	int fd = 0, ret, fd_in = 0, peerfd = 1;
>  	struct addrinfo *peer;
>  	struct wstate winfo;
>  
> @@ -1389,6 +1389,19 @@ int main_loop(void)
>  	if (fd < 0)
>  		return 2;
>  
> +	if (cfg_mode == CFG_MODE_THREAD &&
> +	    listensock >= 0) {

(detail: can it not go to the previous line?)

> +		peerfd = accept(listensock, NULL, NULL);
> +		while (peerfd == -1) {
> +			if (errno == EINTR)
> +				continue;

Mmh, do you not need to call 'accept()' again?

> +			return -errno;
> +		}
> +
> +		if (cfg_timeo)
> +			settimeo(peerfd, cfg_timeo);
> +	}
> +
>  again:
>  	check_getpeername_connect(fd);
>  
> @@ -1407,7 +1420,7 @@ int main_loop(void)
>  			xerror("can't open %s:%d", cfg_input, errno);
>  	}
>  
> -	ret = copyfd_io(fd_in, fd, 1, 0, &winfo);
> +	ret = copyfd_io(fd_in, fd, peerfd, 0, &winfo);
>  	if (ret)
>  		return ret;
>  
> @@ -1430,6 +1443,8 @@ int main_loop(void)
>  		close(fd);
>  	}
>  
> +	if (listensock >= 0)
> +		close(listensock);
>  	return 0;
>  }
>  
> @@ -1630,9 +1645,11 @@ int main(int argc, char *argv[])
>  			set_mark(fd, cfg_mark);
>  		if (cfg_cmsg_types.cmsg_enabled)
>  			apply_cmsg_types(fd, &cfg_cmsg_types);
> +		if (cfg_mode == CFG_MODE_THREAD)
> +			return main_loop(fd);
>  
>  		return main_loop_s(fd);
>  	}
>  
> -	return main_loop();
> +	return main_loop(-1);
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

