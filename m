Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1244CB4A
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057332; cv=none; b=MW2G8DzKCxNlaksMW5bNggQbg9RAelCEKhfPiZbQjXAeT9rQ7Nwkwq0wWVLbkoxm/bziB6bvx4rIQBdR6Acj5f15AeXKKXdeEMFjomuel9i7u9anSRNM74O++upeHuEihmZqYQm7iL1YnfLm/67wbgEsjXPCRET1sTMgwhPnadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057332; c=relaxed/simple;
	bh=LDljFLmfQTei1caqiylzq9/gYIYFVwmDdxWMko1TaSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaE4oe5hFi8NuMR15rM8/4P3u1Kl02maQ2AZSKdat6b5K6WZ92OtfLZlCzhCOcV5sZ3YCZTzYNLFHFrbRLb7iXls8mbX3OkGsIMpILbiwq65w/5gQTo9UHOSjLYqARlmYkowZ1J+Zjes0jzI4GhdJpmK7sw3UvM3CmiUPFQdBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvMc4TPi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvMc4TPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7758AC433F1;
	Tue,  2 Apr 2024 11:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712057331;
	bh=LDljFLmfQTei1caqiylzq9/gYIYFVwmDdxWMko1TaSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GvMc4TPitCXzlqLhXRkyjCoD9Mr+RooXQGKKYlzr8aznjdWIx6S9mnSybxaDRoUFB
	 aGKTMviliqtfoi1M9oPR883y8wKuQWD1IIrSriZWTzlc0uBHRl7cD+f+nktASRqyfE
	 9APNAgGHT7jpDXUIOgOlGCzXVHxdNkQwno8wumYGisgs50XiQfytYW/ErKgH9ExjbP
	 JKhqbbXrT+tjEkhYLkwPq0CREmYIw5y0DB8q1SzYMJ2HcsDH09T8oSy0kRm3Dgm3Vs
	 2kv21oQLdS0IO/pgfbXR1VxLPz8VkTNVt+eSr3LxHIwKIipsT227mr8HAFUCIHrV7N
	 EalWEUgNgrsTA==
Message-ID: <4ae5e3df-27fe-4d07-9a5d-3299ef255348@kernel.org>
Date: Tue, 2 Apr 2024 13:28:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 2/2] selftests: mptcp: test last time
 mptcp_info
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1712049966.git.tanggeliang@kylinos.cn>
 <0e14deb5db6de99fcfd30673ddf54aa9a1191007.1712049966.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0e14deb5db6de99fcfd30673ddf54aa9a1191007.1712049966.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

I did a review of this patch before, but I didn't send it because I was
looking at the CI in parallel (see below). Later, I noticed your
squash-to patch (and the report from the CI). I think you fixed all the
issues I reported here below, except my suggestion about not using
'cnt1', 'cnt2', etc. but something more explicit. Do you mind looking at
that, please?

Also, do you mind sending a v5 instead? The CI will not pick-up the
squash-to patch.

Please note that the CI will now [1] use your IPRoute2 patch [2], so the
diag.sh test should no longer fail:

[1]
https://github.com/multipath-tcp/mptcp-upstream-virtme-docker/commit/fbf8f1a
[2] https://github.com/multipath-tcp/iproute2/commit/591f0654c

On 02/04/2024 11:28, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a new helper chk_msk_info() to show the counters in
> mptcp_info of the given info, and check that the timestamps move
> forward. Use it to show newly added last_data_sent, last_data_recv
> and last_ack_recv in mptcp_info in chk_last_time_info().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh | 48 +++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index bc97ab33a00e..3d60e6544e5f 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -200,6 +200,53 @@ chk_msk_cestab()
>  		 "${expected}" "${msg}" ""
>  }
>  
> +msk_info_get_value()
> +{
> +	local port="${1}"
> +	local info="${2}"
> +
> +	ss -N ${ns} -inHM dport ${port} | \
> +		mptcp_lib_get_info_value "${info}" "${info}"
> +}
> +
> +chk_msk_info()
> +{
> +	local port="${1}"
> +	local info="${2}"
> +	local cnt="${3}"
> +	local now=$(msk_info_get_value ${port} "${info}")
> +	local delta_ms=250
> +
> +	mptcp_lib_print_title "....chk ${info}"
> +	if { [ -z "${cnt}" ] || [ -z "${now}" ]; } &&
> +	   ! mptcp_lib_expect_all_features; then
> +		mptcp_lib_pr_skip "Feature probably not supported"
> +		mptcp_lib_result_skip "${info}"
> +	elif [ "$((cnt1 + ${delta_ms}))" -lt "${now}" ]; then

It should be 'cnt', not 'cnt1', and without ${} around delta_ms when
used inside '$((...))'. shellcheck should complain about that.

> +		mptcp_lib_pr_ok
> +		mptcp_lib_result_pass "${info}"
> +	else
> +		mptcp_lib_pr_fail "value of ${info} changed by $((now - cnt))ms," \
> +				  "expected at least ${delta_ms}ms"
> +		mptcp_lib_result_fail "${info}"
> +		ret=${KSFT_FAIL}
> +	fi
> +}
> +
> +chk_last_time_info()
> +{
> +	local port="${1}"
> +	local cnt1=$(msk_info_get_value ${port} "last_data_sent")
> +	local cnt2=$(msk_info_get_value ${port} "last_data_recv")
> +	local cnt3=$(msk_info_get_value ${port} "last_ack_recv")

I would recommend not using '<generic name>X', but something more readable:

  data_sent=$(...)
  data_recv=$(...)
  ack_recv=$(...)

Also, I guess shellcheck will complain here: double quotes around
"${port}", and declaring and assigning separately, no?

If you are not using them, there are shellcheck plugins for many text
editors [1], or you can use a git hook [1].

[1] https://github.com/koalaman/shellcheck#user-content-in-your-editor
[2] https://github.com/koalaman/shellcheck-precommit

> +
> +	sleep 0.5
> +
> +	chk_msk_info "${port}" "last_data_sent" "${cnt1}"
> +	chk_msk_info "${port}" "last_data_recv" "${cnt2}"
> +	chk_msk_info "${port}" "last_ack_recv" "${cnt3}"
> +}
> +
>  wait_connected()
>  {
>  	local listener_ns="${1}"
> @@ -233,6 +280,7 @@ echo "b" | \
>  				127.0.0.1 >/dev/null &
>  wait_connected $ns 10000
>  chk_msk_nr 2 "after MPC handshake "
> +chk_last_time_info 10000
>  chk_msk_remote_key_nr 2 "....chk remote_key"
>  chk_msk_fallback_nr 0 "....chk no fallback"
>  chk_msk_inuse 2

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

