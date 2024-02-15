Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930A92F30
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037828; cv=none; b=qcVdVvCjU6cwWX0S9gm71+wUA4mm2+loXhbBjC8dMJjUOOa9mI7f2SNBWYeNEti2un/jTE6GWHL4mTWS+HTNiK7FgfRpUjiLrYRb2UVyQjsTimxq9Wrxs51ZWzNZHyyzmhh+zBIk9MP6nW5xB59QNV9BhJ9ZGuk8BX+X+Y+JKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037828; c=relaxed/simple;
	bh=NLnPhjwB5ginT3laTafaqcdEMxqCsbNpIzn3PCHu88c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nJ8/O43VEK1v+FBxf5Mwzn21GyL7Vev6RegqJtky10tKQE2+IUayLIzRjK2t8ntMXDJ8+kA3G/r+ONtRC9QzFLu/yPRGWtmLW0E+PKM4icSc/tTZX/6ChaA8Qth8T4n06yp5CdZqnFxIWDPTgu0tkPZFivIBpIopFdCr08O+BFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2eOvAOV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2eOvAOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1275EC433C7;
	Thu, 15 Feb 2024 22:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708037828;
	bh=NLnPhjwB5ginT3laTafaqcdEMxqCsbNpIzn3PCHu88c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=b2eOvAOVAnaVbbudqiPkUCKoG0uvkIxIhqlwL7lJpAVyATyqsArFohbuJO1kbTteR
	 CyAWYV/nITLSuX1tQ44haJCGRwL99I1Avb0a3snMeLgoklmEbvRQJow/7D1S6hqPaz
	 2Nmx4qzUs6Ar24x2PGiQ+AMDRBj+kFCHEcMZIxmm9Y6tJVIoxMGUDpsutBbDYxKY+T
	 azDcIM7tl2QGTcRkyG+K9tj0ajFYjHzQoEEYCCoeoKwSuVtVwcmzS/r+r5ctXJe4gj
	 B/uEEHglZfLem1atiAlqERGSNyLvEwVR3qbPrjC+Z4nzMe14VieKImV+bZ4qfgnBmn
	 2ANT1pAZxQkZg==
Date: Thu, 15 Feb 2024 14:57:07 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v12 10/15] selftests: mptcp: dump userspace
 addrs list
In-Reply-To: <2acb96d2ed25df7fce8bfc0241dc920678510542.1707910454.git.tanggeliang@kylinos.cn>
Message-ID: <3478f286-365b-1bb3-1f9f-9b6611888888@kernel.org>
References: <cover.1707910454.git.tanggeliang@kylinos.cn> <2acb96d2ed25df7fce8bfc0241dc920678510542.1707910454.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 14 Feb 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch adds two new tests for userspace pm dump address and subflow.
> Use userspace_pm_add_addr() and userspace_pm_add_sf() to add an address
> and a suflow.
>

Hi Geliang -

The kernel code looks good to me, but I realized the selftests need some 
changes.

In order to run the new tests with old kernels (without userspace dump 
address support), mptcp_lib_kallsyms_has checks are needed so the new 
functionality is skipped on old kernels (right Matthieu?).

Also, since our tests already take a long time to run, could the userspace 
dump addrs checks be integrated with an existing test like "userspace pm 
add & remove address"?

Thanks,
Mat


> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 44 +++++++++++++++++++
> 1 file changed, 44 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index dcb146c426dd..5f12bd1de383 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3585,6 +3585,50 @@ userspace_tests()
> 		kill_events_pids
> 		mptcp_lib_kill_wait $tests_pid
> 	fi
> +
> +	# userspace pm dump address
> +	if reset_with_events "userspace pm dump address" &&
> +	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> +		set_userspace_pm $ns1
> +		pm_nl_set_limits $ns2 1 1
> +		speed=5 \
> +			run_tests $ns1 $ns2 10.0.1.1 &
> +		local tests_pid=$!
> +		wait_mpj $ns1
> +		userspace_pm_add_addr $ns1 10.0.2.1 10
> +		chk_join_nr 1 1 1
> +		chk_add_nr 1 1
> +		chk_mptcp_info subflows 1 subflows 1
> +		chk_subflows_total 2 2
> +		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
> +		local dump="id 10 flags signal 10.0.2.1"
> +		check_output "userspace_pm_dump $ns1" \
> +			     "$dump" "      dump addrs signal"
> +		kill_events_pids
> +		wait $tests_pid
> +	fi
> +
> +	# userspace pm dump subflow
> +	if reset_with_events "userspace pm dump subflow" &&
> +	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> +		set_userspace_pm $ns2
> +		pm_nl_set_limits $ns1 0 1
> +		speed=5 \
> +			run_tests $ns1 $ns2 10.0.1.1 &
> +		local tests_pid=$!
> +		wait_mpj $ns2
> +		chk_mptcp_info subflows 0 subflows 0
> +		chk_subflows_total 1 1
> +		userspace_pm_add_sf $ns2 10.0.3.2 20
> +		chk_join_nr 1 1 1
> +		chk_mptcp_info subflows 1 subflows 1
> +		chk_subflows_total 2 2
> +		local dump="id 20 flags subflow 10.0.3.2"
> +		check_output "userspace_pm_dump $ns2" \
> +			     "$dump" "      dump addrs subflow"
> +		kill_events_pids
> +		wait $tests_pid
> +	fi
> }
>
> endpoint_tests()
> -- 
> 2.40.1
>
>
>
