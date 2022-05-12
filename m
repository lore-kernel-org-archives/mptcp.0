Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B36160
	for <mptcp@lists.linux.dev>; Thu, 12 May 2022 00:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652314995; x=1683850995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QOz7ZHX7Fzu8nzJgdncqpRvaW1FkQxs1zJEvh0OQvuM=;
  b=Uhc3mC4c/tZgdDJK5jsUt1APwRPPNI6ZK5gZUcGsqM0b2vwq/zEc1/42
   9cArWDJGQwG30pwwqjk40PxY6E+UmDGcAcR5kd3UUH87s65kln4LJ3llg
   yEuXd9nYKp9Y8sON69YdmmPTXsMS69+lCkjh47qOhZnRl2ZaXSJLtyIQJ
   P6bDFklWSdzW2aLNe+Wbso72+hPgecpZfOeSgvVvjSl2Om5IbzBRzLM7f
   +CaWMPk+0LrbDABmnilCYvhsraV2gV1oSfmqMWeF458AxZtzsHvPV+HNN
   ZuIgXZCSYp+2FpRVDFPVQ7Fn2B6iMw430fggcShTB6tWDq0qXHXHBkzQK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="295093407"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="295093407"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:23:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="658378726"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.225.213])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:23:13 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next 2/2] mptcp: Do not traverse the subflow connection list without lock
Date: Wed, 11 May 2022 17:23:08 -0700
Message-Id: <20220512002308.445416-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512002308.445416-1-mathew.j.martineau@linux.intel.com>
References: <20220512002308.445416-1-mathew.j.martineau@linux.intel.com>
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
handler and only depend on the check in the workqueue.

Reported-by: Paolo Abeni <pabeni@redhat.com>
Fixes: 49fa1919d6bc ("mptcp: reset subflow when MP_FAIL doesn't respond")
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 16 ++--------------
 net/mptcp/protocol.h |  2 +-
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3c55e7f45aef..11e1c58dcbcf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2182,23 +2182,11 @@ mp_fail_response_expect_subflow(struct mptcp_sock *msk)
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
+	set_bit(MPTCP_WORK_TIMEOUT, &mptcp_sk(sk)->flags);
 	mptcp_schedule_work(sk);
 	sock_put(sk);
 }
@@ -2575,7 +2563,7 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
-	if (test_and_clear_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags))
+	if (test_and_clear_bit(MPTCP_WORK_TIMEOUT, &msk->flags))
 		mptcp_mp_fail_no_response(msk);
 
 unlock:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9933c711b787..2c5e16d360fb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -117,7 +117,7 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
-#define MPTCP_FAIL_NO_RESPONSE	6
+#define MPTCP_WORK_TIMEOUT	6
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
-- 
2.36.1

