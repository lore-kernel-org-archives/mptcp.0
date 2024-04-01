Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5634EB24
	for <mptcp@lists.linux.dev>; Mon,  1 Apr 2024 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995678; cv=none; b=JMAVdz+rszLjCUXpZdlzOFIwdL1Gyiuz7EVwXP1LQ/t3lrpWsR823M7rl3ceO/gdSNjETSGMfBkg63si0+lW8Zp9sABUlJSKKcF5lzEM9a54YGV1J5rzzEPLNE/lCYWTUsTKBOF0f3CSYQphiNHDozLThkOsEVQ6QtTY9gAdnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995678; c=relaxed/simple;
	bh=2FIk2uM7abebrPLMaBh36oSSNoPtiSMSnCSgpq3n648=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=etO5oGrhzMjo/PiaGO3o+Dh9Nu1mvNAy4tREQomn1OuSNQJv3c9/UYEZjnlGjwwIPLnLwIGavJ2RhlAGPuVO+04A1XyGcpj7wpFOyK2br+OXgfDULCvl4JjuctLiiFjQ0hbN0QldnyQjoF7SMb7dp5kyEFe43AkVNQpt4xPji3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUEKrk6A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUEKrk6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D6EC433C7;
	Mon,  1 Apr 2024 18:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711995677;
	bh=2FIk2uM7abebrPLMaBh36oSSNoPtiSMSnCSgpq3n648=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PUEKrk6AMBXs3BzSz10fCfAKRkAh1k15vd2rvc8ESfuQw0GxhLZ3Qn97F+mMlWHrd
	 FpVXnwjWDzZthAd288dqS/ViON6Hka0uY89csO9d9gDvQ5oLih1VPqS4cmp5VVGnGy
	 5cZgl/qmCQJj50jovmjY05ZEJkuTF34d2GeC9JUDI+UbEO6fYJfdpk31Gd3XBHPCBW
	 xk65BSYfxe71OfpN0AKWxgtccYEx1sgjOZOGwpYhYES8SQjWAd6Icztnk9Vz7Uam4i
	 0tuknRudOHSBuWUFCvbPNFnWnkkR0ndwy4saBoXgGnRS8May9gN8f+M46Mi4fSvhJf
	 Fgda4jA/3tL/w==
Date: Mon, 1 Apr 2024 11:21:16 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 3/3] selftests: mptcp: add last time actions
 tests
In-Reply-To: <b5a4e6d634ae8fd3e0710b02f57f0998a3da7df0.1711784619.git.tanggeliang@kylinos.cn>
Message-ID: <5b22266f-922f-cfa3-f006-656262aa0351@kernel.org>
References: <cover.1711784619.git.tanggeliang@kylinos.cn> <b5a4e6d634ae8fd3e0710b02f57f0998a3da7df0.1711784619.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 30 Mar 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch adds a new helper chk_msk_info() to show the counters in
> mptcp_info of the given infos, and check that the timestamps move
> forward. Use it to show newly added last_data_sent, last_data_recv
> and last_ack_recv in mptcp_info in diag.sh.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> tools/testing/selftests/net/mptcp/diag.sh | 29 +++++++++++++++++++++++
> 1 file changed, 29 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index bc97ab33a00e..2f9f734015b4 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -200,6 +200,34 @@ chk_msk_cestab()
> 		 "${expected}" "${msg}" ""
> }
>
> +chk_msk_info()
> +{
> +	local port="${1}"
> +	local info
> +
> +	for info in "${@:2}"; do
> +		local cnt1 cnt2 msg
> +
> +		cnt1=$(ss -N ${ns} -inHM dport ${port} | mptcp_lib_get_info_value "$info" "$info")
> +		sleep 0.5

Hi Geliang -

With the loop structured this way, it sleeps 3 times. You could collect 
the first timestamp for all three values (last_data_sent last_data_recv 
last_ack_recv), then sleep once, then get all 3 "after" timestamps.

(Unless Matthieu doesn't care about the extra test time :) )

> +		cnt2=$(ss -N ${ns} -inHM dport ${port} | mptcp_lib_get_info_value "$info" "$info")
> +		msg="....chk ${info}"
> +		mptcp_lib_print_title "${msg}"
> +		if { [ -z "${cnt1}" ] || [ -z "${cnt2}" ]; } &&
> +		   ! mptcp_lib_expect_all_features; then
> +			mptcp_lib_pr_skip "Feature probably not supported"
> +			mptcp_lib_result_skip "${msg}"
> +		elif [ "$((cnt1 + 500))" -lt "${cnt2}" ]; then

Using 500 here is likely to make this test flaky - Matthieu had suggested 
250ms as a way to make sure the value moved forward but would not be 
sensitive to small changes in packet timing.

Also please add a local "delta_ms" variable instead of the magic number 
500.

> +			mptcp_lib_pr_ok
> +			mptcp_lib_result_pass "${msg}"
> +		else
> +			mptcp_lib_pr_fail "expected $((cnt1 + 500)) < $cnt2"

Suggest rephrasing: "value of ${info} changed by $((cnt2 - cnt1))ms, 
expected at least ${delta_ms}ms"

- Mat

> +			mptcp_lib_result_fail "${msg}"
> +			ret=${KSFT_FAIL}
> +		fi
> +	done
> +}
> +
> wait_connected()
> {
> 	local listener_ns="${1}"
> @@ -233,6 +261,7 @@ echo "b" | \
> 				127.0.0.1 >/dev/null &
> wait_connected $ns 10000
> chk_msk_nr 2 "after MPC handshake "
> +chk_msk_info 10000 last_data_sent last_data_recv last_ack_recv
> chk_msk_remote_key_nr 2 "....chk remote_key"
> chk_msk_fallback_nr 0 "....chk no fallback"
> chk_msk_inuse 2
> -- 
> 2.40.1
>
>
>
