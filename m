Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966910E1
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 23:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645744951; x=1677280951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jcxPSYB1Zxxid+t+G+YhJEo7aY7Sfx9GM5su9zqZIAU=;
  b=ES4bUC9vRm0v5UAquUz8X/Br/CsV9k1DeHsg/x0P32itdYargckcVlO6
   46GRFXWGBkbp82Ylu/LxM4+X4RTMsGNg334jdkcp7JUvBwHmQGvyJEI97
   JSjibmP8okvfaQXAeHznFAgIJIZzU/1OnuFp1AStSl7N7LxQFh3NyP+d8
   fyqPRkB2igdX4sivYRtNVEYRBMtUUvHcsMiUMFg81kytkvQRBU+TRENvv
   +yLi79WqsA9rkLK5qmcuLn0L4f+pnEF3ihKaZH155WCYWFjWZOsdEH1r6
   iD2nMBjW/GZhPSAosDq/RmFqUXwzPdNe2tRFjG8kdZpIb3fDHAZZmrnhb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232998399"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="232998399"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:22:28 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="491784932"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.28.67])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:22:28 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	fw@strlen.de
Subject: [RFC PATCH mptcp-next 3/4] tcp: Check for the presence of a MP_JOIN option
Date: Thu, 24 Feb 2022 15:22:25 -0800
Message-Id: <20220224232226.259304-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224232226.259304-1-mathew.j.martineau@linux.intel.com>
References: <20220224232226.259304-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a bit to struct tcp_options_received and set that bit if a
MPTCP option with the MP_JOIN subtype is present in a TCP header.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/linux/tcp.h  | 3 ++-
 net/ipv4/tcp_input.c | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1168302b7927..46a14bce8019 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -93,7 +93,8 @@ struct tcp_options_received {
 		snd_wscale : 4,	/* Window scaling received from sender	*/
 		rcv_wscale : 4;	/* Window scaling to send to receiver	*/
 	u8	saw_unknown:1,	/* Received unknown option		*/
-		unused:7;
+		saw_mp_join:1,	/* Received MPTCP MP_JOIN		*/
+		unused:6;
 	u8	num_sacks;	/* Number of SACK blocks		*/
 	u16	user_mss;	/* mss requested by user in ioctl	*/
 	u16	mss_clamp;	/* Maximal mss, negotiated at connection setup */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7eb02f9da3c9..845f0e6906b5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4122,6 +4122,14 @@ void tcp_parse_options(const struct net *net,
 				opt_rx->saw_unknown = 1;
 				break;
 
+			case TCPOPT_MPTCP:
+				__u8 mptcp_subtype = *ptr >> 4;
+
+				if (mptcp_subtype == MPTCPOPT_MP_JOIN)
+					opt_rx->saw_mp_join = 1;
+
+				break;
+
 			default:
 				opt_rx->saw_unknown = 1;
 			}
-- 
2.35.1

