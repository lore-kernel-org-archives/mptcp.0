Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D933CC
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 22:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665527555; x=1697063555;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nwA1k67atEQqv6tnfklBsyLrcDLX8Z5rpIXcUJSN6Bk=;
  b=DhRIA7UdPt+N2+aIe5/cDMNAkQjUUIeaTJq5VU8QMZFPgtAsfw1T8B/4
   RnuCvlC/aA0NV++v16BoLtRlM9tNV97JyebPdEkztTmw76SxiXat+xmxy
   8o698KThvhawrRQoGrabbihvDih1QndMvQvnKhhQlPUub+i2npYpxzgnF
   H8F+CWiMtjnoeieitQZ5YoXFoQlLvdk2GiPfJE2oH9WbvZKHVSOHFzCZC
   yLgQjmhabEycd3aYjg7DMCKXIgIwac/VX7NIaGDy68r5ennPeiv1pWeH8
   yLe+FTcPWdgT6/lPUQdaUJ+1eSixZ2/PBFxaQ8OqolcA9q4CSEwaK4aT5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="291962720"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="291962720"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 15:32:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="768973764"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="768973764"
Received: from sgzinzer-mobl.amr.corp.intel.com (HELO klee13-mobl1.amr.corp.intel.com) ([10.212.187.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 15:32:35 -0700
Date: Tue, 11 Oct 2022 15:32:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 00/10] register default scheduler
In-Reply-To: <cover.1665154582.git.geliang.tang@suse.com>
Message-ID: <0d086d85-29c6-a903-344b-6ab6ae0c62a0@linux.intel.com>
References: <cover.1665154582.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 7 Oct 2022, Geliang Tang wrote:

> Register the burst scheduler as the default one.
>
> - depends on "refactor push pending" v5
>

Hi Geliang -

I couldn't get these to apply on v5 or v6 of the other series, I also 
tried using older export tags. But I think there are some issues to work 
on with "refactor push pending", so it might be best to get that series 
settled before rebasing and reposting this.

- Mat

> Geliang Tang (10):
>  Squash to "mptcp: add struct mptcp_sched_ops"
>  Squash to "mptcp: add get_subflow wrappers" II
>  mptcp: add mptcp_sched_data_set_contexts helper
>  mptcp: add mptcp_sched_data argument
>  mptcp: register default scheduler
>  Squash to "bpf: Add bpf_mptcp_sched_ops"
>  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
>  Squash to "selftests/bpf: Add bpf_first scheduler"
>  Squash to "selftests/bpf: Add bpf_bkup scheduler"
>  Squash to "selftests/bpf: Add bpf_rr scheduler"
>
> include/net/mptcp.h                           |  7 +-
> net/mptcp/bpf.c                               |  1 +
> net/mptcp/protocol.c                          | 33 ++++---
> net/mptcp/protocol.h                          | 13 ++-
> net/mptcp/sched.c                             | 91 ++++++++++---------
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  9 +-
> .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 10 +-
> .../selftests/bpf/progs/mptcp_bpf_first.c     | 10 +-
> .../selftests/bpf/progs/mptcp_bpf_rr.c        | 10 +-
> 9 files changed, 116 insertions(+), 68 deletions(-)
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
