Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15A35949
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736903609; cv=none; b=VWg+xmdcZLHIh9/yaWzAbpK3oTmXoM6sl+cpedyJq3RSq/niLT5mH85TP03thXqv6T+9NA7eoQGCCrqhGHl+O94tC1qOPfnxIsQOpYoAf73WT0nwqogzkpWXWPcR4DmDPgYkl/1mVpXIBLK1mQnooYcadYTwhqeJmOOunAjPm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736903609; c=relaxed/simple;
	bh=q4qk4JxmLF8HBsSYb2U/H5vkiZA24WNqmIXmq6QqKq4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OxMUeNiN5g26ezITYzEaoal3j6au5lncKj/gHAMNf1v+TWp2vdtbUIuiPcRzRx4Jk1abwkEdUujlJc+z7+GknIk9/CkJJjvr84lEnslM4xuuB1ccpyqkRFG1RnuxwE0mgrbuniT3eD+GRaFnBuoDjzLA5rHpWbF4YaOGfW9+ULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBCDFOwd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBCDFOwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3F4C4CEE9;
	Wed, 15 Jan 2025 01:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736903608;
	bh=q4qk4JxmLF8HBsSYb2U/H5vkiZA24WNqmIXmq6QqKq4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tBCDFOwd0CMDq+Jurv/ItagSrpE8c7Dym8mlxhICAe5KgGZtcmlRMgdHaX1hcI8gY
	 xYUVedumLG981lpT1YNXQsKo7HXO5NSgBltHCScmJ2G+rza6IJ6SRd1yLYVLWnEie6
	 YBpOUYHnhDFXI0EbDi/PkXIrGeVcdbpxset6X+NM80cTapkKvOKT/Rvdt1sZfALuXM
	 WsmdJ9ZoLJOmxd5o6QRun9rzImTqZM0vtEGlL2/m+WmSrShcKS/5Hwxkl8rNQNER3L
	 mx4XOpxoG8+Zgpzl/bj3MRNTK3Lp+0eJV0mEDqpYOxwBvxqKKLf6X9ptZIQolx/2XI
	 ROQL5dWnSrbjw==
Message-ID: <40ddb2e67cbbd7178c5ad3766b8b51bfa7ab0e03.camel@kernel.org>
Subject: Re: [PATCH 3/3] selftests: mptcp: Clean up resources properly in
 main_loop
From: Geliang Tang <geliang@kernel.org>
To: Cong Liu <liucong2@kylinos.cn>
Cc: mptcp@lists.linux.dev
Date: Wed, 15 Jan 2025 09:13:23 +0800
In-Reply-To: <20250113085228.121778-4-liucong2@kylinos.cn>
References: <20250113085228.121778-1-liucong2@kylinos.cn>
	 <20250113085228.121778-4-liucong2@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cc mptcp only.

On Mon, 2025-01-13 at 16:52 +0800, Cong Liu wrote:
> Add proper cleanup of resources (file descriptors and address info)
> in error paths to prevent resource leaks.
> 
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 4d4ea4627daa..e82fde0411b2 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1271,8 +1271,13 @@ int main_loop(void)
>  	}
>  
>  	ret = copyfd_io(fd_in, fd, 1, 0, &winfo);
> -	if (ret)
> +	if (ret) {
> +		close(fd);
> +		if (cfg_input)
> +			close(fd_in);

Should 'listensock' be closed here?

> +		freeaddrinfo(peer);
>  		return ret;
> +	}
>  
>  	if (cfg_truncate > 0) {
>  		xdisconnect(fd, peer->ai_addrlen);
> @@ -1291,6 +1296,7 @@ int main_loop(void)
>  		goto again;
>  	} else {
>  		close(fd);

Should 'fd_in' be closed here? If so, is it possible to use a 'goto
out;' to reduce duplication of code?

Thanks,
-Geliang

> +		freeaddrinfo(peer);
>  	}
>  
>  	return 0;

