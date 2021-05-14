Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71572
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 19:10:10 +0000 (UTC)
IronPort-SDR: cxoPN7BEnSex5y5pEWODbF2+xvGEWtxgKSh+O51w5+3Rici8HfqlMDlOLfxn8iuCbHItYQ3vVB
 MnMRFhjakN0Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="200274831"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="200274831"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:10:09 -0700
IronPort-SDR: 3OK0NvxNuhty/t+gVxaGyfkflB4P51pIg942wUhReeBqFEBCFGv6o8Q3eCyEq5v4/umzuZjgws
 nhdfXNFQTfjQ==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="431827427"
Received: from akshtadu-mobl.amr.corp.intel.com ([10.251.18.116])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:10:08 -0700
Date: Fri, 14 May 2021 12:10:08 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 7/7] selftests: mptcp_connect: add
 SO_TIMESTAMPNS cmsg support
In-Reply-To: <20210514094857.10663-8-fw@strlen.de>
Message-ID: <58b487e3-7527-cbc5-377c-664ddbc8f2c@linux.intel.com>
References: <20210514094857.10663-1-fw@strlen.de> <20210514094857.10663-8-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 May 2021, Florian Westphal wrote:

> This extends the existing setsockopt test case to also check for cmsg
> timestamps.
>
> mptcp_connect will abort/fail if the setockopt was passed but the
> timestamp cmsg isn't present after successful recvmsg().
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> .../selftests/net/mptcp/mptcp_connect.c       | 125 +++++++++++++++++-
> .../selftests/net/mptcp/mptcp_sockopt.sh      |   4 +-
> 2 files changed, 126 insertions(+), 3 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
