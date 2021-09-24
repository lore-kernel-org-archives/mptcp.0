Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465629CA
	for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 21:12:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="246639630"
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="246639630"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:12:44 -0700
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="704320273"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.52.210])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:12:44 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com
Subject: [PATCH net-next 0/5] mptcp: Miscellaneous fixes
Date: Fri, 24 Sep 2021 14:12:33 -0700
Message-Id: <20210924211238.162509-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are five changes we've collected and tested in the mptcp-tree:

Patch 1 changes handling of the MPTCP-level snd_next value during the
recovery phase after a subflow link failure.

Patches 2 and 3 are some small refactoring changes to replace some
open-coded bits.

Patch 4 removes an unused field in struct mptcp_sock.

Patch 5 restarts the MPTCP retransmit timer when there is
not-yet-transmitted data to send and all previously sent data has been
acknowledged. This prevents some sending stalls.


Florian Westphal (3):
  mptcp: do not shrink snd_nxt when recovering
  mptcp: remove tx_pending_data
  mptcp: re-arm retransmit timer if data is pending

Geliang Tang (1):
  mptcp: use OPTIONS_MPTCP_MPC

Paolo Abeni (1):
  mptcp: use lockdep_assert_held_once() instead of open-coding it

 net/mptcp/options.c  | 15 +++------
 net/mptcp/protocol.c | 75 ++++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h |  1 -
 3 files changed, 56 insertions(+), 35 deletions(-)


base-commit: acde891c243c1ed85b19d4d5042bdf00914f5739
-- 
2.33.0

