Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49814B815
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632066; cv=none; b=t/8bqmYh2L0lvoui2yTvWxQcZwup2JuMdWm0Q4CGi/bkT1jlZHe/TDQGnNIOvCM3JppRbIfwe9vOZ8owSHA5hY3EKZ5mHV+3PT+RJfI7RQJFZz4etozQ7hcfm/8esP1+vUqi6ohD0Ud/CQ9Ej6Wehm6lNRcSd9bzECSYbMQw2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632066; c=relaxed/simple;
	bh=BWE0y3yOYt/70LW5BEh+2XjNxOBo4sF68K/6g+iMRF0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IG5lFcdXCoNYBVit//b1fCOOGIuEUq8jw1CFJ2idHcfPjLCmPN/jgj6Rm217uPAvXhbHZKwq5xPX6pCQbZmE3aoUfsWsKzZ3VR6B1X8rPuhVwSjzLd3phvZECGxR71EE+Xl32JALRzTrelMjUAhrSj2vTOt0+pGTrtJPxJ2jDLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afzJYK0t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afzJYK0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E12C433F1;
	Thu, 22 Feb 2024 20:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708632065;
	bh=BWE0y3yOYt/70LW5BEh+2XjNxOBo4sF68K/6g+iMRF0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=afzJYK0tXE/ocNDcwVB57sDWa8rcLWG/PmMTnjCc1GAeVcJ9dgsPmbE4pinyRIQwp
	 MFByUeHkKpHVGXIAtQKli8Ix9EFrdeUnsI7DuxsGpwMi/b0H8oVOfudevZn5oM5ofj
	 0kj/8/fRLziL2kh39kjNK/yPO1jLbgcrT88hG7mFNbwXse9Zc6dfAehJhZdkHQeem0
	 otFupMJqh19AB5Z6fNOO4JGDo7hx6FzN8JoFhaD7bABZbkdO87uC8duMbv3cdOTz5+
	 zUna+WhIG3J32VCECPGgYzRWXJ0cTItoFYX3qoe7E4EKvQyy3KOIVuPIgGMOVDcvzT
	 HiN1Qr5r1h2qQ==
Date: Thu, 22 Feb 2024 12:01:04 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/6] selftests: mptcp: fix shellcheck
 warnings
In-Reply-To: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
Message-ID: <cc409b04-ccb8-b6d2-8e2e-1791a776af2c@kernel.org>
References: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 22 Feb 2024, Matthieu Baerts (NGI0) wrote:

> shellcheck recently helped to prevent issues. It is then good to fix the
> other harmless issues in order to spot "real" ones later.
>
> Note that 3 scripts were already compliant: mptcp_join.sh, mptcp_lib.sh,
> and userspace_pm.sh. mptcp_lib.sh was compliant from the beginning.
>
> The modifications are minor, mainly because SC2086 has been ignored:
> Double quote to prevent globbing and word splitting. This is
> recommended, but the current usage is correct and there is no need to do
> all these modifications to be compliant with this rule. New files, like
> mptcp-lib.sh, should not have that rule ideally. Ideally new code other
> existing files should use double quotes when needed.
>
> Once applied, I'm planning to add a check on the CI side to catch new
> issues, not to have to check that manually and report issues when
> applying patches, like I had to do a few times very recently.
>
> The last patch is not related to shellcheck, but I found this while
> looking at the scripts: in userspace_pm.sh, we launch 'pm_nl_ctl events'
> once, then kill it, then relaunch it using the same temp files.
>

Regarding your note in patch 6, I don't think it's a big enough issue to 
backport it.

> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (6):
>      selftests: mptcp: diag: fix shellcheck warnings
>      selftests: mptcp: connect: fix shellcheck warnings
>      selftests: mptcp: sockopt: fix shellcheck warnings
>      selftests: mptcp: pm netlink: fix shellcheck warnings
>      selftests: mptcp: simult flows: fix shellcheck warnings
>      selftests: userspace pm: avoid relaunching pm events
>
> tools/testing/selftests/net/mptcp/diag.sh          | 14 ++--
> tools/testing/selftests/net/mptcp/mptcp_connect.sh | 76 +++++++++++++---------
> tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 14 ++--
> tools/testing/selftests/net/mptcp/pm_netlink.sh    | 14 ++--
> tools/testing/selftests/net/mptcp/simult_flows.sh  | 10 ++-
> tools/testing/selftests/net/mptcp/userspace_pm.sh  | 29 ++++-----
> 6 files changed, 98 insertions(+), 59 deletions(-)
> ---
> base-commit: 482712b4b5fc44b30dcd54409cbab4ec7e405294
> change-id: 20240222-selftests-mptcp-shellcheck-80338a0300c5

Series LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>



