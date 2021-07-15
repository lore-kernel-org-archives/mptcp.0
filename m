Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE9168
	for <mptcp@lists.linux.dev>; Thu, 15 Jul 2021 01:20:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="208638108"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="208638108"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 18:20:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="494811393"
Received: from ywu57-mobl2.amr.corp.intel.com ([10.212.215.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 18:20:45 -0700
Date: Wed, 14 Jul 2021 18:20:44 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 0/8] mptcp: refactor active backup
In-Reply-To: <cover.1626210682.git.pabeni@redhat.com>
Message-ID: <9f78517b-1ce0-ef5-8e3d-9319433edbc0@linux.intel.com>
References: <cover.1626210682.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 13 Jul 2021, Paolo Abeni wrote:

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
>        and outstanding data over a single subflow needed to declare
>        such subflow 'stale': no more data will be queue until some ack
>        is observed.
>
> Changes from v1:
> - stale_loss_cnt is now configurable via sysctl
> - addressed buglet noted by Mat on v1
> - fixed timeout update issues in patches 1-2
> - fixed splat in __mptcp_clean_una() on reinection
>   - the new self-tests are now less unstable

The "less unstable" tests pass reliably for me!

Ok with me to put these on the export branch, with the squash-to that 
addresses the kbuild warning.

Regarding the "stale vs. stall" discussion on irc, I'm fine with referring 
to the subflows as "stale".

Thanks!

Mat


>
> Paolo Abeni (8):
>  mptcp: more accurate timeout
>  mptcp: less aggressive retransmission stragegy
>  mptcp: handle pending data on closed subflow
>  mptcp: cleanup sysctl data and helpers
>  mptcp: faster active backup recovery
>  mptcp: add mibs for stale subflows processing
>  mptcp: backup flag from incoming MPJ ack option
>  selftests: mptcp: add testcase for active-back
>
> Documentation/networking/mptcp-sysctl.rst     |  12 +
> net/mptcp/ctrl.c                              |  26 ++-
> net/mptcp/mib.c                               |   2 +
> net/mptcp/mib.h                               |   2 +
> net/mptcp/options.c                           |   8 +-
> net/mptcp/pm.c                                |  21 ++
> net/mptcp/pm_netlink.c                        |  37 +++
> net/mptcp/protocol.c                          | 187 +++++++++++----
> net/mptcp/protocol.h                          |  31 ++-
> net/mptcp/subflow.c                           |   6 +-
> .../testing/selftests/net/mptcp/mptcp_join.sh | 215 +++++++++++++++---
> 11 files changed, 459 insertions(+), 88 deletions(-)
>
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
