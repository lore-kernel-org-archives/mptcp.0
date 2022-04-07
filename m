Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8743D73
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 23:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649375215; x=1680911215;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gjyS3o5kzsELGT5pILr0YZd48vC3FS54SHB0og6an5g=;
  b=QFlVXdd7zd83LCBRMlP3jNH/72p0kWgdJ5c7OkC1QCKnGVQ0OV+GcIul
   zfoxS4LZ2ZxjY81xgeEE7wQQ/8ylqIp2DmOiMpi9zE2bNSDNB2L73dh5Z
   equok4Ywl3GpckPQITTw03vjL/ovC348lk0WhyMX5aDyZOMuuewHpwwTz
   zCTsbP1Zkewh/pRFB1dJQqRrlApq2vMLiAEdfGEJqsJAlFxdjk1qYwwx0
   9hCPaDLE8CYjg9yqktW/ubRRYrztBab4YW3m7fWgkmuE4EmsuLwn+Jub8
   Yk74THqjzrbfFOQm5afrvVDYh5TN/M4ZBieTD5krBF6ALSfHC7nVlvAoT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="347906193"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="347906193"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 16:46:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="571272410"
Received: from prclayto-mobl2.amr.corp.intel.com ([10.212.232.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 16:46:53 -0700
Date: Thu, 7 Apr 2022 16:46:49 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 00/14] mptcp: APIs and self-tests for
 userspace path management
In-Reply-To: <20220407234029.1774481-1-kishen.maloor@intel.com>
Message-ID: <b687d32-a970-6524-6c50-9e5fd3c6f9bc@linux.intel.com>
References: <20220407234029.1774481-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 7 Apr 2022, Kishen Maloor wrote:

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

Hi Kishen -

I went over v7 in detail, and confirmed the change for v8. Looks good to 
me, and the tests are working on my VM. So, I'm ready to tag it:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Matthieu, I haven't marked it as "Queued" in patchwork yet since Paolo may 
want to take a look. Ready to merge from my POV though.

Thanks,

Mat


>
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
> .../selftests/net/mptcp/userspace_pm.sh       | 771 ++++++++++++++++++
> 10 files changed, 1989 insertions(+), 63 deletions(-)
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
