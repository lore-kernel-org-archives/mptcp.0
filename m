Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D6548F2
	for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355828; cv=none; b=hQtqTJUmgba/U6YqSLA5svf9qrXhMd5frQD39y6KH9ZAj9Gun/qFU3N15b80xUrGubx8gNu5fP7HKt6smaMvPtNqieYDsQiPFeJBtU5pBqm3ZEJJ1Qx5EG57c34HP2xcC1PTy+kSEv2ntVdjoXtLccAgvEpMF3cphAgu5dONLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355828; c=relaxed/simple;
	bh=xr36Gme3GN9IsMOLPP6xvfw40oVW0vkjqOJx0BRm4hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYCSBXNX9RezSYrtY6GwSm4lhZYNQHks35lyK7l8Wk8LMbTcAQdQi9dMJbK6aTgMJWK75ikRhJhc4DtWw9rTpiFNZKl00aTdYEhDScbKI88kRg6d86M4xxzz8FAl0Q/664lNhbMQowHWxTHcmZwLy+NyWOWDNLIjMUdYmiVZP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx+XaZ92; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx+XaZ92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9094BC433C7;
	Wed, 13 Mar 2024 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710355827;
	bh=xr36Gme3GN9IsMOLPP6xvfw40oVW0vkjqOJx0BRm4hQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xx+XaZ92k1jGr/LQ7rhavx8toqrtnqxnDd+Q4qemYwSHuDIMnT+r7E+OfgMy90XdP
	 bKsrvL9rpHf2EGsD8NOPGYdvrbLcedYNI82llRWt9b5Y3gb8KM/yWU8i1X4IFX9ixB
	 juO6oKb65crdR9k672MKA7MUHjGEdla8Md5WBJdJBAPNb6G4kWUBJ5Md/ut4boYzWs
	 7KTo3dpSycOyR20IM7dbCzSjCpzG0bA/ac4fxbxscMbKRKozh5TSZxaH0N4AVyVsJh
	 iYvYLs1jkjd4+TET0gp0vCL01w1gro8jDU3qDVsgzXSDS0/4ibwteZ9Dba7HJck/07
	 8GjGNWBV075dA==
Message-ID: <bc95bd09-8b32-4a4a-ae87-0cd4fbfc6e4c@kernel.org>
Date: Wed, 13 Mar 2024 19:50:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 07/10] selftests: mptcp: add endpoint_ops API
 helper
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
 <d327fe8645094080a922dc5075a0d2b45166a5f8.1710121590.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d327fe8645094080a922dc5075a0d2b45166a5f8.1710121590.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 11/03/2024 02:48, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch moves six endpoint operation helpers with the pm_nl_ prefix:
> 
> 	pm_nl_limits(),
> 	pm_nl_add_endpoint(),
> 	pm_nl_del_endpoint(),
> 	pm_nl_flush_endpoint(),
> 	pm_nl_show_endpoints() and
> 	pm_nl_change_endpoint()
> 
> from mptcp_join.sh into mptcp_lib.sh as public functions, and renamed each
> of them with a mptcp_lib_ prefix.
> 
> Add a new helper mptcp_lib_endpoint_ops() in mptcp_lib.sh as the API for
> all endpoint operation helpers, which invokes each of mptcp_lib_ prefix
> helpers according to the first argument of it is "limits", "add", "del",
> "flush", "show" or "change".
> 
> Usage:
>         mptcp_lib_endpoint_ops limits $ns $addrs $subflows
>         mptcp_lib_endpoint_ops add $ns $addr
>         mptcp_lib_endpoint_ops del $ns $id $addr
>         mptcp_lib_endpoint_ops flush $ns
>         mptcp_lib_endpoint_ops show $ns
>         mptcp_lib_endpoint_ops change $ns $id $flags

I'm not sure to understand why you called this helper "endpoint". With
"pm_nl", it means it is linked to the Path Manager, the Netlink
interface. Maybe best to use 'mptcp_lib_pm_nl_ops'?

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index c465f1d59419..d395692fac0d 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -523,3 +523,151 @@ mptcp_lib_is_ip_mptcp() {
>  
>  	[ ${mptcp_lib_ip_mptcp} -eq 1 ]
>  }
> +
> +mptcp_lib_limits() {

Same here for the prefix, "limits" is too vague:

  mptcp_lib_pm_nl_limits()

> +	local ns=${1}
> +	local addrs=${2}
> +	local subflows=${3}
> +
> +	if mptcp_lib_is_ip_mptcp; then
> +		local limits="limits"
> +
> +		if [ -n "${addrs}" ] && [ -n "${subflows}" ]; then
> +			limits+=" set add_addr_accepted ${addrs} subflows ${subflows}"
> +		fi
> +		# shellcheck disable=SC2086

Please *always* *always* justify why you ignore a rule, e.g.

  # shellcheck disable=SCXXXX  ## <reason>

or

  # <long description>
  # <on multiple lines>
  # shellcheck disable=SCXXXX


(I guess you don't need to ignore that if you look at my comment on
patch 2/10, same below)

> +		ip -n "${ns}" mptcp ${limits}
> +	else
> +		# shellcheck disable=SC2086
> +		ip netns exec "${ns}" ./pm_nl_ctl limits "${addrs}" ${subflows}
> +	fi
> +}
> +
> +mptcp_lib_add_endpoint() {
> +	local ns=${1}
> +	local addr=${2}
> +	local flags _flags
> +	local port _port
> +	local dev _dev
> +	local id _id
> +	local nr=2
> +
> +	local p
> +	for p in "${@}"
> +	do
> +		if [ "${p}" = "flags" ]; then
> +			eval _flags=\$"${nr}"
> +			[ -n "${_flags}" ]; flags="flags ${_flags}"
> +		fi
> +		if [ "${p}" = "dev" ]; then
> +			eval _dev=\$"${nr}"
> +			[ -n "${_dev}" ]; dev="dev ${_dev}"
> +		fi
> +		if [ "${p}" = "id" ]; then
> +			eval _id=\$"${nr}"
> +			[ -n "${_id}" ]; id="id ${_id}"
> +		fi
> +		if [ "${p}" = "port" ]; then
> +			eval _port=\$"${nr}"
> +			[ -n "${_port}" ]; port="port ${_port}"
> +		fi
> +
> +		nr=$((nr + 1))
> +	done
> +
> +	if mptcp_lib_is_ip_mptcp; then
> +		# shellcheck disable=SC2086

I wonder if you couldn't use arrays:

  dev=(dev "${_dev}")
  (...)
  ip (...) "${dev[@]}")

> +		ip -n "${ns}" mptcp endpoint add "${addr}" ${_flags//","/" "} ${dev} ${id} ${port}
> +	else
> +		# shellcheck disable=SC2086
> +		ip netns exec "${ns}" ./pm_nl_ctl add "${addr}" ${flags} ${dev} ${id} ${port}
> +	fi
> +}
> +
> +mptcp_lib_del_endpoint() {
> +	local ns=${1}
> +	local id=${2}
> +	local addr=${3}
> +
> +	if mptcp_lib_is_ip_mptcp; then
> +		[ "${id}" -ne 0 ] && addr=''
> +		# shellcheck disable=SC2086
> +		ip -n "${ns}" mptcp endpoint delete id "${id}" ${addr}

or something like that to avoid the disable:

  ${addr:+"${addr}"}

> +	else
> +		ip netns exec "${ns}" ./pm_nl_ctl del "${id}" "${addr}"
> +	fi
> +}
> +
> +mptcp_lib_flush_endpoint() {
> +	local ns=${1}
> +
> +	if mptcp_lib_is_ip_mptcp; then
> +		ip -n "${ns}" mptcp endpoint flush
> +	else
> +		ip netns exec "${ns}" ./pm_nl_ctl flush
> +	fi
> +}
> +
> +mptcp_lib_show_endpoints() {

(I guess this one is only needed in pm_netlink.sh, no?)

> +	local ns=${1}
> +	local id=${2}
> +
> +	if mptcp_lib_is_ip_mptcp; then
> +		local show="show"
> +
> +		[ -n "${id}" ] && show+=" id ${id}"
> +		# shellcheck disable=SC2086
> +		ip -n "${ns}" mptcp endpoint ${show}

Maybe this to avoid the disable:

  ip -n "${ns}" mptcp endpoint show ${id:+id "${id}"}

Same below

> +	else
> +		local dump="dump"
> +
> +		[ -n "${id}" ] && dump="get ${id}"
> +		# shellcheck disable=SC2086
> +		ip netns exec "${ns}" ./pm_nl_ctl ${dump}
> +	fi
> +}
> +
> +mptcp_lib_change_endpoint() {

(I guess this one is only needed in pm_netlink.sh, no?)

> +	local ns=${1}
> +	local addr=${2}
> +	local flags=${3}
> +
> +	if ! mptcp_lib_is_addr "${addr}"; then
> +		[ "${addr}" -gt 0 ] && [ "${addr}" -lt 256 ] && addr="id ${addr}"

use an array?

  XX=("${addr}")
  XX=("id ${addr}")
  ${XX[@]}

> +	fi
> +
> +	if mptcp_lib_is_ip_mptcp; then
> +		# shellcheck disable=SC2086
> +		ip -n "${ns}" mptcp endpoint change ${addr} ${flags//","/" "}
> +	else
> +		# shellcheck disable=SC2086
> +		ip netns exec "${ns}" ./pm_nl_ctl set ${addr} flags "${flags}"
> +	fi
> +}
> +
> +mptcp_lib_endpoint_ops() {
> +	[ "$#" -lt 2 ] && return 1
> +
> +	case "$1" in

(missing {} → ${1})

> +	"limits")
> +		mptcp_lib_limits "${@:2}"
> +		;;
> +	"add")
> +		mptcp_lib_add_endpoint "${@:2}"
> +		;;
> +	"del")
> +		mptcp_lib_del_endpoint "${@:2}"
> +		;;
> +	"flush")
> +		mptcp_lib_flush_endpoint "${@:2}"
> +		;;
> +	"show")
> +		mptcp_lib_show_endpoints "${@:2}"
> +		;;
> +	"change")
> +		mptcp_lib_change_endpoint "${@:2}"
> +		;;
> +	*)
> +		;;
> +	esac
> +}

I'm not sure to see the advantage of using mptcp_lib_endpoint_ops(), why
not directly calling mptcp_lib_pm_nl_limits, etc.?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

