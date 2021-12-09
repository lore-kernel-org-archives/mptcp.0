Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7BB68
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 01:03:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="238215844"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="238215844"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 17:03:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="658578410"
Received: from mnepal-mobl2.amr.corp.intel.com ([10.209.68.94])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 17:03:46 -0800
Date: Wed, 8 Dec 2021 17:03:40 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] mptcp: a couple of cleanups
In-Reply-To: <cover.1638811854.git.pabeni@redhat.com>
Message-ID: <19906159-80c5-e657-9e5e-d94891e81478@linux.intel.com>
References: <cover.1638811854.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Dec 2021, Paolo Abeni wrote:

> The first patch was already shared as RFC, this iteration
> addresses a couple of bugs there.
>
> The second patch removes a bunch of conditionals and atomic
> operations in the fast path, but the performance impact is
> actually below noise level. Still I think it's worthy, as the
> unneeded atomic operations are confusing.
>
> Paolo Abeni (2):
>  mptcp: cleanup MPJ subflow list handling
>  mptcp: avoid atomic bit manipulation when possible
>
> net/mptcp/pm_netlink.c |   3 -
> net/mptcp/protocol.c   | 149 ++++++++++++++++++-----------------------
> net/mptcp/protocol.h   |  31 ++++-----
> net/mptcp/sockopt.c    |  24 ++-----
> net/mptcp/subflow.c    |   9 ++-
> 5 files changed, 89 insertions(+), 127 deletions(-)

Looks good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Matthieu, note that this patch set depends on the "mptcp: improve subflow 
creation on errors" patches.

--
Mat Martineau
Intel
