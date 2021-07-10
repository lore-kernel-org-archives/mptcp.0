Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212472
	for <mptcp@lists.linux.dev>; Sat, 10 Jul 2021 00:21:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="190179047"
X-IronPort-AV: E=Sophos;i="5.84,228,1620716400"; 
   d="scan'208";a="190179047"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 17:20:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,228,1620716400"; 
   d="scan'208";a="462343530"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.240.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 17:20:56 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	pabeni@redhat.com,
	fw@strlen.de,
	geliangtang@gmail.com,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/6] mptcp: Connection and accounting fixes
Date: Fri,  9 Jul 2021 17:20:45 -0700
Message-Id: <20210710002051.216010-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are some miscellaneous fixes for MPTCP:

Patch 1 modifies an MPTCP hash so it doesn't depend on one of skb->dev
and skb->sk being non-NULL.

Patch 2 removes an extra destructor call when rejecting a join due to
port mismatch.

Patches 3 and 5 more cleanly handle error conditions with MP_JOIN and
syncookies, and update a related self test.

Patch 4 makes sure packets that trigger a subflow TCP reset during MPTCP
option header processing are correctly dropped.

Patch 6 addresses a rmem accounting issue that could keep packets in
subflow receive buffers longer than necessary, delaying MPTCP-level
ACKs.


Jianguo Wu (5):
  mptcp: fix warning in __skb_flow_dissect() when do syn cookie for
    subflow join
  mptcp: remove redundant req destruct in subflow_check_req()
  mptcp: fix syncookie process if mptcp can not_accept new subflow
  mptcp: avoid processing packet if a subflow reset
  selftests: mptcp: fix case multiple subflows limited by server

Paolo Abeni (1):
  mptcp: properly account bulk freed memory

 include/net/mptcp.h                           |  5 +++--
 net/ipv4/tcp_input.c                          | 19 +++++++++++++++----
 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  1 +
 net/mptcp/options.c                           | 19 +++++++++++++------
 net/mptcp/protocol.c                          | 12 +++++++-----
 net/mptcp/protocol.h                          | 10 +++++++++-
 net/mptcp/subflow.c                           | 11 +++--------
 net/mptcp/syncookies.c                        | 16 +++++++++++++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  2 +-
 10 files changed, 68 insertions(+), 28 deletions(-)

-- 
2.32.0

