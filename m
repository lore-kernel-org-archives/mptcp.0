Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920CF70
	for <mptcp@lists.linux.dev>; Tue,  6 Apr 2021 00:48:08 +0000 (UTC)
IronPort-SDR: /BkusIj3cQwWmpAkYLw0U2n+KFA3Nh6SjnvkraHBXU9SFLfKGdPasrEW+nuVlxfUA+BgMfPIs0
 05eF4BR/HIaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180083592"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="180083592"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 17:48:05 -0700
IronPort-SDR: cdAtzmz7VlU8K077BgNQLThYBipZiqEFYq5E2JmchqFKq/t5zsX6OaRfDI1UqWMFGkdOWdI2mv
 iuJHfA+ONZNQ==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="379173379"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.255.228.70])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 17:47:55 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	pabeni@redhat.com
Subject: [RFC PATCH mptcp-next] mptcp: Retransmit DATA_FIN
Date: Mon,  5 Apr 2021 17:47:50 -0700
Message-Id: <20210406004750.14212-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With this change, the MPTCP-level retransmission timer is used to resend
DATA_FIN. The retranmit timer is not stopped while waiting for a
MPTCP-level ACK of DATA_FIN, and retransmitted DATA_FINs are sent on all
subflows.

There are still important things to address to move this beyond a RFC
patch:

1. Additional limits on the time that an MPTCP socket waits for a
DATA_FIN. Do we need to support TCP_LINGER2?

2. Retransmission rate. In testing, it looks like TCP_RTO_MIN is used,
so DATA_FIN is resent every 200ms. Too fast?

3. Testing. Rely on packetdrill?

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d895c3c8746..ca34b2828fc3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1032,7 +1032,8 @@ static void __mptcp_clean_una(struct sock *sk)
 		}
 	}
 
-	if (snd_una == READ_ONCE(msk->snd_nxt)) {
+	if (snd_una == READ_ONCE(msk->snd_nxt) &&
+	    !mptcp_data_fin_enabled(msk)) {
 		if (msk->timer_ival)
 			mptcp_stop_timer(sk);
 	} else {
@@ -2247,8 +2248,16 @@ static void __mptcp_retrans(struct sock *sk)
 
 	__mptcp_clean_una_wakeup(sk);
 	dfrag = mptcp_rtx_head(sk);
-	if (!dfrag)
+	if (!dfrag) {
+		if (mptcp_data_fin_enabled(msk)) {
+			mptcp_set_timeout(sk, NULL);
+			mptcp_send_ack(msk);
+
+			goto reset_timer;
+		}
+
 		return;
+	}
 
 	ssk = mptcp_subflow_get_retrans(msk);
 	if (!ssk)
-- 
2.31.1

