Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE427E
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 00:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665101820; x=1696637820;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TGVkSKQOYcRQhUAaWwf3xpWhvFnT5V+/0FTxbx09+ok=;
  b=ccawfnx+KuYh7e79D7pViq5CAKxM7jQfICNI5rSNgNPbYT6f2JUVd4tV
   2wzmGCC2Bf1g7oeOy2qO6rchxvc7aA/PVUIry5RhELXGQCXLX58F8/hdt
   If8cuEH2Kdb0XS5/xPUkfkGLNXFiRJwwY/miGpBfODGZhscFJGU2RWAJJ
   9FUS6kY1Izw3S2e1/hKdQMvQ9Z3Og4QtVblPkhk6RjP0k+f/YOhD40q/h
   fsXb8FfvZDl+uhutYCxX0fJu8DzxMjzBVlGgpuDg3yOhJkCsgVS5pfW6u
   MonrYR0ijGtlU9zkW2bhIwJM15lz2j/p8pE+a/pg8spciQl5VsHBQvKqG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="367738466"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="367738466"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 17:16:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="624934508"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="624934508"
Received: from morristo-mobl.amr.corp.intel.com ([10.209.50.167])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 17:16:55 -0700
Date: Thu, 6 Oct 2022 17:16:55 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 00/11] refactor push pending
In-Reply-To: <cover.1665058388.git.geliang.tang@suse.com>
Message-ID: <86e6c9a8-4361-ec40-56ee-98c270d8342a@linux.intel.com>
References: <cover.1665058388.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 6 Oct 2022, Geliang Tang wrote:

> v5:
> - address Mat's comments in v4.

Hi Geliang -

Thanks for the v5. I haven't finished looking over all the patches in 
detail yet, but two things I do want to reply to right now:

  * Thanks for explaining in patch 4 that last_snd is still useful for 
round robin. I had forgotten about that, and it looked like a "write-only" 
variable in the kernel code.

  * In the meeting today Paolo suggested that a good test for the new 
scheduler loop would be to modify simult_flows.sh to use much larger 
files, then see if the modified code slowed down any of the simult_flows 
tests.

He suggested making the test file 10x larger in simult_flows.sh:

-	size=$((2 * 2048 * 4096))
+	size=$((2 * 2048 * 4096 * 10))

Can you compare the test times between the export branch and this series, 
with both of them using the larger file size?


Thanks,

Mat


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
> Geliang Tang (11):
>  Squash to "mptcp: add get_subflow wrappers"
>  mptcp: 'first' argument for subflow_push_pending
>  mptcp: refactor push_pending logic
>  mptcp: drop last_snd for burst scheduler
>  mptcp: simplify push_pending
>  mptcp: multi subflows push_pending
>  mptcp: use msk instead of mptcp_sk
>  mptcp: refactor subflow_push_pending logic
>  mptcp: simplify subflow_push_pending
>  mptcp: multi subflows subflow_push_pending
>  mptcp: multi subflows retrans support
>
> net/mptcp/pm.c         |   9 +-
> net/mptcp/pm_netlink.c |   3 -
> net/mptcp/protocol.c   | 285 ++++++++++++++++++++++-------------------
> net/mptcp/protocol.h   |   5 +-
> net/mptcp/sched.c      |  61 +++++----
> 5 files changed, 184 insertions(+), 179 deletions(-)
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
