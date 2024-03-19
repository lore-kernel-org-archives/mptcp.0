Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACC1CD24
	for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867593; cv=none; b=jsRbeou5HTMWyr9oAV/nZvNUQfdpqSmHKmy3Qva15XlhQKf8IScEG7gPIGd+sEICaRY7jRXvNHGWDczEDN+Uycmbq/rij5xjWQnQxFn4MXvRbE6dsaJlQEF/OjJbfQAS/Ap908SvBNEgEUyfR7Z3HdIpSQR0KyTRCdnCpHFeFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867593; c=relaxed/simple;
	bh=vf1XWEjixrHtBkuy027CBhnYAA5HE9hHRFB5Tm6IWR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lrt1dwQPLfqUl8LhgAT9HRysBMXDr0YE5FBQPDdGh1NEP/rJdLNk0orFyk9EjkgTQeE/ANglf2kjo0CaViA2bKrVTT3d5kYf9/jYHp9dZx1dTGK3jw40kdZp/oVfKcXsYeD4tpuxZdAWEDOAD0in/s3AuClvS+BmGT6aHHySH9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTebx3LU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTebx3LU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40371C433F1;
	Tue, 19 Mar 2024 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710867593;
	bh=vf1XWEjixrHtBkuy027CBhnYAA5HE9hHRFB5Tm6IWR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BTebx3LUcjrKcLVAWJjiL+HshpZ8gOYJI2Ey/8ZzRSL6XxCBrCzuTbGbwRZo+1usy
	 aNESyg+mwrlLzDPtYpH+bCYABiXTdNkfACWPC0szGuPeN/2nQ6L8K1mBLaDM31JFAC
	 9JerXhoiHGj8Zrjip20RFBhoJdN9ri8mgAygWBfG7j1kjoxm1r1gKzrzU8uVUb5KuF
	 JathO13fGVd4meLYfOkIZrng5ScBaQbzAFDYFHwA+81G/NnF0CP1MlP1HtUXXf+sAm
	 EBx9Ff2iMLZ+Mfmx6FDLV5AEfeAERCr8hpY+YNfmYyEH3vVpN1TppZJwb0tf43Kpjj
	 g1ViTGe7/FOzg==
Message-ID: <b02edbef-2910-4e50-b9ea-f236f262d2dc@kernel.org>
Date: Tue, 19 Mar 2024 17:59:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 3/9] selftests: mptcp: add get_endpoint
 helper
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1710832493.git.tanggeliang@kylinos.cn>
 <95b2607b75ac0225a4bff3d863d786b7a0db999b.1710832493.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <95b2607b75ac0225a4bff3d863d786b7a0db999b.1710832493.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 19/03/2024 08:16, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The output formats of 'ip mptcp' commands are much different from that
> of 'pm_nl_ctl' commands. This patch adds a new helper format_endpoints()
> to format the outputs of 'ip mptcp' and 'pm_nl_ctl' with 'endpoints'
> arguments to hide these differences.
> 
> All endpoints are showed in show_endpoints(). Here add another helper
> named get_endpoint() to show a specofic endpoint identified by the given

s/specofic/specific

> address ID.
> 
> Usage:
> 	All endpoints - show_endpoints $ns
> 	One endpoint - get_endpoint $ns $id

It is a bit confusing, you didn't add 'show_endpoints', maybe you are
talking about 'pm_nl_show_endpoints' from mptcp_join.sh? But there is
nothing about mptcp_lib_pm_nl_format_endpoints().

> 
> Use these two helpers in mptcp_join.sh and pm_netlink.sh to replace all
> 'pm_nl_ctl get' commands and outputs of 'pm_nl_ctl dump/get'.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index ca01d949fad8..ceb8f272c69d 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -520,3 +520,37 @@ mptcp_lib_set_ip_mptcp() {
>  mptcp_lib_is_ip_mptcp() {
>  	[ "${MPTCP_LIB_IP_MPTCP}" = "1" ]
>  }
> +
> +# format: <id>,<ip>,<flags>,<dev>
> +mptcp_lib_pm_nl_format_endpoints() {
> +	local entry id ip flags dev port
> +
> +	for entry in "${@}"; do
> +		IFS=, read -r id ip flags dev port <<< "${entry}"
> +		if mptcp_lib_is_ip_mptcp; then
> +			echo -n "${ip}"
> +			[ -n "${port}" ] && echo -n " port ${port}"
> +			echo -n " id ${id}"
> +			[ -n "${flags}" ] && echo -n " ${flags}"
> +			[ -n "${dev}" ] && echo -n " dev ${dev}"
> +			echo " " # always a space at the end
> +		else
> +			echo -n "id ${id}"
> +			echo -n " flags ${flags//" "/","}"
> +			[ -n "${dev}" ] && echo -n " dev ${dev}"
> +			echo -n " ${ip}"
> +			[ -n "${port}" ] && echo " ${port}" || echo ""

detail: maybe easier to read with:

  [ -n "${port}" ] && echo -n " ${port}"
  echo

> +		fi
> +	done
> +}
> +
> +mptcp_lib_pm_nl_get_endpoint() {
> +	local ns=${1}
> +	local id=${2}
> +
> +	if mptcp_lib_is_ip_mptcp; then
> +		ip -n "${ns}" mptcp endpoint show id "${id}"
> +	else
> +		ip netns exec "${ns}" ./pm_nl_ctl get "${id}"
> +	fi
> +}
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

