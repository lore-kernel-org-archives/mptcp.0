Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D086F171A5
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729571; cv=none; b=t7hfbYH5FeNaCks2x71kL+3GAza8eVqNCp6PFt5wsWJ6Y76ZWpFejJWpLqCyA+sKm+O9YoJgudN8mxIUwrEqO7FbZiXuzv+LM4OpW1+MfJtWXZ3K4cfWs7wr7P+4CUJnaU3iV9IQeMptIBnfzJSbmMIp983+BVYjuU/PmwdglG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729571; c=relaxed/simple;
	bh=JbSqVSX1nT7FJzW553WqwIx2Q/MJlGfFFz6nID4cCFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jztVbznilpCAjn3QMEBqQ17lrff7sJjdtdn7rwm7aFqTyC67XxvtsM97UjYZkkYxf5x8bXDGRX4DlPc7d+F5q2vR/xWde0goiX9H9lIB/upaghzPnoGkd88C4Uh9Jr1/x2To/TLaWWRSw8hSfPgULzRdlAFqnnBMe1oeVTE+OjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmWr7JV5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmWr7JV5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C29C433C7;
	Fri, 29 Mar 2024 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711729571;
	bh=JbSqVSX1nT7FJzW553WqwIx2Q/MJlGfFFz6nID4cCFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jmWr7JV5g2HLJjaQ6iUFK9TNH9CCgTCDvyCiqhoDEPoTAuoXa81nqhTYTVX7bvyn7
	 pzJS4zl7tofbQE3Z1dP6BOscivzj9u2kBXvnSIJiAjpQTEAQpIb/NWa9nGhq7XK3u3
	 QGxKlxir7xrA43MFFkqxJSzMvSyBMl7lljX1i5jVzitN7/7Xs5L/4rGCA9AKm+ujZ9
	 AXzqc6BtyOuyko3uYLafwfSWE6lxpqtA+aCBNcZNrgv9TnpcEDdTJamtYPYYGbFGaz
	 3ZJOetHz3qNIVTwnGEhYLa043IZ479vmDCGOd9n7NZOOP1zskomSrRCjnJA8sxD9oj
	 CHv48Ok8jIymg==
Message-ID: <0ce6427e-7f48-410e-8db5-444f3b49d74f@kernel.org>
Date: Fri, 29 Mar 2024 17:26:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add last time
 actions tests"
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <d177c05847edc56a2bbc56d904a18cee8011a1ef.1711713371.git.tanggeliang@kylinos.cn>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d177c05847edc56a2bbc56d904a18cee8011a1ef.1711713371.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 29/03/2024 12:56, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Update chk_msk_info with mptcp_lib_pr_fail.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 6e865f95f85e..aa1cdfb176db 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -211,12 +211,16 @@ chk_msk_info()
>  		cnt2=$(ss -N ${ns} -inmHM | mptcp_lib_get_info_value "$info" "$info")
>  		msg="....chk ${info:0:15}=$cnt1:$cnt2"
>  		mptcp_lib_print_title "${msg}"
> -		if [ "${cnt1}" -lt "${cnt2}" ]; then
> +		if [ -z "${cnt1}" ] || [ -z "${cnt2}" ]; then

Here, you should have:

  if { [ -z "${cnt1}" ] || [ -z "${cnt2}" ]; } &&
     ! mptcp_lib_expect_all_features; then

Because our CI should fail if the failure is not available [1].

I understand that it means the test will fail if we don't use IPRoute2
with your suggested patch, but that's normal: when applying this series,
we can modify the CI docker image to include this support this new feature.


[1] Because only our CI has SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES=1

> +			mptcp_lib_pr_skip "Feature probably not supported"
> +			mptcp_lib_result_skip "${msg}"
> +		elif [ "${cnt1}" -lt "${cnt2}" ]; then
>  			mptcp_lib_pr_ok
>  			mptcp_lib_result_pass "${msg}"
>  		else
> -			mptcp_lib_pr_skip
> -			mptcp_lib_result_skip "${msg}"
> +			mptcp_lib_pr_fail "expected $cnt1 < $cnt2"
> +			mptcp_lib_result_fail "${msg}"
> +			ret=${KSFT_FAIL}
>  		fi
>  	done
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

