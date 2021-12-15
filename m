Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61268
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 01:28:26 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="226400932"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="226400932"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 17:28:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="465333192"
Received: from gchandra-mobl.amr.corp.intel.com ([10.209.52.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 17:28:26 -0800
Date: Tue, 14 Dec 2021 17:28:25 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v6 mptcp-next 0/7] mptcp: improve subflow creation on
 errors
In-Reply-To: <cover.1639500873.git.pabeni@redhat.com>
Message-ID: <5a6a597-47a1-e01-9391-50a529b5eef2@linux.intel.com>
References: <cover.1639500873.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 14 Dec 2021, Paolo Abeni wrote:

> This iteration tries to add address the feedback on v5, namely
> test counter update and locking in write_options. The latter
> required quite significant changes in patch 5/7.
>
> Additionally the series now includes the pending cleanup, as
> they depends on the previous patches. No changes there WRT the
> previous iteration.
>
> Currently when a subflow connection fails - either the TCP
> connection is reset by the peer, or the MPJ handshake never
> completes - the in kernel PM don't perform any further action.
> Notably no additional subflow creation is attempted.
>
> This series is aimed at improving the in-kernel path manager
> behavior in the above scenario:
> - each endpoint is used only once per connection (patch 2/4)
> - on failure we try to move to the next subflow, if any
>  (patch 3/4)
>
> The first patch is minor cleanup, and the last patch adds
> specific self-tests.
>
> This should address/close:
> https://github.com/multipath-tcp/mptcp_net-next/issues/235
> https://github.com/multipath-tcp/mptcp_net-next/issues/242
>

Hi Paolo -

Thanks for the changes, I think the "start all the subflows in a loop" 
works out better.

Looks good for wider testing on the export branch, with the one selftest 
fix noted in patch 5 (Matthieu, let us know how you prefer to proceed on 
that).

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> Paolo Abeni (7):
>  mptcp: fix per socket endpoint accounting.
>  mptcp: clean-up MPJ option writing.
>  mptcp: keep track of local endpoint still available for each msk
>  mptcp: do not block subflows creation on errors
>  selftests: mptcp: add tests for subflow creation failure
>  mptcp: cleanup MPJ subflow list handling
>  mptcp: avoid atomic bit manipulation when possible
>
> net/mptcp/options.c                           |  44 ++--
> net/mptcp/pm.c                                |  24 ++-
> net/mptcp/pm_netlink.c                        | 188 +++++++++++-------
> net/mptcp/protocol.c                          | 158 +++++++--------
> net/mptcp/protocol.h                          |  46 +++--
> net/mptcp/sockopt.c                           |  24 +--
> net/mptcp/subflow.c                           |   9 +-
> tools/testing/selftests/net/mptcp/config      |   1 +
> .../testing/selftests/net/mptcp/mptcp_join.sh |  83 +++++++-
> 9 files changed, 350 insertions(+), 227 deletions(-)
>
> -- 
> 2.33.1
>
>
>

--
Mat Martineau
Intel
