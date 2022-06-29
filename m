Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720737A
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 03:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656473834; x=1688009834;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wKSTDk7i7hOASEb6LbBVIeFx+Lbs8uLGLSMwULdARmM=;
  b=DVouz8oPKGTBcRpvKH9t4tidjcROsX5mhl8ojPkWawEztb9MhqW8zLYZ
   8PRvSQ7T1Y3lAGbG//xkSy8yZU6frE12K0UP7NAMK98VKTpCQs4g5eGWf
   4NL3fkC7vdYZdadVGQwSy4GpMtgJQOkX50eJ5xnZLTdEsT2pUjwg6yYn0
   3tfdEQzRBoqV2gsfBdh7FkwI45TaIuB4mxFtjDhXnHueUEBLMPKxvIB/+
   GWP47blEoqo9S350ayj3QiY1ITIFca9HNAGVhVEL3QxxYR4veEBvd1GLK
   CQTIpUM/ivMa7GC/4yvhxA3sMuuAEF+TayvmFFbvpKdUwAl1jdWVnVLDv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="280673828"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="280673828"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 20:37:13 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="588106116"
Received: from hmok-mobl1.amr.corp.intel.com ([10.209.98.71])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 20:37:13 -0700
Date: Tue, 28 Jun 2022 20:37:12 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v4 0/2] mptcp: support MP_PRIO signals with
 userspace PMs
In-Reply-To: <20220629012702.425574-1-kishen.maloor@intel.com>
Message-ID: <144ee4af-c481-ffd3-1eae-151557d28e9c@linux.intel.com>
References: <20220629012702.425574-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 28 Jun 2022, Kishen Maloor wrote:

> This patch series updates MPTCP_PM_CMD_SET_FLAGS to allow userspace PMs
> to issue MP_PRIO signals over a selected (by local and remote address+port)
> subflow in a MPTCP connection. It also adds self tests for this
> change.
>
> This patch series has been rebased to the series (in review) titled
> "Locking fixes for subflow flag changes".
>
> v2:
> -userspace_pm.sh: added a sleep after issuing the MP_PRIO signal.
>
> v3:
> -use local and remote address+port (instead of address ID) alongwith the
> connection token to select a subflow.
>
> v4:
> -fixed bug during rebase in v3.

Thanks Kishen. v4 looks good to me, and the builds look good (I pushed 
equivalent commits to github to trigger a build):

https://cirrus-ci.com/build/6289402744799232
https://github.com/multipath-tcp/mptcp_net-next/runs/7103422638

Looks like the github action got a little confused by the exact version of 
the patches not being in patchwork.


Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

At the meeting last week Paolo said he was planning to take a look as 
well.

>
> Kishen Maloor (2):
>  mptcp: netlink: issue MP_PRIO signals from userspace PMs
>  selftests: mptcp: userspace PM support for MP_PRIO signals
>
> net/mptcp/pm_netlink.c                        | 30 ++++++--
> net/mptcp/pm_userspace.c                      | 30 ++++++++
> net/mptcp/protocol.h                          |  8 +-
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 73 ++++++++++++++++++-
> .../selftests/net/mptcp/userspace_pm.sh       | 32 ++++++++
> 5 files changed, 165 insertions(+), 8 deletions(-)
>
> --
> 2.31.1
>
>

--
Mat Martineau
Intel
