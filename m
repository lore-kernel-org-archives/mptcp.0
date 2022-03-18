Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761548BF
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 11:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1647601582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3b5iC7KiFTctESadvUaSVuwuTMkL/Z8nKxEbj4utJ4=;
	b=NFMJzgqF/LqZC6LMHQJzBEAGduTHoNJ1xswpvx2H3u3u2xgezLXCh1cgb+W2UPSd0jDdm1
	e+to5OWNgIiVktXaHc+IA2DAh9l81C36A74L14NH83NFs/jobTSJAo1GyssKi1XJxhYCCG
	tcYhsZaD/WKNjevnUZ7IOm2o4Tj9vRU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-ESVDAmnmPSSetJDJA2hs9A-1; Fri, 18 Mar 2022 07:06:20 -0400
X-MC-Unique: ESVDAmnmPSSetJDJA2hs9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 921813C02B7E
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 11:06:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 239EC1402400
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 11:06:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/3] mptcp: reset the packet scheduler on incoming MP_PRIO.
Date: Fri, 18 Mar 2022 12:06:04 +0100
Message-Id: <4982f05aedd915cdc486399696d8c5b492fd2d9a.1647601548.git.pabeni@redhat.com>
In-Reply-To: <6fc1ea29ae85074d626ad1cef3fea34055de37f1.1647601548.git.pabeni@redhat.com>
References: <6fc1ea29ae85074d626ad1cef3fea34055de37f1.1647601548.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

When an incoming MP_PRIO option changes the backup
status of any subflow, we need to reset the packet
scheduler status, or the next send could keep using
the previously selected subflow, without taking in account
the new priorities.

Reported-by: Davide Caratti <dcaratti@redhat.com>
Fixes: 40453a5c61f4 ("mptcp: add the incoming MP_PRIO support")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm.c       | 19 +++++++++++++++----
 net/mptcp/protocol.c |  2 ++
 net/mptcp/protocol.h |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d0d31d5c198a..2f6ee422c6df 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -262,14 +262,25 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
-void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
+void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct sock *sk = subflow->conn;
+	struct mptcp_sock *msk;
 
 	pr_debug("subflow->backup=%d, bkup=%d\n", subflow->backup, bkup);
-	subflow->backup = bkup;
+	msk = mptcp_sk(sk);
+	if (subflow->backup == bkup) {
+		subflow->backup = bkup;
+		mptcp_data_lock(sk);
+		if (!sock_owned_by_user(sk))
+			msk->last_snd = NULL;
+		else
+			__set_bit(MPTCP_RESET_SCHEDULER,  &msk->cb_flags);
+		mptcp_data_unlock(sk);
+	}
 
-	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, mptcp_sk(subflow->conn), sk, GFP_ATOMIC);
+	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, msk, ssk, GFP_ATOMIC);
 }
 
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bdba1ddee2a7..cec42bc16d12 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3128,6 +3128,8 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
+		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
+			msk->last_snd = NULL;
 	}
 
 	__mptcp_update_rmem(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8bada4537e2..d59c16d248a4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,6 +124,7 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
+#define MPTCP_RESET_SCHEDULER	7
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
-- 
2.35.1

