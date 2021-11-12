Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E62C81
	for <mptcp@lists.linux.dev>; Fri, 12 Nov 2021 04:24:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="230532943"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="230532943"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 20:24:47 -0800
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="602868346"
Received: from neelchat-mobl2.amr.corp.intel.com ([10.209.109.125])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 20:24:47 -0800
Date: Thu, 11 Nov 2021 20:24:46 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 0/7] mptcp: improve accept() and
 disconnect()
In-Reply-To: <cover.1636647623.git.pabeni@redhat.com>
Message-ID: <1224de1f-c6b-a82e-8074-e5d112b95@linux.intel.com>
References: <cover.1636647623.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 11 Nov 2021, Paolo Abeni wrote:

> As outlined in the public mtg, mptcp_accept() is currently quite
> suboptimal, both from performance and code complexity
>
> This series tries to clean it up, enforcing a wider lifetime for
> the initial subflow, so that we don't need to acquire additional
> references there.
>
> To reach such goal we need to properly define the disconnect()
> behavior, which is currently quite incomplete. Additionally allow
> user-space to really disconnect established connections.
>
> Disconnect() needs in turn an egress FASTCLOSE implementation,
> added here according to option R (reset - the simpler form).
>
> Finally, the self-tests need as pre-req Florian's patches implementing
> SIOCOUTQ
>
> v1 -> v2:
> - update mptcp_connect argument lists and usage() in patch 7/7
>

Thanks for the v2 Paolo. Looks good to me.

(Matthieu, note the dependency on Florian's TCP_INQ series)


Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> RFC -> v1:
> - added patches 1/7, 3/7, 6/7, 7/7
> - added a few missing bits in patch 4/7
>
> Paolo Abeni (7):
>  mptcp: keep snd_una updated for fallback socket
>  mptcp: never allow the PM to close a listener subflow
>  mptcp: implement fastclose xmit path
>  mptcp: full disconnect implementation
>  mptcp: cleanup accept and poll
>  mptcp: implement support for user-space disconnect
>  mptcp: add disconnect selftests
>
> net/mptcp/options.c                           |  57 +++++--
> net/mptcp/pm.c                                |  10 +-
> net/mptcp/pm_netlink.c                        |   3 +
> net/mptcp/protocol.c                          | 144 +++++++++++------
> net/mptcp/protocol.h                          |  16 +-
> net/mptcp/subflow.c                           |   1 -
> net/mptcp/token.c                             |   1 +
> .../selftests/net/mptcp/mptcp_connect.c       | 148 +++++++++++++++---
> .../selftests/net/mptcp/mptcp_connect.sh      |  39 ++++-
> 9 files changed, 324 insertions(+), 95 deletions(-)
>
> -- 
> 2.33.1
>
>
>

--
Mat Martineau
Intel
