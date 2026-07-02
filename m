Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6045BE3
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782971443; cv=none; b=pWO4GbuVcf9l2k2hfA6VsnhlBaYHEu5KjTxPcjo92SXgiaXYjoItO42udGKQzNJT8TS1IMOG1tgooOOPqs00V9ExAvb+v+OYIC7gt0RhQYKNFBKVbXQhF1tFGeyS3DxjswX85yL5L+HIlJQZD4+aT18OQOQU1jiji4tTDtGOuIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782971443; c=relaxed/simple;
	bh=oj5TCjolPc8OSdkokaOXFcYJUnHR9f+Ti0rcRfpyzAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZv+8f3VX/5CJL1W0v8onBryUce1+eiHDyyWVcV2PapKgpHN9SVkTevbr6T1roR5EgPo5BuYdU2L9y3onSObLNxC2YLU3O5DthtvvYQ5x5w/aJYPVA2b0S7aaJMV7L+TMz4vVQPruqmooNI/TGw4s9fM9GzMRKtWnWwPVz0p2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAchyqiR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAchyqiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF27C1F000E9;
	Thu,  2 Jul 2026 05:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782971441;
	bh=kxyTo6EtRAxGb4mOJvaF/bW/1jXLRDfhV7LWISUbAXo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NAchyqiR/LkeaZMwbmtlCnRwwuU5xouk9ljoLfyvwbLsvtGDr5VeGj9SbsMaL8Fcj
	 wZyM9qxT84Jv8R6kSlYCLe/oHqoE65CvGmo7xi1JrOPFTvtCp+H4mu3PXcFVd9MRss
	 +rCun2KRohel1qAAeefdmIR5H7dOsRwGpXGV+cJJa81Uord8kXRhrlppapT2zUk/DA
	 iosOrrJPucW/aVT91qu3fQ3tIZ4Er1NAmKD0fLYs2Wt2bKDeFYZ/VA9SGy9lldFTaq
	 nuUIeaiqofx9yJ3SfTZ4hh1svs357sd4hjNiI+Zrer0gxxnljGxdITBNdhLKN9snTe
	 o6/5BbEcXe04A==
Message-ID: <f66bcc626255440b7fc7ef8c2a9b9dde0675f30e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: diag: fix stack buffer
 overflow in get_subflow_info()
From: Geliang Tang <geliang@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: mptcp@lists.linux.dev
Date: Thu, 02 Jul 2026 13:50:38 +0800
In-Reply-To: <20260702041118.2193877-1-yijiangshan@kylinos.cn>
References: <20260702041118.2193877-1-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiangshan,

On Thu, 2026-07-02 at 12:11 +0800, Jiangshan Yi wrote:
> get_subflow_info() parses the subflow address string with:
> 
> 	char saddr[64], daddr[64];
> 
> 	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d",
> 		     saddr, &sport, daddr, &dport);
> 
> The subflow_addrs buffer holds up to 1024 bytes and is taken directly
> from the command line ("-c" argument). The "%[^:]" conversions have
> no
> maximum field width, so if the address substring before the ':'
> exceeds
> 63 bytes, sscanf() writes past the end of the 64-byte saddr/daddr
> stack
> buffers. This overflows the stack, corrupting adjacent stack data
> such
> as the saved return address, and can crash the tool or lead to
> out-of-bounds writes controlled by user-supplied input.
> 
> Bound both string conversions to the destination buffer size by
> adding
> an explicit maximum field width of 63 (leaving room for the
> terminating
> NUL), so at most 63 bytes are written into each 64-byte buffer:
> 
> 	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d",
> 		     saddr, &sport, daddr, &dport);

v2 looks good now.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

> 
> Fixes: c7ac7452df70 ("selftests: mptcp: add helpers to get
> subflow_info")

I suggest to remove this Fixes tag when applying it. Since this is a
cleanup, not fix.

> Suggested-by: Geliang Tang <geliang@kernel.org>

Also remove this line, add my Reviewed-by tag is enough.

Thanks,
-Geliang

> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
> v2:
>  - add field width to sscanf() (fix >80 col warning, MPTCP CI)
>  - fix subject prefix: mptcp_diag: -> diag: (Geliang Tang)
> 
>  tools/testing/selftests/net/mptcp/mptcp_diag.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> index 5e222ba977e4..3b8d2c8a6216 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> @@ -377,7 +377,8 @@ static void get_subflow_info(char *subflow_addrs)
>  	int ret;
>  	int fd;
>  
> -	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d", saddr,
> &sport, daddr, &dport);
> +	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d",
> +		     saddr, &sport, daddr, &dport);
>  	if (ret != 4)
>  		die_perror("IP PORT Pairs has style problems!");
>  

