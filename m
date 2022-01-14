Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0F29CA
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 01:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642123678; x=1673659678;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tk/CxxW3DR+T1ktSv3G3kFTqK6ZFM5h3efyQUPPV9Uc=;
  b=XN2ueVdH39SPDouRpWg7xtx/gMgY+lyzh6RoRBRcd0SNWkMfZgHzzlTf
   TkJdEY6m+o49JzHvFvuLqkkcoU+kUV7+roljtipTJIJ3OimhqCG4U/GaY
   /5Ra7k/ARjf8RFprYHn/LbFeBL+XQodHTxY5/J/3cGc7ugLiLRvdci7O+
   4lV3Ri/DyXzKbYkeiOUp6gi9WzxTRpgNbGK9L28oC5mAlyaIYM3RGmOsJ
   HiozJU8cYxV+A6pI85DE0lNvRvuop+lg7Gos3b1cONqczS6yjEH8N4CPw
   i7nOWPlP//Mdci3t+0sesNHazGGnkIkeFSLEuzl6oAczvRxkChxeL8KPg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="241721355"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="241721355"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 17:27:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="491330591"
Received: from pialybar-mobl.amr.corp.intel.com ([10.212.252.249])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 17:27:57 -0800
Date: Thu, 13 Jan 2022 17:27:56 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 0/5] use 'ip mptcp' in selftests
In-Reply-To: <cover.1642086296.git.geliang.tang@suse.com>
Message-ID: <585f769d-c18a-b611-5925-5d1230b668ba@linux.intel.com>
References: <cover.1642085750.git.geliang.tang@suse.com> <cover.1642086296.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 13 Jan 2022, Geliang Tang wrote:

> v5:
> - init _port in patch 4, otherwise it will be a random number in some
>   tests.
> - depends on:
> the "set_flags port support" series.

Hi Geliang -

I appreciate that you were trying to make the patchset dependencies more 
obvious by threading this patch set under "set_flags port support". 
However, it seems like all the tools (patchew, b4, my email client's 
threading) didn't handle it well :)

I think it's better to keep the series separate and comment in the cover 
letters about the dependencies, or merge them in to one big series that 
patchew/b4/etc can understand.

Thanks!

Mat


>
> v4:
> - move the patch "new approach of getting addr" into "set_flags port
> support" series.
> - rebased with "set_flags port support" series.
>
> RESEND:
> - update subjects and commit messages.
> - rename pm_nl_show_endpoint to pm_nl_show_endpoints.
> v3:
> - use new approach of getting addr.
> - squash four patches, pm_nl_set_limits, pm_nl_add_endpoint,
> pm_nl_del_endpoint and pm_nl_flush_endpoint, into one.
> - rebased, fix conflicts.
> - depends on:
> the "fullmesh flag setting support" series.
>
> RESEND:
> - fix typos and checkpatch.pl warnings.
> v2:
> - use both ip_mptcp and pm_nl_ctl in mptcp_join.sh, instead of
>   replaceing pm_nl_ctl in v1.
> - drop last three patches in v1, keep using pm_nl_ctl in
>   mptcp_sockopt.sh, pm_netlink.sh and simult_flows.sh
>
> v1:
> This patchset replaced all the pm_nl_ctl commands in selftests with the
> 'ip mptcp' commands.
>
> Geliang Tang (5):
>  selftests: mptcp: add ip mptcp wrappers
>  selftests: mptcp: new approach of getting ID
>  selftests: mptcp: add wrapper for showing addrs
>  selftests: mptcp: add wrapper for setting flags
>  selftests: mptcp: set ip_mptcp in command line
>
> .../testing/selftests/net/mptcp/mptcp_join.sh | 878 ++++++++++--------
> 1 file changed, 502 insertions(+), 376 deletions(-)
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
