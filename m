Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016572B9BD
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951315; cv=none; b=p4BQWiap0uIUlBiUfXjj5cxFiX4d8BdYCW/o2VfKi/Cp50dGIjlYuUaqbaA+Pwg4tiFO+OwdpECGUx8ZEKUjGSXfgEgN0E/a2wPQXH9EX8dnmG9Dea8k0OBPBmdX0tdoLqzHw4F4Ku070CBgwgTctSfyLoMKPW92F+8wLDNMm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951315; c=relaxed/simple;
	bh=N/RbMXHkHxXVNP6tSluwBLLvUO52fAa/IHAup95TEdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNMeYDPQHRGTW5E+nGTSSZmtnYfaeRq5kt6Nn66tkgcx7U8UmIPOC0TALg04JOWapgzZydqtnB4qla8bBUll0tpdyLUoTmef9vkme7mcQ3miZ7Pwy+HyHNchaw5LJluWxeKp1CIycYxUPjQqEL23AQgaZPhx1UnWbpio5yKV8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBBoouq+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBBoouq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB79C433C7;
	Mon, 26 Feb 2024 12:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708951314;
	bh=N/RbMXHkHxXVNP6tSluwBLLvUO52fAa/IHAup95TEdo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hBBoouq+Iu7HXDYVjZNElZQBr/wgdYZ2tzxSZUGvN5+IrzQPwMhokU+x5vWUdNuaH
	 ngF5D9aAvOxBtJhKvxzjerQan87TiyFhQJx6wPwgmKgY+E0tvT+DDBT1beXmz6U2u5
	 CsHj5Qt9DqyQYIkrIJmj8lm0/roCz9gI7EGX2cUcn3dhWwMs2QuuSoLXRUp48nxsBX
	 Y/matruoiTM5nMRjl+oDqRlwBy2VU8YkBQMJNngi8jwuzHU1iscX9EVQk6i/OlE1d7
	 FjFCyN6kaL7zBUsbTGN5r9ISNzpGRbnO67tL163AbvhCEwh3xcIT4tNYc7t9MgH22P
	 Nu1A15ZyUiMyw==
Message-ID: <5273bf67-282b-4b16-8576-670b12447d6a@kernel.org>
Date: Mon, 26 Feb 2024 13:41:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 09/12] selftests: mptcp: extract
 mptcp_lib_check_expected
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
 <71d2dc8ad19fd8d87c8e128ed3f02a6c77d1c9d2.1708939962.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <71d2dc8ad19fd8d87c8e128ed3f02a6c77d1c9d2.1708939962.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/02/2024 10:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Extract the main part of check_expected() in userspace_pm.sh to a new
> function mptcp_lib_check_expected() in mptcp_lib.sh. It will be used
> in both mptcp_john.sh and userspace_pm.sh.
> 
> check_expected_one() is moved into mptcp_lib.sh too as a sub function
> of mptcp_lib_check_expected().

Out of curiosity: why a subfunction?

(see below)

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 48 +++++++++++++++++++
>  .../selftests/net/mptcp/userspace_pm.sh       | 39 ++-------------
>  2 files changed, 52 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index df495658f043..ed0013b47edb 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -1,6 +1,9 @@
>  #! /bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> +# Some variables are used below but indirectly, see check_expected_one()
> +#shellcheck disable=SC2034

Please move that just above the lines or functions having these
false-positive errors to reduce the scope. Otherwise, this rule will be
applied everywhere, and maybe missing valid issues.

In other words, don't declare it here, but in mptcp_join.sh, where used.
For userspace_pm.sh, you can keep it where it is, I suppose.

> +
>  readonly KSFT_PASS=0
>  readonly KSFT_FAIL=1
>  readonly KSFT_SKIP=4
> @@ -419,3 +422,48 @@ mptcp_lib_print_test_counter() {
>  
>  	printf "%02u ${fmt}" "$((++counter))" "${msg}"
>  }
> +
> +# $@: all var names to check
> +mptcp_lib_check_expected() {
> +	# $1: var name ; $2: prev ret
> +	check_expected_one() {

You still need to prefix it with mptcp_lib_ because you could override
functions with the same name declared elsewhere: when
mptcp_lib_check_expected(), this subfunction will be created globally,
potentially overriding other ones with the same name.

> +		local var="${1}"
> +		local exp="e_${var}"
> +		local prev_ret="${2}"
> +
> +		if [ "${!var}" = "${!exp}" ]

Please keep the same code style as in the rest of this file: "then" and
"do" are on the same line as "if" / "for".

> +		then
> +			return 0
> +		fi
> +
> +		if [ "${prev_ret}" = "0" ]
> +		then
> +			return 2
> +		fi
> +
> +		printf "\tExpected value for '%s': '%s', got '%s'.\n" \
> +			"${var}" "${!exp}" "${!var}"
> +		return 1
> +	}
> +
> +	local rc=0
> +	local var
> +
> +	for var in "${@}"
> +	do
> +		check_expected_one "${var}" "${rc}" || rc="${?}"
> +		if [ "${rc}" -eq 2 ]
> +		then
> +			break
> +		fi
> +	done
> +	unset -f check_expected_one
> +
> +	if [ ${rc} -eq 0 ]
> +	then
> +		mptcp_lib_print_ok "[ OK ]"
> +		return 0
> +	fi
> +
> +	return "${rc}"
> +}
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 473639a8009f..3f475ae44d0b 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -5,7 +5,7 @@
>  # code but we accept it.
>  #shellcheck disable=SC2086
>  
> -# Some variables are used below but indirectly, see check_expected_one()
> +# Some variables are used below but indirectly

Maybe point to check_expected now?

>  #shellcheck disable=SC2034
>  
>  . "$(dirname "${0}")/mptcp_lib.sh"
> @@ -233,46 +233,15 @@ make_connection()
>  	fi
>  }
>  
> -# $1: var name ; $2: prev ret
> -check_expected_one()
> -{
> -	local var="${1}"
> -	local exp="e_${var}"
> -	local prev_ret="${2}"
> -
> -	if [ "${!var}" = "${!exp}" ]
> -	then
> -		return 0
> -	fi
> -
> -	if [ "${prev_ret}" = "0" ]
> -	then
> -		return 2
> -	fi
> -
> -	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
> -		"${var}" "${!exp}" "${!var}"
> -	return 1
> -}
> -
>  # $@: all var names to check
>  check_expected()
>  {
>  	local rc=0
> -	local var
>  
> -	for var in "${@}"
> -	do
> -		check_expected_one "${var}" "${rc}" || rc="${?}"
> -		if [ "${rc}" -eq 2 ]
> -		then
> -			break
> -		fi
> -	done
> -
> -	if [ ${rc} -eq 0 ]
> +	mptcp_lib_check_expected "${@}" || rc="${?}"
> +	if [ "${rc}" -eq 0 ]
>  	then
> -		test_pass
> +		mptcp_lib_result_pass "${test_name}"
>  		return 0
>  	elif [ "${rc}" -eq 2 ]
>  	then

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
