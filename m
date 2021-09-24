Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47773FCC
	for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 21:12:48 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="246639634"
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="246639634"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:12:45 -0700
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="704320282"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.52.210])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:12:44 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/5] mptcp: use OPTIONS_MPTCP_MPC
Date: Fri, 24 Sep 2021 14:12:35 -0700
Message-Id: <20210924211238.162509-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924211238.162509-1-mathew.j.martineau@linux.intel.com>
References: <20210924211238.162509-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

Since OPTIONS_MPTCP_MPC has been defined, use it instead of open-coding.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1ec6529c4326..422f4acfb3e6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -748,9 +748,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 	/* can't send MP_PRIO with MPC, as they share the same option space:
 	 * 'backup'. Also it makes no sense at all
 	 */
-	if (!subflow->send_mp_prio ||
-	    ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
-	      OPTION_MPTCP_MPC_ACK) & opts->suboptions))
+	if (!subflow->send_mp_prio || (opts->suboptions & OPTIONS_MPTCP_MPC))
 		return false;
 
 	/* account for the trailing 'nop' option */
@@ -1327,8 +1325,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 			}
 		}
-	} else if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
-		    OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
+	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
 		if (OPTION_MPTCP_MPC_SYN & opts->suboptions) {
-- 
2.33.0

