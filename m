Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC571
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 18:17:15 +0000 (UTC)
IronPort-SDR: 4k3Ud2ZQRJ1nO34igLKffNsbSxXFeJmk+0fUhleWm1ACk8t09Eb8lt0CjFhxqWuOly4cSTZtg0
 1RLi1TTxXGUw==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="183243827"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="183243827"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:17:14 -0700
IronPort-SDR: LW9qXCt4g0q1brPfHw6YMETn7T8DGBIsajekmhAS4v7hpFBIvz5vPor+9Vbkidv7c9kJ5Gbkot
 rgTwGmZHT7hA==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="402264966"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.254.72.13])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:17:14 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/5] mptcp: Compatibility with common msg flags
Date: Fri, 23 Apr 2021 11:17:04 -0700
Message-Id: <20210423181709.330233-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches from the MPTCP tree handle some of the msg flags that are
typically used with TCP, to make it easier to adapt userspace programs
for use with MPTCP.

Patches 1, 2, and 4 add support for MSG_ERRQUEUE (no-op for now),
MSG_TRUNC, and MSG_PEEK on the receive side.

Patch 3 ignores unsupported msg flags for send and receive.

Patch 5 adds a selftest for MSG_PEEK.


Paolo Abeni (3):
  mptcp: implement dummy MSG_ERRQUEUE support
  mptcp: implement MSG_TRUNC support
  mptcp: ignore unsupported msg flags

Yonglong Li (2):
  mptcp: add MSG_PEEK support
  selftests: mptcp: add a test case for MSG_PEEK

 net/mptcp/protocol.c                          | 49 ++++++++++++-------
 .../selftests/net/mptcp/mptcp_connect.c       | 48 +++++++++++++++++-
 .../selftests/net/mptcp/mptcp_connect.sh      | 29 ++++++++---
 3 files changed, 99 insertions(+), 27 deletions(-)


base-commit: cad4162a90aeff737a16c0286987f51e927f003a
-- 
2.31.1

