Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623C4139D
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992667; cv=none; b=mpnIZhkEPOuUaoi6BFS1bVW85Uo/ywuFSl2hzLXXswlX4p3cPhHzcPySp604Zv7g+cRtuCUyugsYrKckf0uhvK1leI0sIztsKD+RIBKgh+spAaaZ3NfdSNT67tMST6VnUDq6x8Em+3JuOKMvvlGTiaBBYhHPkChUN+BHlbeOIUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992667; c=relaxed/simple;
	bh=0YMgWiYBF6yn1Ng5wQZdIio18el3SYEsrQIRUvPYOBI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NuVkSvS58rgTtdMVwzzlUVUcTnsSnA0teOdUZtuh6ZufJ5vsoUFGrnbTC9o89+/P7eT32UklNy4jUAEg4c1MJ6L8cwFbsmfO/Gn0BiAbn9+Q0kJtUucMCEWTbUE/C3D/j9lmap6NNNJrUQtiitlgQi/xbBPkb0GKPpRAGBze9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpU8R9AB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpU8R9AB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762992663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIdG2aOjc1nyZ6RoNo9HwYB9lkd7OQSVaoQZpHTMP+w=;
	b=DpU8R9ABqvCYzT/bVhwfRoqW1ELXmcgLOZstw4hbTYpwwFx6sZWNUr2tWCi8Zt1JsZotJ3
	WNKb+y6864ZKSdYmjP7sTkZR3+1jctaJuFDC7pb7m88JwcVevIvM9QsOt8i0BQsSPt4U38
	FxO+HZRWKJo2WTMd4srLOvdlRRstfFU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-uoUxyaf_N9Cxa-BmppLPIg-1; Wed,
 12 Nov 2025 19:11:01 -0500
X-MC-Unique: uoUxyaf_N9Cxa-BmppLPIg-1
X-Mimecast-MFC-AGG-ID: uoUxyaf_N9Cxa-BmppLPIg_1762992661
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E25651956095
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:11:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E6D830044E0
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:10:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-net 1/3] mptcp: fix grafting corner case
Date: Thu, 13 Nov 2025 01:10:50 +0100
Message-ID: <4696be966622c9d340e8bfa4728b219b7cac1d1b.1762992570.git.pabeni@redhat.com>
In-Reply-To: <cover.1762992570.git.pabeni@redhat.com>
References: <cover.1762992570.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7oB5g7wa5EwYOtoHR_2cdj-n3_I_OJgjoO727XwrF8U_1762992661
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

If a passive MPTCP socket creates active subflows while still unaccepted,
__mptcp_subflow_connect() will try to graft such subflows to the msk,
but the msk struct socket is not yet initialized at that point:
the subflows will misbehave.

Address the issue always trying to graft the subflow in
mptcp_finish_join(), regardless of the subflow itself being active or
passive. To avoid races with accept(), access the msk->sk_socket under
the callback lock.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8965abb94b81..1b3c5fd01600 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -913,12 +913,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_subflow_joined(msk, ssk);
 	spin_unlock_bh(&msk->fallback_lock);
 
-	/* attach to msk socket only after we are sure we will deal with it
-	 * at close time
-	 */
-	if (sk->sk_socket && !ssk->sk_socket)
-		mptcp_sock_graft(ssk, sk->sk_socket);
-
 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_stop_tout_timer(sk);
@@ -3734,6 +3728,20 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent)
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
+static void mptcp_check_graft(struct sock *sk, struct sock *ssk)
+{
+	struct socket *sock;
+
+	if (ssk->sk_socket)
+		return;
+
+	write_lock_bh(&sk->sk_callback_lock);
+	sock = sk->sk_socket;
+	write_lock_bh(&sk->sk_callback_lock);
+	if (sock)
+		mptcp_sock_graft(ssk, sock);
+}
+
 bool mptcp_finish_join(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -3758,6 +3766,7 @@ bool mptcp_finish_join(struct sock *ssk)
 		}
 		mptcp_subflow_joined(msk, ssk);
 		spin_unlock_bh(&msk->fallback_lock);
+		mptcp_check_graft(parent, ssk);
 		mptcp_propagate_sndbuf(parent, ssk);
 		return true;
 	}
@@ -3767,6 +3776,8 @@ bool mptcp_finish_join(struct sock *ssk)
 		goto err_prohibited;
 	}
 
+	mptcp_check_graft(parent, ssk);
+
 	/* If we can't acquire msk socket lock here, let the release callback
 	 * handle it
 	 */
-- 
2.51.1

