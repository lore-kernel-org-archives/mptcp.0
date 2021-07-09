Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3B168
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 00:51:48 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="209441563"
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="209441563"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 17:51:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="564736463"
Received: from pkadam-mobl1.amr.corp.intel.com ([10.212.141.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 17:51:47 -0700
Date: Thu, 8 Jul 2021 17:51:47 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, fwestpha@redhat.com
Subject: Re: [PATCH mptcp-next 7/7] selftests: mptcp: add testcase for
 active-back
In-Reply-To: <84049ecdf3185b99e16ffc17be6594cfafd57119.1624895054.git.pabeni@redhat.com>
Message-ID: <15d981a-acb3-61c0-1a79-ea703b1db2c9@linux.intel.com>
References: <cover.1624895054.git.pabeni@redhat.com> <84049ecdf3185b99e16ffc17be6594cfafd57119.1624895054.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 28 Jun 2021, Paolo Abeni wrote:

> Add more test-case for link failures scenario,
> including recovery from link failure using only
> backup subflows and bi-directional transfer.
>
> Additionally explicitly check for stale count
>

I get a lot of intermittent failures due to the expected stale count 
range, like this:

15 multiple flows, signal, bidirectional, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         add[ ok ] - echo  [ ok ]
                                         stale[fail] got 19 stale[s] 18 recover[s],   expected stale in range [1..5],  stale-recover delta 1

02 multiple flows, signal, bidirectional, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         add[ ok ] - echo  [ ok ]
                                         stale[fail] got 11 stale[s] 10 recover[s],   expected stale in range [1..5],  stale-recover delta 1

02 multiple flows, signal, bidirectional, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         add[ ok ] - echo  [ ok ]
                                         stale[fail] got 51 stale[s] 50 recover[s],   expected stale in range [1..5],  stale-recover delta 1


and


18 backup subflow in use, bidirectional, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         add[ ok ] - echo  [ ok ]
                                         stale[fail] got 8 stale[s] 6 recover[s],   expected stale in range [2..4],  stale-recover delta 2

05 backup subflow in use, bidirectional, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         add[ ok ] - echo  [ ok ]
                                         stale[fail] got 8 stale[s] 6 recover[s],   expected stale in range [2..4],  stale-recover delta 2

I also saw one instance of a poll timeout failure in the "backup subflow 
in use, bidirectional, link failure" case. Let me know if you want the 
logs for that.


> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 185 +++++++++++++++---
> 1 file changed, 156 insertions(+), 29 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 9a191c1a5de8..e7c021d199e3 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

...

> @@ -1288,6 +1412,9 @@ v4mapped_tests()
>
> backup_tests()
> {
> +	local rx_backup
> +	local tx_backup
> +

These aren't used (yet?)

> 	# single subflow, backup
> 	reset
> 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1

--
Mat Martineau
Intel
