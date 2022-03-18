Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AFB48B7
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1647601581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EiAyQKHEALrPLIHRw6Hj7ZzoXCy4hlsXglWnKmaPSmc=;
	b=O6/JvRK9mg9nuAJFIxsVKULsXWvgy47nVJ9OUmsBDg7hAOV0tjfm2UfHh8ihxVZqBuM286
	z/LOXbbVjyPdjdeXcHQY1nNZjffF6X1r1/A+wxeXTJJbP04A7o6vgKtEyVabFwa0LBrDFK
	k4m+dgmWIMh9RJnuYNCEKblfv3m0T28=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-mQi2T1saP-e56GeUP-to7Q-1; Fri, 18 Mar 2022 07:06:20 -0400
X-MC-Unique: mQi2T1saP-e56GeUP-to7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4A582999B4C
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 11:06:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 681411400E6F
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 11:06:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/3] mptcp: optimize release_cb for the common case
Date: Fri, 18 Mar 2022 12:06:03 +0100
Message-Id: <6fc1ea29ae85074d626ad1cef3fea34055de37f1.1647601548.git.pabeni@redhat.com>
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

The mptcp release callback checks several flags in atomic
context, but only MPTCP_CLEAN_UNA can be up frequently.

Reorganize the code to avoid multiple conditionals in the
most common scenarios.

Additional clarify a related comment.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fbb14dfe62b3..bdba1ddee2a7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3118,15 +3118,17 @@ static void mptcp_release_cb(struct sock *sk)
 		spin_lock_bh(&sk->sk_lock.slock);
 	}
 
-	/* be sure to set the current sk state before tacking actions
-	 * depending on sk_state
-	 */
-	if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags))
-		__mptcp_set_connected(sk);
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
 		__mptcp_clean_una_wakeup(sk);
-	if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
-		__mptcp_error_report(sk);
+	if (unlikely(&msk->cb_flags)) {
+		/* be sure to set the current sk state before tacking actions
+		 * depending on sk_state, that is processing MPTCP_ERROR_REPORT
+		 */
+		if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags))
+			__mptcp_set_connected(sk);
+		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
+			__mptcp_error_report(sk);
+	}
 
 	__mptcp_update_rmem(sk);
 }
-- 
2.35.1

