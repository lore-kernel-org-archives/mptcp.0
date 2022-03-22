Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B1C6A
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 15:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1647963961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bQz0tq+s705kNvo0rmJmEQJxQ8Fc9RjQij61rWQR8to=;
	b=HHmNzVs5Doo/kza/r+X1umTjRm6Xs2lZHLI/sgKAhIM0pExG3cOJaM2QjlP7F9uNIP/gdi
	An1ZzuSovbRhH9LaBei5t2ByU3SOS3WTr6ofIjdMMNt2eZCczPX148Tw1nBrpWta0JFAf0
	F0/Oy7FvIYA5FwVI4iiJOVFIZf0LnfQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-4ue4VXgSPM2P5VnCKQp1Yw-1; Tue, 22 Mar 2022 11:46:00 -0400
X-MC-Unique: 4ue4VXgSPM2P5VnCKQp1Yw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D55B3C01B84
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 15:46:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D162156F7F4
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 15:45:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 1/3] mptcp: optimize release_cb for the common case
Date: Tue, 22 Mar 2022 16:45:49 +0100
Message-Id: <53b59c780c15855fb57ec41e187a19272747c9d8.1647960598.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
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
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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

