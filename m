Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628E6A8B1
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709116286; cv=none; b=mom0saG/3R2/ls1wEF7GZtBiOLjflb+I277TR13Ft3sSYtdh+Caieh/17tP4UVcqG1kb2s9VP0V52fICJqeYF4/UkvCInIOlG0LzL9b9NaYIQtFNhH5wEi0GTn6skeAavueUHDIAMBzY5c2TBanomXAgEr3PXrW88/48yyOB2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709116286; c=relaxed/simple;
	bh=ez1VxmtNteMAUyYhPJQIJM8wOyWvmZzY3PdwJiY4jsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRAK47fJCQ1v54Q5npmNXU3BGxAYWS7BrCvGa7xNvl5t45mElgoKnHx8YBfCD2I+2nVjdrdtfNTw6XYf4RP1+q7hs3sDOf5Vtb2fQX/SMbjSuQkWF9P9S1yATi9BoiOu8ODHKQ1/c2NMUg+YEhSFLD9ImQmEfVRxS5PhWJWkNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG5ywcgW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG5ywcgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C9AC43390;
	Wed, 28 Feb 2024 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709116286;
	bh=ez1VxmtNteMAUyYhPJQIJM8wOyWvmZzY3PdwJiY4jsc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RG5ywcgWOxKubehbWnlyBrLXM87gkbasPnYNqpUpVkSICk6skgFdJ8VogXNw9NZ66
	 u1vYRj4f231mngPN0IehZkTY0dui/vUoARb5L1Mdc82H8LNe8liey66rbd/zbqs+yL
	 ctXsxZS42fIoL386y+awPMJ3S/PuJ8GgVpRouFrrrqzK1A12lRI2jn0Vbr2R4bBxj8
	 s5+6tbmI6tvI6DCvdnrkiu9YMZ98W8RGRL1cejoRhB8K9WD8u5zR1ymYHzF/g8CciH
	 0X4I9P3qWeZmbYuxgO7avsSjBM27tCRG0Aunu3vCRIUdWds2aN0F5+gfa6niG65M6t
	 5GN6wwAK9Gb7w==
Message-ID: <d47680f0-c91f-497b-9ecd-b6a1375e4b60@kernel.org>
Date: Wed, 28 Feb 2024 11:31:23 +0100
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
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d7732e6238909444e5c3d8a67aa06f2fa4b3e79b.1709105922.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 28/02/2024 08:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> To unify the output formats of all test scripts, this patch adds
> four more helpers:
> 
> 	mptcp_lib_pr_ok()
> 	mptcp_lib_pr_skip()
> 	mptcp_lib_pr_fail()
> 	mptcp_lib_pr_info()
> 
> to print out [ OK ], [SKIP], [FAIL] and 'INFO:' with colors. Use
> them in mptcp_join.sh and userspace_pm.sh first, and then use them
> in all scripts in the next commit.

Please add: please note that the mptcp_join.sh tests will now print
these keywords with capital letters, like most of the other tests.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh |  6 ++---
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 23 +++++++++++++++++++
>  .../selftests/net/mptcp/userspace_pm.sh       | 13 ++++-------
>  3 files changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 1df2d24979a0..53d51a5f68f9 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -190,17 +190,17 @@ print_info()
>  
>  print_ok()
>  {
> -	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
> +	mptcp_lib_pr_ok "${@}"
>  }
>  
>  print_fail()
>  {
> -	mptcp_lib_print_err "[fail]${1:+ ${*}}"
> +	mptcp_lib_pr_fail "${@}"
>  }
>  
>  print_skip()
>  {
> -	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
> +	mptcp_lib_pr_skip "${@}"
>  }
>  
>  # [ $1: fail msg ]
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 763a2989ca6d..3f5b16fe5220 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -48,6 +48,29 @@ mptcp_lib_print_err() {
>  	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
>  }
>  
> +mptcp_lib_pr_ok() {
> +	mptcp_lib_print_ok "[ OK ]"

Here, you will potentially have more info to print (at least from
mptcp_join.sh, it can be called with extra args to print):

  mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"


> +}
> +
> +mptcp_lib_pr_skip() {
> +	local msg="[SKIP]"
> +
> +	mptcp_lib_print_warn "${msg}"

Same here:

  mptcp_lib_print_warn "[SKIP]${1:+ ${*}}"

> +}
> +
> +mptcp_lib_pr_fail() {
> +	local msg="[FAIL]"
> +
> +	if [ "${#}" -gt 0 ]; then
> +		msg+="${1:+ ${*}}"
> +	fi
> +	mptcp_lib_print_err "${msg}"

And here, it can be simplified:

  mptcp_lib_print_err "[FAIL]${1:+ ${*}}"

> +}
> +
> +mptcp_lib_pr_info() {
> +	mptcp_lib_print_info "INFO:${1:+ ${*}}"

I guess here, we will always have arguments, no?

  mptcp_lib_print_info "INFO: ${*}"

> +}
> +
>  # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
>  # features using the last version of the kernel and the selftests to make sure
>  # a test is not being skipped by mistake.
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index b0cce8f065d8..5f32ac451596 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -61,7 +61,7 @@ _printf() {
>  
>  print_title()
>  {
> -	_printf "INFO: %s\n" "${1}"
> +	mptcp_lib_print_info "INFO: ${1}"

Use mptcp_lib_pr_info() directly, no?

>  }
>  
>  # $1: test name
> @@ -72,27 +72,22 @@ print_test()
>  	_printf "%-68s" "${test_name}"
>  }
>  
> -print_results()
> -{
> -	_printf "[%s]\n" "${1}"
> -}
> -
>  test_pass()
>  {
> -	print_results " OK "
> +	mptcp_lib_pr_ok
>  	mptcp_lib_result_pass "${test_name}"
>  }
>  
>  test_skip()
>  {
> -	print_results "SKIP"
> +	mptcp_lib_pr_skip
>  	mptcp_lib_result_skip "${test_name}"
>  }
>  
>  # $1: msg
>  test_fail()
>  {
> -	print_results "FAIL"
> +	mptcp_lib_pr_fail "${1:+ ${*}}"

I guess you can pass "${@}", no?

  mptcp_lib_pr_fail "${@}"

>  	ret=1
>  
>  	if [ -n "${1}" ]; then

Here, I guess you don't need the 'if' to print more info, there will be
printed with 'mptcp_lib_pr_fail "${@}"' just before, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
