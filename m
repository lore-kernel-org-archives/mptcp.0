Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C816D00
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 23:31:46 +0000 (UTC)
IronPort-SDR: +p/9lfl4BmwZJMSZMUWYO5B8/PtIF3oDoKR0n3c1Y5IJzERFXHfmtSL/Ja2HvWbICNdAGKrzaq
 SYWZ+wi+hYWA==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="202623684"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="202623684"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:31:45 -0700
IronPort-SDR: R/G+pz4gfW74pjTxC7PXtjO4LjKr3lEJhcGj3FkBY+TQiJKLzIUmvKlh7rGW+DhafuxgPzkdGx
 A3rDP+VgRzgA==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="477700330"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.84.136])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:31:45 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/4] mptcp: Fixes for 5.13
Date: Thu, 27 May 2021 16:31:36 -0700
Message-Id: <20210527233140.182728-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches address two issues in MPTCP.

Patch 1 fixes a locking issue affecting MPTCP-level retransmissions.

Patches 2-4 improve handling of out-of-order packet arrival early in a
connection, so it falls back to TCP rather than forcing a
reset. Includes a selftest.

Paolo Abeni (4):
  mptcp: fix sk_forward_memory corruption on retransmission
  mptcp: always parse mptcp options for MPC reqsk
  mptcp: do not reset MP_CAPABLE subflow on mapping errors
  mptcp: update selftest for fallback due to OoO

 net/mptcp/protocol.c                          | 16 +++-
 net/mptcp/subflow.c                           | 79 ++++++++++---------
 .../selftests/net/mptcp/mptcp_connect.sh      | 13 ++-
 3 files changed, 64 insertions(+), 44 deletions(-)


base-commit: fb91702b743dec78d6507c53a2dec8a8883f509d
-- 
2.31.1

