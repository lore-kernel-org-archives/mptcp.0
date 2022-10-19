Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8CC7E
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 00:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666138597; x=1697674597;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I6RLfPId9/KFMZIPh7noefdeajlrHsKIVrsJ773JGyM=;
  b=lWRLlnyKl1RHSx85y0Xtee1PFZpMcPKZG3CYKLBT38F+IrVJTo526C4U
   iBHznX+gqP7PX0bcZxPLaTEadOvDRG2pBib9OV0d3KoGh8U5MNLjgBjuq
   Cjt7w4W+LGBww5zDO7LiTJshBFJ2dzvl8wTdeDxALKkCOo6X//Cl5f0QQ
   jdmh39z+LsE67mDDlv8xuYF+5n0fLCOCwJLY1A0zzck1hjyydTYOBTY1t
   4SEaoxI5eq4FLDFEJwVDZLbeu2/Z8hGXXo5wdAZBQotPUc3fvbmNEJ1Vk
   88hIatTCrj/U41jrb+YEJ74BwHrblj94yiFRH8leX6KE/MAMT3WdSMhvk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="307375658"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="307375658"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 17:16:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="606813836"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="606813836"
Received: from dprende1-mobl1.ger.corp.intel.com ([10.209.71.142])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 17:16:36 -0700
Date: Tue, 18 Oct 2022 17:16:28 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v9 0/4] refactor push pending
In-Reply-To: <20221018110312.22510-1-geliang.tang@suse.com>
Message-ID: <23006926-3427-35b4-242a-dac886f992e5@linux.intel.com>
References: <20221018110312.22510-1-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 18 Oct 2022, Geliang Tang wrote:

> v9:
> - move "register default scheduler" out of this series.
> - add missing "first = false" in patch 4
> - patch 2 could be merged before the commit "mptcp: add
> struct mptcp_sched_ops" as a non-bpf cleanup.
>

The first 3 patches look good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


I have some other comments for patch 4.


> v8:
> - merge "register default scheduler" into this series.
> - Move "multi-subflow scheduling" out of this series.
> - This series should be merged between the commit "mptcp: add get_subflow
> wrappers" and "bpf: Add bpf_mptcp_sched_ops", except the squash-to patches.
>
> v7:
> - update delegate sending in patch 10
> - rebase to export/20221011T063543.
>
> v6:
> - drop all msk->last_snd, add last_snd variable instead in patch 13
> - fix lock_sock issue in patch 3
> - merge squash-to patches
>
> v5:
> - address Mat's comments in v4.
>
> v4:
> - update __mptcp_subflow_push_pending as Mat suggested.
> - add more patches from "BPF redundant scheduler" series.
>
> v3:
> - add a cleanup patch.
> - remove msk->last_snd in mptcp_subflow_get_send().
> - add the loop that calls the scheduler again in __mptcp_push_pending().
>
> v2:
> - add snd_burst check in dfrags loop as Mat suggested.
>
> Refactor __mptcp_push_pending() and __mptcp_subflow_push_pending() to
> remove duplicate code and support redundant scheduler more easily in
> __mptcp_subflow_push_pending().
>
> Geliang Tang (4):
>  Squash to "mptcp: add get_subflow wrappers"
>  mptcp: use msk instead of mptcp_sk
>  mptcp: change 'first' as a parameter
>  mptcp: refactor push_pending logic
>
> net/mptcp/protocol.c | 183 +++++++++++++++++++------------------------
> net/mptcp/protocol.h |   4 +-
> net/mptcp/sched.c    |  61 +++++++--------
> 3 files changed, 111 insertions(+), 137 deletions(-)
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
