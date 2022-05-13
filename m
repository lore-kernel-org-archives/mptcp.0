Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049A17E7
	for <mptcp@lists.linux.dev>; Fri, 13 May 2022 00:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652402142; x=1683938142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z1WZLVRkQfKK8s9jSV8yCvjpYgok2e55HaS29UyWUZQ=;
  b=Lyb7HwLUtuq/79Tz1O3IeRI7pD4ORA+bGlFTotBW6Bvm5JHlBpUXYii5
   NtlxF9iPp8Wg5HKWhsdn+WA4Ob5+IqrDQuV/BGWljPDWRj10Utz8xKqOk
   m7RqvR1U5eHRO4Ze2V7fKEzGPp9WcYZ9/AJipoesGLMUoC+Of+e6QhouS
   OqKhW+QSACK/xybbo27UCpyZ1CA4dO9SNKpH/KTonnkVJ1jdwX2h3D0q/
   GLuMKV3N8GckYqwy0d4lCn1zsRyv1kVU4tHDLxDQshamoR5dqA4hrDFL9
   Ehl1ymavFIKF3yfMAm7aVrXcw7m8/GNsKNBwnTa1sFqVqZIJQOiBEOyOa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269845025"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="269845025"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 17:35:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="554007923"
Received: from cmokhtar-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.36.250])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 17:35:26 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v2] mptcp: Do not traverse the subflow connection list without lock
Date: Thu, 12 May 2022 17:35:21 -0700
Message-Id: <20220513003521.548193-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MPTCP socket's conn_list (list of subflows) requires the socket lock
to access. The MP_FAIL timeout code added such an access, where it would
check the list of subflows both in timer context and (later) in workqueue
context where the socket lock is held.

Rather than check the list twice, remove the check in the timeout
handler and only depend on the check in the workqueue. Also remove the
MPTCP_FAIL_NO_RESPONSE flag, since mptcp_mp_fail_no_response() has
insignificant overhead and can be checked on each worker run.

Reported-by: Paolo Abeni <pabeni@redhat.com>
Fixes: 49fa1919d6bc ("mptcp: reset subflow when MP_FAIL doesn't respond")
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

v2: Remove flag.

---
 net/mptcp/protocol.c | 16 +---------------
 net/mptcp/protocol.h |  1 -
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3c55e7f45aef..d6aef4b13b8a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2182,23 +2182,10 @@ mp_fail_response_expect_subflow(struct mptcp_sock *msk)
 	return ret;
 }
 
-static void mptcp_check_mp_fail_response(struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
-
-	bh_lock_sock(sk);
-	subflow = mp_fail_response_expect_subflow(msk);
-	if (subflow)
-		__set_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags);
-	bh_unlock_sock(sk);
-}
-
 static void mptcp_timeout_timer(struct timer_list *t)
 {
 	struct sock *sk = from_timer(sk, t, sk_timer);
 
-	mptcp_check_mp_fail_response(mptcp_sk(sk));
 	mptcp_schedule_work(sk);
 	sock_put(sk);
 }
@@ -2575,8 +2562,7 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
-	if (test_and_clear_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags))
-		mptcp_mp_fail_no_response(msk);
+	mptcp_mp_fail_no_response(msk);
 
 unlock:
 	release_sock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9933c711b787..9ccbe25dcc3e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -117,7 +117,6 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
-#define MPTCP_FAIL_NO_RESPONSE	6
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
-- 
2.36.1

