Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165107C
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 00:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45C4C433C8;
	Fri, 28 Jul 2023 00:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690505622;
	bh=4zpNDCjn996RDfKdAVWXfPf6q0bbrNYvLmAImn/+gNU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kAZVduiJqAN/iPYoLuFPjROuSk00sWpQNGZMeyPjBINqzJ2Vu0H4Enj2zO24z9pgI
	 BABvDgoHaGsdcZQgKFp/kavAef/JuhEl/JCPGY9T8LSbzuO0icx5091d3EsW86EvoU
	 3aPXCqccQIUCWhbZgR38Xi945qfaPZm5i1YyrN7kxe35iHesWgYxDZUWFqreAb7G2L
	 qF8U/Yjnj/MXGekvHddoS36rsFRWmWF7dWy/EG/FLt7e3PVY+l+RYe/2n0J+07pjkR
	 QU1vcmYMFIw+IPL/wO1IujAo9EBzPoj0KVrIbTbMcZV4+Lj2tLwVcHlw4vwJi4fMx3
	 pp6O23QMBBMMg==
Date: Thu, 27 Jul 2023 17:53:42 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 00/13] BPF packet scheduler updates part
 2
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
Message-ID: <b8bc949e-c9b7-0a4e-7f61-5369efbce970@kernel.org>
References: <cover.1689650435.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 18 Jul 2023, Geliang Tang wrote:

> v2:
> - Init nr to -1 for bpf_bkup and bpf_stale.
> - Update has_bytes_sent() to make sure only one item showed in 'ss -it',
>  this needs to start server with PORT_1.
> - Rename to bpf_mptcp_subflow_memory_free() and
>  bpf_mptcp_subflow_queues_empty().
> - Simplify div_u64().
> - Move mptcp_subflow_set_stale() to kernel space. stale is a bit filed,
>  I haven't found a way to set a bit filed in BPF context yet, so set it
>  in kernel space.
> - Sync with new bpf_tcp_ca.c.
>
> Geliang Tang (13):


Thanks for the patches Geliang.

I think the first 7 patches are ok to squash on the export branch:

>  Squash to "bpf: Add bpf_mptcp_sched_ops"
>  Squash to "selftests/bpf: Add bpf scheduler test"
>  Squash to "selftests/bpf: Add bpf_first test"
>  Squash to "selftests/bpf: Add bpf_bkup scheduler"
>  Squash to "selftests/bpf: Add bpf_bkup test"
>  Squash to "selftests/bpf: Add bpf_rr test"
>  Squash to "selftests/bpf: Add bpf_red test"

I have questions for a few of the remaining patches, I will reply 
separately to those.

- Mat

>  mptcp: add subflow_set_stale helper
>  selftests/bpf: Add bpf_stale scheduler
>  selftests/bpf: Add bpf_stale test
>  bpf: Export more bpf_burst related functions
>  selftests/bpf: Add bpf_burst scheduler
>  selftests/bpf: Add bpf_burst test
>
> net/mptcp/bpf.c                               |  44 ++--
> net/mptcp/protocol.c                          |   4 +-
> net/mptcp/protocol.h                          |   6 +
> net/mptcp/sched.c                             |   6 +
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |   7 +-
> .../testing/selftests/bpf/prog_tests/mptcp.c  |  91 +++++++-
> .../selftests/bpf/progs/mptcp_bpf_bkup.c      |   5 +-
> .../selftests/bpf/progs/mptcp_bpf_burst.c     | 197 ++++++++++++++++++
> .../selftests/bpf/progs/mptcp_bpf_stale.c     |  63 ++++++
> 9 files changed, 384 insertions(+), 39 deletions(-)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
>
> -- 
> 2.35.3
>
>
>
