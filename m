Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F12222C4
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111851; cv=none; b=mA8MXLOo+OL4EQ7QEEUk45y207+Ys83LJwjfRxDoOJ1gE+BrHoWDIwiNJyQVk/fD9ox/wqeBNtQ0XczM4crw8OgyAWQ4I5MemHg8Wdf5phUMyJKsnORdaYPjcXjm01WYIqNTg/MErV6lXspTLjkW+Nf2gHamA7KQaDmIiCF5/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111851; c=relaxed/simple;
	bh=Dzf2juHVl0sVND98n1jH36RCIpOTSCDRhccFFuEKttw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=T4f/YMMNMn5SwNkMIwhRaXVNfAeFVlo7D/ggrbAboPaN4gjwZOwtDC9xn7pMDhFKW3FbsWTSv+L609BEmDUNyHkpKnb+8Tskddptgz/QSYmqEHL8mNAEWdZ9Qg7HIqnC3gOrNZhi1SDf1fcqeTraM08bcV7DL5Ilat9R7/8tFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fu2lrJj0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fu2lrJj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763111848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m81cAZhPJdxk55S0XQngQABFt9OZ9/xrFNDTWT5z57o=;
	b=fu2lrJj0sez1FYkQcmrofUllUcgs6gUsY9v8gPWlc7yT2Gn9Upb5NElBCzMMLaKxUEu8Cf
	pfLcrkOYV2coYV18hBRuT51wn/Yg/r+I1LVd/dwVAsw1Rc7+nZtUPcxW1vVBSuNYJKBTlN
	feTrb0ca4PK6xijvZ9K1ktF0DilvkDg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-hbdTincdNu23nDunL7Z8dg-1; Fri,
 14 Nov 2025 04:17:26 -0500
X-MC-Unique: hbdTincdNu23nDunL7Z8dg-1
X-Mimecast-MFC-AGG-ID: hbdTincdNu23nDunL7Z8dg_1763111846
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1C2018AB423
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 09:17:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.173])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 177721800451
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 09:17:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 1/3] mptcp: grafting MPJ subflow earlier
Date: Fri, 14 Nov 2025 10:17:12 +0100
Message-ID: <d3493b16bf6c109ceba3fb33544bfd6756a3d50b.1763111767.git.pabeni@redhat.com>
In-Reply-To: <cover.1763111767.git.pabeni@redhat.com>
References: <cover.1763111767.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z_xZ_OP4jdkfYPF0Fkn6jSCstfe7loIbUhXMJoCvf00_1763111846
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Later patches need to ensure that all MPJ subflows are grafted to the
msk socket before accept() completion.

Currently the grafting happens under the msk socket lock: potentially
at msk release_cb time which make satisfying the above condition a bit
tricky.

Move the MPJ subflow grafting earlier, under the msk data lock, so that
we can use such lock as a synchronization point.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - clarified it's not a fix
  - move the graft under the msk socket lock
  - no need to graft for active subflows
---
 net/mptcp/protocol.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 78ac8ba80e59..4a4cb9952596 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -933,12 +933,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
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
@@ -3760,6 +3754,20 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent)
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
+/* Can be called without holding the msk socket lock; use the callback lock
+ * to avoid {READ_,WRITE_}ONCE annotations on sk_socket.
+ */
+static void mptcp_sock_check_graft(struct sock *sk, struct sock *ssk)
+{
+	struct socket *sock;
+
+	write_lock_bh(&sk->sk_callback_lock);
+	sock = sk->sk_socket;
+	write_unlock_bh(&sk->sk_callback_lock);
+	if (sock)
+		mptcp_sock_graft(ssk, sock);
+}
+
 bool mptcp_finish_join(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -3775,7 +3783,9 @@ bool mptcp_finish_join(struct sock *ssk)
 		return false;
 	}
 
-	/* active subflow, already present inside the conn_list */
+	/* Active subflow, already present inside the conn_list; is grafted
+	 * either by __mptcp_subflow_connect() or accept.
+	 */
 	if (!list_empty(&subflow->node)) {
 		spin_lock_bh(&msk->fallback_lock);
 		if (!msk->allow_subflows) {
@@ -3802,11 +3812,17 @@ bool mptcp_finish_join(struct sock *ssk)
 		if (ret) {
 			sock_hold(ssk);
 			list_add_tail(&subflow->node, &msk->conn_list);
+			mptcp_sock_check_graft(parent, ssk);
 		}
 	} else {
 		sock_hold(ssk);
 		list_add_tail(&subflow->node, &msk->join_list);
 		__set_bit(MPTCP_FLUSH_JOIN_LIST, &msk->cb_flags);
+
+		/* In case of later failures, __mptcp_flush_join_list() will
+		 * properly orphan the ssk via mptcp_close_ssk().
+		 */
+		mptcp_sock_check_graft(parent, ssk);
 	}
 	mptcp_data_unlock(parent);
 
-- 
2.51.1

