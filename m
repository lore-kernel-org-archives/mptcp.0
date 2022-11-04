Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891D18490
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667586339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmbAzgg0IGQygmBxX2z1x3peJRUEYh082ntGa40C0Vk=;
	b=TfyGCxtI0raImcXtpp1Nmt6h7+G80uOCEct/U8GdphxQo3mvDJkA50/irpyXKKM+lg7c+R
	Dx6unXLO/uR54OyOllWDC0KtTIf/Z9SLp0umaGzkZ/NkbW2Qw/FFwCo66R+9rnSQNNn0t5
	gW4MxZhhvlRf7C/5Z5Qx3N50SOmHDuk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-JBAZvDv8O3SHIH_QGVFrNA-1; Fri, 04 Nov 2022 14:25:38 -0400
X-MC-Unique: JBAZvDv8O3SHIH_QGVFrNA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B14FA85A583
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 18:25:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 41052C2C8D9
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 18:25:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/2] mptcp: more detailed error reporting on endpoint creation
Date: Fri,  4 Nov 2022 19:25:23 +0100
Message-Id: <d51ab9e9d73cfa3e7b8e6c8864e022d5fdad434d.1667586266.git.pabeni@redhat.com>
In-Reply-To: <13fc62c6a047dbd043be5131567c0f3a6c46267e.1667586266.git.pabeni@redhat.com>
References: <13fc62c6a047dbd043be5131567c0f3a6c46267e.1667586266.git.pabeni@redhat.com>
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

Endpoint creation can fail for a number of reasons; in case of failure
append the error number to the extended ack message, using a newly
introduced generic helper.

Additionally let mptcp_pm_nl_append_new_local_addr() report different
error reasons.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/genetlink.h |  3 +++
 net/mptcp/pm_netlink.c  | 24 +++++++++++++-----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 9f97f73615b6..356e4c119322 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -119,6 +119,9 @@ static inline void genl_info_net_set(struct genl_info *info, struct net *net)
 
 #define GENL_SET_ERR_MSG(info, msg) NL_SET_ERR_MSG((info)->extack, msg)
 
+#define GENL_SET_ERR_MSG_FMT(info, msg, args...) \
+	NL_SET_ERR_MSG_FMT((info)->extack, msg, ##args)
+
 /* Report that a root attribute is missing */
 #define GENL_REQ_ATTR_CHECK(info, attr) ({				\
 	struct genl_info *__info = (info);				\
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fdf2ee29f762..d66fbd558263 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -912,10 +912,14 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	 */
 	if (pernet->next_id == MPTCP_PM_MAX_ADDR_ID)
 		pernet->next_id = 1;
-	if (pernet->addrs >= MPTCP_PM_ADDR_MAX)
+	if (pernet->addrs >= MPTCP_PM_ADDR_MAX) {
+		ret = -ERANGE;
 		goto out;
-	if (test_bit(entry->addr.id, pernet->id_bitmap))
+	}
+	if (test_bit(entry->addr.id, pernet->id_bitmap)) {
+		ret = -EBUSY;
 		goto out;
+	}
 
 	/* do not insert duplicate address, differentiate on port only
 	 * singled addresses
@@ -929,8 +933,10 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 			 * endpoint is an implicit one and the user-space
 			 * did not provide an endpoint id
 			 */
-			if (!(cur->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT))
+			if (!(cur->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT)) {
+				ret = -EEXIST;
 				goto out;
+			}
 			if (entry->addr.id)
 				goto out;
 
@@ -1016,16 +1022,12 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
 	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
-	if (err) {
-		pr_warn("kernel_bind error, err=%d", err);
+	if (err)
 		return err;
-	}
 
 	err = kernel_listen(ssock, backlog);
-	if (err) {
-		pr_warn("kernel_listen error, err=%d", err);
+	if (err)
 		return err;
-	}
 
 	return 0;
 }
@@ -1329,13 +1331,13 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	if (entry->addr.port) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
-			GENL_SET_ERR_MSG(info, "create listen socket error");
+			GENL_SET_ERR_MSG_FMT(info, "create listen socket error: %d", ret);
 			goto out_free;
 		}
 	}
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0) {
-		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
+		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;
 	}
 
-- 
2.38.1

