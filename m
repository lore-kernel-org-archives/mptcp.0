Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F343A4F2E
	for <mptcp@lists.linux.dev>; Wed, 14 Jan 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409435; cv=none; b=lWaKyiMzuWFhwvtKG3yQVyxjMV0277K3/+hu6t9rbbWQYDsqy6JwbbLwWeKt4kA7rnuyatR9Mck80mHswo0jDKGOxvJrTJaULk2B5J6U09Xh6teVnYNxLzvwKJ+f2lT08ofFZOOaC1zS2q56XyzQfFWsiJJ/GTPsboNNqInkUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409435; c=relaxed/simple;
	bh=QwFTF6HDwzjZxzliMhMMK4ZWV5EvRcL6AjVFfxmzje0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qg32tJNB5oKk1GNfjYCeS6X0mhOhu8EmhkwdFB3grnZGCFRZJGmFsb8JS84gDL769/hhCV8gUqoqwu12PtP9pSXOk4b1uPkzPQMhEv+gUdkYOIqQMJ3sWhTa/+8qd9GuufX5r/QVxg6Sm5EyfLsWPVM9VYQ//vSI6O6mqmbMS+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVWfGr/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVWfGr/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7B2C4AF0B;
	Wed, 14 Jan 2026 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768409435;
	bh=QwFTF6HDwzjZxzliMhMMK4ZWV5EvRcL6AjVFfxmzje0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kVWfGr/tosZQS8vsqONSzCrQKE3DiM6n/y0PMnF8kX+k9Osjc4+v6GUQkgMTX2O6J
	 Uea7m/b0sPCS4QL19+BZ2/hY0kjffCCxvFvVcG2+0TJHh1YE3AYiV41K9ev0s1R0XW
	 KraevOaaG+Q8k/48G3cS2bRSBRBhXBp77VlVEpqcumygmTrJbO/pJ9IkioRu8NulF+
	 thuUmmNaKOiOfOtiGOjl14T/3PLCt7qACalF7x7mISYETFNbpLaO6UzpkaKA+iRdqU
	 gsPkpC6tqSLDq5DH3uwXWdMdbkGTd/i1MjZa9RZOQDufO21fa5YwRmkw8lroaxVHrm
	 8evMYas1ksGpA==
Date: Wed, 14 Jan 2026 08:50:34 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: join: fix local endp not
 being tracked
In-Reply-To: <20251222-sft-5-15-signal-race-test-v1-1-a9b67c49af15@kernel.org>
Message-ID: <d75df364-38c3-b9b3-b978-dcba2b9fb96b@kernel.org>
References: <20251222-sft-5-15-signal-race-test-v1-1-a9b67c49af15@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 Dec 2025, Matthieu Baerts (NGI0) wrote:

> When running this mptcp_join.sh selftest on older kernel versions not
> supporting local endpoints tracking, this test fails because 3 MP_JOIN
> ACKs have been received, while only 2 were expected.
>
> It is not clear why only 2 MP_JOIN ACKs were expected on old kernel
> versions, while 3 MP_JOIN SYN and SYN+ACK were expected. When testing on
> the v5.15.197 kernel, 3 MP_JOIN ACKs are seen, which is also what is
> expected in the selftests included in this kernel version, see commit
> f4480eaad489 ("selftests: mptcp: add missing join check").
>
> Switch the expected MP_JOIN ACKs to 3. While at it, move this
> chk_join_nr helper out of the special condition for older kernel
> versions as it is now the same as with more recent ones. Also, invert
> the condition to be more logical: what's expected on newer kernel
> versions having such helper first.
>
> Fixes: d4c81bbb8600 ("selftests: mptcp: join: support local endpoint being tracked or not")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me, thanks Matthieu.

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index b2e6e548f796..f1a0d812e642 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2329,17 +2329,16 @@ signal_address_tests()
> 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
> 		speed=slow \
> 			run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr 3 3 3
>
> 		# It is not directly linked to the commit introducing this
> 		# symbol but for the parent one which is linked anyway.
> -		if ! mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
> -			chk_join_nr 3 3 2
> -			chk_add_nr 4 4
> -		else
> -			chk_join_nr 3 3 3
> +		if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
> 			# the server will not signal the address terminating
> 			# the MPC subflow
> 			chk_add_nr 3 3
> +		else
> +			chk_add_nr 4 4
> 		fi
> 	fi
> }
>
> ---
> base-commit: fab1280894b693ae0b9bb08f21f74852f112db79
> change-id: 20251222-sft-5-15-signal-race-test-ec18c70d295a
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
