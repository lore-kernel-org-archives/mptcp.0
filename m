Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0E4EB52
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517799; cv=none; b=dVCKBrOGfSSePISfUeBxTVtH3eVsDJ9X3CS72TQWd1ALEvpmv7AcgeJ62B5exzrAIzpLjkxhLIQGL71E6svhvoUW+jMJmbroB2X8bco+pUXCmPPjZf5aCgwAq4AevrNn9uh59illUwiyTWmz/F+gXSRT1P/IAEcTllnBnNfflfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517799; c=relaxed/simple;
	bh=DOoUk0EosAi+A7y+LXxbbuLx9u1Qsw1Xepd1zC9zKys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IP1MmW5Vlqf0JpWZtiITwbQNjbYU0UMxTQGE+BSeKPfzeHYDDIEse5S1mddU+mjUd3AcRRA/C9+YnWydQ8+CTChiML93MtdiM1meNcMiofOT1XH5CFlzK+y9unZkUIHy5JLgE4CZnpEsCS1lG8++79mhxFkUa13uOaf+9DIzNYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+kGJYOH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+kGJYOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E36C433C7;
	Wed, 21 Feb 2024 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708517799;
	bh=DOoUk0EosAi+A7y+LXxbbuLx9u1Qsw1Xepd1zC9zKys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S+kGJYOH0MRT8FCqMODTGXtDp7x1+I5ncaXMIYdqpipXSliD1FOD5Dtkei6S4sTUw
	 Pj3J658nH93WTDKDRYxczof20J9RVrD129BHmo3nDnZGY6KjfZpzKrsfNQy5V/MYX7
	 LSBQz7goo8aTJlVVqPYF6QYeTcV0alEhy2T73DJCN0AHWOG6YCPkZZIYoXaU7eKUBC
	 Q+7uHCiA7P/ceXpWOKDTNjmkB2JO7WhtDu14+IK5BVAsaTu/1HO919VMyMckcTEA2r
	 Mi/4cE8g86R0oj7ONUkgm/Up9HMXPivmTYwhARKK2gEdZFs7r9TcovRzb9flJh/nWz
	 KfkeCXDqcV2JQ==
Message-ID: <facd117e-c18f-42b4-aeba-86a7dc9bbf02@kernel.org>
Date: Wed, 21 Feb 2024 13:16:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 3/3] selftests: mptcp: add mptcp_lib_evts_*
 helpers
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708499011.git.tanggeliang@kylinos.cn>
 <82a62a697fa15f7f430076f67d6bb23a1827eb7b.1708499011.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <82a62a697fa15f7f430076f67d6bb23a1827eb7b.1708499011.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/02/2024 8:06 am, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> To avoid duplicated code in different MPTCP selftests, we can add and
> use helpers defined in mptcp_lib.sh.
> 
> This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
> and mptcp_join.sh into four helpers: mptcp_lib_evts_init(), _start(),
> _kill() and _remove(). Define them in mptcp_lib.sh and use these new
> helpers in both scripts.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 16 ++----
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 55 +++++++++++++++++++
>  .../selftests/net/mptcp/userspace_pm.sh       | 28 +++-------
>  3 files changed, 67 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index bea7627c7313..006fefaf2e2a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -158,8 +158,7 @@ init() {
>  	cinsent=$(mktemp)
>  	cout=$(mktemp)
>  	err=$(mktemp)
> -	evts_ns1=$(mktemp)
> -	evts_ns2=$(mktemp)
> +	mptcp_lib_evts_init evts_ns1 evts_ns2

Maybe easier to keep this unchanged? All you do in the lib is:

  <var>=$(mktemp)

Same for the mptcp_lib_evts_remove -- just a 'rm' -- and
mptcp_lib_evts_kill -- just calling mptcp_lib_kill_wait.

Or do you see other advantages?

>  	trap cleanup EXIT
>  

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 14c0b97a153e..9573edb4efb1 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -396,3 +396,58 @@ mptcp_lib_ns_exit() {
>  		ip netns del "$netns"
>  	done
>  }
> +
> +mptcp_lib_evts_init() {
> +	local arg
> +
> +	for arg in "${@}"; do
> +		declare -n evts="${arg}"
> +
> +		if [ -z "${evts}" ]; then
> +			evts=$(mktemp)
> +		fi
> +	done
> +}

(see above, maybe we don't need this helper?)

> +
> +# $1 ns1, $2 ns2
> +mptcp_lib_evts_start() {
> +	local ns_1="${1}"
> +	local ns_2="${2}"
> +	local evts_1="${3}"
> +	local evts_2="${4}"
> +	declare -n pid_1="${5}"
> +	declare -n pid_2="${6}"

(or use ${!pid_1} as in mptcp_lib_ns_init -- or we use 'declare -n'
there too, just for consistency)

(I hope 'declare -n' will respect the 'local' scope, but I guess yes)

> +
> +	:>"${evts_1}"
> +	:>"${evts_2}"
> +
> +	if [ ${pid_1} -ne 0 ]; then
> +		mptcp_lib_kill_wait "${pid_1}"
> +	fi
> +	ip netns exec "${ns_1}" ./pm_nl_ctl events >> "${evts_1}" 2>&1 &
> +	pid_1=$!
> +
> +	if [ ${pid_2} -ne 0 ]; then
> +		mptcp_lib_kill_wait "${pid_2}"
> +	fi
> +	ip netns exec "${ns_2}" ./pm_nl_ctl events >> "${evts_2}" 2>&1 &
> +	pid_2=$!
> +}
> +
> +mptcp_lib_evts_kill() {
> +	declare -n pid_1="${1}"
> +	declare -n pid_2="${2}"
> +
> +	mptcp_lib_kill_wait "${pid_1}"
> +	mptcp_lib_kill_wait "${pid_2}"
> +
> +	pid_1=0
> +	pid_2=0

This was not done before, do you need that?

(but see above, maybe we don't need this helper, and the one below)

> +}
> +
> +mptcp_lib_evts_remove() {
> +	local evts_1="${1}"
> +	local evts_2="${2}"
> +
> +	rm -rf "${evts_1}" "${evts_2}"
> +}

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
