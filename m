Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCD3481
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 00:27:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="212585459"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="212585459"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 17:27:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="475468940"
Received: from navarrof-mobl.amr.corp.intel.com ([10.252.140.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 17:27:16 -0700
Date: Tue, 27 Jul 2021 17:27:15 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [MPTCP][PATCH v5 mptcp-next 0/5] MP_FAIL support
In-Reply-To: <cover.1627281326.git.geliangtang@xiaomi.com>
Message-ID: <80cc102e-39d8-f779-866e-5772ed2a9f@linux.intel.com>
References: <cover.1627281326.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 26 Jul 2021, Geliang Tang wrote:

> From: Geliang Tang <geliangtang@xiaomi.com>
>
> v5:
> - patch 1, change "ret = true;" to "return true;"
> - patch 3, in the single-subflow case, send MP_FAIL and receive the
>   echo, then temporarily handled by reset.
>

Hi Geliang -

Thanks for the v5 changes. The changes are looking good in terms of manual 
code review. Since the selftest changes in patch 5 only confirm that 
MP_FAIL was not sent, I'm going to do some testing tomorrow to force 
checksum failures in single and multiple subflow cases so I can check some 
packet traces. It would be good to have some packetdrill checksum test 
cases to cover that, but we don't yet.


- Mat


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
> net/mptcp/options.c                           | 78 ++++++++++++++++++-
> net/mptcp/pm.c                                | 20 +++++
> net/mptcp/protocol.h                          | 20 +++++
> net/mptcp/subflow.c                           | 18 +++++
> .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++
> 8 files changed, 178 insertions(+), 5 deletions(-)
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
