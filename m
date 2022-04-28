Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E206136B
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 16:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651165111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tFJidSmc5wAv35Hlv9QIpe7SR9V0b/plBI1IP3Qeckc=;
	b=RP+AuI9UIYcqBAZtif+LmlvdY74VfP5U2RElHBjz0LwyG0PVbAvOd5Z4dy7X9AQ+M1wf+i
	BBr66SAE1SxlSiVf1XvFG5hAjAB84vE9KPFO97JqIVu7sqsF5kjB/wl10iVCnNDKCYsij4
	AK6NZyREhDe81zq2eIyvbmrfCF5pF7A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-998GHxUGMrSHHIcZWACx3g-1; Thu, 28 Apr 2022 12:58:30 -0400
X-MC-Unique: 998GHxUGMrSHHIcZWACx3g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D4E41E10B42
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 16:58:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C199257354B
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 16:58:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/2] mptcp: fix subflow accounting on close
Date: Thu, 28 Apr 2022 18:58:23 +0200
Message-Id: <84bfd492fa6e4a5ca5c90201283c48ed07318aa9.1651165091.git.pabeni@redhat.com>
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
Content-Type: text/plain; charset="US-ASCII"; x-default=true

If the PM closes a fully established MPJ subflow or the subflow
creation errors out in it's early stage the subflows counter is
not bumped accordingly.

This change adds the missing accouting, additionally taking care
of updating accordingly the 'accept_subflow' flag.

Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm.c       |  5 ++---
 net/mptcp/protocol.h | 14 ++++++++++++++
 net/mptcp/subflow.c  | 12 +++++++++---
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index cdc2d79071f8..59fdab2d0c27 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -181,15 +181,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool update_subflows;
 
-	update_subflows = (ssk->sk_state == TCP_CLOSE) &&
-			  (subflow->request_join || subflow->mp_join) &&
+	update_subflows = (subflow->request_join || subflow->mp_join) &&
 			  mptcp_pm_is_kernel(msk);
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
 	spin_lock_bh(&pm->lock);
 	if (update_subflows)
-		pm->subflows--;
+		__mptcp_pm_close_subflow(msk);
 
 	/* Even if this subflow is not really established, tell the PM to try
 	 * to pick the next ones, if possible.
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4672901d0dfe..06b8ebc15204 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -893,6 +893,20 @@ unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
+/* called under PM lock */
+static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
+{
+	if (--msk->pm.subflows < mptcp_pm_get_subflows_max(msk))
+		WRITE_ONCE(msk->pm.accept_subflow, true);
+}
+
+static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
+{
+	spin_lock_bh(&msk->pm.lock);
+	__mptcp_pm_close_subflow(msk);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6d59336a8e1e..75c85ce9a19e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1444,20 +1444,20 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	struct sockaddr_storage addr;
 	int remote_id = remote->id;
 	int local_id = loc->id;
+	int err = -ENOTCONN;
 	struct socket *sf;
 	struct sock *ssk;
 	u32 remote_token;
 	int addrlen;
 	int ifindex;
 	u8 flags;
-	int err;
 
 	if (!mptcp_is_fully_established(sk))
-		return -ENOTCONN;
+		goto err_out;
 
 	err = mptcp_subflow_create_socket(sk, &sf);
 	if (err)
-		return err;
+		goto err_out;
 
 	ssk = sf->sk;
 	subflow = mptcp_subflow_ctx(ssk);
@@ -1515,6 +1515,12 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 failed:
 	subflow->disposable = 1;
 	sock_release(sf);
+
+err_out:
+	/* we account subflows before the creation, and this failures will not
+	 * be catched by sk_state_change()
+	 */
+	mptcp_pm_close_subflow(msk);
 	return err;
 }
 
-- 
2.35.1

