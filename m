Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67706A492
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 21:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668807769; x=1700343769;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VZwMJpHKlzwtM+KuTMZlod7brRKTOqoOe66k/sfcgc8=;
  b=ZjnUI2R6sgv39TCewvhx6XLIrBoP2u9jESqwpixxAQwLt4fGtom4v7fs
   hd9z+0mfFwDklVn23Wmjaqd1+UmOH93OOUoOAKho20wi+Kh+JJcZqs5r4
   isSFHenQwske8vBICts0uLUPFbT9oo6vNeLiTgvLXpqeyLWanm78LRTWC
   7U2DveK7if+u+snxLFOG/sZzAmmWMYn/thgokMc6eboW0KnKvH5DPF3Fv
   0BxXDlx6wJAg6RJklUvxYmauKnXIZwdOlht6Frc4fnKpqwhic84x2wVrc
   HC+g4F1tO6E7q0QaeZ5UuiaJ5/0qRuZdP23E7zAX/4GLIGLd6PsAd0y1k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="340085388"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="340085388"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 13:42:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="969421417"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="969421417"
Received: from kwells1-mobl1.amr.corp.intel.com ([10.212.140.181])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 13:42:48 -0800
Date: Fri, 18 Nov 2022 13:42:48 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v20 0/7] BPF redundant scheduler, part 2
In-Reply-To: <cover.1668598782.git.geliang.tang@suse.com>
Message-ID: <68561c02-7c8a-d460-1139-1822499af26e@linux.intel.com>
References: <cover.1668598782.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Nov 2022, Geliang Tang wrote:

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

I didn't notice this back in v16 - why has last_snd returned? At the end 
of the series, it still doesn't appear to do anything. Is it useful for 
some future feature?

- Mat

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
> Geliang Tang (7):
>  mptcp: add scheduler wrappers
>  mptcp: use get_send wrapper
>  mptcp: use get_retrans wrapper
>  mptcp: delay updating first_pending
>  mptcp: delay updating already_sent
>  selftests/bpf: Add bpf_red scheduler
>  selftests/bpf: Add bpf_red test
>
> net/mptcp/protocol.c                          | 242 ++++++++++++------
> net/mptcp/protocol.h                          |  18 +-
> net/mptcp/sched.c                             |  67 +++++
> .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 +++
> .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 ++++
> 5 files changed, 320 insertions(+), 86 deletions(-)
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
