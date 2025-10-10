Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733B26FA77
	for <mptcp@lists.linux.dev>; Fri, 10 Oct 2025 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091154; cv=none; b=RriLOdHH+Qh/UTQNYqS6J7JWJIO9Tzhfv0cl8ixv6p9XgGTLre4vKXmszhfNgCZrcWT56uDkZ347fb9v+3MtB+utlPL9V+3oD2HwFEU8ga0Ak4s5fBqdUsmoxewOXJUYwRDqAt4xKTTZms+ncQRWxbyh6KM4NFUoztsQ9y13PoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091154; c=relaxed/simple;
	bh=BStSGDhdabqJEnXQeTHkGBTqoW1xkS416MKaZhXsUyI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YLsk44+zOxm4J7/Vet51Hi9ESNUl8ldygT3+xQvBiJpW0S4VemO5wcpu/7Yqt0vgo6Us/mVjOt2CX5SbBJkXsT8qklyWUUk2NyxSCxPTg6U9tzEW9Au/oCk7m2IYSfnfse6B2Ip8Fbnd9ckeKIgTBx11Xu4pMvjdUS3VVVwwssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPzQkPj2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPzQkPj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2927CC4CEF1;
	Fri, 10 Oct 2025 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760091153;
	bh=BStSGDhdabqJEnXQeTHkGBTqoW1xkS416MKaZhXsUyI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=NPzQkPj2aNWdDmsktxbllqYEKvx4NFYddqfy/sJoyV3klMdlJ+lvqMLdoxJSFOMvM
	 f7AtI2zoQTvgEgI28IvgtcTxeE/DoRG82UsbQrcmq2B1FX37RLtzV0v9OHzkeiHcv3
	 aH9qFXWsOxo+czC9XHsAeyOOZCKusgWvkxkF+pMdz2c9od7Vfi/mjN+jUIqzMfg4/g
	 U50ZkMy8LdDZtkzst+RLTjeZEO77evOwysb1MLkvNPXkRYuzFXIZ7YYNtVg+6tz/QT
	 f8F7T+EO/tZPpBkg3N9aJvbx9tq5lng2jGib16767O18o0BmTYiU74RWetvSzUdM0I
	 a/2IKEGwPDemg==
Message-ID: <355444b6acdf767fbd7fe6a3d820ab3ff43332f5.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 3/7] selftests: mptcp: join: mark 'delete
 re-add signal' as skipped if not supported
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 10 Oct 2025 18:12:30 +0800
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-3-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
	 <20251008-c-flag-add-addr-delay-v1-3-c624eb3bf10d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Wed, 2025-10-08 at 15:59 +0200, Matthieu Baerts (NGI0) wrote:
> The call to 'continue_if' was missing: it properly marks a subtest as
> 'skipped' if the attached condition is not valid.
> 
> Without that, the test is wrongly marked as passed on older kernels.
> 
> Fixes: b5e2fb832f48 ("selftests: mptcp: add explicit test case for
> remove/readd")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This patch looks good to me.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index deba21ca5a97..59983aed2591 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4040,7 +4040,7 @@ endpoint_tests()
>  
>  	# remove and re-add
>  	if reset_with_events "delete re-add signal" &&
> -	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
> +	   continue_if mptcp_lib_kallsyms_has
> "subflow_rebuild_header$"; then
>  		ip netns exec $ns1 sysctl -q
> net.mptcp.add_addr_timeout=0
>  		pm_nl_set_limits $ns1 0 3
>  		pm_nl_set_limits $ns2 3 3
> 

