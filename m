Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11052FB2
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 23:46:34 +0000 (UTC)
IronPort-SDR: yDqAMUTUmcDWiuHn7fKAVlv1/nL6gW1oiyHm9NS6OK3lLp/j6MkRiEpI9DHkTpL+fSajHnhP9T
 hVQHmCbNlzxQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="270316973"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="270316973"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 16:46:33 -0700
IronPort-SDR: 8GiAdAH02eEJVaKhqz+FI74k4TAUwJATquH5i8T8DQqHm/rmH+Zmp3cL26N0GxNeZc8WpgXWU7
 u6RSLo02bPpA==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="452943918"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.250.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 16:46:32 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	geliangtang@gmail.com,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 11/16] mptcp: tune re-injections for csum enabled mode
Date: Thu, 17 Jun 2021 16:46:17 -0700
Message-Id: <20210617234622.472030-12-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617234622.472030-1-mathew.j.martineau@linux.intel.com>
References: <20210617234622.472030-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

If the MPTCP-level checksum is enabled, on re-injections we
must spool a complete DSS, or the receive side will not be
able to compute the csum and process any data.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b6e5c0930533..42fc7187beee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2375,8 +2375,8 @@ static void __mptcp_retrans(struct sock *sk)
 
 	/* limit retransmission to the bytes already sent on some subflows */
 	info.sent = 0;
-	info.limit = dfrag->already_sent;
-	while (info.sent < dfrag->already_sent) {
+	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
+	while (info.sent < info.limit) {
 		if (!mptcp_alloc_tx_skb(sk, ssk))
 			break;
 
@@ -2388,9 +2388,11 @@ static void __mptcp_retrans(struct sock *sk)
 		copied += ret;
 		info.sent += ret;
 	}
-	if (copied)
+	if (copied) {
+		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
+	}
 
 	mptcp_set_timeout(sk, ssk);
 	release_sock(ssk);
-- 
2.32.0

