Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939C5B690
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199099; cv=none; b=ChVAyT0mcgaLgecTHkeEXIUsaUNt0QE62FjZySBaZHbbxt0gPi/mHLqOSi6mOTIfE72v3jMctaHqJEOZgayszAhHxaym7j4+lpuI1vRShHCbrCaA5jxyHORnUX+dXAJRDFezMwEzN1sIAM4AEve9S2jyfKlv+/bBKPmBdyhAjL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199099; c=relaxed/simple;
	bh=AS71jIK3irneNO3OshO0eNoloXH3UIjnQHbR8Oih0rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9YXbM4lZdKYAZf4jIziKVRb7cLBFUh8VObKS6AFt0M6YNPGdrcd1rPl8e7x32Lk1L1wxB4s316P1WVL7R3S4pXp7XsAOIvX4RdfSwbJ2lyYF9gIUHUiD2FB2ghJuyYw6mekwnqhjYrd678ZoMWxSBXvt6H+NInfir/1u9ziYx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2GdkIcB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2GdkIcB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FDDC433F1;
	Thu, 29 Feb 2024 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709199098;
	bh=AS71jIK3irneNO3OshO0eNoloXH3UIjnQHbR8Oih0rQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B2GdkIcB6OqF0LtJFKL7Am1lJvyvEjfGZNn3kgEm9InIbWvXjJIob+nk508E3vHFW
	 iG0ly42AyncmOM4jd0Lu+Zk5pM2difYcjj+FDk+bjjioo/HWtA/sX94eYTQJqyk+Yo
	 A+YutjGq9jGeq8fXUDE35aAaXt6xTZUSrGFH9WBxdVJGI9v7lQ28v1oZuMihkXqJfo
	 uBf0p5MhpGv80wfVoo2TxmVnuMIgAGyRXYcpG8fEGFOIOAYdAxgAeTTMp6z4cIfa2r
	 Oluxzp5equDc5826jSiorB/GuSyAO4ATS/zxgRVmPAEUVexrKZmQc3GhtbcewMi7Ac
	 cdaRbV4zWWd3w==
Message-ID: <f524961c-3315-4e44-8e53-c8dbde1a6cea@kernel.org>
Date: Thu, 29 Feb 2024 10:31:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v6 1/9] selftests: mptcp: add
 mptcp_lib_pr_ok/skip/fail/info
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
 <d7732e6238909444e5c3d8a67aa06f2fa4b3e79b.1709105922.git.tanggeliang@kylinos.cn>
 <d47680f0-c91f-497b-9ecd-b6a1375e4b60@kernel.org>
 <90251e8855c97cb8f88509fff8fab7b3be6ffe12.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <90251e8855c97cb8f88509fff8fab7b3be6ffe12.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 29/02/2024 10:18, Geliang Tang wrote:
> Hi Matt,
> 
> On Wed, 2024-02-28 at 11:31 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 28/02/2024 08:43, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> To unify the output formats of all test scripts, this patch adds
>>> four more helpers:
>>>
>>> 	mptcp_lib_pr_ok()
>>> 	mptcp_lib_pr_skip()
>>> 	mptcp_lib_pr_fail()
>>> 	mptcp_lib_pr_info()
>>>
>>> to print out [ OK ], [SKIP], [FAIL] and 'INFO:' with colors. Use
>>> them in mptcp_join.sh and userspace_pm.sh first, and then use them
>>> in all scripts in the next commit.

(...)

>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> index 763a2989ca6d..3f5b16fe5220 100644
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> @@ -48,6 +48,29 @@ mptcp_lib_print_err() {
>>>  	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
>>>  }
>>>  
>>> +mptcp_lib_pr_ok() {
>>> +	mptcp_lib_print_ok "[ OK ]"
>>
>> Here, you will potentially have more info to print (at least from
>> mptcp_join.sh, it can be called with extra args to print):
>>
>>   mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
> 
> I have to use '[ OK ]' here, shellcheck complains about '[ OK ]${1:+
> ${*}}':
> 
> mptcp_lib_pr_ok
>                 ^-------------^ SC2119 (info): Use mptcp_lib_pr_ok "$@"
> if function's $1 should mean script's $1.
Interesting, that's the first time I see that. It looks like you have
this warning, in other files, when mptcp_lib_pr_ok() is called without
parameters, from a function taking some, no?

I guess we can ignore this, explicitly marking this function as "having
optional parameters", using "shellcheck disable=SC2120":

e.g.


> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 4f6bbf5711b17..81ac18841df10 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -48,30 +48,23 @@ mptcp_lib_print_err() {
>         mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
>  }
>  
> +# shellcheck disable=SC2120  # parameters are optional
>  mptcp_lib_pr_ok() {
> -       mptcp_lib_print_ok "[ OK ]"
> +       mptcp_lib_print_ok "[ OK ]${1:+" ${*}"}"
>  }
>  
> +# shellcheck disable=SC2120  # parameters are optional
>  mptcp_lib_pr_skip() {
> -       local msg="[SKIP]"
> -
> -       if [ "${#}" -gt 0 ]; then
> -               msg+="${1:+ ${*}}"
> -       fi
> -       mptcp_lib_print_warn "${msg}"
> +       mptcp_lib_print_warn "[SKIP]${1:+ ${*}}"
>  }
>  
> +# shellcheck disable=SC2120  # parameters are optional
>  mptcp_lib_pr_fail() {
> -       local msg="[FAIL]"
> -
> -       if [ "${#}" -gt 0 ]; then
> -               msg+="${1:+ ${*}}"
> -       fi
> -       mptcp_lib_print_err "${msg}"
> +       mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
>  }
>  
>  mptcp_lib_pr_info() {
> -       mptcp_lib_print_info "INFO:${1:+ ${*}}"
> +       mptcp_lib_print_info "INFO: ${*}"
>  }
>  
>  # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating al


WDYT?


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
