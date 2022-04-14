Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0C3234
	for <mptcp@lists.linux.dev>; Thu, 14 Apr 2022 23:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649978921; x=1681514921;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pkd2Qm+FmDr3nTRhn9Zx8ThibdT0s6hnOF8sGapypys=;
  b=c5ue2+BdDYp/fR/cxMTERpEJTEWOU+0Se0tCmy6tjPyoKZa4CPFfyIxj
   9VNrxCicDOwuaEWWzcZp9bUFigICxn1craGpIropJKxxOgm0+w2omcvJu
   54k2Peqo6rJdIT2B2xsX7oHytaZKITfbjaNoju5CXRn3x+ZOc6K37w4cl
   lBhCgaptCCocJr/mKsamKiOjhUdyh+7gVMi3Z18vkZIrRvNmQzmiS7DAV
   ffsKjrNs0OQxH5oIsqLNkoS82Q0uP1wXx/XDAiDRAgKjksny+8hLCv3h7
   VtmTpOogIUzi7MbT+gqswGjWp2PxVrRAfLb/rlopPquVyHmOoRebLD41t
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="323496143"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="323496143"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 16:28:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="574049628"
Received: from woodmatt-mobl1.amr.corp.intel.com ([10.212.148.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 16:28:41 -0700
Date: Thu, 14 Apr 2022 16:28:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v10 00/14] mptcp: APIs and self-tests for
 userspace path management
In-Reply-To: <20220414211920.1987961-1-kishen.maloor@intel.com>
Message-ID: <471ea964-edcd-8054-8e9c-cef41cde6f1f@linux.intel.com>
References: <20220414211920.1987961-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 14 Apr 2022, Kishen Maloor wrote:

> This patch series brings together the base functionality
> and new netlink APIs for flexible path management from userspace.
> Further it extends the MPTCP self-testing framework to support the new
> netlink APIs along with the ability to capture MPTCP netlink events
> to aid in functional/behavioral validations. Lastly, it adds a
> self-testing script with a suite of test cases covering the entire
> range of the new userspace path management capabilities.
>
> Note: This series depends on the prior patchset "mptcp: fixes and
> enhancements related to path management".
>
> v5:
> -Primary change over v4 is the reliance on userspace
> managed listener sockets for receiving MPJ requests.
> -Addressed CI reported issues.
>
> v6:
> -Put all distinct userspace PM related code into a separate compilation
> unit: pm_userspace.c.
> -Made a few internal helpers non-static (now declared in protocol.h) to
> facilitate the above change.
> -Use the pm spinlock instead of mptcp_data_lock() to synchronize
> access to the per-msk local_addr_list.
>
> v7:
> -Move userspace PM specific handling from pm_netlink
> into mptcp_userspace_pm_get_local_id()
> and mptcp_userspace_pm_get_flags_and_ifindex_by_id() in pm_userspace.
>
> v8:
> -Add copyright notice to pm_userspace.c.
>
> v9:
> -userspace_pm.sh: Mitigate possible buffering issues with CI.
>
> v10:
> -userspace_pm.sh: Increased sleep time between steps to counter
> any timing issues with capturing events for verifying the tested
> behavior. Might resolve test failures in the CI debug build.
>

Thanks, Kishen. Looks like the timeout changes helped the CI succeed when 
running userspace_pm.sh, so we're good to merge the series to the export 
branch as discussed in the meeting today.

Renewing my tag from v8:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>




> Florian Westphal (2):
>  mptcp: netlink: split mptcp_pm_parse_addr into two functions
>  mptcp: netlink: allow userspace-driven subflow establishment
>
> Kishen Maloor (12):
>  mptcp: allow ADD_ADDR reissuance by userspace PMs
>  mptcp: handle local addrs announced by userspace PMs
>  mptcp: read attributes of addr entries managed by userspace PMs
>  mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
>  selftests: mptcp: support MPTCP_PM_CMD_ANNOUNCE
>  mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
>  selftests: mptcp: support MPTCP_PM_CMD_REMOVE
>  selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_CREATE
>  selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_DESTROY
>  selftests: mptcp: capture netlink events
>  selftests: mptcp: create listeners to receive MPJs
>  selftests: mptcp: functional tests for the userspace PM type
>
> include/uapi/linux/mptcp.h                    |   7 +
> net/mptcp/Makefile                            |   2 +-
> net/mptcp/pm.c                                |   1 +
> net/mptcp/pm_netlink.c                        | 169 ++--
> net/mptcp/pm_userspace.c                      | 415 ++++++++++
> net/mptcp/protocol.c                          |   1 +
> net/mptcp/protocol.h                          |  39 +-
> net/mptcp/subflow.c                           |   2 +-
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 645 ++++++++++++++-
> .../selftests/net/mptcp/userspace_pm.sh       | 779 ++++++++++++++++++
> 10 files changed, 1997 insertions(+), 63 deletions(-)
> create mode 100644 net/mptcp/pm_userspace.c
> create mode 100755 tools/testing/selftests/net/mptcp/userspace_pm.sh
>
>
> base-commit: 812de90f114c9234a4ebc80058e71250e552ce5f
> --
> 2.31.1
>
>

--
Mat Martineau
Intel
