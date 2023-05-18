Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CE524E86
	for <mptcp@lists.linux.dev>; Thu, 18 May 2023 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684429168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adwPBPHdnk1QIyvCuHO9SxciI8J1l73qF4LWlJNqDxc=;
	b=EF81KtsaOzLrH/VMux/3cifvyqf+BMYXOooaOLiWshG6l77k6Us/bNK7hYp6C+75hu0TqV
	YNRXp0NbguaUofBqFgjw1r5wWVgWppjcHNHKNWqo/we/RabHlsJDN6HdrMkAX23Otaejxn
	mqFJr07qfEKrSn+pZ7/0J5qCZEuGTfM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-xB-ycCkAOjKzNb_S9UDSYg-1; Thu, 18 May 2023 12:59:27 -0400
X-MC-Unique: xB-ycCkAOjKzNb_S9UDSYg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38E2E29AB3F1;
	Thu, 18 May 2023 16:59:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97ABA492B01;
	Thu, 18 May 2023 16:59:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH v2 mptcp-net 5/5] mptcp: fix active subflow finalization.
Date: Thu, 18 May 2023 18:59:14 +0200
Message-Id: <41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com>
In-Reply-To: <cover.1684427027.git.pabeni@redhat.com>
References: <cover.1684427027.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Active subflow are inserted into the connection list at creation time.
When the MPJ handshake completes succesfully, a the new subflow creation
netlink event is generated correctly, but the current code wrongly
avoid initializing a couple of subflow data.

The above will cause misbehavior on a few exceptional events: unneeded
mptcp-level retransmission on msk-level sequence wrap-around and infinite
mapping fallback even when a MPJ socket is present.

Address the issue factoring out the needed initialization in a new helper
and invoking the latter from __mptcp_finish_join() time for passive
subflow and from mptcp_finish_join() for active ones.

Fixes: 0530020a7c8f ("mptcp: track and update contiguous data status")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4b24f3bc6919..28da6a9fe8fd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -825,6 +825,13 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	mptcp_data_unlock(sk);
 }
 
+static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
+{
+	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
+}
+
 static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -839,6 +846,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 		mptcp_sock_graft(ssk, sk->sk_socket);
 
 	mptcp_sockopt_sync_locked(msk, ssk);
+	mptcp_subflow_joined(msk, ssk);
 	return true;
 }
 
@@ -3532,14 +3540,16 @@ bool mptcp_finish_join(struct sock *ssk)
 		return false;
 	}
 
-	if (!list_empty(&subflow->node))
-		goto out;
+	/* active subflow, already present inside the conn_list */
+	if (!list_empty(&subflow->node)) {
+		mptcp_subflow_joined(msk, ssk);
+		return true;
+	}
 
 	if (!mptcp_pm_allow_new_subflow(msk))
 		goto err_prohibited;
 
-	/* active connections are already on conn_list.
-	 * If we can't acquire msk socket lock here, let the release callback
+	/* If we can't acquire msk socket lock here, let the release callback
 	 * handle it
 	 */
 	mptcp_data_lock(parent);
@@ -3562,11 +3572,6 @@ bool mptcp_finish_join(struct sock *ssk)
 		return false;
 	}
 
-	subflow->map_seq = READ_ONCE(msk->ack_seq);
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
-
-out:
-	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 	return true;
 }
 
-- 
2.40.1

