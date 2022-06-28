Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE2370
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 01:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656378172; x=1687914172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i6wITeGD2ci5ZfC2XCyuFVON6e/8N77vyd9vkqBeJqU=;
  b=GW4alMs//NbAeL6m715SgnHunyIf+k64/JLvtDTeEfYvkLoDGnEzU/C1
   0TkTEqR/w39mRrF7A52L+NyOPK5kyB8utAsh9jDa3JrHzSLcSkNheIdBf
   yr6e+O8ImmIEyTFqARizVEWEQu6uhgdW4erWzGayOqAmg/z10pKw4viXa
   q4ltUR81u+/Yo9TGmQoY9IcSv2AWiy9XRAskU7plipeJsklcr72Oguz5g
   /zRYtkE5JcErzG67f9FMQ+qBfBSUejYnK6ExAthmoyLJ9Lw7yA003CZrk
   Farios7sazCIT0t0xPXBflLO+HLkuo+3n2tUnoyjB0KIE4dYxF5fN6cbC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270347716"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270347716"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:02:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="692867381"
Received: from cgarner-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.0.217])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:02:50 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	fw@strlen.de,
	geliang.tang@suse.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 4/9] mptcp: fix shutdown vs fallback race
Date: Mon, 27 Jun 2022 18:02:38 -0700
Message-Id: <20220628010243.166605-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220628010243.166605-1-mathew.j.martineau@linux.intel.com>
References: <20220628010243.166605-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

If the MPTCP socket shutdown happens before a fallback
to TCP, and all the pending data have been already spooled,
we never close the TCP connection.

Address the issue explicitly checking for critical condition
at fallback time.

Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
Fixes: 0348c690ed37 ("mptcp: add the fallback check")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c  |  2 +-
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h | 19 ++++++++++++++++---
 net/mptcp/subflow.c  |  2 +-
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2a6351d55a7d..aead331866a0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -967,7 +967,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 			goto reset;
 		subflow->mp_capable = 0;
 		pr_fallback(msk);
-		__mptcp_do_fallback(msk);
+		mptcp_do_fallback(ssk);
 		return false;
 	}
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e6fcb61443dd..e63bc2bb7fff 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1245,7 +1245,7 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 	pr_fallback(msk);
-	__mptcp_do_fallback(msk);
+	mptcp_do_fallback(ssk);
 }
 
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1d2d71711872..9860179bfd5e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -927,12 +927,25 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
-static inline void mptcp_do_fallback(struct sock *sk)
+static inline void mptcp_do_fallback(struct sock *ssk)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct sock *sk = subflow->conn;
+	struct mptcp_sock *msk;
 
+	msk = mptcp_sk(sk);
 	__mptcp_do_fallback(msk);
+	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
+		gfp_t saved_allocation = ssk->sk_allocation;
+
+		/* we are in a atomic (BH) scope, override ssk default for data
+		 * fin allocation
+		 */
+		ssk->sk_allocation = GFP_ATOMIC;
+		ssk->sk_shutdown |= SEND_SHUTDOWN;
+		tcp_shutdown(ssk, SEND_SHUTDOWN);
+		ssk->sk_allocation = saved_allocation;
+	}
 }
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8dfea6a8a82f..b34b96fb742f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1279,7 +1279,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return false;
 		}
 
-		__mptcp_do_fallback(msk);
+		mptcp_do_fallback(ssk);
 	}
 
 	skb = skb_peek(&ssk->sk_receive_queue);
-- 
2.37.0

