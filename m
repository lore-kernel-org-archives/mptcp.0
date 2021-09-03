Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0D3FD5
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 20:11:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="219565537"
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="219565537"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 13:11:18 -0700
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="543943250"
Received: from gchandr2-mobl.amr.corp.intel.com ([10.209.38.180])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 13:11:18 -0700
Date: Fri, 3 Sep 2021 13:11:17 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 0/4] mptcp: just another xmit path
 refactor
In-Reply-To: <cover.1630595171.git.pabeni@redhat.com>
Message-ID: <319eb0-91a3-fceb-d780-2e7f96ca4232@linux.intel.com>
References: <cover.1630595171.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 2 Sep 2021, Paolo Abeni wrote:

> Eric want to revert the tcp_tx_skb_cache. MPTCP relies on it
> for skb allocation. Before the revert we need to refactor our
> xmit path.
>
> Patch 1 exposes some needed helpers (endorsed by Eric)
> Patch 2 contains the nasty new code
> Patch 3 revert some core TCP changes not needed anymore
> and patch 4 is Eric's revert.
>
> This iteration should hopefully solve the OoB issues I observed with
> the previous attempt, changes documented in patch 2.
>
> Eric Dumazet (1):
>  tcp: remove sk_{tr}x_skb_cache
>
> Paolo Abeni (3):
>  tcp: expose the tcp_mark_push() and skb_entail() helpers
>  mptcp: stop relaying on tcp_tx_skb_cache.
>  Partially revert "tcp: factor out tcp_build_frag()"
>
> Documentation/networking/ip-sysctl.rst |   8 --
> include/net/sock.h                     |  19 ----
> include/net/tcp.h                      |   4 +-
> net/ipv4/af_inet.c                     |   4 -
> net/ipv4/sysctl_net_ipv4.c             |  12 --
> net/ipv4/tcp.c                         | 147 +++++++++----------------
> net/ipv4/tcp_ipv4.c                    |   6 -
> net/ipv6/tcp_ipv6.c                    |   6 -
> net/mptcp/protocol.c                   | 132 +++++++++++++---------
> 9 files changed, 132 insertions(+), 206 deletions(-)
>
> -- 
> 2.26.3

It's ok to apply the series to the export branch. Before we upstream it, 
can Paolo send a squash-to patch for #2 that removes the 
WARN_ON_ONCE(!mpext)?

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>



--
Mat Martineau
Intel
