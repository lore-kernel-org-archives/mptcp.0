Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4AF168
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 01:13:13 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="209669124"
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="209669124"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 18:13:13 -0700
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="461946161"
Received: from pkadam-mobl1.amr.corp.intel.com ([10.212.141.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 18:13:12 -0700
Date: Thu, 8 Jul 2021 18:13:12 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, fwestpha@redhat.com
Subject: Re: [PATCH mptcp-next 0/7] mptcp: refactor active backup
In-Reply-To: <cover.1624895054.git.pabeni@redhat.com>
Message-ID: <e6a391d0-13cc-edc6-958d-745b5d3ba29c@linux.intel.com>
References: <cover.1624895054.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 28 Jun 2021, Paolo Abeni wrote:

> This series addresses a bunch of issues somewhat related to active
> backup handling. The most visible functial issue addressed here is:
>
> https://github.com/multipath-tcp/mptcp_net-next/issues/191
>
> This series also add some specific self-tests, to cover both
> active-backup switch-over and proper usage of backup link.
>
> A new netns parameter is introduced:
>
> stale_loss_cnt - the max amount of mptcp rtx timeouts with no progresses
> 	and outstanding data over a single subflow needed to declare
> 	such subflow 'stale': no more data will be queue until some ack
> 	is observed.
>
> This parameter is currently not configurable: I'm undecited if it should
> stay under the pm_netlink APIs or under the sysfs. I've a slightly
> preference for the latter. Any opinion welcome!

I also lean toward sysfs/sysctl. If anyone has reasons to prefer netlink 
for this setting I'd like to hear them!

>
> This is only lightly (but painfully) tests, my proposal it to let
> it stage in the export branch for some time.
>

Yes, I agree on staging in the export branch. I had only a couple of small 
code changes to suggest (fixes could easily be squashed). I think the more 
important consideration is how noisy the tests would be in CI. The self 
tests did not consistently pass for me, there's more detail about that in 
my patch 7/7 reply. I would suggest having the mptcp_join.sh tests at 
least in a place of "intermittent failure" rather than "rare success" 
before adding to the export branch.


- Mat


> Paolo Abeni (7):
>  mptcp: more accurate timeout
>  mptcp: less aggressive retransmission stragegy
>  mptcp: handle pending data on closed subflow
>  mptcp: faster active backup recovery
>  mptcp: add mibs for stale subflows processing
>  mptcp: backup flag from incoming MPJ ack option
>  selftests: mptcp: add testcase for active-back
>
> net/mptcp/mib.c                               |   2 +
> net/mptcp/mib.h                               |   2 +
> net/mptcp/options.c                           |   9 +-
> net/mptcp/pm.c                                |  21 ++
> net/mptcp/pm_netlink.c                        |  40 ++++
> net/mptcp/protocol.c                          | 132 ++++++++++---
> net/mptcp/protocol.h                          |  19 +-
> net/mptcp/subflow.c                           |   6 +-
> .../testing/selftests/net/mptcp/mptcp_join.sh | 185 +++++++++++++++---
> 9 files changed, 352 insertions(+), 64 deletions(-)
>
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
