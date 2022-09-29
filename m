Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AF67B
	for <mptcp@lists.linux.dev>; Thu, 29 Sep 2022 00:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664409959; x=1695945959;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GG8XTgC2/mc10XBa47uLfmyCvOCNs9xhO8FvsCuTwmY=;
  b=nB8/ahAJWPfjqHhvE6qgENNQYnhPp8bMr9GBI9x8+TjpTEV/ORsWw6gP
   479cIARXvRVFjlYmV1FfkQ6oBIkjpSVHThHZPEIF0N6D+a6JOK6frMePF
   YWHTm1kqTp+7jkKGetHvxDVV/FAPsxcaR782ggjih1XI2Fo5/MtWwtWW9
   IE0c6bPeckQE+PYOTcvhuDM2CLXJNPGkTd8SSdiYa4c4WK7rXa5PubLrh
   2XmwjGrrbRHeIm3eJeIvk8MOIbsjsq5wi2HDVtfmLRHLMt1xwJJuWGuAn
   g54fAKu3xRhcsl3yHVYGn1JuLuQn25yJYJ+2cFSIoWVZbGgf//ThF/7A3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="288910738"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="288910738"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 17:05:58 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="684612818"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="684612818"
Received: from iban-mobl1.amr.corp.intel.com (HELO ncucuk-mobl2.amr.corp.intel.com) ([10.209.77.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 17:05:58 -0700
Date: Wed, 28 Sep 2022 17:05:57 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v12 0/5] BPF redundant scheduler
In-Reply-To: <cover.1664291273.git.geliang.tang@suse.com>
Message-ID: <d72b5b99-bc97-05eb-aea2-549d11aa47b8@linux.intel.com>
References: <cover.1664291273.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 27 Sep 2022, Geliang Tang wrote:

> v12:
> - fix WARN_ON_ONCE(reuse_skb) and WARN_ON_ONCE(!msk->recovery) errors
>   in kernel logs.
>

Hi Geliang -

Sorry I didn't see your v11 comment last week.

I was partway through a review of the scheduler loops in this series 
yesterday, but it made sense to focus on the "refactor push pending" 
patches today. I'm going to mark this v12 series as "superseded" in 
patchwork while we continue discussing "refactor push pending".


Thanks,
Mat



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
>  Squash to "mptcp: add get_subflow wrappers"
>  mptcp: redundant subflows push pending
>  mptcp: redundant subflows retrans support
>  selftests/bpf: Add bpf_red scheduler
>  selftests/bpf: Add bpf_red test
>
> net/mptcp/protocol.c                          | 190 +++++++++++-------
> net/mptcp/protocol.h                          |  13 +-
> net/mptcp/sched.c                             |  59 +++---
> .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++++
> .../selftests/bpf/progs/mptcp_bpf_red.c       |  36 ++++
> 5 files changed, 231 insertions(+), 101 deletions(-)
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
