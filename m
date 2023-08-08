Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390A4C6B
	for <mptcp@lists.linux.dev>; Tue,  8 Aug 2023 15:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60228C433C7;
	Tue,  8 Aug 2023 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691509289;
	bh=L0T4o3PZVLQWomMtthpszUNNxlCkDFLUGAor1U0RHL8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PbJXx/xw0d8Yqb+xXlxrv4a2UgVGKki69d6YeFRfvxTI11qpyS5FBy7l6Ld2cGdgn
	 aY+mbFdCOHDr3hWXZBgWwefrYuvBUFegbkX1X5/QIzMYkPT6P2OH0nM01k0M1+rbIj
	 FSkCKFJr2eMwr+2P8qVLk/OdGeSU20wVSMaA7LhK0sah0/UwUC2MX8HsWMvNOuH6eD
	 cR9U6bMTng2aTAT/NgaRemvA21Iq85kWiLeT0V6eC4ZNIF8It6EgagDQlWKmqkFr78
	 rd/YI+pG0kdA1nyK0qVHqz5DcA+8EYlzr4F4kMugCdNhsvX27g4PQv2wSKXE6B4tAy
	 ik+qKpA6/dlFg==
Date: Tue, 8 Aug 2023 08:41:28 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/6] BPF packet scheduler updates part 3
In-Reply-To: <cover.1691036765.git.geliang.tang@suse.com>
Message-ID: <7741b237-11eb-e2a1-fb41-7367e1466622@kernel.org>
References: <cover.1691036765.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 3 Aug 2023, Geliang Tang wrote:

> v3:
> - define tcp_rtx_and_write_queues_empty() and sk_stream_memory_free() in
> BPF context.

v3 looks good to squash, thanks Geliang.

- Mat

>
> v2:
> - use __always_inline instead of inline.
>
> Some cleanups.
>
> Geliang Tang (6):
>  Squash to "mptcp: add sched_data helpers"
>  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
>  Squash to "selftests/bpf: add two mptcp netns helpers"
>  Squash to "selftests/bpf: Add bpf_rr scheduler"
>  Squash to "bpf: Export more bpf_burst related functions"
>  Squash to "selftests/bpf: Add bpf_burst scheduler"
>
> net/mptcp/bpf.c                               | 19 ++++----
> net/mptcp/protocol.h                          |  6 ---
> net/mptcp/sched.c                             |  6 +++
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 +-
> .../testing/selftests/bpf/prog_tests/mptcp.c  |  1 -
> .../selftests/bpf/progs/mptcp_bpf_burst.c     | 43 +++++++++++++++----
> 6 files changed, 52 insertions(+), 26 deletions(-)
>
> -- 
> 2.35.3
>
>
>
