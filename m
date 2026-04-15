Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972A330B22
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245025; cv=none; b=htP+V2zznixJP1gM0o4KZHU2w0o/zKgJdAbNAconwrKwh0W8hDPcKYiWMNp4Lt8J0fimmqcFYSlMuD6cky2hm6jpcdSISCW+Io3h83gUJrJHEOE5TYvwUL5BalSeB+I/95ri2CNkrrYALHGxrUGD0B5Du6AamxU9V3I9sbdo5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245025; c=relaxed/simple;
	bh=LjOwLdqNkOKXCdfwlMLyTO7oqeEtboomShG7MqR28yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=phF6gq8jZ3+4FXa0N/2NlGKHXBSI35NCqnfO5MdFtdsR00oj69xzPlX6j1wGX7F+m9JLkZW41hdLEHfbQlMf8mf4+osfUqgok6184EBF8K/cs5U0nTAsg1kXohTKn0xzn70wLDIYIVGJJA0aib2QrSvbxOG2fJrLnXfALc0iRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfiB50bj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfiB50bj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04606C2BCB4
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776245025;
	bh=LjOwLdqNkOKXCdfwlMLyTO7oqeEtboomShG7MqR28yM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=RfiB50bjTVRWziy71VfmA1UEnYLWI7fKpskpM+hfYxsSms9o6qrfC0KlBCR0u6nrf
	 iXREX+oitch/x+iEsJpWak4PAGBpNfeZedvSevb1SQMS0Ao1f734mtXSTBxnZQfrif
	 k3xHlLTYrZZ/xBrKzETX92JkitUpocEQxRgtiY+Ri951mkiuGifRUkzzdIlt4iTyYU
	 236koFZB3QfK7MzabI+aXhMwc0+AFxN/Cn8bx3rql0y5s0Hvxs0oUym4infebrjs6B
	 kMVOtFXGHE4ItjO6ZSldMuBITo+1/eddPXAAFfz1vJkXtrIAaktn25imP59JVP+fMG
	 r05W4/tF3DZyA==
Message-ID: <35f1fc27-b706-4942-a729-3bd7124bb44e@kernel.org>
Date: Wed, 15 Apr 2026 11:23:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v4 10/20] selftests: mptcp: check output: catch
 cmd errors
Content-Language: fr
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
 <20260414-mptcp-inc-limits-v4-10-78274edda5dd@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260414-mptcp-inc-limits-v4-10-78274edda5dd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 14/04/2026 15:34, Matthieu Baerts (NGI0) wrote:
> Using '${?}' inside the if-statement to check the returned value from
> the command that was evaluated as part of the if-statement is not
> correct: here, '${?}' will be linked to the previous instruction, not
> the one that is expected here (${cmd}).
> 
> Instead, simply mark the error, except if an error is expected. If
> that's the case, 1 can be passed as the 4th argument of this helper. Two
> checks from pm_netlink.sh expect an error.
> 
> Note that we could expect a specific returned value, but the checks
> currently expecting an error can be used with 'ip mptcp' or 'pm_nl_ctl',
> and these two tools don't return the same error code.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 5fea7e7df628..9e0cd426845d 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -474,18 +474,18 @@ mptcp_lib_wait_local_port_listen() {
>  	wait_local_port_listen "${@}" "tcp"
>  }
>  
> +# $1: error file, $2: cmd, $3: expected msg, [$4: expected error]
>  mptcp_lib_check_output() {
>  	local err="${1}"
>  	local cmd="${2}"
>  	local expected="${3}"
> +	local exp_error="${4:-0}"
>  	local cmd_ret=0
>  	local out
>  
> -	if ! out=$(${cmd} 2>"${err}"); then
> -		cmd_ret=${?}
> -	fi
> +	out=$(${cmd} 2>"${err}") || cmd_ret=1
>  
> -	if [ ${cmd_ret} -ne 0 ]; then
> +	if [ "${cmd_ret}" != "${exp_error}" ]; then
>  		mptcp_lib_pr_fail "command execution '${cmd}' stderr"
>  		cat "${err}"

Here, we could print a better error and output:

-               mptcp_lib_pr_fail "command execution '${cmd}' stderr"
-               cat "${err}"
+               mptcp_lib_pr_fail "unexpected returned code for
'${cmd}', info:"
+               if [ "${exp_error}" = 0 ]; then
+                       cat "${err}"
+               else
+                       echo "${out}"
+               fi


>  		return 2
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index 123d9d7a0278..26ff4c360a77 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -122,10 +122,12 @@ check()
>  	local cmd="$1"
>  	local expected="$2"
>  	local msg="$3"
> +	local no_err="$4"

I forgot to rename this one to "exp_error".

I can do that when applying the patches if there are nothing else.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

