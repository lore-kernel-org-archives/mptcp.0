Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F1384
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 01:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82DBC433C8;
	Wed, 13 Sep 2023 01:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694569063;
	bh=1I4qn/qkko9jx/h8RZTN+lT9Pwwk5d8Va+JQpIm6k2A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=nLRHQX75Ppx+mGDwvFimoFGlhVN4hOZiyKKNfSuTQ48tNoA+DBgdouKUFHa8XDFql
	 yDPcgs7UE7zFdqLWK1C905HGMouTH4K+OoLbgyCmM/Gfvlnq/nZtlsvw6eT4REMX41
	 1gg9b9rnLrjiPvlEzICddkh1RJIQLDRehH+GtYsB5OUWEFm+LF/6keu8Ry7eESyz1X
	 S7rW7FHMVlvWiKwznsDRGrVEWizcHX4ooJDkmMxFkOOihauu80wZu1ov+jO9URkiyP
	 tY9eoj7aV/hp97yeFLHcNexT1spqUx9KHeYuyOpzwzp8XkAfwuiFMXMJ5bqt1TlMPG
	 opgwfC/RhqZVw==
Date: Tue, 12 Sep 2023 18:37:42 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/9] BPF packet scheduler updates part 4
In-Reply-To: <cover.1693820153.git.geliang.tang@suse.com>
Message-ID: <d93a5e47-82be-c4d2-2ab9-d19aed82e0fb@kernel.org>
References: <cover.1693820153.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 4 Sep 2023, Geliang Tang wrote:

> v3:
> - store burst in msk->snd_burst instead of in sk_storage.
> - make mptcp_sched_data_set_contexts static.
> - rename mptcp_subflow_ctx_by_pos to bpf_mptcp_subflow_ctx_by_pos, and
>   add "__bpf_kfunc" before it.
>

Hi Geliang -

Apologies for the delay on reviewing these. The series looks good to 
squash, thanks!

- Mat


> v2:
> - keep sched API unchanged.
> - use bpf_sk_storage_lookup to get snd_burst from BPF context.
> - applied after "add bpf_stale scheduler v3" serise.
>
> v1:
>
> There's a bug in bpf_burst. snd_burst stored in mptcp_burst_storage in
> BPF context is not used. msk->snd_burst is still used in kernel space.
> To fix this, add two new interfaces in mptcp_sched_ops to get and set
> scheduler's paramters from BPF context to kernel space.
>
> Geliang Tang (9):
>  Squash to "bpf: Export more bpf_burst related functions"
>  Squash to "mptcp: add sched_data helpers"
>  Squash to "bpf: Add bpf_mptcp_sched_ops"
>  Squash to "selftests/bpf: Add mptcp sched structs"
>  Squash to "selftests/bpf: Add bpf_first scheduler"
>  Squash to "selftests/bpf: Add bpf_bkup scheduler"
>  Squash to "selftests/bpf: Add bpf_rr scheduler"
>  Squash to "selftests/bpf: Add bpf_red scheduler"
>  Squash to "selftests/bpf: Add bpf_burst scheduler"
>
> net/mptcp/bpf.c                               | 41 +++++++++++----
> net/mptcp/protocol.h                          |  6 +--
> net/mptcp/sched.c                             | 50 ++++++++-----------
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 +-
> .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  6 +--
> .../selftests/bpf/progs/mptcp_bpf_burst.c     | 30 ++---------
> .../selftests/bpf/progs/mptcp_bpf_first.c     |  3 +-
> .../selftests/bpf/progs/mptcp_bpf_red.c       |  6 +--
> .../selftests/bpf/progs/mptcp_bpf_rr.c        |  9 ++--
> 9 files changed, 70 insertions(+), 86 deletions(-)
>
> -- 
> 2.35.3
>
>
>
