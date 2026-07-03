Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08B1ADC97
	for <mptcp@lists.linux.dev>; Fri,  3 Jul 2026 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783040950; cv=none; b=UBqwohdzdNv+bN3zOQf4BWW9VEU/zOsx+0elyHjzGcytTbJAPyamcC7Fuw+SBqiy77D46gSXQcFCLF3zaZRltWg0cF3M1GciYDRVIfAy7nzhj47XeIIfzRo7uRsgmE9mSfv1tdWw0bsppaZVcs/ZT/glclTbv0iLYGk2h7sp6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783040950; c=relaxed/simple;
	bh=8/66wkuwU7cySx4lUj5tE4BVC2R9nJCijeGELTXDg9U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jWKMdxSy4GCtZ+zE5lTC7cxjSLHCSu0BkA0w7wKo5yZmPjx0aWmF0dx2hvcNyMMm2UW36rbO82Jl1m8MuSCf6N1+Ft/mY++T6wdVmzx6PJD9OipAEw9EgwDrATq+ioBoyo1mFxCK9k1iLdIev4jIqZAqBEUkzfjHRAH1IFo5lNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGLo3oyc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGLo3oyc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645521F000E9;
	Fri,  3 Jul 2026 01:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783040949;
	bh=JiTwXkwb+rbplsxIfLWtf4z47KcJsQDqopkMOK9SmVo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VGLo3oycDNZE1PDdwynjAfCV/8i5uBmiboO7P7Xofx0c2tkieR4iY1We/eDhVOtc1
	 lPHcdfm7N77s7XqSyEOcFt2Cd1Gj9G/2uyA2Lhf6ibW5UfRbqI6UYlQLa9zO+CzlXO
	 9/bcP6H1uwTY6tu91wijG2PAqD67KWNT5tarUt+6//STt4x0rbTECIHAWq3kFeORMx
	 73JIgqu/ijbX6Kl0u+HvYw483vRkscMBwd+LMYmyufU7X17pkHxeJwgPchN/9l1f+4
	 3BYv20GmRfCCrqJWuTRB5Wsn3ajAIgGWTF5yfGTsb1pgLouw76tEblidMXI0sBcYtx
	 h7VSsyZsuMwAA==
Message-ID: <9155c24a8743c2648ced51f304bc72a9c96036d8.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: diag: fix stack buffer
 overflow in get_subflow_info()
From: Geliang Tang <geliang@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: mptcp@lists.linux.dev
Date: Fri, 03 Jul 2026 09:09:06 +0800
In-Reply-To: <20260702062909.4147641-1-yijiangshan@kylinos.cn>
References: <f66bcc626255440b7fc7ef8c2a9b9dde0675f30e.camel@kernel.org>
	 <20260702062909.4147641-1-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiangshan,

On Thu, 2026-07-02 at 14:29 +0800, Jiangshan Yi wrote:
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
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
> v3:
>  - drop the Fixes tag: this is a cleanup/hardening, not a fix
> (Geliang)
>  - drop the Suggested-by tag, keep Geliang's Reviewed-by (Geliang)

Actually, there's no need to send this v3, since it doesn't introduce
any code changes compared to v2; we could simply reply and continue the
discussion on the v2 thread.

Anyway, this patch LGTM. I've changed its status to "Queued".

Thanks,
-Geliang

> v2:
>  - add field width to sscanf() (fix >80 col warning, MPTCP CI)
>  - fix subject prefix: mptcp_diag: -> diag: (Geliang)
> v1: 
>  - initial submission
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
