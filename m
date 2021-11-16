Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A86972
	for <mptcp@lists.linux.dev>; Tue, 16 Nov 2021 19:16:31 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="221018644"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="221018644"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 11:16:31 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="536030612"
Received: from rgstewar-desk3.amr.corp.intel.com ([10.209.15.110])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 11:16:30 -0800
Date: Tue, 16 Nov 2021 11:16:30 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 0/4] TCP_INQ support
In-Reply-To: <20211116134804.30090-1-fw@strlen.de>
Message-ID: <b51a1726-34f8-3a84-e5c8-83258a1b456@linux.intel.com>
References: <20211116134804.30090-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 16 Nov 2021, Florian Westphal wrote:

> No major changes since v2, see individual patches for details.
>
> This adds TCP_INQ for mptcp and extends the selftest infra.
> Patch 3 adds ioctls to retrieve amount of in-sequence bytes
> ready to for read() (older version of TCP_INQ) and counters for
> unsent and unacked byte count.
>
> Last patch is new in v2, its a more specific TCP_INQ test case.
> See individual patches for changes since v1.
>
> Florian Westphal (4):
>  mptcp: add TCP_INQ cmsg support
>  selftests: mptcp: add TCP_INQ support
>  mptcp: add SIOCINQ, OUTQ and OUTQNSD ioctls
>  selftests: mptcp: add inq test case
>
> net/mptcp/protocol.c                          |  89 ++-
> net/mptcp/protocol.h                          |   1 +
> net/mptcp/sockopt.c                           |  37 ++
> tools/testing/selftests/net/mptcp/.gitignore  |   1 +
> tools/testing/selftests/net/mptcp/Makefile    |   2 +-
> .../selftests/net/mptcp/mptcp_connect.c       |  58 +-
> tools/testing/selftests/net/mptcp/mptcp_inq.c | 603 ++++++++++++++++++
> .../selftests/net/mptcp/mptcp_sockopt.sh      |  44 +-
> 8 files changed, 830 insertions(+), 5 deletions(-)
> create mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c
>
> -- 
> 2.32.0
>

Thanks for the revisions Florian. Looks good to me (with the one comment 
about the unused variable warnings in patch 4 to address before 
upstreaming).

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
