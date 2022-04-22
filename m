Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6632F55
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 21:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650664552; x=1682200552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SihafiiIWl8xeQ/8FEZfOF2xPjFHGPAiYamiWwV82b0=;
  b=f1Lx39dMT/5B++uYmHV8f16budSgTe6x8k0qVa2U4Mf9thOMxH8VYYAk
   9V9xy+49qyS5VVKa5zFcV/GDD5U3+pcPXSmm5C1YWeLpjLg3Jub/DTFqv
   Rg6F1xsK/zOecsf0ROE9I23f3VD+/fNlAS47O9hxWqAzTbYs2BM3BVa/9
   YZTgpPLb7lihhLRKJsJNBLeuZXcf7QdYSRxviamoe4bOkDEH/p1kYqKB+
   4w4d34GphhsKsXHdaOn1HRkedSkRvk7Q/G2rnc+z3Idts9N46v2wdspd1
   hTkeEBrxxUZVVxCsQ5btIP0FCDt2MbFCFu6VCmzuuyGkzuRZpbJVp+2Vw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244720729"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="244720729"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:55:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="578119258"
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
Subject: [PATCH net-next 3/8] mptcp: track and update contiguous data status
Date: Fri, 22 Apr 2022 14:55:38 -0700
Message-Id: <20220422215543.545732-4-mathew.j.martineau@linux.intel.com>
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

This patch adds a new member allow_infinite_fallback in mptcp_sock,
which is initialized to 'true' when the connection begins and is set
to 'false' on any retransmit or successful MP_JOIN. Only do infinite
mapping fallback if there is a single subflow AND there have been no
retransmissions AND there have never been any MP_JOINs.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 3 +++
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0492aa9308c7..6d653914e9fe 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2465,6 +2465,7 @@ static void __mptcp_retrans(struct sock *sk)
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
+		WRITE_ONCE(msk->allow_infinite_fallback, false);
 	}
 
 	release_sock(ssk);
@@ -2539,6 +2540,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
+	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery = false;
 
 	mptcp_pm_data_init(msk);
@@ -3275,6 +3277,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	}
 
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 
 out:
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index aca1fb56523f..88d292374599 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -263,6 +263,7 @@ struct mptcp_sock {
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
+	bool		allow_infinite_fallback;
 	u8		recvmsg_inq:1,
 			cork:1,
 			nodelay:1;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7f26a5b04ad3..31dcb550316f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1206,7 +1206,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	if (!__mptcp_check_fallback(msk)) {
 		/* RFC 8684 section 3.7. */
 		if (subflow->send_mp_fail) {
-			if (mptcp_has_another_subflow(ssk)) {
+			if (mptcp_has_another_subflow(ssk) ||
+			    !READ_ONCE(msk->allow_infinite_fallback)) {
 				ssk->sk_err = EBADMSG;
 				tcp_set_state(ssk, TCP_CLOSE);
 				subflow->reset_transient = 0;
@@ -1486,6 +1487,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	/* discard the subflow socket */
 	mptcp_sock_graft(ssk, sk->sk_socket);
 	iput(SOCK_INODE(sf));
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 	return err;
 
 failed_unlink:
-- 
2.36.0

