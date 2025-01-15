Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E9CA64
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736903194; cv=none; b=hl97kAyjYwrqDEXvcvqCjDRDNaovkie71EBs1Z86vRHedzrLyiru7wsgZAz1fZ+s7qYDxttUXf7OP/VsgCa6ahuVDgP6CBHTaEv7hveP93R/fKkFj4yehK+lyM8TNjz5Ru3IY1FLfxssErP4u4LLG/fywh9Ir0qPElk1cVUn+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736903194; c=relaxed/simple;
	bh=A3vbDqaxIUVLZem9iF8l8Ny3BrhZexeu+5TKVCFQ+GU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l+pwRb+vC0Ucf74qg8bs6y+39xl/KQCQr8g2nN3yf0MFJimyjkbFRP46JCGs1UtSKTQ1STxmZeK/302KwlG8ArnENVD8t6BKzHDNaR+EKoEV4xgPs4G8PtOPX/FoaeQYxoYaBgvxmU+HcJNOQhaRjyipKoWqtSMr6BCurkbM9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgcGxHKK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgcGxHKK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A638C4CEDD;
	Wed, 15 Jan 2025 01:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736903193;
	bh=A3vbDqaxIUVLZem9iF8l8Ny3BrhZexeu+5TKVCFQ+GU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AgcGxHKKIC9Gze5hyejMUgaCwSnHHHNGih6e8767o6bfnpLB7Y+2jp5CFoUzlZxiA
	 2Jcn2h+ljsLbvBtPkwML45tJUlf/zt5vzQLjifzHlR856KhE1hmQpMXrzuoqMEWYEL
	 qlPOT7ZoVX+hcrjI+m78t+iV3W081ECG/yYYok8AvK1MDCbnMnvbjY4red3IC+IiI/
	 ChfVW98Ns/Qz8q1NhgdkjUVGXmkcE1ciHGso0XzOZoAkOaasptn/ggPLK+H+wJvSc8
	 3ml8xF7UCNK2EI/QsAk+3Qlag56H+AqXJnaTO30WB7PxXiOIBPJ0SNY9Xa2ljXM2sr
	 mR4Oi8fhMlLfQ==
Message-ID: <e6e2731a54a4b56854d4bf61bdda27dde7ea35a3.camel@kernel.org>
Subject: Re: [PATCH 2/3] selftests: mptcp: Fix input fd lifecycle in
 reconnection loop
From: Geliang Tang <geliang@kernel.org>
To: Cong Liu <liucong2@kylinos.cn>
Cc: mptcp@lists.linux.dev
Date: Wed, 15 Jan 2025 09:06:27 +0800
In-Reply-To: <20250113085228.121778-3-liucong2@kylinos.cn>
References: <20250113085228.121778-1-liucong2@kylinos.cn>
	 <20250113085228.121778-3-liucong2@kylinos.cn>
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
> When both cfg_input and cfg_sockopt_types.mptfo are set, the input
> file
> descriptor (fd_in) is opened before the reconnection loop but closed
> within the loop. However, when mptfo is enabled, the descriptor is
> not
> reopened in the loop, causing subsequent iterations to use an invalid
> file descriptor.
> 
> Move the file open operation into the loop to ensure fd_in is always
> valid when needed, regardless of mptfo setting.
> 
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 31f4c5618569..4d4ea4627daa 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1247,12 +1247,6 @@ int main_loop(void)
>  	struct addrinfo *peer;
>  	struct wstate winfo;
>  
> -	if (cfg_input && cfg_sockopt_types.mptfo) {
> -		fd_in = open(cfg_input, O_RDONLY);
> -		if (fd_in < 0)
> -			xerror("can't open %s:%d", cfg_input,
> errno);
> -	}
> -
>  	memset(&winfo, 0, sizeof(winfo));
>  	fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto,
> &peer, fd_in, &winfo);

Is this 'fd_in' here valid if the previous 'fd_in = open(cfg_input,
O_RDONLY);' is deleted?

>  	if (fd < 0)
> @@ -1270,7 +1264,7 @@ int main_loop(void)
>  	if (cfg_cmsg_types.cmsg_enabled)
>  		apply_cmsg_types(fd, &cfg_cmsg_types);
>  
> -	if (cfg_input && !cfg_sockopt_types.mptfo) {
> +	if (cfg_input) {
>  		fd_in = open(cfg_input, O_RDONLY);
>  		if (fd_in < 0)
>  			xerror("can't open %s:%d", cfg_input,
> errno);

