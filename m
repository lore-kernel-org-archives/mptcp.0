Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A715FA81
	for <mptcp@lists.linux.dev>; Wed, 24 Apr 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973048; cv=none; b=t7iZn9awzVV+uLh/3i4dNIdCrKK7w8DTovdv1FG12p0btE2uQ7Ye0m6dw3PNWyVCDgTrWKgzX9MwIE7+8TwobwDPTmdCK0vTxBr190mB5wKr8azEmALW6x2DL1PwxVpvoQYUeqKSO2nZOXbFwXm+EYw8GdYX2drqU+dC+Fv+i0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973048; c=relaxed/simple;
	bh=NFmtx4wZ/tolTbSdZNn54SQXBn25sOnxMUzcJ7jKnCw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c1SeHOGTDOD88cl85LvE+d1Px26DthqdDg5fDJ9fHCNMgry8j6lcqwY7L12JkzT5dwIPnhU8hzhnn9rIs1vp1UyYrGwvepq+Az5NgxqE4VrXxCZ2iNC+3AZja1OjB6corCgkD7zKRy91W2eTnbUzAkCIB+2cf00k6DSnO7VUMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGRhsDit; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGRhsDit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE77C113CD;
	Wed, 24 Apr 2024 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713973048;
	bh=NFmtx4wZ/tolTbSdZNn54SQXBn25sOnxMUzcJ7jKnCw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XGRhsDit9AF5T/sB/7Tf6jT/AaATR+nrx402iV2phW+22sc83TI79Qw7h/j4Cm1wv
	 7BYuXpymxj2gLny7Se/ZSUB0p60Onlgk2dlMjOxMPXkdTk/7u0mku33EtetqhbPNYU
	 wpvrRuaaMTLHwq1+QdMgqQm0YVUZjMvKVHbiWbSsDUJantApqmQ3fNnV5OP1r1vlt7
	 KViVx1oWVcBSQokug4UdIWMhXiuUPbpN+QI2TH+9j2quWv7MkuoAXPcqxodDqWJfCu
	 HAtxFKcVNSpHe1e3Ch7y7of9rUGaBTQQC7ACaWz69sRh7wWD7uwFb8N+qMFoR01xhJ
	 V3rJyXP/EgTYA==
Date: Wed, 24 Apr 2024 08:37:27 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 0/4] setsockopt per subflow: BPF
In-Reply-To: <cover.1713920939.git.tanggeliang@kylinos.cn>
Message-ID: <cd56b984-64ee-526d-9b4a-f1b181958349@kernel.org>
References: <cover.1713920939.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 24 Apr 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v9:
> - validate the return value of snprintf in patch 2 as Mat suggested.
> - patch 2 depends on "selftests/bpf: Add RUN_MPTCP_TEST macro", so this
>   series could be merged in this order:
>   1 selftests/bpf: Add mptcp subflow example
>   2 selftests/bpf: Add RUN_MPTCP_TEST macro
>   3 selftests/bpf: Add mptcp subflow subtest
>   4 selftests/bpf: Handle SIGINT when creating netns

Hi Geliang -

v9 looks good to me, thanks!

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> v8:
> - update the git metadata to add Nicolas as the git "Author" and add a
>   "Co-authored-by" tag with my name in patch 1 as Mat suggested in v7.
> - use send_byte in patch 2 instead of send_recv_data, to make this
>   series independent of the commit "selftests/bpf: Export send_recv_data
>   helper", which is in bpf-next, but not in mptcp_net-next at this moment.
>
> v7:
> - address Mat's comments in v6 (thanks): drop MPTCP_BASE_TEST and rebased.
> - depends on:
> "refactor mptcp bpf tests" v7
> "export send_byte and send_recv_data" v2
>
> v6:
> - Deponds on "[bpf-next] export send_byte and send_recv_data" series.
>
> v5:
> - #1-#7 Address #76: add new macros MPTCP_BASE_TEST and RUN_MPTCP_TEST.
> - #8-#14 add MPTCP_SCHED_TEST macro.
>
> v4:
> - #1-#5 Address #76: add a new macro RUN_MPTCP_TEST.
> - #6-#11 Cleanups: add send_data_and_verify and SCHED_TEST.
>
> v3:
> - deal with EAGAIN.
> - add _ss_search helper.
>
> v2:
> - fix checkpatch warnings.
> - cleanups.
>
> Geliang Tang (3):
>  selftests/bpf: Add mptcp subflow subtest
>  selftests/bpf: Handle SIGINT when creating netns
>  Squash to "selftests/bpf: Add bpf scheduler test"
>
> Nicolas Rybowski (1):
>  selftests/bpf: Add mptcp subflow example
>
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 143 +++++++++++++++---
> .../selftests/bpf/progs/mptcp_subflow.c       |  70 +++++++++
> 2 files changed, 195 insertions(+), 18 deletions(-)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c
>
> -- 
> 2.40.1
>
>
>
