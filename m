Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB02770
	for <mptcp@lists.linux.dev>; Mon,  2 Aug 2021 23:38:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="200724186"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="200724186"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 16:38:07 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="666835851"
Received: from necannon-mobl.amr.corp.intel.com ([10.212.133.159])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 16:38:06 -0700
Date: Mon, 2 Aug 2021 16:38:05 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Patches ready for net-next
Message-ID: <d015d3be-ca34-56bb-4a85-1660fcc13bb5@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1113292549-1627947486=:14340"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1113292549-1627947486=:14340
Content-Type: text/plain; format=flowed; charset=UTF-8
Content-Transfer-Encoding: 8BIT


Hi Paolo -

On Thursday we talked about patches to send next:

Patches to send to netdev:
     - net-next:
         - 2 series are ready:
             - Paolo's series (backup / scheduler):
                 → maybe best to wait, see issues/219
             - Yonglong & Geliang's series (ADD_ADDR/RM_ADDR refactor)

I saw your comment on 
https://github.com/multipath-tcp/mptcp_net-next/issues/219, you mentioned 
that the two newest patches on the export branch looked like they were not 
related to the divide error seen by syzkaller. Any reason to wait on 
sending the active-backup series earlier in the export branch:

9058115c3ff7 selftests: mptcp: add testcase for active-back
8a8c8b5711d7 mptcp: backup flag from incoming MPJ ack option
1f05f7524500 mptcp: add mibs for stale subflows processing
f1abc22dbc32 mptcp: faster active backup recovery
69a226d4b8c4 mptcp: cleanup sysctl data and helpers
f0699e78732e mptcp: handle pending data on closed subflow
167e8cf026aa mptcp: less aggressive retransmission strategy
77477273b6de mptcp: more accurate timeout

?


Thanks,

--
Mat Martineau
Intel
--0-1113292549-1627947486=:14340--
