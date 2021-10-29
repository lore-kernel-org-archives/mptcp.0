Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBFB2C87
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 20:15:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="229471280"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="229471280"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 13:15:14 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="636930429"
Received: from feiyang2-mobl.amr.corp.intel.com ([10.209.25.152])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 13:15:14 -0700
Date: Fri, 29 Oct 2021 13:15:13 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/2] mptcp: add freebind & transparent
 sockopt
In-Reply-To: <20211029110927.12315-1-fw@strlen.de>
Message-ID: <56d63cc2-cc8b-c55-1d6a-673ce3937f7b@linux.intel.com>
References: <20211029110927.12315-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 29 Oct 2021, Florian Westphal wrote:

> First patch adds ipv4/ipv6 TRANSPARENT and FREEBIND, second
> patch adds a selftest to mptcp_connect.sh.
>
> Only change is in patch 2 which has more verbose SKIP messages
> and an updated mptcp/config to account for IPV6_MULTIPLE_TABLES
> and other toggles required for the tproxy test case.
>
> Florian Westphal (2):
>  mptcp: sockopt: add SOL_IP freebind & transparent options
>  selftests: mptcp: add tproxy test case
>
> net/mptcp/sockopt.c                           | 66 ++++++++++++++-
> net/mptcp/subflow.c                           |  3 +-
> .../selftests/net/mptcp/config                |  7 ++-
> .../selftests/net/mptcp/mptcp_connect.c       | 51 +++++++++++-
> .../selftests/net/mptcp/mptcp_connect.sh      | 80 +++++++++++++++++++
> 5 files changed, 202 insertions(+), 5 deletions(-)
> -- 
> 2.32.0

Looks good to me, thanks for tracking down the missing config.

It seemed a little odd at first that sync_socket_options() copies the 
transparent/freebind values without considering whether the protocol (v4 
or v6) used in the setsockopt matches the subflow being synced, but the IP 
code doesn't really care for historical reasons. Looks like ipv6 used to 
just use the SOL_IP options for these anyway, until someone noticed it 
didn't work on AF_INET6 SOCK_RAW sockets.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
