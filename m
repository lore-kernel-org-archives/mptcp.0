Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79091DFFD
	for <mptcp@lists.linux.dev>; Sun, 28 Dec 2025 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766890746; cv=none; b=aK2dcvZAyE8vk35if45sh+1H3uYZzbMD3OTEzArI1SearIOjk3knNdDo0Rmkr6v6F4EEDxaRXUBBx6SUDWGZ2IMJ0tcld1N7lteVsRzfo0354HDZ813fK89QfftZTCllQZUlNAny/TkzDdzoFWzdYkGlg+uCrHhpU6c2jfQ+OwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766890746; c=relaxed/simple;
	bh=bfu94th0CjgASFm1d2uPtDJZpINAdIbfq9G5JrwETLc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=duEEDCkmeT5f68dv/795fcUEbYFscr/iZXj02jt6DV1E2i92yZTMMGQ5kWa2DFiWEH71LfqM2ZuIy1fpkmCrZWJ7cEkYXvkpYOMTLAWFV1yi7L6XZ44OfSt3USqAbUynvi1hRZHdLvNArjcSq6L/tc7EGlJj+3JiuQlpSckjMxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rae/9cw1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rae/9cw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0C1C4CEF1;
	Sun, 28 Dec 2025 02:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766890745;
	bh=bfu94th0CjgASFm1d2uPtDJZpINAdIbfq9G5JrwETLc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=rae/9cw1AEPmzSaP+hVqU0Na2PesFiQ7pszIsRHc5DD0X8TeyOefKYZcQapU9q22P
	 jzodmd07LPCBBzWY540gfEWfnTICKMKWXTzXbq9rjCPjayeX+vkePywzSJ6IvbPIC3
	 PxNuPGBBymxbGB1zUna3d/B79PN3G6R5r03SXPiarKUbyja0/l3SaBe9XtcoGR5Y5o
	 1vfYiWeX0wT0zeJsP8qhyQr6SFxhdfuatCYu7CkkMOq5kot+2d8gGGIEmdBnJudttG
	 on91mcT3JBqCr78hsBnPEcwhtDi5+MAYv16YI4RaCxUJdB/lE4+zJrU2lmq5bfFtTZ
	 vGEyQp9orcGfA==
Message-ID: <052b88ccb1d8a3ebb64b196a75db3a616023f606.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 11/11] selftests: mptcp: connect cleanup TFO
 setup
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Sun, 28 Dec 2025 10:59:02 +0800
In-Reply-To: <20251226-mptcp-issue-603-v1-11-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
	 <20251226-mptcp-issue-603-v1-11-bb30e331b839@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this patch.

On Fri, 2025-12-26 at 07:40 +0100, Matthieu Baerts (NGI0) wrote:
> To the TFO, only the file descriptor is needed, the family is not.
> 
> Also, the error can be handled the same way when 'sendto()' or
> 'connect()' are used. Only the printed error message is different.
> 
> This avoids a bit of confusions.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

LGTM!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 17 +++++++------
> ----
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 27a93a25b142..6d2eb5cf8539 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -258,7 +258,7 @@ static void set_transparent(int fd, int pf)
>  	}
>  }
>  
> -static void set_mptfo(int fd, int pf)
> +static void set_mptfo(int fd)
>  {
>  	int qlen = 25;
>  
> @@ -335,7 +335,7 @@ static int sock_listen_mptcp(const char * const
> listenaddr,
>  			set_transparent(sock, pf);
>  
>  		if (cfg_sockopt_types.mptfo)
> -			set_mptfo(sock, pf);
> +			set_mptfo(sock);
>  
>  		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
>  			break; /* success */
> @@ -406,21 +406,18 @@ static int sock_connect_mptcp(const char *
> const remoteaddr,
>  				*peer = a;
>  				break; /* success */
>  			}
> +			perror("sendto()");
>  		} else {
>  			if (connect(sock, a->ai_addr, a->ai_addrlen)
> == 0) {
>  				*peer = a;
>  				break; /* success */
>  			}
> -		}
> -		if (cfg_sockopt_types.mptfo) {
> -			perror("sendto()");
> -			close(sock);
> -			sock = -1;
> -		} else {
>  			perror("connect()");
> -			close(sock);
> -			sock = -1;
>  		}
> +
> +		/* error */
> +		close(sock);
> +		sock = -1;
>  	}
>  
>  	freeaddrinfo(addr);
