Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE24F8B2
	for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355632; cv=none; b=YLWPPnTy03HeKgg/EZiu0IwIwst/f0u00zaBuGCDMiNjP4yGAMyJ1NDAo3OISlfCjiLWPqinvt8OHaOXkFsG9jS8zqFQhq83Shb6NdgEvIJDmCvrddy19UN7yZDN22A89S4OyOZ9YG78SKwZ0u6dnw28ZFpi2xyt83OYzA+JTYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355632; c=relaxed/simple;
	bh=Z6dA48x4MkQPrVymS17pn9LXoN4DgO0i73I9p3bMWSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8ZY+ATLMmgQKl8IKLbgBgBxJq3nEjfHgbI+5FeDwgIT1RUtyeStLBenuwv/40DOo1uHVPTEvdlF2/is+0yZBsQmm7rkEbzSfhyq0BLlCLwEnnVq/I2Y+u+zDest4gK8X6Jap+S/fYlHPe4QsOjwqTgk/f2pbiEk7wADMud8adk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YggSBn8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YggSBn8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0EDC433C7;
	Wed, 13 Mar 2024 18:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710355631;
	bh=Z6dA48x4MkQPrVymS17pn9LXoN4DgO0i73I9p3bMWSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YggSBn8Tb3fQBnEuc6hoFc5KxnnO2OOHrLgQkQtcU8bFduHbDBcztnIKCGQSUxF8o
	 wITNhNkoHD8xawg6HxD8UcYhWTRK7jO/eqhJXJvmSvpLaY9EgXTtNVn2akPL1Laogl
	 Ea/seNKWQHNIayPsN7/NTX2tEF75a4kOZBS6jc1U4i8jMO37XvjN1XvqPkW/pkxa5j
	 iCggHY4afkJF6z4ckUfsOkWoMLXtCKQsDWvR4Aq6bBk09HFPdVMBsy/LLoCXqO9Ii5
	 TJ5GgybpcKYcdLCELsgws4LmQuzwIGr9EhT3XIRZYNp7ESRx5ronyQgTrVBjJfxTh0
	 A5vfPM9lO63Vg==
Message-ID: <252586c0-53bd-4588-8dee-3378099ed4a1@kernel.org>
Date: Wed, 13 Mar 2024 19:47:07 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 01/10] selftests: mptcp: export ip_mptcp to
 mptcp_lib
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
 <79aa9c522bcbd104823284a9ea42a91bbbd1f9e2.1710121590.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <79aa9c522bcbd104823284a9ea42a91bbbd1f9e2.1710121590.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 11/03/2024 02:48, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch exports ip_mptcp into mptcp_lib.sh as a public variable,
> named mptcp_lib_ip_mptcp. Add a helper mptcp_lib_set_ip_mptcp() to set
> it, and a helper mptcp_lib_is_ip_mptcp() to test whether it is set. Use
> these two helpers in mptcp_join.sh.
> 
> This patch is prepared for coming commits.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index d529b4b37af8..d84f2f4986a7 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -23,6 +23,7 @@ MPTCP_LIB_SUBTESTS=()
>  MPTCP_LIB_SUBTESTS_DUPLICATED=0
>  MPTCP_LIB_TEST_COUNTER=0
>  MPTCP_LIB_TEST_FORMAT="%02u %-50s"
> +mptcp_lib_ip_mptcp=0

Please use capital letters for these global variables, like the other
ones here above.

>  # only if supported (or forced) and not disabled, see no-color.org
>  if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
> @@ -505,3 +506,15 @@ mptcp_lib_verify_listener_events() {
>  	mptcp_lib_check_expected "type" "family" "saddr" "sport" || rc="${?}"
>  	return "${rc}"
>  }
> +
> +mptcp_lib_set_ip_mptcp() {
> +	: "${mptcp_lib_ip_mptcp:?}"

I don't think you need that, the variable is declared in the same file.
(and you are going to modify it anyway, no "read")

> +	mptcp_lib_ip_mptcp=1
> +}
> +
> +mptcp_lib_is_ip_mptcp() {
> +	: "${mptcp_lib_ip_mptcp:?}"

Same here, not needed I think.

> +
> +	[ ${mptcp_lib_ip_mptcp} -eq 1 ]

detail: because global variables could be modified elsewhere, I usually
find it safer to use double quotes, and compare strings:

  [ "${MPTCP_LIB_IP_MPTCP}" = "1" ]

But on the other hand, this global variable is not supposed to be
modified elsewhere... So up to you.

> +}

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

