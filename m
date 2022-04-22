Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD52F4E
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 21:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650664551; x=1682200551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OLEkBdK7onccBpmQX1luhp5dKr/ZK3Z7PbbHCEDcqyg=;
  b=Na6IPJBJkrm7NqqJiRtclnDXGrkgZ3OMZltMJgLaB4hSLd500zT6XIYN
   OTjznbTkuvEWVl3T27zztVO7JuNq1eqUPBNfQrrhrh71mLaPHPbDFA6d6
   HQQ+2Dq8pqbv4eL+GBUE3Kylck89QOPwxZ5/rJxpkwbiB72qUhd+etkrX
   EresYFX1TLQuyyawuPuCqTFifsQzmPrjjyw+I/U+niYBEqLvQNqu4BDQi
   Rq1C9h7IuKt+1m12i8DaJcEx64Vcdi1eUosRadtvfruBSjmTGGGlWpdBe
   F9M2tLD4+prW7K1V+lkeiohNssYCmubgCyyjzeYJuJaEo9wBcL9OMmZ6N
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244720727"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="244720727"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:55:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="578119257"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.99.29])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:55:48 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/8] mptcp: add the fallback check
Date: Fri, 22 Apr 2022 14:55:37 -0700
Message-Id: <20220422215543.545732-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220422215543.545732-1-mathew.j.martineau@linux.intel.com>
References: <20220422215543.545732-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch adds the fallback check in subflow_check_data_avail(). Only
do the fallback when the msk hasn't fallen back yet.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/subflow.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f217926f6a9c..7f26a5b04ad3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1203,35 +1203,38 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	return false;
 
 fallback:
-	/* RFC 8684 section 3.7. */
-	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk)) {
+	if (!__mptcp_check_fallback(msk)) {
+		/* RFC 8684 section 3.7. */
+		if (subflow->send_mp_fail) {
+			if (mptcp_has_another_subflow(ssk)) {
+				ssk->sk_err = EBADMSG;
+				tcp_set_state(ssk, TCP_CLOSE);
+				subflow->reset_transient = 0;
+				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+				tcp_send_active_reset(ssk, GFP_ATOMIC);
+				while ((skb = skb_peek(&ssk->sk_receive_queue)))
+					sk_eat_skb(ssk, skb);
+			}
+			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+			return true;
+		}
+
+		if (subflow->mp_join || subflow->fully_established) {
+			/* fatal protocol error, close the socket.
+			 * subflow_error_report() will introduce the appropriate barriers
+			 */
 			ssk->sk_err = EBADMSG;
 			tcp_set_state(ssk, TCP_CLOSE);
 			subflow->reset_transient = 0;
-			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			tcp_send_active_reset(ssk, GFP_ATOMIC);
-			while ((skb = skb_peek(&ssk->sk_receive_queue)))
-				sk_eat_skb(ssk, skb);
+			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+			return false;
 		}
-		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
-		return true;
-	}
 
-	if (subflow->mp_join || subflow->fully_established) {
-		/* fatal protocol error, close the socket.
-		 * subflow_error_report() will introduce the appropriate barriers
-		 */
-		ssk->sk_err = EBADMSG;
-		tcp_set_state(ssk, TCP_CLOSE);
-		subflow->reset_transient = 0;
-		subflow->reset_reason = MPTCP_RST_EMPTCP;
-		tcp_send_active_reset(ssk, GFP_ATOMIC);
-		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
-		return false;
+		__mptcp_do_fallback(msk);
 	}
 
-	__mptcp_do_fallback(msk);
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
-- 
2.36.0

