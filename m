Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF51C8FAA
	for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728685653; cv=none; b=Yne88sytEu/mW6sWMPOPHPTEW6NQc5CeJlhCdyeXEx5LE7JUbgwTzm91wEo7FtF5WZVOJkVMoUS82TqElj5LqeXbycjvXjsS6ge3XR/x2QQKZYx3WvScCdoyjcRyfLAsvMgrplJegfRdPNB8o2L6EccuNz5BP3FXS9ztOQ5FUZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728685653; c=relaxed/simple;
	bh=vNV4X50SFfRrSzhpR4T+p2NYWPEI1YuCRluNlPKz/yI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZhoCf2QZfoLCpCwsnR+QhQQicSak7txzqolTZMAkNJhdxCc2O9MDYcGGWKc2mDHr1bZKLOQLPDi795mHHWAtrJfuof0PCaiae55kUp1owP5lGossjv0pcjPFqjoTZKaBfv6YmNcySD2mlK9k3kPcacvzldxO/C2ZRjw0PXUWKhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n11iyzJY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n11iyzJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5DDC4CEC3;
	Fri, 11 Oct 2024 22:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728685652;
	bh=vNV4X50SFfRrSzhpR4T+p2NYWPEI1YuCRluNlPKz/yI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=n11iyzJYbDJsblU/DSKCn8g1rUV7SsrVPjV87fx9PFNMwLlMGfXRLbCF4d48YXo+Y
	 z37A16UD3lwjwRfj9xdW89Q/DpZGu1Jig33xJL5vBmdSv9jqXvg7cz1W6MpmdX1Em3
	 QxQw7DIPhnsG0NFLXIPbfXn6i2FeKP241LFwextD0w1YAzTByX8EUDdJZIzjJeLXK0
	 h1PGj3DQYppnIP/TPUpFxdJY6OlRsH+2GnNLiUijJIsHL2XyuTlBWbZP3dXBRuNGDc
	 9iZ5yg/qLJFF7t1V2ArNSsed4GbojSCodaHfKmV+wWVyFUZdej9EcXp92V72i7PVN9
	 hwYFz7Bc+c8vw==
Date: Fri, 11 Oct 2024 15:27:31 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 0/7] add mptcp_subflow bpf_iter
In-Reply-To: <cover.1728466623.git.tanggeliang@kylinos.cn>
Message-ID: <6e9260a4-b83b-0916-e5f1-0834955e6f0f@kernel.org>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 9 Oct 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v9:
> - rename bpf prog to "mptcp_bpf_iters_subflow.c"
> - drop the helper bpf_mptcp_sk(), it's not used in this test.
>

Hi Geliang -

Series LGTM, thanks for all the updates.

Reviewed-by: Mat Martineau <martineau@kernel.org>

> v8:
> - Make the test prog in patch 4 more like a bpf packet scheduler.
> - Export more mptcp helpers into BPF in patch 1.
>
> v7:
> - As Martin recently replied, mptcp_stubflow bpf_iter can still be
> used in tracing. So go back to the tracing selftest.
>
> v6:
> - add KF_TRUSTED_ARGS flag in patch 2 (Andrii, Martin), then acquire
> and release helpers (patch 3) are needed to be implemented.
> - test mptcp_subflow bpf_iter in "cgroup/getsockopt" (patch 5),
> instead of testing them in "tracing" (Martin).
>
> v5:
> - update patch 1 as Andrii suggested: if msk is NULL, initialize
> kit->msk to NULL in _new() and check it in _next().
>
> v4:
> - squash patch 1/5 and 3/5 in v3 together as Matt suggested.
> - a new squash-to patch to drop mptcp_subflow_active declaration in
>   bpf_burst.
>
> v3:
> - drop bpf_iter__mptcp_subflow, __diag_push, __diag_pop and
> __diag_ignore_all
> - drop declarations for bpf kfuncs
>
> v2:
> - update patch 1 as Martin and Andrii suggested.
> - fix warnings and errors reported by MPTCP CI.
>
> This patch set adds a mptcp_subflow type bpf_iter, and self tests.
>
> Geliang Tang (7):
>  bpf: Register mptcp common kfunc set
>  bpf: Add mptcp_subflow bpf_iter
>  bpf: Add mptcp_sock acquire and release helpers
>  selftests/bpf: Add mptcp_subflow bpf_iter test prog
>  selftests/bpf: More endpoints for endpoint_init
>  Squash to "selftests/bpf: Add bpf scheduler test"
>  selftests/bpf: Add mptcp_subflow bpf_iter subtest
>
> net/mptcp/bpf.c                               |  95 ++++++++++++-
> .../testing/selftests/bpf/bpf_experimental.h  |   7 +
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 126 +++++++++++++++++-
> tools/testing/selftests/bpf/progs/mptcp_bpf.h |   9 ++
> .../bpf/progs/mptcp_bpf_iters_subflow.c       |  42 ++++++
> 5 files changed, 267 insertions(+), 12 deletions(-)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c
>
> -- 
> 2.43.0
>
>
>
