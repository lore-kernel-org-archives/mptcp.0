Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12DAD53
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 23:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3F4C433C7;
	Fri,  1 Sep 2023 23:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693609238;
	bh=d7NpIG+j9+xlEENlogo22hvP2Hc0TtQG3CCBVbZvp2c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=GFbzVs7RtbXGW9QSZZpVN68obCsFjVyQgTs4FeADL3fX1aWStuMrRI8NmG3X+2NPc
	 O4Q4Nt0Exxufb6x4WD+054TRaSPolx9nuvrCXRJ9xp4FJ0Et67t6hNNPSWbk836UZD
	 M9H5R/T0JJpg4lP7IINH/bVrV9R3249rep81QIDNowawIlwjZuLFuoFlzp/Ff+6FYt
	 sIXJkD64ENxCF5/EH/47eNCykVZMck5hyu/Z0/56G0Hmd5wtPxbQmmNfKJ7Z6avvAI
	 wfqXHoDFX5pIWGiXSQhJwzNhyXQKVbtDlHVEoU3xvd0EdnW1z2shP0Gp/um060Dt9d
	 ZggG01RQu3s7w==
Date: Fri, 1 Sep 2023 16:00:37 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/5] add bpf_stale scheduler
In-Reply-To: <cover.1692344463.git.geliang.tang@suse.com>
Message-ID: <b8475d7f-24cf-4518-255f-4d9d5405ba1a@kernel.org>
References: <cover.1692344463.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 18 Aug 2023, Geliang Tang wrote:

> v3:
> - init sk_storage in .init, delete it in .release.
> We invoke bpf_sk_storage_get() to get the sk_storage map many times. Only
> the first call is the slow path (see bpf_local_storage_lookup in
> kernel/bpf/bpf_local_storage.c), alloc the map and cache it. The
> subsequent calls are all in fast path, the cache hits. So we should
> first call bpf_sk_storage_get in .init, then call it many times in
> .get_subflow.
> - if no subflow is scheduled, it should return '-1' to indicate an error.

Thanks Geliang, patches 1-3 are ok to squash.

For 4-5, see my reply to patch 4.


- Mat


>
> v2:
> - store subflow ids instead of storing subflow pointers in sk_storage.
>
> v1:
> - This patchset adds the new bpf_stale scheduler. Use sk_storage to save
> the stale map instead of using subflow->stale flag to manage it.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/349
>
> Geliang Tang (5):
>  Squash to "selftests/bpf: Add bpf_bkup scheduler"
>  Squash to "selftests/bpf: Add bpf_rr scheduler"
>  Squash to "selftests/bpf: Add bpf_burst scheduler"
>  selftests/bpf: Add bpf_stale scheduler
>  selftests/bpf: Add bpf_stale test
>
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |   1 +
> .../testing/selftests/bpf/prog_tests/mptcp.c  |  38 +++++
> .../selftests/bpf/progs/mptcp_bpf_bkup.c      |   4 +-
> .../selftests/bpf/progs/mptcp_bpf_burst.c     |   2 +
> .../selftests/bpf/progs/mptcp_bpf_rr.c        |   2 +
> .../selftests/bpf/progs/mptcp_bpf_stale.c     | 152 ++++++++++++++++++
> 6 files changed, 198 insertions(+), 1 deletion(-)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
>
> -- 
> 2.35.3
>
>
>
