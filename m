Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DE31171C
	for <mptcp@lists.linux.dev>; Wed, 22 May 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392309; cv=none; b=ui1KZDK1vS6apxMsXg9qoCRuGTDDNIsSh2g+NLbCDrQ3Govw9PdOlxGWi/6zl45wtC6gP14FQTqZVq6Qiy4v8COpP9xVeCIbBZW6WDSeIPt4m3PNCsKiZGKCmbkBD5yDLHvuQGoxyeINuhmv5WSN7zHOatuFQaYTEzSY/KdSdG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392309; c=relaxed/simple;
	bh=Lna21kl4FEl07sV3z2uHIOk/IcoVaH+QCnCH3BDI330=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CC70QA4jowFhRSYJXMXzPKTs+7aX/EEtcB/oq8qEseINU59VdxIvUfq32i/GEKbc0uN3hoMXyO1rStvQ2bYGstvJTW58Ld9JTAVzi7FtJgMTftLVUP644kGmRTeT9MwKzSsOyajnQNXFHEjPI6tJOEcOj+aKe0ERi5HSM+9Mv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO2r/hSI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO2r/hSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAA9C2BBFC;
	Wed, 22 May 2024 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716392309;
	bh=Lna21kl4FEl07sV3z2uHIOk/IcoVaH+QCnCH3BDI330=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XO2r/hSIuuCPiOj6XO2XFvPb0MbC+sFZjCPuy5c1OIiBq9xQdumewVoGmq69UDSM/
	 uxkRzAlsZ+5hRpIgamM8hfsOcwYbenFsTeEzyWHksRT/vDc5Xxv1MYZMhLpR5ca4iZ
	 udpLse4Ez62QpphSsgiiSs0ovkFmOjtoMSKODyfgMPbE1djKJFwCUpgesotlal5yrr
	 aAVAGGjIu18V1UP5RHv4cqGeCS+erKAHLsguJwOXLrMV/hWeXzgHLHp6lSuYhz2ur6
	 B8lXy61Q/v92zzjekehOr+nifEFoeCx5zMeu6aVF1q1hjRPNGXopLUuIQ2cy2WHX7R
	 xzdGf8mGkhFpQ==
Date: Wed, 22 May 2024 08:38:28 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v3 0/4] selftests: mptcp: mark unstable subtests
 as flaky
In-Reply-To: <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
Message-ID: <be731768-e8ce-2f05-0e49-21909e8cda19@kernel.org>
References: <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 22 May 2024, Matthieu Baerts (NGI0) wrote:

> Some subtests can be unstable, failing once every X runs. Fixing them
> can take time: there could be an issue in the kernel or in the subtest,
> and it is then important to do a proper analysis, not to hide real bugs.
>
> To avoid creating noises on the different CIs, some subtests have been
> marked as flaky. As a result, errors with these subtests (if any) are
> ignored.
>
> Note that the MPTCP CI will continue to track these flaky subtests. All
> these unstable subtests are also tracked by our bug tracker.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v3:
> - Patch 1/4:
>  - use SELFTESTS_MPTCP_LIB_OVERRIDE_FLAKY env var (Mat)
>  - clearly indicate 'flaky' in the output / TAP format
> - Target mptcp-net: these are "fixes" for the selftests. I don't think
>  we need to add Fixes tag, right?
> - Link to v2: https://lore.kernel.org/r/20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org
>

Thanks for the v3, this version LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> Changes in v2:
> - Patch 2/4: only mark "unbalanced bwidth" subtest as flaky (Paolo)
> - Link to v1: https://lore.kernel.org/r/20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org
>
> ---
> Matthieu Baerts (NGI0) (4):
>      selftests: mptcp: lib: support flaky subtests
>      selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky
>      selftests: mptcp: join: mark 'fastclose' tests as flaky
>      selftests: mptcp: join: mark 'fail' tests as flaky
>
> tools/testing/selftests/net/mptcp/mptcp_join.sh   | 10 +++++++-
> tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 30 +++++++++++++++++++++--
> tools/testing/selftests/net/mptcp/simult_flows.sh |  6 ++---
> 3 files changed, 40 insertions(+), 6 deletions(-)
> ---
> base-commit: d048726b432ccff9b4e3d8b0012a7328c5c7c2f6
> change-id: 20240520-selftests-mptcp-disable-flaky-380759d6503c
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
