Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D08310E6
	for <mptcp@lists.linux.dev>; Tue, 20 Dec 2022 01:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671500401; x=1703036401;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QvvjzwXSpfzlfUCkFGNnznob/siYDlR2Yi31fqSqYRA=;
  b=kLGXplQlfqRsCthXrek73xHYlbmmpi8ntmBKaFuZmyZu9BGavDs3s8Xc
   VrK8vlgTlFRwZsgzWwIOKhk1fQd48O9ve9EFnLk0wCpIF97TT5hSy5Phi
   Iu0yDLMQZosu6NDezaGsTX3R9OeXgE4wC/w35lCGKNmNF7hTqaIqJeV6T
   F0z2zve6ON35Frt/YWQEEeZdr6jv/zTHCeD7CQYqCyzGUWFIYPJ3VbjRx
   xokv2Axz1wgT8agYlnsScwQWE0oxcWNTtrO7JjvScmMYC81x+M8J7Exaw
   4JyQnIxU7ZLVKq2a5l9XFdSG0UIvlQccPhxATLbLSuMAEoVJj9eCEaEhY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="299840131"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="299840131"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 17:40:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="681452546"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="681452546"
Received: from wootaekl-mobl1.amr.corp.intel.com ([10.212.220.86])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 17:40:00 -0800
Date: Mon, 19 Dec 2022 17:39:59 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v25 0/5] BPF redundant scheduler, part 2
In-Reply-To: <cover.1671107241.git.geliang.tang@suse.com>
Message-ID: <a94575d7-c444-c011-e49f-e538a61a0481@linux.intel.com>
References: <cover.1671107241.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 15 Dec 2022, Geliang Tang wrote:

> v25:
> - update calls to mptcp_subflow_set_scheduled(subflow, false) in
>  __mptcp_subflow_push_pending().
> - rebased on "tag: export/20221215T054923"
>

Thanks for all the work on this Geliang. I think it's ok to add this to 
the export branch for further testing, and any fixes/updates can be 
squashed if needed.

I do have feedback on one line to delete in patch 2 (see that reply). Not 
sure if Matthieu needs a squash-to patch for that or can update when 
applying.

Should this be applied after the bpf_rr patches, or earlier in the 
"features other trees" section of the export branch?

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


- Mat

> v24:
> - rename push to keep_pushing
> - check the scheduled bit on ssk first
> - drop delegate flag
> - depends on "mptcp: use msk_owned_by_me helper"
>
> v23:
> - patch 2 and 3: clear subflow->scheduled flag on the error paths.
>
> v22:
> - update patch 2 as Mat suggested.
> - patch 4 and 5 in v21 will send later.
>
> v21:
> - address Mat's comments in v20.
> - redundant sends on retransmit code path.
>
> v20:
> - rebased on "Squash to "mptcp: refactor push_pending logic" v19"
>
> v19:
> - patch 1, use 'continue' instead of 'goto again'.
>
> v18:
> - some cleanups
> - update commit logs.
>
> v17:
> - address to Mat's comments in v16
> - rebase to export/20221108T055508.
>
> v16:
> - keep last_snd and snd_burst in struct mptcp_sock.
> - drop "mptcp: register default scheduler".
> - drop "mptcp: add scheduler wrappers", move it into "mptcp: use
> get_send wrapper" and "mptcp: use get_retrans wrapper".
> - depends on 'v2, Revert "mptcp: add get_subflow wrappers" - fix
> divide error in mptcp_subflow_get_send'
>
> v15:
> 1: "refactor push pending" v10
> 2-11: "register default scheduler" v3
>  - move last_snd and snd_burst into struct mptcp_sched_ops
> 12-19: "BPF redundant scheduler" v15
>  - split "use get_send wrapper" into two patches
> - rebase to export/20221021T061837.
>
> v14:
> - add "mptcp: refactor push_pending logic" v10 as patch 1
> - drop update_first_pending in patch 4
> - drop update_already_sent in patch 5
>
> v13:
> - deponds on "refactor push pending" v9.
> - Simply 'goto out' after invoking mptcp_subflow_delegate in patch 1.
> - All selftests (mptcp_connect.sh, mptcp_join.sh and simult_flows.sh) passed.
>
> v12:
> - fix WARN_ON_ONCE(reuse_skb) and WARN_ON_ONCE(!msk->recovery) errors
>   in kernel logs.
>
> v11:
> - address to Mat's comments in v10.
> - rebase to export/20220908T063452
>
> v10:
> - send multiple dfrags in __mptcp_push_pending().
>
> v9:
> - drop the extra *err paramenter of mptcp_sched_get_send() as Florian
>   suggested.
>
> v8:
> - update __mptcp_push_pending(), send the same data on each subflow.
> - update __mptcp_retrans, track the max sent data.
> = add a new patch.
>
> v7:
> - drop redundant flag in v6
> - drop __mptcp_subflows_push_pending in v6
> - update redundant subflows support in __mptcp_push_pending
> - update redundant subflows support in __mptcp_retrans
>
> v6:
> - Add redundant flag for struct mptcp_sched_ops.
> - add a dedicated function __mptcp_subflows_push_pending() to deal with
>   redundat subflows push pending.
>
> v5:
> - address to Paolo's comment, keep the optimization to
> mptcp_subflow_get_send() for the non eBPF case.
> - merge mptcp_sched_get_send() and __mptcp_sched_get_send() in v4 into one.
> - depends on "cleanups for bpf sched selftests".
>
> v4:
> - small cleanups in patch 1, 2.
> - add TODO in patch 3.
> - rebase patch 5 on 'cleanups for bpf sched selftests'.
>
> v3:
> - use new API.
> - fix the link failure tests issue mentioned in ("https://patchwork.kernel.org/project/mptcp/cover/cover.1653033459.git.geliang.tang@suse.com/").
>
> v2:
> - add MPTCP_SUBFLOWS_MAX limit to avoid infinite loops when the
>   scheduler always sets call_again to true.
> - track the largest copied amount.
> - deal with __mptcp_subflow_push_pending() and the retransmit loop.
> - depends on "BPF round-robin scheduler" v14.
>
> v1:
>
> Implements the redundant BPF MPTCP scheduler, which sends all packets
> redundantly on all available subflows.
>
> Geliang Tang (5):
>  mptcp: add scheduler wrappers
>  mptcp: use get_send wrapper
>  mptcp: use get_retrans wrapper
>  selftests/bpf: Add bpf_red scheduler
>  selftests/bpf: Add bpf_red test
>
> net/mptcp/protocol.c                          | 187 +++++++++++-------
> net/mptcp/protocol.h                          |   4 +
> net/mptcp/sched.c                             |  69 +++++++
> .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++++
> .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 +++++
> 5 files changed, 264 insertions(+), 75 deletions(-)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
