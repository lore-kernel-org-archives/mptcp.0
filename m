Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C970
	for <mptcp@lists.linux.dev>; Wed,  4 Aug 2021 00:42:31 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="213800750"
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="213800750"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 17:42:31 -0700
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="458453917"
Received: from takbas-mobl.amr.corp.intel.com ([10.212.253.160])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 17:42:30 -0700
Date: Tue, 3 Aug 2021 17:42:30 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [MPTCP][PATCH v7 mptcp-next 0/5] MP_FAIL support
In-Reply-To: <cover.1627547666.git.geliangtang@xiaomi.com>
Message-ID: <d345bd98-3b46-50bf-5e20-3ec28e4eda41@linux.intel.com>
References: <cover.1627547666.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 29 Jul 2021, Geliang Tang wrote:

> From: Geliang Tang <geliangtang@xiaomi.com>
>
> v7:
> - The single subflow case is handled by sending MP_FAIL + RST instead
>   of sending MP_FAIL echo.
>

Hi Geliang -

I ran some tests using your checksum test patch, and verified the single 
subflow behavior. So I think this looks good for the export branch:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


Thanks,

Mat


> v6: only rebased patch 1
> - move the struct member 'fail_seq' behind 'ext_copy'.
> - define OPTION_MPTCP_FAIL to BIT(12), BIT(11) is used by DSS
> - move the MP_FAIL writing code at the beginning of mptcp_write_options,
>   and add the 'unlikely' tag.
> - tag: export/20210728T080904
>
> v5:
> - patch 1, change "ret = true;" to "return true;"
> - patch 3, in the single-subflow case, send MP_FAIL and receive the
>   echo, then temporarily handled by reset.
>
> v4:
> - just deal with the multiple subflows case, put the single subflow
>   case into the new 'infinite mapping' part.
>
> v3:
> - respond with MP_FAIL
> - add single subflow check
> - add infinite mapping sending and receiving
> - export/20210626T054902
>
> v2:
> - MP_FAIL logic:
>   * Peer B send a DSS to peer A, and the data has been modify by the
>  middleboxes, then peer A detects the bad checksum.
>   * In the multiple subflows case, peer A sends MP_FAIL+RST back to peer B,
>  and peer A discards the data following the bad data sequence number. Peer
>  B receives this MP_FAIL+RST, and close this subflow.
>   * In the single subflow case, using the simple implementation, peer A
>  sends MP_FAIL back to peer B, and peer A fallback to a regular TCP. Peer
>  B receives this MP_FAIL, and fallback to a regular TCP.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/52
>
> Geliang Tang (5):
>  mptcp: MP_FAIL suboption sending
>  mptcp: MP_FAIL suboption receiving
>  mptcp: send out MP_FAIL when data checksum fails
>  mptcp: add the mibs for MP_FAIL
>  selftests: mptcp: add MP_FAIL mibs check
>
> include/net/mptcp.h                           |  5 +-
> net/mptcp/mib.c                               |  2 +
> net/mptcp/mib.h                               |  2 +
> net/mptcp/options.c                           | 76 ++++++++++++++++++-
> net/mptcp/pm.c                                |  5 ++
> net/mptcp/protocol.h                          | 19 +++++
> net/mptcp/subflow.c                           | 16 ++++
> .../testing/selftests/net/mptcp/mptcp_join.sh | 38 ++++++++++
> 8 files changed, 158 insertions(+), 5 deletions(-)
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
