Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434133DC
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 21:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651010246; x=1682546246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JYk3TyUbDhDUxu3NzojGlAGOTE6VhZ0AbqCyRH92EY8=;
  b=V0eSC4yvGl3D6nHqZRWNRlGfdDkqrrRj08APG8MYLtfdJcAkeCeHImNY
   zR9eckhutv0tj9Fv/+MVlzggJmKOG+4KyeIq5rtoARcYyQw0btVANe9oW
   qElucYPNOWxQL5OkN+51j+mD299CNhe8Y9hjshJJ8VM0EFFiK1eyKwSQb
   NZNqcGYwfUf8y/2YrHS2KGRWWvLZ2hh3V9Mqo41fkj4KC7rbqv8bjhaEi
   oUiSNv+yLY38Qh4Nu9TxSAtO+U43AQo36fbA7wPX0RRo3v+lJc+7FFtE5
   aok1dekQjiu1/fkryUmQXcQaSigd8SQXKQpUhUsukyJuJ/oGd1aLWDuM5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326222715"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326222715"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="532878096"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.10.176])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:23 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/7] mptcp: add data lock for sk timers
Date: Tue, 26 Apr 2022 14:57:13 -0700
Message-Id: <20220426215717.129506-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426215717.129506-1-mathew.j.martineau@linux.intel.com>
References: <20220426215717.129506-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

mptcp_data_lock() needs to be held when manipulating the msk
retransmit_timer or the sk sk_timer. This patch adds the data
lock for the both timers.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e3db319ce92e..ea74122065f1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1605,8 +1605,10 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 out:
 	/* ensure the rtx timer is running */
+	mptcp_data_lock(sk);
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
+	mptcp_data_unlock(sk);
 	if (copied)
 		__mptcp_check_send_data_fin(sk);
 }
@@ -2491,8 +2493,10 @@ static void __mptcp_retrans(struct sock *sk)
 reset_timer:
 	mptcp_check_and_set_pending(sk);
 
+	mptcp_data_lock(sk);
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
+	mptcp_data_unlock(sk);
 }
 
 static void mptcp_worker(struct work_struct *work)
@@ -2651,8 +2655,10 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
 			tcp_send_ack(ssk);
+			mptcp_data_lock(sk);
 			if (!mptcp_timer_pending(sk))
 				mptcp_reset_timer(sk);
+			mptcp_data_unlock(sk);
 		}
 		break;
 	}
@@ -2753,8 +2759,10 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	/* join list will be eventually flushed (with rst) at sock lock release time*/
 	list_splice_init(&msk->conn_list, &conn_list);
 
+	mptcp_data_lock(sk);
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
+	mptcp_data_unlock(sk);
 	msk->pm.status = 0;
 
 	/* clears msk->subflow, allowing the following loop to close
@@ -2816,7 +2824,9 @@ static void mptcp_close(struct sock *sk, long timeout)
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
 	} else {
+		mptcp_data_lock(sk);
 		sk_reset_timer(sk, &sk->sk_timer, jiffies + TCP_TIMEWAIT_LEN);
+		mptcp_data_unlock(sk);
 	}
 	release_sock(sk);
 	if (do_cancel_work)
@@ -2861,8 +2871,10 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
 	}
 
+	mptcp_data_lock(sk);
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
+	mptcp_data_unlock(sk);
 
 	if (mptcp_sk(sk)->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
-- 
2.36.0

