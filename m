Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512881C26
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 22:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655937974; x=1687473974;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=//Y6ClaLcm1vuw+B1LDRmk5c+7dBIrFs3HQen3tcI1U=;
  b=iOwyD8V5W6uLhOhdSok7t9f0vHmliWT0XWu3NU36sfzWJij16kli8h1/
   H4V1xGCrT5fa/GFt5hNrdDzOZISFDy3gph2ITxH8YAnlAHoTVn+2c7SvJ
   WZVk1yn3dxJvI4q6fVl+4q8QOPaOPqywS1YAeTDUV6OjsEEIEInlUVqCd
   rmahcmUYqfVFFpk1hJG2lk7w3/VpPXp56QH4xxJRrOwO7JKsVtvJx8Yac
   V8x+TR9DX/PZFipecehPoZraEXxjAhlwjrTuBhZfeGGVSL11F+IssHIUV
   5DuUKrZQ4BYkHMYM77q8ZSGkXI6Z4syd8O43GA7U5fJoOctNIhCk9mPnE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="263598672"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="263598672"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:46:13 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="834351895"
Received: from desireen-mobl.amr.corp.intel.com ([10.209.126.32])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:46:13 -0700
Date: Wed, 22 Jun 2022 15:46:13 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 0/2] mptcp: support MP_PRIO signals with
 userspace PMs
In-Reply-To: <77ba5fc9-7f13-d67e-621b-305ff26e58a9@linux.intel.com>
Message-ID: <9a99df6a-a6bb-b9c7-6e87-4a3c842cfcf0@linux.intel.com>
References: <20220622175547.289717-1-kishen.maloor@intel.com> <77ba5fc9-7f13-d67e-621b-305ff26e58a9@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 22 Jun 2022, Mat Martineau wrote:

> On Wed, 22 Jun 2022, Kishen Maloor wrote:
>
>> This patch series updates MPTCP_PM_CMD_SET_FLAGS to allow userspace PMs
>> to issue MP_PRIO signals for a specified address ID over a chosen
>> MPTCP connection. It also adds self testing support for this change.
>> 
>> Kishen Maloor (2):
>>  mptcp: netlink: issue MP_PRIO signals from userspace PMs
>>  selftests: mptcp: userspace PM support for MP_PRIO signals
>> 
>> net/mptcp/pm_netlink.c                        | 23 ++++++++++----
>> net/mptcp/pm_userspace.c                      | 30 ++++++++++++++++++
>> net/mptcp/protocol.h                          |  6 +++-
>> tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 19 ++++++++++--
>> .../selftests/net/mptcp/userspace_pm.sh       | 31 +++++++++++++++++++
>> 5 files changed, 100 insertions(+), 9 deletions(-)
>> 
>> 
>> base-commit: 68fec8b7f640037e4bf224ca4e924574098f5911
>> --
>> 2.31.1
>
> Thanks Kishen!
>
> The selftest passed on my test system, but I have one comment on that patch.
>
> Paolo, do agree this is best sent to the -net branch? This is an important 
> chunk of the userspace PM that we accidentally overlooked, and it seems 
> pretty important to get in to 5.19.
>

One other thing: I did gather some pcaps in a manual run, and verified 
that the MP_PRIO packet is generated for both setting and clearing the 
backup flag.

--
Mat Martineau
Intel
