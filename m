Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9EC8490
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 18:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667586336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AwX7Q1vA7ERvLhR5GPaDreInRwrx9yg8kHGj6FsuLSs=;
	b=ZWsqvBs86dBRTdgNrxqjc69ixQzOL9mf9E/JX7W7sVwVYLSJXUW+ojlJQVOlLnCcSoaSKn
	APgb3SuAesLvN9lICeKElIYN3oktNw3ZpVWYdiuHxMQRNoyWWD4AxVDij3qlk76PsCMnFd
	rZSG04871Gv3T6YOcJu+iGFlKTabla8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-WeHfQPuLMVq7S1eNqnECGQ-1; Fri, 04 Nov 2022 14:25:35 -0400
X-MC-Unique: WeHfQPuLMVq7S1eNqnECGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4ECD811E75
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 18:25:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 72EC8C15BA5
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 18:25:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/2] mptcp: deduplicate error paths on endpoint creation
Date: Fri,  4 Nov 2022 19:25:22 +0100
Message-Id: <13fc62c6a047dbd043be5131567c0f3a6c46267e.1667586266.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When endpoint creation fails, we need to free the newly allocated
entry and eventually destroy the paired mptcp listener socket.

Consolidate such action in a single point let all the errors path
reach it.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9813ed0fde9b..fdf2ee29f762 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1003,16 +1003,12 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 		return err;
 
 	msk = mptcp_sk(entry->lsk->sk);
-	if (!msk) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (!msk)
+		return -EINVAL;
 
 	ssock = __mptcp_nmpc_socket(msk);
-	if (!ssock) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (!ssock)
+		return -EINVAL;
 
 	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -1022,20 +1018,16 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
 	if (err) {
 		pr_warn("kernel_bind error, err=%d", err);
-		goto out;
+		return err;
 	}
 
 	err = kernel_listen(ssock, backlog);
 	if (err) {
 		pr_warn("kernel_listen error, err=%d", err);
-		goto out;
+		return err;
 	}
 
 	return 0;
-
-out:
-	sock_release(entry->lsk);
-	return err;
 }
 
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
@@ -1327,7 +1319,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "can't allocate addr");
 		return -ENOMEM;
@@ -1338,22 +1330,21 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
 			GENL_SET_ERR_MSG(info, "create listen socket error");
-			kfree(entry);
-			return ret;
+			goto out_free;
 		}
 	}
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
-		if (entry->lsk)
-			sock_release(entry->lsk);
-		kfree(entry);
-		return ret;
+		goto out_free;
 	}
 
 	mptcp_nl_add_subflow_or_signal_addr(sock_net(skb->sk));
-
 	return 0;
+
+out_free:
+	__mptcp_pm_release_addr_entry(entry);
+	return ret;
 }
 
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
-- 
2.38.1

