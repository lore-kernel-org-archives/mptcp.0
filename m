Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E010E2
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 23:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645744951; x=1677280951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MPcoIlfb8cRyOXEBIy/zCEWbrLuumRm9LC6RGE9AxLE=;
  b=V1xqvcKvlT5VrxakkfF5GRJNF9ZrioiJagQnLFOrjAb/mxEO6KlFGZsn
   cIzdGTwxOGk2qr83JBWfcfLxkxHB/ncEOD+2xrGh3HfoRwy1mOvTBpgw5
   D3TyRYwbPbWDDFZU7pUPlqgBHM9QpNDvWxNa3iYn1FetEfk78xSipW1IZ
   LwGbLQK0aiA/MIiIwUXOV3ygVuli+4rLvcLpshUlYvFpFTqT5RqXM5jMy
   nf47ILy4z1Gak4j4FSPg/RbqHHAlPvOhwOQyQ2sJtJykIcl4raOnvcRbc
   /1l8sdYDS7lTrecdSwXn/kEj8qx9jZVICcPHjrw4mZOn3BPWvhVIWaX23
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232998400"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="232998400"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:22:28 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="491784933"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.28.67])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:22:28 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	fw@strlen.de
Subject: [RFC PATCH mptcp-next 4/4] tcp: Add TCP hooks for detecting MP_JOIN on a regular TCP listener
Date: Thu, 24 Feb 2022 15:22:26 -0800
Message-Id: <20220224232226.259304-5-mathew.j.martineau@linux.intel.com>
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

MPTCP uses a TCP SYN packet with the MP_JOIN option to add subflows to
an existing MPTCP connection. This uses token lookup to match the
incoming SYN with the appropriate MPTCP socket instead of the port
number (in accordance with RFC 8684), and it is possible for a TCP
listener to be present at the port that the MPTCP peer is trying to
connect to. If the TCP listener ignores the MP_JOIN option and sends a
normal TCP SYN-ACK without a MP_JOIN option header, the peer will be
forced to send a RST.

Given that a peer sending MP_JOIN is guaranteed to reject a regular TCP
SYN-ACK, it's better to attempt a MPTCP token lookup and either let
MPTCP continue the handshake or immediately reject the connection
attempt.

The only new conditional in the TCP SYN handling hot path is a check of
the saw_mp_join bit. If that is set, tcp_check_req() returns early and
tcp_v4_rcv() or tcp_v6_rcv() call the MPTCP join handler in an error
path.

If MPTCP is not configured, all the code added in this commit should be
optimized away.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/ipv4/tcp_ipv4.c      | 7 +++++++
 net/ipv4/tcp_minisocks.c | 8 +++++++-
 net/ipv6/tcp_ipv6.c      | 7 +++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 73e5726af8d0..124ad393e6fb 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2082,6 +2082,13 @@ int tcp_v4_rcv(struct sk_buff *skb)
 				tcp_v4_restore_cb(skb);
 				sock_put(sk);
 				goto lookup;
+			} else if (req_status == TCP_REQ_MP_JOIN) {
+				struct sock *msk = mptcp_handle_join4(skb);
+
+				if (msk) {
+					sk = msk;
+					goto process;
+				}
 			}
 			goto discard_and_relse;
 		}
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 3d989f8676a5..4fdca31b33bb 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -572,10 +572,16 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	tmp_opt.saw_tstamp = 0;
+	tmp_opt.saw_mp_join = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
-		if (tmp_opt.saw_tstamp) {
+		if (unlikely(tmp_opt.saw_mp_join) &&
+		    mptcp_is_enabled(sock_net(sk))) {
+			*req_status = TCP_REQ_MP_JOIN;
+
+			return NULL;
+		} else if (tmp_opt.saw_tstamp) {
 			tmp_opt.ts_recent = req->ts_recent;
 			if (tmp_opt.rcv_tsecr)
 				tmp_opt.rcv_tsecr -= tcp_rsk(req)->ts_off;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4706aad6dd8f..d46fa8243e83 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1731,6 +1731,13 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 				tcp_v6_restore_cb(skb);
 				sock_put(sk);
 				goto lookup;
+			} else if (req_status == TCP_REQ_MP_JOIN) {
+				struct sock *msk = mptcp_handle_join6(skb);
+
+				if (msk) {
+					sk = msk;
+					goto process;
+				}
 			}
 			goto discard_and_relse;
 		}
-- 
2.35.1

