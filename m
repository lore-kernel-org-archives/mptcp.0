Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCDD2FAF
	for <mptcp@lists.linux.dev>; Tue,  1 Jun 2021 17:21:54 +0000 (UTC)
IronPort-SDR: D+A3mhMcyRDQKrDH3k1fQc768/szcMROditCgrY5WxhOScMlthXx7mf/dAyJ4L335yBFC4w59S
 eF6b7gT70Lvg==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="264775436"
X-IronPort-AV: E=Sophos;i="5.83,240,1616482800"; 
   d="scan'208";a="264775436"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 10:21:52 -0700
IronPort-SDR: mUUFdZakwdUrX2r0uqMC+u9+ApcxRj1SgJ/AHj9HMjTWXE/+g8MHFyaTFckOt6Zg5X+X8GknYX
 KQhreUlkGVtA==
X-IronPort-AV: E=Sophos;i="5.83,240,1616482800"; 
   d="scan'208";a="479366127"
Received: from ipiacent-mobl1.amr.corp.intel.com ([10.209.119.149])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 10:21:51 -0700
Date: Tue, 1 Jun 2021 10:21:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: netdev@vger.kernel.org, davem@davemloft.net, matthieu.baerts@tessares.net, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 0/7] mptcp: Miscellaneous cleanup
In-Reply-To: <20210528140719.0e18900f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Message-ID: <2832722e-2697-3563-c16f-422d8c743f8d@linux.intel.com>
References: <20210527235430.183465-1-mathew.j.martineau@linux.intel.com> <20210528140719.0e18900f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 28 May 2021, Jakub Kicinski wrote:

> On Thu, 27 May 2021 16:54:23 -0700 Mat Martineau wrote:
>> Here are some cleanup patches we've collected in the MPTCP tree.
>>
>> Patches 1-4 do some general tidying.
>>
>> Patch 5 adds an explicit check at netlink command parsing time to
>> require a port number when the 'signal' flag is set, to catch the error
>> earlier.
>>
>> Patches 6 & 7 fix up the MPTCP 'enabled' sysctl, enforcing it as a
>> boolean value, and ensuring that the !CONFIG_SYSCTL build still works
>> after the boolean change.
>
> Pulled, thanks!
>
> Would you mind making sure that all maintainers and authors of commits
> pointed to by Fixes tags are always CCed? I assume that those folks
> usually see the patches on mptcp@ ML before they hit netdev but I'd
> rather not have to assume..

No problem at all, I will add get_maintainers.pl to my checklist and add 
Cc: tags to future patch sets.

--
Mat Martineau
Intel
