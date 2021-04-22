Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BBB71
	for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 01:13:00 +0000 (UTC)
IronPort-SDR: nDCJyfsLO+b/WacpadT/US+gfbAU9a4TKtcYYMB/b2zCCrNxeH41uHYSGrvZX/CvnRTyePORGI
 CvultMF/4hrg==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="259760936"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="259760936"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 18:12:59 -0700
IronPort-SDR: jTA34BK95wwNDZcLYCA5pgJp6QjQuA+pe5q5cT3VIifFutRy0oL7czry5Xby6mPKsi7apwtHHy
 4QRNCDmbEmJA==
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="401667568"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.162.177])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 18:12:59 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	pabeni@redhat.com
Subject: [PATCH mptcp-next] Squash to: mptcp: Retransmit DATA_FIN
Date: Wed, 21 Apr 2021 18:12:51 -0700
Message-Id: <20210422011251.299480-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix timer logic in __mptcp_clean_una(). Only look at DATA_FIN enable
when snd_una and snd_nxt match to avoid bad calls to mptcp_reset_timer().

Thank you Paolo for adding the WARN_ON() to mptcp_reset_timer()!

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 661873b373e3..6cbddfc18158 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1069,9 +1069,8 @@ static void __mptcp_clean_una(struct sock *sk)
 		}
 	}
 
-	if (snd_una == READ_ONCE(msk->snd_nxt) &&
-	    !mptcp_data_fin_enabled(msk)) {
-		if (msk->timer_ival)
+	if (snd_una == READ_ONCE(msk->snd_nxt)) {
+		if (msk->timer_ival && !mptcp_data_fin_enabled(msk))
 			mptcp_stop_timer(sk);
 	} else {
 		mptcp_reset_timer(sk);
-- 
2.31.1

