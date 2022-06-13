Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9F33E8
	for <mptcp@lists.linux.dev>; Mon, 13 Jun 2022 23:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655161452; x=1686697452;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=MG8hAdNbnODw30fzL3S31aPuhzpeDFAMbWPVFsAZbFI=;
  b=LkPJ3CzNsQ1WiV/D3Miq96rBsiLcznoebyomygyqEdLGQXqXJAGowMPa
   Cq3R6y9zkcVQlzJAtPQmykqaVS7YTRyuIwKe10tVwivlKtbaPYj9Tk3sQ
   qf5QDc/e4Ko4p5bvS1D7SfuUam6J2incpX7CRjoY3ZRTInK5CEf8JACxk
   wuRb3vv7U/ue7cAq1uFi6C7af4EIU8Go7VRCl3Ep2iC6Iw3F5JeAuUdAI
   unlGYf7jOfIYKyL6GKUII30hctdaj4cVmQ5uMToWtx4/ys6bJzGrbx1b7
   iY6SKTQtoybSlAW1GRouaMn0fLFJN7LqaZ4Dv+TeLhuasoQgfhCpCfsF/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="267128770"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="267128770"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 16:04:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="611979079"
Received: from jfgiesbe-mobl.amr.corp.intel.com ([10.209.95.28])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 16:04:11 -0700
Date: Mon, 13 Jun 2022 16:04:11 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 1/5] mptcp: update MIB_RMSUBFLOW in
 cmd_sf_destroy
In-Reply-To: <982d63cf-8369-5f88-64bd-b59bc8c2f93f@tessares.net>
Message-ID: <59e571be-7ce8-6af-4ebe-74c538446f29@linux.intel.com>
References: <cover.1654958401.git.geliang.tang@suse.com> <4ed5348a34b4de9b482fe192fc271a59ee334e37.1654958401.git.geliang.tang@suse.com> <982d63cf-8369-5f88-64bd-b59bc8c2f93f@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-1208693152-1655161263=:5187"
Content-ID: <68f9a447-d9d3-a0be-455e-3b2d65ea7b23@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1208693152-1655161263=:5187
Content-Type: text/plain; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <5e415ba2-b084-3b7c-5ddb-2e16b7d7de1f@linux.intel.com>

On Mon, 13 Jun 2022, Matthieu Baerts wrote:

> Hi Geliang,
>
> On 11/06/2022 16:54, Geliang Tang wrote:
>> This patch increases MPTCP_MIB_RMSUBFLOW mib counter in userspace pm
>> destroy subflow function mptcp_nl_cmd_sf_destroy() when removing subflow.
>>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>>  net/mptcp/pm_userspace.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> index f56378e4f597..ebbab5200290 100644
>> --- a/net/mptcp/pm_userspace.c
>> +++ b/net/mptcp/pm_userspace.c
>> @@ -5,6 +5,7 @@
>>   */
>>
>>  #include "protocol.h"
>> +#include "mib.h"
>>
>>  void mptcp_free_local_addr_list(struct mptcp_sock *msk)
>>  {
>> @@ -418,6 +419,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
>>
>>  		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
>>  		mptcp_close_ssk(sk, ssk, subflow);
>> +		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
>
> It looks like this instruction is causing quite a bit of issues
> according to the public CI:
>
> - KVM Validation: normal:
>  - Critical: 7 Call Trace(s) ❌:
>  - Task: https://cirrus-ci.com/task/5443636765655040
>  - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/5443636765655040/summary/summary.txt
>
>
> I guess you should use MPTCP_INC_STATS() instead.

+1

>
>
> Side note: I don't know if it is a good idea to increment MIB counters
> from the PM code (any pm*.c files). I think this should only be done
> from "core" functions in protocol.c and subflow.c (+ options.c of
> course). Or from new helpers declared in protocol.h. WDYT?
>

Could you elaborate some more on this? There's some existing MIB counter 
code in the pm*.c files that doesn't seem too out of place - is the idea 
that moving calls to the core it would reduce duplicated code in 
pm_netlink.c and pm_userspace.c?


--
Mat Martineau
Intel
--0-1208693152-1655161263=:5187--
