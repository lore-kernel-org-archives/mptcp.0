Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770552FAF
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 17:01:55 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="203522981"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="203522981"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 09:59:54 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="488807919"
Received: from mvanclea-mobl1.amr.corp.intel.com ([10.212.157.75])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 09:59:52 -0700
Date: Wed, 18 Aug 2021 09:59:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/5] mptcp: add SOL_MPTCP getsockopt
 support
In-Reply-To: <20210818102756.30734-1-fw@strlen.de>
Message-ID: <e71aceb0-299-c17d-28ec-5114ea5fc36c@linux.intel.com>
References: <20210818102756.30734-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 18 Aug 2021, Florian Westphal wrote:

> Changes in v3:
> - address comments from Mat.
>  This only affects selftest program (init 'fd' to -1).
>  Other than that, the only changes are in commit messages or
>  re-format of code (reverse xmas).
>

Thanks for the final adjustments - looks ready for the export branch now.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>



> Changes in v2:
> - move #define to start of file (Mat)
> - refer to '"multipath-tcp.org"', not mptcp.org (Mat)
> - use __kernel_sa_family_t in uapi header (test robot)
> - add test cases with invalid inputs (Paolo)
> - avoid duplicate mptcp_sockopt.h in Makefile (Paolo)
> - remove _u_optlen (Paolo)
>
> original cover letter:
>
> This adds the MPTCP_INFO, MPTCP_TCPINFO and MPTCP_SUBFLOW_ADDRS
> mptcp getsockopt optnames.
>
> MPTCP_INFO exposes the mptcp_info struct as an alternative to the
> existing netlink diag interface.
>
> MPTCP_TCPINFO exposes the tcp_info struct.
> Unlike SOL_TCP/TCP_INFO, this returns one struct for each active
> subflow.
>
> MPTCP_SUBFLOW_ADDRS allows userspace to discover the ip addresses/ports
> used by the local and remote endpoints, one for each active tcp subflow.
>
> MPTCP_TCPINFO and MPTCP_SUBFLOW_ADDRS share the same meta-header that
> needs to be pre-filled by userspace with the size of the data structures
> it expects.  This is done to allow extension of the involved structs
> later on, without breaking backwards compatibility.
>
> The meta-structure can also be used to discover the required space
> to obtain all information, as kernel will fill in the number of
> active subflows even if there is not enough room for the requested info
> itself.
>
> More information is available in the individual patches.
> Last patch adds test cases for the three optnames.
>
> Florian Westphal (5):
>  mptcp: add new mptcp_fill_diag helper
>  mptcp: add MPTCP_INFO getsockopt
>  mptcp: add MPTCP_TCPINFO getsockopt support
>  mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support
>  selftests: mptcp: add mptcp getsockopt test cases
>
> include/linux/socket.h                        |   1 +
> include/net/mptcp.h                           |   4 +
> include/uapi/linux/mptcp.h                    |  29 +
> net/mptcp/mptcp_diag.c                        |  26 +-
> net/mptcp/sockopt.c                           | 276 ++++++++
> tools/testing/selftests/net/mptcp/Makefile    |   2 +-
> .../selftests/net/mptcp/mptcp_sockopt.c       | 644 ++++++++++++++++++
> .../selftests/net/mptcp/mptcp_sockopt.sh      |  31 +-
> 8 files changed, 985 insertions(+), 28 deletions(-)
> create mode 100644 tools/testing/selftests/net/mptcp/mptcp_sockopt.c
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
