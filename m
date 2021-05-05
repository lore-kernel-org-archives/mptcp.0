Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282271
	for <mptcp@lists.linux.dev>; Wed,  5 May 2021 23:56:31 +0000 (UTC)
IronPort-SDR: z6mcSASkNSU+Ae6ixl79XNaMyBbCOQmgFjtSjpVi1f70GHgpZrulW1Lb9SUSc0iyUJyuTd17vI
 Xy/vnLyCuuBA==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="219207034"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="219207034"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 16:56:30 -0700
IronPort-SDR: yA6l92PUXbEu2ZbzBaCcknoHcmF7SLxi0SgGlDMDbzGcbYmgiC/s/5sCALcPlp4FKYIAjfr7qn
 nrKnNZBYLOAg==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="459019230"
Received: from ckanakam-mobl2.amr.corp.intel.com ([10.255.231.27])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 16:56:30 -0700
Date: Wed, 5 May 2021 16:56:30 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v6 mptcp-next 00/22] mptcp: data checksum support
In-Reply-To: <cover.1620163861.git.pabeni@redhat.com>
Message-ID: <4393f928-4ed8-8350-683d-cf5b93e9350@linux.intel.com>
References: <cover.1620163861.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 4 May 2021, Paolo Abeni wrote:

> Changes from v5:
> - none really, added patch lost in previous iteration due to PEBKAC
>
> Changes from v4:
> - cope with odd-aligned csum blocks
> - avoid re-adding multiple times the same skb bits on tx
> - fix pseudo header generation (must be in NBO)
>
> Changes from v3:
> - included Geliang's feedback
> - hopefully fixed wrong csum computation in the rx path
>   for DSS+data_fin
>
> Changes from v2:
> - implement RFC behavior WRT csum failure and csum mismatch
> - cope with zero win probe and re-injection
> - fix csum computation for DSS with data_fin flag set
>
> Only some Squash-to patches has been changes WRT the previous
> iteration.
>
> There is still at least a ough edge:
> - the csum computation in the tx path is very suboptimal.
>
> Anyhow, I propose to address the above with additional squash-to patches
> to avoid complex/extra long review cycles.

Thanks Paolo. Looking through the squash-to patches in v6, I don't have 
any changes to suggest right now. I agree that it would be good to add 
them to the export branch and then squash additional fixes before sending 
further upstream.

I did get a csum failure in mp_join.sh test 14:

14 multiple flows, signal, link failure syn[ ok ] - synack[ ok ] - ack[ ok 
]
                                         sum[fail] got 1 data checksum 
error[s] expected 0
  - csum  [ ok ]
Server ns stats
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             3                  0.0
MPTcpExtMPJoinAckRx             3                  0.0
MPTcpExtDSSCsumErr              1                  0.0
MPTcpExtOFOQueueTail            2624               0.0
MPTcpExtOFOQueue                2776               0.0
MPTcpExtOFOMerge                2395               0.0
MPTcpExtDuplicateData           67                 0.0
MPTcpExtEchoAdd                 1                  0.0
Client ns stats
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            45                 0.0
MPTcpExtMPJoinSynAckRx          3                  0.0
MPTcpExtAddAddr                 1                  0.0
                                         add[ ok ] - echo  [ ok ]

Unfortunately I wasn't running packet capture at the time, and I haven't 
duplicated the failure yet.


-Mat


>
> Geliang Tang (14):
>  mptcp: add csum_enabled in mptcp_sock
>  mptcp: generate the data checksum
>  mptcp: add csum_reqd in mptcp_out_options
>  mptcp: send out checksum for MP_CAPABLE with data
>  mptcp: send out checksum for DSS
>  mptcp: add sk parameter for mptcp_parse_option
>  mptcp: add csum_reqd in mptcp_options_received
>  mptcp: receive checksum for MP_CAPABLE with data
>  mptcp: receive checksum for DSS
>  mptcp: validate the data checksum
>  mptcp: add the mib for data checksum
>  mptcp: add a new sysctl checksum_enabled
>  selftests: mptcp: enable checksum in mptcp_connect.sh
>  selftests: mptcp: enable checksum in mptcp_join.sh
>
> Paolo Abeni (8):
>  Squash-to: "mptcp: generate the data checksum"
>  Squash-to: "mptcp: send out checksum for MP_CAPABLE with data"
>  Squash-to "mptcp: send out checksum for DSS"
>  Squash-to: "mptcp: receive checksum for MP_CAPABLE with data"
>  Squash-to: "mptcp: receive checksum for DSS"
>  Squash-to: mptcp: validate the data checksum
>  mptcp: cleanup error path in subflow_check_data_avail()
>  mptcp: tune re-injections for csum enabled mode.
>
> Documentation/networking/mptcp-sysctl.rst     |   8 +
> include/net/mptcp.h                           |   7 +-
> include/uapi/linux/mptcp.h                    |   1 +
> net/mptcp/ctrl.c                              |  14 ++
> net/mptcp/mib.c                               |   1 +
> net/mptcp/mib.h                               |   1 +
> net/mptcp/mptcp_diag.c                        |   1 +
> net/mptcp/options.c                           | 165 +++++++++++++-----
> net/mptcp/protocol.c                          |  29 ++-
> net/mptcp/protocol.h                          |  23 ++-
> net/mptcp/subflow.c                           | 146 +++++++++++++---
> .../selftests/net/mptcp/mptcp_connect.sh      |  13 +-
> .../testing/selftests/net/mptcp/mptcp_join.sh | 107 +++++++++++-
> 13 files changed, 440 insertions(+), 76 deletions(-)
>
> -- 
> 2.26.2
>
>
>

--
Mat Martineau
Intel
