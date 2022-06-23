Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461F1FB3
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 15:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655996560; x=1687532560;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SIhCnJuDAho1l1V4TYeOCv1fk2yaqX2V4qvtNWeWhYA=;
  b=GNftdIIqaGLWbR3nFA+XWzKxnmTEYQ60hAUaWM1aikfjnXhv7ZyfW8bI
   waTh4s/1FrCHBb6NNvRen7uVKlKcDGMSU4Ns+0gcoqAq1tST9IGku5mu1
   k9HS+xGrU/sTpvfj7mxDFuB2cqnwN+M/ci6cjbb8+dzNPPgznQmvYbNZi
   XUwjEIUCU2eqiF4grCL1dj8T1xRELN4kC8CvCPFx/Ur6X/oVYUd0i+24l
   6YqqRo0hBU995f+69tAxlfz9jepQbMpP89XiYR2b2bp/S1G9Mc1VdI1y2
   UgqQp2+khxdLaMRwhOH875H0RxJc29OOoGU5gI4Fkm74HXyCmrl9Ko6O7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="261174374"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="261174374"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 08:02:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="563482324"
Received: from jngertso-mobl1.amr.corp.intel.com ([10.212.159.56])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 08:02:39 -0700
Date: Thu, 23 Jun 2022 08:02:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: support MP_PRIO signals with
 userspace PMs
In-Reply-To: <20220623005948.291792-1-kishen.maloor@intel.com>
Message-ID: <8cab7043-8cc3-eecc-08f-c5e563b8f2e@linux.intel.com>
References: <20220623005948.291792-1-kishen.maloor@intel.com>
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
> v2:
> -userspace_pm.sh: added a sleep after issuing the MP_PRIO signal.

Thanks Kishen. v2 looks good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>
> Kishen Maloor (2):
>  mptcp: netlink: issue MP_PRIO signals from userspace PMs
>  selftests: mptcp: userspace PM support for MP_PRIO signals
>
> net/mptcp/pm_netlink.c                        | 23 +++++++++----
> net/mptcp/pm_userspace.c                      | 30 +++++++++++++++++
> net/mptcp/protocol.h                          |  6 +++-
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 19 +++++++++--
> .../selftests/net/mptcp/userspace_pm.sh       | 32 +++++++++++++++++++
> 5 files changed, 101 insertions(+), 9 deletions(-)
>
>
> base-commit: 68fec8b7f640037e4bf224ca4e924574098f5911
> --
> 2.31.1
>
>

--
Mat Martineau
Intel
