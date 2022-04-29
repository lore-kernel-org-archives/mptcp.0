Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832210EB
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 03:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651203542; x=1682739542;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hbI67oUZUKEUm3P+EJ8M8Uh3g2wNFyH+0FXYQT3fUko=;
  b=LuNoSOwoMabIHvG/jw8HI+mb1AEh8fWT3Uw0mg6DrMMs0S6RO3UYsvYO
   tpIiKZCkO/kJ2lK6gbBizd8btoCNTIw9A0w5vFBZYKZU+LfZin+Tf30oI
   8Qh1+mg9DMBJXdt8Qqma9oiG3DMQnIJXh+HrYoQJh0yezassrduBh3c3d
   rxgEEIKQLuG9iuhy/o//zTzX8/lcqoFyXdiRBKfwnDI4F49jfWfg4g4F0
   SkHD6SNPiNa3ZsUP+yYSmPXhoHA8k6wA45u/ltl6OwTy6Be8a4dB+N4ms
   krKpeixsO8gAZF3hqqnaehVjA3YvLczh6xnhTOvUnOIEpptEsoXnHg+E0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="329459709"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="329459709"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 20:39:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="560073529"
Received: from davideli-mobl.amr.corp.intel.com ([10.209.69.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 20:39:01 -0700
Date: Thu, 28 Apr 2022 20:39:01 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
    matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 0/6] mptcp: Path manager mode selection
In-Reply-To: <20220428185739.39cdbb33@kernel.org>
Message-ID: <23ff3b49-2563-1874-fa35-3af55d3088e7@linux.intel.com>
References: <20220427225002.231996-1-mathew.j.martineau@linux.intel.com> <20220428185739.39cdbb33@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


On Thu, 28 Apr 2022, Jakub Kicinski wrote:

> On Wed, 27 Apr 2022 15:49:56 -0700 Mat Martineau wrote:
>> MPTCP already has an in-kernel path manager (PM) to add and remove TCP
>> subflows associated with a given MPTCP connection. This in-kernel PM has
>> been designed to handle typical server-side use cases, but is not very
>> flexible or configurable for client devices that may have more
>> complicated policies to implement.
>>
>> This patch series from the MPTCP tree is the first step toward adding a
>> generic-netlink-based API for MPTCP path management, which a privileged
>> userspace daemon will be able to use to control subflow
>> establishment. These patches add a per-namespace sysctl to select the
>> default PM type (in-kernel or userspace) for new MPTCP sockets. New
>> self-tests confirm expected behavior when userspace PM is selected but
>> there is no daemon available to handle existing MPTCP PM events.
>>
>> Subsequent patch series (already staged in the MPTCP tree) will add the
>> generic netlink path management API.
>
> Could you link to those patches, maybe? Feels a little strange to add
> this sysctl to switch to user space mode now, before we had a chance
> to judg^W review the netlink interface.
>

Hi Jakub -

Sure, no problem. If you'd prefer a pull request for this feature as a 
whole I could stage that.

Here's a tag (note: do not merge this as-is, the committer ids and full 
history aren't suitable) -> 
https://github.com/multipath-tcp/mptcp_net-next/commits/netdev-review-userspace-path-manager

The last 26 commits there cover the full userspace path manager kernel 
code, with the first 6 of those being this series.

Userspace path managers makes use of generic netlink MPTCP events that 
have already been upstream for a while, and the full series adds four 
netlink commands for userspace:

* MPTCP_PM_CMD_ANNOUNCE: advertise an address that's available for 
additional subflow connections.

* MPTCP_PM_CMD_REMOVE: revoke an advertisement

* MPTCP_PM_CMD_SUBFLOW_CREATE: initiate a new subflow on an existing MPTCP 
connection

* MPTCP_PM_CMD_SUBFLOW_DESTROY: close a subflow on an existing MPTCP 
connection

There's one commit for each command, each with an obvious title ("mptcp: 
netlink: Add MPTCP_PM_CMD_<name>")


> Does the pm_type switch not fit more neatly into the netlink interface
> itself?

We (on the MPTCP ML) did discuss that as a design option, and landed on 
the sysctl.

The stack can handle having no userspace PM daemon present since MPTCP 
connections can still be initiated without the PM and operate in single 
subflow mode at first. When the daemon starts up later it can manage the 
existing sockets and start announcing addresses or adding subflows. We 
wanted to avoid accidentally ending up with a mix of kernel-PM-managed and 
userspace-PM-managed sockets depending on when the daemon loaded.

Userspace PM daemons could depend on carrier policy or other complex 
dependencies, so it made sense to allow setting the sysctl early and leave 
more flexibility for launching the daemon later.

--
Mat Martineau
Intel
