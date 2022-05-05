Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF8259A
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 17:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651770761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d+uxHQeZI4zp5AocO2ATY6179eGzpGUR4gGziSNhM1c=;
	b=AnfiCuDLTACCUuH/Jf4LJT5NL4v9uTZuwXkRIyziCrc0FNtzrCKCWhrPPkYMiOlGi7ZcvQ
	9iXQDNGyHMxAkyRYXrc43sS1f6fE69lc+kG1Xr80Q1u65/caOeQsATEv5uBtV1SKAnwytO
	uFgsnZJExjG26IXZRTfhcJtIkbASNV4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-fYUCkER5MBOuOTKZAPVB9Q-1; Thu, 05 May 2022 13:12:37 -0400
X-MC-Unique: fYUCkER5MBOuOTKZAPVB9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5C98299E758;
	Thu,  5 May 2022 17:12:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.241])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3E9B4400E89B;
	Thu,  5 May 2022 17:12:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] Revert "mptcp: add data lock for sk timers"
Date: Thu,  5 May 2022 19:12:26 +0200
Message-Id: <0343ae0f3f81535f20d387147ce6b8e4158cc1fc.1651770128.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This reverts commit 4293248c6704b854bf816aa1967e433402bee11c.

Additional locks are not needed, all the touched sections
are already under mptcp socket lock protection.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5243c58789a4..ff567e9d0b1f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1605,10 +1605,8 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 out:
 	/* ensure the rtx timer is running */
-	mptcp_data_lock(sk);
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-	mptcp_data_unlock(sk);
 	if (copied)
 		__mptcp_check_send_data_fin(sk);
 }
@@ -2516,10 +2514,8 @@ static void __mptcp_retrans(struct sock *sk)
 reset_timer:
 	mptcp_check_and_set_pending(sk);
 
-	mptcp_data_lock(sk);
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-	mptcp_data_unlock(sk);
 }
 
 static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
@@ -2707,10 +2703,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
 			tcp_send_ack(ssk);
-			mptcp_data_lock(sk);
 			if (!mptcp_timer_pending(sk))
 				mptcp_reset_timer(sk);
-			mptcp_data_unlock(sk);
 		}
 		break;
 	}
@@ -2811,10 +2805,8 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	/* join list will be eventually flushed (with rst) at sock lock release time*/
 	list_splice_init(&msk->conn_list, &conn_list);
 
-	mptcp_data_lock(sk);
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
-	mptcp_data_unlock(sk);
 	msk->pm.status = 0;
 	mptcp_release_sched(msk);
 
@@ -2877,9 +2869,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
 	} else {
-		mptcp_data_lock(sk);
 		sk_reset_timer(sk, &sk->sk_timer, jiffies + TCP_TIMEWAIT_LEN);
-		mptcp_data_unlock(sk);
 	}
 	release_sock(sk);
 	if (do_cancel_work)
@@ -2924,10 +2914,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
 	}
 
-	mptcp_data_lock(sk);
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
-	mptcp_data_unlock(sk);
 
 	if (mptcp_sk(sk)->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
-- 
2.35.1

