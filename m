Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A1168
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 18:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641492436; x=1673028436;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QlfSgwrbBIIxN7MEwy8kqYN19i5d0TJjmmyxhJAXhwU=;
  b=Ky/Q8wgNvK3o9XRCVV3VJ1tyAlnkYF/rirYLAiFlEyquZ4Xi3vkTDTHo
   B5yc7uU7pWNG0hTZit7odmQQv285kZThzZ+d3U/+HIzSruQ9kxppNsCdC
   380vaW6gkC/+I8eLwTEOt5W9h+HHi5KJ137FXAWWsJ0+F9iuq+7E3LMDA
   cXvZWINMYw7XyDMIaHp/H7vPIhIy7amcBb5iJAny7kTcElIfrs5mnhXL8
   kiiZLtKv/uWMIgWTEGch325ZrqjjN6Uqj/bvxOL917nUajU3SS/bGPr0K
   7WbcMSADUmwkGW4cAAs0ze0tizr6V82A6hwij+JBu+gwy7mESYNGDLvoi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241523913"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="241523913"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 10:07:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="471017409"
Received: from rahamme-mobl.amr.corp.intel.com ([10.252.138.196])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 10:07:15 -0800
Date: Thu, 6 Jan 2022 10:07:15 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/4] use 'ip mptcp' in selftests
In-Reply-To: <20220105023556.GA3356@dhcp-10-157-36-190>
Message-ID: <3faff68f-44f5-61ee-fb52-d7b72ada2193@linux.intel.com>
References: <cover.1641290905.git.geliang.tang@suse.com> <e0bd41a6-9147-e9c-5bc9-c541282127d7@linux.intel.com> <20220105023556.GA3356@dhcp-10-157-36-190>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 5 Jan 2022, Geliang Tang wrote:

> On Tue, Jan 04, 2022 at 05:41:21PM -0800, Mat Martineau wrote:
>> On Tue, 4 Jan 2022, Geliang Tang wrote:
>>
>>> This patchset replaced all the pm_nl_ctl commands in selftests with the
>>> 'ip mptcp' commands.
>>>
>>> Geliang Tang (4):
>>>  selftests: mptcp: use 'ip mptcp' in mptcp_join.sh
>>>  selftests: mptcp: use 'ip mptcp' in mptcp_sockopt.sh
>>>  selftests: mptcp: use 'ip mptcp' in pm_netlink.sh
>>>  selftests: mptcp: use 'ip mptcp' in simult_flows.sh
>>>
>>> .../testing/selftests/net/mptcp/mptcp_join.sh | 686 +++++++++---------
>>> .../selftests/net/mptcp/mptcp_sockopt.sh      |  12 +-
>>> .../testing/selftests/net/mptcp/pm_netlink.sh | 164 ++---
>>> .../selftests/net/mptcp/simult_flows.sh       |   6 +-
>>> 4 files changed, 432 insertions(+), 436 deletions(-)
>>>
>>> --
>>> 2.31.1
>>
>> Hi Geliang -
>>
>> I think we had been using pm_nl_ctl to avoid possible problems with varying
>> 'ip' command versions on host systems, and to make sure we are checking for
>> kernel regressions rather than 'ip' regressions, and to be able to check the
>> netlink API in ways that might not make sense for the 'ip mptcp' command.
>>
>> Could you comment on the reasons to move away from pm_nl_ctl?
>>
>
> Hi Mat,
>
> How about using both pm_nl_ctl and 'ip mptcp' in the selftests? Add an
> argument to choose which one to use. Or add the 'ip' command version check
> to decide which one to use.
>

Hi Geliang -

I like the idea to add a command line option to use 'ip' commands, but 
still defaulting to pm_nl_ctl. It's important to have consistent behavior 
across systems with the default self tests (especially with various 
automated build systems like kbuild where we don't know or control the 
iproute2 version).

> My intention to add these patches was to check whether all the changes in
> pm_nl_ctl have been merged into 'ip mptcp'.

Yes, it's very useful to be able to run all these test cases with 'ip 
mptcp' in addition to pm_nl_ctl.

> I hesitated to use both pm_nl_ctl and 'ip mptcp' or replace pm_nl_ctl 
> with 'ip mptcp'. The latter is easier to implement, so I chose the 
> latter. Now I think maybe using both of them is much better.

I agree!

--
Mat Martineau
Intel
