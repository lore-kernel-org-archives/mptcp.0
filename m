Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3283C20
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 22:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655937879; x=1687473879;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=b39Ky72S+DZ1RSflIec01qGN7smFZ1nA90DZ0iQjVKA=;
  b=l1WE47yYG+HMPFb5NdH/YK2OqavSTLXGxFGSw5YOHUnA3OcREKgJXr/B
   PCPHqJTNtWUqsLjpP9qYfYNh5EVbDQi7YrX7G/8fO6vcjvpWW19NMjMLz
   CAaMw7Jc8FMsVYOdF+Rp3EdZIL2IHRovLBlrS/L1ZzRoHxXncdnCVET12
   gHaMbvEEq9T+f0pngX/RAq3f4hRdZTg4URLTr+koPIxYvjGIqIC7YgD7V
   XF6lbOevzHWD5fjRhOOOlNA+jmnHPZb3nCTCLWFffGwFZghpb0seRJbAm
   Vc2sbvSGKDHQYuMZ0WdYQYG1eQx7YNbLWGIVgnskJmll/nMbDlG9WJJdP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="278114723"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="278114723"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:44:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="592414344"
Received: from desireen-mobl.amr.corp.intel.com ([10.209.126.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:44:39 -0700
Date: Wed, 22 Jun 2022 15:44:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>, Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 0/2] mptcp: support MP_PRIO signals with
 userspace PMs
In-Reply-To: <20220622175547.289717-1-kishen.maloor@intel.com>
Message-ID: <77ba5fc9-7f13-d67e-621b-305ff26e58a9@linux.intel.com>
References: <20220622175547.289717-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 22 Jun 2022, Kishen Maloor wrote:

> This patch series updates MPTCP_PM_CMD_SET_FLAGS to allow userspace PMs
> to issue MP_PRIO signals for a specified address ID over a chosen
> MPTCP connection. It also adds self testing support for this change.
>
> Kishen Maloor (2):
>  mptcp: netlink: issue MP_PRIO signals from userspace PMs
>  selftests: mptcp: userspace PM support for MP_PRIO signals
>
> net/mptcp/pm_netlink.c                        | 23 ++++++++++----
> net/mptcp/pm_userspace.c                      | 30 ++++++++++++++++++
> net/mptcp/protocol.h                          |  6 +++-
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 19 ++++++++++--
> .../selftests/net/mptcp/userspace_pm.sh       | 31 +++++++++++++++++++
> 5 files changed, 100 insertions(+), 9 deletions(-)
>
>
> base-commit: 68fec8b7f640037e4bf224ca4e924574098f5911
> --
> 2.31.1

Thanks Kishen!

The selftest passed on my test system, but I have one comment on that 
patch.

Paolo, do agree this is best sent to the -net branch? This is an important 
chunk of the userspace PM that we accidentally overlooked, and it seems 
pretty important to get in to 5.19.

--
Mat Martineau
Intel
