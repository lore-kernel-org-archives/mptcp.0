Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14B1E866
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822860; cv=none; b=HXQVb16f27B8LnBWnqfKF5Wl0W2QIbvk4dXWMBBxSZ6uhADYCXrG/7jauFIHRnvuywVzgDL1dnsl7wE+HvDUvCxPxFyWwABjZUEGv5ulfUoV0gGSA5wn6n0zBlIdLlNtKi4yCQV7hgRcvU/r1zd+PbHMAq9KAp+WW/wRITG63Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822860; c=relaxed/simple;
	bh=Mr/Kk+Tx9z1IaIg762JyoPjVWDdQ8lhEBn1/4jNZIbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suItIV/o5FB4cqksxCju9fb/buuZsDn0zGD41Yur+b97cN8VuATW1AsXtQBHPLzw/kBhuilaksdO4pq47HGHTd2GlCwhOqJJmlcVXV/fAvlEVwj87WEUhCEA8rc5Ssq0FPZ5KTWVlcQy9k7bGQbcJdk6qekdJiostHayc4aYGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kstdyc3S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kstdyc3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2827C433C7;
	Thu,  7 Mar 2024 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709822859;
	bh=Mr/Kk+Tx9z1IaIg762JyoPjVWDdQ8lhEBn1/4jNZIbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kstdyc3Sb/dFyUosxYfxeRNxYR/1HgRaHExJw0+e5kjBL3rvRK7FpKOgXU/SbW3Rw
	 o8hfq4uHwCgcdRb0LSe8SjnN9KQXRk52PUavGUHOdhgFcNzywtCkDVeEwWFHAy315W
	 EaUmCvq+5UR0yp1G0atgS6VOwj//RWD3IH96OGpMHI4VFU3OzyAULYPP5Ae4lon07K
	 c4kwQquRKtlbsVfI7IaGPg2EMTxQVK1ptmux1oEC+HwtKxfq3cdcQ/Gpilqkdry1b5
	 vve9ths2f27vXyNyuvbr5/QbOXfWOoj/5QiwP+M1PnnWS8Zkhkkq7pmLiVQ39kszUM
	 G2PzmCLbOTWoA==
Message-ID: <565efb7d-3f29-4636-a717-84c45db8856b@kernel.org>
Date: Thu, 7 Mar 2024 15:47:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 1/5] selftests: mptcp: extract
 mptcp_lib_check_expected
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709815545.git.tanggeliang@kylinos.cn>
 <b1d6b400a21b15b9237e6cdd35d325f9fd5584d9.1709815545.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b1d6b400a21b15b9237e6cdd35d325f9fd5584d9.1709815545.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 07/03/2024 13:48, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Extract the main part of check_expected() in userspace_pm.sh to a new
> function mptcp_lib_check_expected() in mptcp_lib.sh. It will be used
> in both mptcp_john.sh and userspace_pm.sh. check_expected_one() is
> moved into mptcp_lib.sh too as mptcp_lib_check_expected_one().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 30 ++++++++++++++++
>  .../selftests/net/mptcp/userspace_pm.sh       | 34 +++----------------
>  2 files changed, 35 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index ea39392c68e7..44491f18ed17 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -438,3 +438,33 @@ mptcp_lib_print_title() {
>  	# shellcheck disable=SC2059 # the format is in a variable
>  	printf "${MPTCP_LIB_TEST_FORMAT}" "$((++MPTCP_LIB_TEST_COUNTER))" "${*}"
>  }
> +
> +# $1: var name ; $2: prev ret
> +mptcp_lib_check_expected_one() {
> +	local var="${1}"
> +	local exp="e_${var}"
> +	local prev_ret="${2}"
> +
> +	if [ "${!var}" = "${!exp}" ]; then
> +		return 0
> +	fi
> +
> +	if [ "${prev_ret}" = "0" ]; then
> +		mptcp_lib_pr_fail
> +	fi
> +
> +	mptcp_lib_print_err "Expected value for '${var}': '${!exp}', got '${!var}'."

Maybe keep the tab like before? Please check how it looks like when
there is a failure in mptcp_join.sh and userspace_pm.sh.

> +	return 1
> +}
> +
> +# $@: all var names to check
> +mptcp_lib_check_expected() {
> +	local rc=0
> +	local var
> +
> +	for var in "${@}"; do
> +		mptcp_lib_check_expected_one "${var}" "${rc}" || rc=1
> +	done
> +
> +	return "${rc}"
> +}
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 4e29aa9c2529..6ab9efda8627 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -5,7 +5,7 @@
>  # code but we accept it.
>  #shellcheck disable=SC2086
>  
> -# Some variables are used below but indirectly, see check_expected_one()
> +# Some variables are used below but indirectly, see verify_*_event()
>  #shellcheck disable=SC2034
>  
>  . "$(dirname "${0}")/mptcp_lib.sh"
> @@ -225,44 +225,20 @@ make_connection()
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
> -		test_fail
> -	fi
> -
> -	mptcp_lib_print_err "\tExpected value for '${var}': '${!exp}', got '${!var}'."
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
> -		check_expected_one "${var}" "${rc}" || rc=1
> -	done
> -
> -	if [ ${rc} -eq 0 ]
> +	mptcp_lib_check_expected "${@}" || rc=1
> +	if [ "${rc}" -eq 0 ]

I guess you no longer need "rc":

  if mptcp_lib_check_expected "${@}"
  then
      test_pass
      return 0
  fi

>  	then
>  		test_pass
>  		return 0
>  	fi
>  
> +	ret=1
> +	mptcp_lib_result_fail "${test_name}"

Mmh, you should keep using test_fail(): best to keep using a single
helper in case of failure, because we need to do these two actions, and
for sure, we will miss one later in new code by accident.

Instead, I suggest modifying test_fail() to call "mptcp_lib_pr_fail"
only if there are arguments (if [ ${#} -gt 0 ]). But then, you will have
to add arguments when calling test_fail() from test_remove() → e.g.
"unexpected type: ${type}" (it even makes sense to print that any way to
help to understand what's wrong)

>  	return 1
>  }
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
