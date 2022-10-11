Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C02D15AC
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 01:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665450070; x=1696986070;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eRIugIPe/Pom2/1oB/3LQVg/wdhIgDnH22uh4U4+mPE=;
  b=SaX6R2lqpl8B1ECp9JlFDem1D1ic3iOTm+2G5a72ssTmXtPgIM0+8KJ7
   ICFI6y8ZrC1KPvnMdZRm+fq3PMDDqeATJC31wJzbTTxJ68AOXXnpa/wRN
   GVn2rhz0pyEAqnBKTOL4g7y9HklH7UK+WuqfT01Nw8uC5O68wpAeme2IO
   x7QvEV5P/vgXDisIuTVU7RjxD2m32z4ltJOoGj6dBvG0UkhpNELCJbpTu
   CEgOTTeNfDpWgfS4ElWRJlEyygYVmZ13+h8/gGDur+WcnxNRKDHnBz4Vy
   7eE4pIhVPlCIo4PSDpdbbiKZU9ewUdT0bRjVc5O9C1clCp8JYHvy111U9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="303112213"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="303112213"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 18:01:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="955137738"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="955137738"
Received: from pnle-mobl.amr.corp.intel.com ([10.212.235.19])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 18:01:09 -0700
Date: Mon, 10 Oct 2022 18:01:08 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 00/11] refactor push pending
In-Reply-To: <cover.1665058388.git.geliang.tang@suse.com>
Message-ID: <798c2189-afea-dd5a-c15c-20880aee8d3a@linux.intel.com>
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
>

Hi Geliang -

I do think these changes are getting closer to being good to merge, 
there's a remaining bisectability issue that I mention in patch 3 and the 
feedback on the squash-to patches to address.

- Mat

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
