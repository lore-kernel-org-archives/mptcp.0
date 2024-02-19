Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B292EB10
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354547; cv=none; b=iPa4+F3lqgSP7pdH3c7WZeVcdDe3NhGiJmBE/pJf6pIKHnzOuO1rJgTzyHNatkTP5nHtyjat5D6hqvOGLQHyv7tyVM2zKv/68hyaexzLTLP4o/aVvpDd07gm19szog5z1TAeXF/NsPx6S1W/ELgP/4o7TtWftVIgCY8KDVlMDeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354547; c=relaxed/simple;
	bh=u3iD1BhVpJSewLt/qfXdmYC/+BBEtfXNYRAXoV+fHY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8CU5V/EJ3iCmX4Wm8lpfZjYXpXWViYUoKgUdNTX1ajkBZzt4HEPB6rb1CkAqk+o0yUZZ6/6bVfroBrvfSrduFCPUqdf3qLMiCgfSDerMq3XHscFbruZXAF3YCffPvv+/lw2kDdhNXrYRJn+HPXPNuS0JvAOq4i5WF+s6kD/uSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Veh55i3J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Veh55i3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4151DC433C7;
	Mon, 19 Feb 2024 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708354547;
	bh=u3iD1BhVpJSewLt/qfXdmYC/+BBEtfXNYRAXoV+fHY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Veh55i3JZ7A+vEGqAYZBdE7QdDGVmKEaL89TaBHxatPDFdZ9S2axzL5rAX8Ztv23r
	 jFZNdZ+4Tv5kludXaIJN+ORx3hYTK3B6kPBLcnQNYz2pS2vVDHTRLN/DN1Bf8AcVNk
	 t6jMJ91GSOl88IuzYlffEU8jgJVsfaqykr2glweRE17kWYEsItagD7MuT5TDcQ9Rfm
	 /svJeszrSzIZ4UHMNCpMnXUUqc4LBG1cdBIc7oKSE5XWqV5/GpnaEqTb/NrNnghOAA
	 VuGLXRgHv7lLq1rSz/MgNpz0zE5OHcbOheOcgumiHhC+5i9oqO2+J3lVWbKa5jwrlH
	 1DdKhwdNEkf2Q==
Message-ID: <4d28e3bc-481a-43da-846c-318de40628fa@kernel.org>
Date: Mon, 19 Feb 2024 15:55:44 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v13 09/14] selftests: mptcp: dump userspace
 addrs list
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
 <2ec5777c29d4e6e005c015db60432ef4ba734ed0.1708069036.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2ec5777c29d4e6e005c015db60432ef4ba734ed0.1708069036.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 16/02/2024 08:42, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a new helper userspace_pm_dump() to dump addresses
> for the userspace PM. Use this helper to check whether an ID 0 subflow
> is listed in the output of dump command after creating an ID 0 subflow
> in "userspace pm create id 0 subflow" test. Dump userspace PM addresses
> list in "userspace pm add & remove address" test and in "userspace pm
> create destroy subflow" test.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 6f7e83f61707..fb9b3ee9fee0 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3350,6 +3350,18 @@ userspace_pm_rm_sf()
>  	wait_rm_sf $1 "${cnt}"
>  }
>  
> +# $1: ns
> +userspace_pm_dump()
> +{
> +	local evts=$evts_ns1
> +	local tk
> +
> +	[ "$1" == "$ns2" ] && evts=$evts_ns2
> +	tk=$(mptcp_lib_evts_get_info token "$evts")
> +
> +	ip netns exec $1 ./pm_nl_ctl dump token $tk
> +}
> +
>  check_output()
>  {
>  	local cmd="$1"
> @@ -3465,10 +3477,24 @@ userspace_tests()
>  		chk_mptcp_info subflows 2 subflows 2
>  		chk_subflows_total 3 3
>  		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
> +		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then

It is important to mark tests that are skipped, otherwise we might miss
an issue with the check skipping the tests.

In mptcp_join.sh, you can see 'mptcp_lib_kallsyms_has' is usually called
from a 'continue_if': it is useful to skip the whole subtest. But here,
we only want to skip one check of a subtest, not the whole subtest. We
should then simply add: 'else print_skip (...)'.

→ see below

> +			check_output "userspace_pm_dump $ns1" \
> +				     $'id 10 flags signal 10.0.2.1\nid 20 flags signal 10.0.3.1' \
> +				     "      dump addrs signal"
> +		fi

Maybe easier to move the kallsyms check + other stuff in a new helper,
not to repeat that 6 times? Here you would have just one line, something
like that:

  userspace_pm_chk_dump_addr "${ns1}" "<expected>" "signal"

And in this helper, you would do something like:

  local ns="${1}"
  local exp="${2}"
  local check="${3}"

  print_check "dump addrs ${check}"

  if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
      check_output "userspace_pm_dump ${ns}" "${exp}"
  else
      print_skip
  fi

WDYT?

Same below.

>  		userspace_pm_rm_addr $ns1 10
>  		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
> +		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
> +			check_output "userspace_pm_dump $ns1" \
> +				     "id 20 flags signal 10.0.3.1" \
> +				     "      dump addrs after rm_addr 10"
> +		fi
>  		userspace_pm_rm_addr $ns1 20
>  		userspace_pm_rm_sf $ns1 10.0.3.1 $SUB_ESTABLISHED
> +		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
> +			check_output "userspace_pm_dump $ns1" \
> +				     "" "      dump addrs after rm_addr 20"
> +		fi
>  		chk_rm_nr 2 2 invert
>  		chk_mptcp_info subflows 0 subflows 0
>  		chk_subflows_total 1 1
> @@ -3489,8 +3515,18 @@ userspace_tests()
>  		chk_join_nr 1 1 1
>  		chk_mptcp_info subflows 1 subflows 1
>  		chk_subflows_total 2 2
> +		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
> +			check_output "userspace_pm_dump $ns2" \
> +				     "id 20 flags subflow 10.0.3.2" \
> +				     "      dump addrs subflow"
> +		fi
>  		userspace_pm_rm_addr $ns2 20
>  		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
> +		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
> +			check_output "userspace_pm_dump $ns2" \
> +				     "" \
> +				     "      dump addrs after rm_addr 20"
> +		fi
>  		chk_rm_nr 1 1
>  		chk_mptcp_info subflows 0 subflows 0
>  		chk_subflows_total 1 1
> @@ -3510,6 +3546,11 @@ userspace_tests()
>  		chk_mptcp_info subflows 0 subflows 0
>  		chk_subflows_total 1 1
>  		userspace_pm_add_sf $ns2 10.0.3.2 0
> +		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
> +			check_output "userspace_pm_dump $ns2" \
> +				     "id 0 flags subflow 10.0.3.2" \
> +				     "      dump addrs id 0 subflow"
> +		fi
>  		chk_join_nr 1 1 1
>  		chk_mptcp_info subflows 1 subflows 1
>  		chk_subflows_total 2 2

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
