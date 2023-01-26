Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6C5393
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674767151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHCxiG11K+kIHNnb/eGUD9VzBVT3US9uC+OJzNaVe94=;
	b=e4v1L2DccrTER2ztw/s6Pj5PBoqVC7Zh6FYUsnBB6w+GTNf6wNCt2UhFOfMaHdoxVD2sWz
	bhxAlvK7Nj8yniXqF8+z4KDEFbvRuCFkuJ8E2L14C5wTUjL8YOr6FbXFJRs4m7ZdB5vemV
	mrrZ/pr0azkvT5o1upPchVmhZRy39ps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-q68yqySkPvWCyxgCdVfrDg-1; Thu, 26 Jan 2023 16:05:50 -0500
X-MC-Unique: q68yqySkPvWCyxgCdVfrDg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE46C1991C43
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53AE4492C1B
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 14/15] security, lsm: Introduce security_mptcp_add_subflow()
Date: Thu, 26 Jan 2023 22:05:19 +0100
Message-Id: <e7c19d84b06f2d909ba7c42263f51515f9ed50ac.1674767058.git.pabeni@redhat.com>
In-Reply-To: <cover.1674767058.git.pabeni@redhat.com>
References: <cover.1674767058.git.pabeni@redhat.com>
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

MPTCP can create subflows in kernel context, and later indirectly
expose them to user-space, via the owning mptcp socket.

As discussed in the reported link, the above causes unexpected failures
for server, MPTCP-enabled applications.

Let's introduce a new LSM hook to allow the security module to relabel
the subflow according to the owing process.

Note that the new hook requires both the mptcp socket and the new
subflow. This could allow future extensions, e.g. explicitly validating
the mptcp <-> subflow linkage.

Link: https://lore.kernel.org/mptcp/CAHC9VhTNh-YwiyTds=P1e3rixEDqbRTFj22bpya=+qJqfcaMfg@mail.gmail.com/
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - fix build issue with !CONFIG_SECURITY_NETWORK
---
 include/linux/lsm_hook_defs.h | 1 +
 include/linux/lsm_hooks.h     | 9 +++++++++
 include/linux/security.h      | 6 ++++++
 net/mptcp/subflow.c           | 6 ++++++
 security/security.c           | 5 +++++
 5 files changed, 27 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ed6cb2ac55fa..860e11e3a26b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -343,6 +343,7 @@ LSM_HOOK(void, LSM_RET_VOID, sctp_sk_clone, struct sctp_association *asoc,
 	 struct sock *sk, struct sock *newsk)
 LSM_HOOK(int, 0, sctp_assoc_established, struct sctp_association *asoc,
 	 struct sk_buff *skb)
+LSM_HOOK(int, 0, mptcp_add_subflow, struct sock *sk, struct sock *ssk)
 #endif /* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0a5ba81f7367..84c9c4d4341e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1096,6 +1096,15 @@
  *	@skb pointer to skbuff of association packet.
  *	Return 0 if permission is granted.
  *
+ * Security hooks for MPTCP
+ *
+ * @mptcp_add_subflow
+ * 	Update the labeling for the given MPTCP subflow, to match to
+ * 	owning MPTCP socket.
+ * 	@sk: the owning MPTCP socket
+ * 	@ssk: the new subflow
+ * 	Return 0 if successful, otherwise < 0 error code.
+ *
  * Security hooks for Infiniband
  *
  * @ib_pkey_access:
diff --git a/include/linux/security.h b/include/linux/security.h
index 5b67f208f7de..82d50b2ba683 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1479,6 +1479,7 @@ void security_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk,
 			    struct sock *newsk);
 int security_sctp_assoc_established(struct sctp_association *asoc,
 				    struct sk_buff *skb);
+int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk);
 
 #else	/* CONFIG_SECURITY_NETWORK */
 static inline int security_unix_stream_connect(struct sock *sock,
@@ -1706,6 +1707,11 @@ static inline int security_sctp_assoc_established(struct sctp_association *asoc,
 {
 	return 0;
 }
+
+static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 53e2a1852ca7..5e57a9a7178b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1688,6 +1688,10 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 
 	lock_sock_nested(sf->sk, SINGLE_DEPTH_NESTING);
 
+	err = security_mptcp_add_subflow(sk, sf->sk);
+	if (err)
+		goto release_ssk;
+
 	/* the newly created socket has to be in the same cgroup as its parent */
 	mptcp_attach_cgroup(sk, sf->sk);
 
@@ -1700,6 +1704,8 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
 	sock_inuse_add(net, 1);
 	err = tcp_set_ulp(sf->sk, "mptcp");
+
+release_ssk:
 	release_sock(sf->sk);
 
 	if (err) {
diff --git a/security/security.c b/security/security.c
index d1571900a8c7..3491a4fc2b1f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2493,6 +2493,11 @@ int security_sctp_assoc_established(struct sctp_association *asoc,
 }
 EXPORT_SYMBOL(security_sctp_assoc_established);
 
+int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
+{
+	return call_int_hook(mptcp_add_subflow, 0, sk, ssk);
+}
+
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
-- 
2.39.1

