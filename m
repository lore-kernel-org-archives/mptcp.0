Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C937D37163
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354620; cv=none; b=VmwpSRWkjxOP7fABlNg4ybmH82+XPT3Bqgdz5DPxgSgDynDQUF7E9zQMJZtfhsq6c5mcn4IICY8qiikL0aUxkpTdzHaPLACz7VQZa/Ot7aOG1QjuYMjIbCAS/7qKj6il83C7g0blIcqQzl2uGYbuSD01X9xWrBNtdhJERP6PGTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354620; c=relaxed/simple;
	bh=/ldbhHHRdXiFqENN5LAIQK8ZqPcTcoHD0ttUW4sl0GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gK5zhPvY95yxGxVvIQ5SV4h6GgbLZz4AKHaIyi8Uhwtp3JVDIG5vXkQp50SGmANSCWoIVMhvE3AnBq7kLBhjl9bm9VlR971tBAmF7vGa31miQLZuKoXEyFgWkLj6jBdpqGgkM9oFfJqeoc7rg+72+12qN5GvRj45VBVIo2KQXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHCvidUi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHCvidUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EDAC433F1;
	Mon, 19 Feb 2024 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708354620;
	bh=/ldbhHHRdXiFqENN5LAIQK8ZqPcTcoHD0ttUW4sl0GI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aHCvidUiQFkH6df2yLYmIMT3+r1b5zuNRpD3STBMg5EmgMUYIU1X6z/7G4TTHgOyy
	 x46LOgdUTDgxTBm55sH3oHNtObCXbAjdULOjuhyP8w9GUHoCzvE2Xf0FSgGFcEp0YV
	 l8IruzZiZxICOOxqwjzgPF+0cZSb37JAU9OU9fl0XYogJwN9HYBQTIgVi4YPwYa4N+
	 /rNCVapIWvLRrqHl7M4j/+lW4Nd7x0zoAueL7HrGZcBZQi7ERypd/JxWo8XKESfVt9
	 aPSZ1hqve60HfC1If08EQ56Ayg1rLJI3lDTF9yNM5fzhggIo/b4w3WbpbVmp8BKDXv
	 m16ITpKlX/SGA==
Message-ID: <5262a7ec-6ef6-4938-9924-e70b9bb023b8@kernel.org>
Date: Mon, 19 Feb 2024 15:56:59 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v13 14/14] selftests: mptcp: userspace pm get
 addr tests
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
 <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/02/2024 08:42, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a new helper userspace_pm_get_addr() in mptcp_join.sh.
> In it, parse the token value from the output of 'pm_nl_ctl events', then
> pass it to pm_nl_ctl get_addr command. Use this helper in userspace pm
> dump tests.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index fb9b3ee9fee0..a4d121f9e467 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3362,6 +3362,18 @@ userspace_pm_dump()
>  	ip netns exec $1 ./pm_nl_ctl dump token $tk
>  }
>  
> +# $1: ns ; $2: id
> +userspace_pm_get_addr()
> +{
> +	local evts=$evts_ns1
> +	local tk
> +
> +	[ "$1" == "$ns2" ] && evts=$evts_ns2
> +	tk=$(mptcp_lib_evts_get_info token "$evts")
> +
> +	ip netns exec $1 ./pm_nl_ctl get $2 token $tk
> +}
> +
>  check_output()
>  {
>  	local cmd="$1"
> @@ -3482,6 +3494,14 @@ userspace_tests()
>  				     $'id 10 flags signal 10.0.2.1\nid 20 flags signal 10.0.3.1' \
>  				     "      dump addrs signal"
>  		fi
> +		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_get_addr$"; then

Same as in patch 9/14: you need an 'else print_skip', and best to move
duplicated code to a new helper, called with:

userspace_pm_chk_get_addr "${ns1}" "10" "<expected>"

And in this helper, you would do something like:

  local ns="${1}"
  local id="${2}"
  local exp="${3}"

  print_check "get id ${id} addr"

  if mptcp_lib_kallsyms_has "mptcp_userspace_pm_get_addr$"; then
      check_output "userspace_pm_get_addr ${ns} ${id}" "${exp}"
  else
      print_skip
  fi

> +			check_output "userspace_pm_get_addr $ns1 10" \
> +				     "id 10 flags signal 10.0.2.1" \
> +				     "      get id 10 addr"
> +			check_output "userspace_pm_get_addr $ns1 20" \
> +				     "id 20 flags signal 10.0.3.1" \
> +				     "      get id 20 addr"
> +		fi
>  		userspace_pm_rm_addr $ns1 10
>  		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
>  		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
> @@ -3520,6 +3540,11 @@ userspace_tests()
>  				     "id 20 flags subflow 10.0.3.2" \
>  				     "      dump addrs subflow"
>  		fi
> +		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_get_addr$"; then
> +			check_output "userspace_pm_get_addr $ns2 20" \
> +				     "id 20 flags subflow 10.0.3.2" \
> +				     "      get id 20 addr"
> +		fi
>  		userspace_pm_rm_addr $ns2 20
>  		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
>  		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
