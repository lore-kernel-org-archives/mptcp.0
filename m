Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D237163
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354280; cv=none; b=ZOJ0SVnULPYDjHXCKVbGqfOLEzPVK5Iz2FAemc58CxZFnxqG0N0Tnik03I1hZXaaA0qkWRE7gpBFoFI120iTZwTrw/LumBcdoZF9QrAFVdNbxu32tGdXn8Wnr4Qa4ChhZ0YdfMTRathXKj4YAomK3oyvzpED9cs+9jJo9U1JWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354280; c=relaxed/simple;
	bh=Ay0mB959ataCLBiv5hUh8QzU2M4EMkuyAjm4y64CAEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdoVO7oaF0k5FTaaBx4Evm4akOSq0TR5QiBBfpY2gyOEiD3O9fv0tG1e0VLW/8A0dvnsXK74p4KhhkA/xdNt7XrXT+vaawwidty97odNTZZ/IVFcpCc1WrMRTRvq70hIh0kb0SxMoDTHGIv7VhtloTn1HcljYAvx1DhaleC8luQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTFHrsh3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTFHrsh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E435C433C7;
	Mon, 19 Feb 2024 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708354280;
	bh=Ay0mB959ataCLBiv5hUh8QzU2M4EMkuyAjm4y64CAEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TTFHrsh3vcJEZMla3OZD/uc5k8JMZ0B3HwqwF2yuJgBjzqonGtyukncobylOY89mY
	 sYXQxhyA9UlDGrvZlwJCUnwqLg1j/W+Rk4Nxh++beeoX6BbDA2/qdoJqkmrM/bg+Uw
	 7PRHgXBdUDlAHgP6X1zDyDefBYq+L3gJRyNcXbTu/96Ev3wbol3tVnnzMhVHNB4wKC
	 kxTfIja24D+AdAnxmqLXQid/N2Tg6Vu5xaP2aoGZheOnVxu0r1JxuRv0s/OdYKz7WO
	 QOm2Q9tT2Shs961IlzSTi+2euqBA7zrZ6ROR3l4iw9gCVEzwksJgUtJWFzvY3PIFK6
	 UqCDCE0CB2mjg==
Message-ID: <245af371-13ea-4e67-9d8d-93844e5cdf9a@kernel.org>
Date: Mon, 19 Feb 2024 15:51:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v13 08/14] selftests: mptcp: add check_output
 helper
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
 <203718fd9b34ac092a198737bed0e36baa447d69.1708069036.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <203718fd9b34ac092a198737bed0e36baa447d69.1708069036.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/02/2024 08:42, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Similar to check() in pm_netlink.sh, add a new helper check_output()
> in mptcp_join.sh to check the output of the given commands.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index b807e2a42c61..6f7e83f61707 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -21,6 +21,7 @@ cinfail=""
>  cinsent=""
>  tmpfile=""
>  cout=""
> +check_output_err=""
>  capout=""
>  ns1=""
>  ns2=""
> @@ -182,6 +183,7 @@ init() {
>  	cout=$(mktemp)
>  	evts_ns1=$(mktemp)
>  	evts_ns2=$(mktemp)
> +	check_output_err=$(mktemp)
>  
>  	trap cleanup EXIT
>  
> @@ -195,6 +197,7 @@ cleanup()
>  	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
>  	rm -f "$tmpfile"
>  	rm -rf $evts_ns1 $evts_ns2
> +	rm -f $check_output_err
>  	cleanup_partial
>  }
>  
> @@ -3347,6 +3350,30 @@ userspace_pm_rm_sf()
>  	wait_rm_sf $1 "${cnt}"
>  }
>  
> +check_output()
> +{
> +	local cmd="$1"
> +	local expected="$2"
> +	local msg="$3"
> +	local out=`$cmd 2>$check_output_err`

This causes the following warnings from shellcheck:

> $ shellcheck -x mptcp_join.sh
> 
> In mptcp_join.sh line 3365:
>         local out=`$cmd 2>$check_output_err`
>               ^-^ SC2155 (warning): Declare and assign separately to avoid masking return values.
>                   ^------------------------^ SC2006 (style): Use $(...) notation instead of legacy backticks `...`.
> 
> Did you mean: 
>         local out=$($cmd 2>$check_output_err)

I guess it should be:

  local out cmd_ret=0

  out=$(${cmd} 2>${check_output_err}) || cmd_ret=${?}

Please check you don't introduce new shellcheck warnings. There are
shellcheck plugins for various text editors.

> +	local cmd_ret=$?
> +
> +	printf "%-42s" "$msg"

You should not need this. Can you not use print_check() instead?

And in fact, you should not call 'print_check' from here, but from the
caller, where you would have 'print_skip', see patches 9 and 14/14.

> +	if [ $cmd_ret -ne 0 ]; then
> +		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "

Here, you should call fail_test() instead, and not set ret=<FAIL>: there
is a single function setting ret to a different value, best not to
change that.

Also, fail_test() will print more info if needed, and mark the test as
failed.

> +		cat $check_output_err
> +		ret=${KSFT_FAIL}
> +		return $cmd_ret
> +	elif [ "$out" = "$expected" ]; then
> +		mptcp_lib_print_ok "[ OK ]"

And here you should call print_ok().

> +		return 0
> +	else
> +		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
> +		ret=${KSFT_FAIL}
> +		return 1

Same here: fail_test().

> +	fi
> +}
> +
>  userspace_tests()
>  {
>  	# userspace pm type prevents add_addr

(looking at the modifications that are specific to mptcp_join.sh, you
might have to drop "selftests: mptcp: add mptcp_lib_check_output helper"
from "add helpers and vars in mptcp_lib.sh, part 2" series. But of
course, still OK to use mptcp_lib_print_XXX from pm_netlink.sh and other
.sh scripts to add colours!)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
