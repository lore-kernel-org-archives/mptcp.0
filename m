Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999466027
	for <mptcp@lists.linux.dev>; Tue,  5 Jul 2022 21:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657056745; x=1688592745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tC1Hm50rsxSVlGIGSTUympAYSK9JNlJ0/U3l5u6G7IM=;
  b=K/32AKVaE5VJ86rABOFC/kGjU0HPN07AZ1SA2YVNQklsJXKIvt3UQQDn
   nKXdbj8CHOsmCDAPBlo1fb03cjOda1iFdomE8dPDgXyPKiZXPR6Wh8OzC
   OehBp6hBIQdOzMHcAVykCyOQDredEYVIPEKY/UUXy9MnWqarsrCbFE6jH
   qJmZnu+VLtKxSYhUlohL6EW5E7QOEW1+70tSx/qYPkPzHyXvgtsev9EYO
   4DujU9mLS8PeX7cCVsEMyVK9JrzoDXGdWKXZUbYB5aXyelKWYrsDSZIQp
   gjNCOZS0aYK0ZXTLaK7DCVsh/NcyaddjrKmlLqKiLeAnfTjD/kN40aK2h
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284633929"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="284633929"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 14:32:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="590558744"
Received: from rcenter-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.17.169])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 14:32:22 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	geliang.tang@suse.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net 3/7] mptcp: Acquire the subflow socket lock before modifying MP_PRIO flags
Date: Tue,  5 Jul 2022 14:32:13 -0700
Message-Id: <20220705213217.146898-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705213217.146898-1-mathew.j.martineau@linux.intel.com>
References: <20220705213217.146898-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting up a subflow's flags for sending MP_PRIO MPTCP options, the
subflow socket lock was not held while reading and modifying several
struct members that are also read and modified in mptcp_write_options().

Acquire the subflow socket lock earlier and send the MP_PRIO ACK with
that lock already acquired. Add a new variant of the
mptcp_subflow_send_ack() helper to use with the subflow lock held.

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 5 ++++-
 net/mptcp/protocol.c   | 9 +++++++--
 net/mptcp/protocol.h   | 1 +
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5ff93b73f33d..ca86c88f89e0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -728,11 +728,13 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_addr_info local;
+		bool slow;
 
 		local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;
 
+		slow = lock_sock_fast(ssk);
 		if (subflow->backup != bkup)
 			msk->last_snd = NULL;
 		subflow->backup = bkup;
@@ -740,7 +742,8 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		subflow->request_bkup = bkup;
 
 		pr_debug("send ack for mp_prio");
-		mptcp_subflow_send_ack(ssk);
+		__mptcp_subflow_send_ack(ssk);
+		unlock_sock_fast(ssk, slow);
 
 		return 0;
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e475212f2618..cc21fafd9726 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -506,13 +506,18 @@ static inline bool tcp_can_send_ack(const struct sock *ssk)
 	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
 }
 
+void __mptcp_subflow_send_ack(struct sock *ssk)
+{
+	if (tcp_can_send_ack(ssk))
+		tcp_send_ack(ssk);
+}
+
 void mptcp_subflow_send_ack(struct sock *ssk)
 {
 	bool slow;
 
 	slow = lock_sock_fast(ssk);
-	if (tcp_can_send_ack(ssk))
-		tcp_send_ack(ssk);
+	__mptcp_subflow_send_ack(ssk);
 	unlock_sock_fast(ssk, slow);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c14d70c036d0..033c995772dc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -607,6 +607,7 @@ void __init mptcp_subflow_init(void);
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow);
+void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *ssk);
-- 
2.37.0

