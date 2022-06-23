Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F723A8
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 21:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656019956; x=1687555956;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+B3fEMgi/9XyCQpjlwim/Ply7sByS1rxENmE4xesunE=;
  b=Iayt+/ugKdWnNVFi3fZ6mjZkd8X7H64jMA1aDO+5VLTn2Kmrr1Z/+3gf
   Mm6DdCcno3bsOEH2I9oDGUuGwjQE1qq/2r+Fe8x9IY/PnIvKVFYO9hpcM
   Y6qBsfqsrFtt+oV8s6nLx2O/ufdEwFKwmXgg3hSjHTx25+SKhymMCbQ3G
   45BvI996GJymcMFIPY9ead6Jrnf+3ub3l4WS9W0L/tT573gG5r61ZfAb1
   T5UZZR7kUNJJCToryXshSfYIslNWXZqPp1rjvROvxuVuosuE1mhfTams/
   YHrkjkEs/fJAi5TdizV1GvLHNyrhrl8xqtWFp+Yh6NlnYZGgEVYyJFm3F
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="263882931"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="263882931"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 14:32:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="615737442"
Received: from jngertso-mobl1.amr.corp.intel.com ([10.212.159.56])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 14:32:20 -0700
Date: Thu, 23 Jun 2022 14:32:20 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: support MP_PRIO signals with
 userspace PMs
In-Reply-To: <8cab7043-8cc3-eecc-08f-c5e563b8f2e@linux.intel.com>
Message-ID: <efd28e16-67e5-4ef2-ed45-e75e431581aa@linux.intel.com>
References: <20220623005948.291792-1-kishen.maloor@intel.com> <8cab7043-8cc3-eecc-08f-c5e563b8f2e@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 23 Jun 2022, Mat Martineau wrote:

> On Wed, 22 Jun 2022, Kishen Maloor wrote:
>
>> This patch series updates MPTCP_PM_CMD_SET_FLAGS to allow userspace PMs
>> to issue MP_PRIO signals for a specified address ID over a chosen
>> MPTCP connection. It also adds self testing support for this change.
>> 
>> v2:
>> -userspace_pm.sh: added a sleep after issuing the MP_PRIO signal.
>
> Thanks Kishen. v2 looks good to me:
>
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>

I spoke too soon.

I was looking at the multipath-tcp.org API for changing the backup flag 
with Ossama, and that netlink command (MPTCP_CMD_SUB_PRIORITY) uses the 
local and remote addresses and port numbers rather than the endpoint IDs.

This is so the priority can be changed for an individual subflow. The 
API parameters I asked for in issue 286 would only allow priority to be 
changed for all subflows using a specific local endpoint, which is not 
specific enough.

I'll update https://github.com/multipath-tcp/mptcp_net-next/issues/286 
to request a change to the MPTCP_PM_CMD_SET_FLAGS parameters.

>> 
>> Kishen Maloor (2):
>>  mptcp: netlink: issue MP_PRIO signals from userspace PMs
>>  selftests: mptcp: userspace PM support for MP_PRIO signals
>> 
>> net/mptcp/pm_netlink.c                        | 23 +++++++++----
>> net/mptcp/pm_userspace.c                      | 30 +++++++++++++++++
>> net/mptcp/protocol.h                          |  6 +++-
>> tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 19 +++++++++--
>> .../selftests/net/mptcp/userspace_pm.sh       | 32 +++++++++++++++++++
>> 5 files changed, 101 insertions(+), 9 deletions(-)
>> 
>> 
>> base-commit: 68fec8b7f640037e4bf224ca4e924574098f5911
>> --
>> 2.31.1
>> 
>>

--
Mat Martineau
Intel
