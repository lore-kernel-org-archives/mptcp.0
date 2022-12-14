Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7595BA24
	for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 22:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671055357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zZI+v6Iz9fu4P+tN9ii9dNN7/Dql4T2fwtA0wpvKfc=;
	b=Dg1CITnP580OUc/V+JPn+R//oQtIebG6kxboJNs3h6Yb82wl0lBL/TCfAyBk7x+tm2nWWY
	MUrCjNYZspU1X6UUxSD3fXcK2xb30C2Btb6CSg2yDYEE8xUJ8nSRCd+TSVW0i1n3m+weri
	XQXO10hXanjObTdl/jq9Wb0VWj/n+zg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-Lg97WhIKM2CucLxNJf-hRQ-1; Wed, 14 Dec 2022 17:02:31 -0500
X-MC-Unique: Lg97WhIKM2CucLxNJf-hRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BF93802C1C;
	Wed, 14 Dec 2022 22:02:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.136])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED0BF40C2064;
	Wed, 14 Dec 2022 22:02:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	selinux@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH 2/2] selinux: Implement mptcp_add_subflow hook
Date: Wed, 14 Dec 2022 23:01:58 +0100
Message-Id: <d6f04d238c8a797899d6cb543a43f75e544221af.1671054577.git.pabeni@redhat.com>
In-Reply-To: <cover.1671054577.git.pabeni@redhat.com>
References: <cover.1671054577.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1

Newly added subflows should inherit the associated label
from the current process context, regarless of the sk_kern_sock
flag value.

This patch implements the above resetting the subflow sid, deleting
the existing subflow label, if any, and then re-creating a new one.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 security/selinux/hooks.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3c5be76a9199..cbb4c711c502 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5476,6 +5476,35 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
 	selinux_netlbl_sctp_sk_clone(sk, newsk);
 }
 
+static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	struct sk_security_struct *ssksec = ssk->sk_security;
+	u16 sclass;
+	u32 sid;
+	int err;
+
+	/* create the sid using the current cred, regardless of the ssk kern
+	 * flag
+	 */
+	sclass = socket_type_to_security_class(ssk->sk_family, ssk->sk_type,
+					       ssk->sk_protocol);
+	err = socket_sockcreate_sid(tsec, sclass, &sid);
+	if (err)
+		return err;
+
+	ssksec->sid = sid;
+
+	/* replace the existing subflow label with the new one
+	 * inherited from the mptcp socket
+	 */
+	if (ssksec->nlbl_secattr != NULL) {
+		netlbl_secattr_free(ssksec->nlbl_secattr);
+		ssksec->nlbl_secattr = NULL;
+	}
+	return selinux_netlbl_socket_post_create(ssk, ssk->sk_family);
+}
+
 static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 				     struct request_sock *req)
 {
@@ -7216,6 +7245,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sctp_sk_clone, selinux_sctp_sk_clone),
 	LSM_HOOK_INIT(sctp_bind_connect, selinux_sctp_bind_connect),
 	LSM_HOOK_INIT(sctp_assoc_established, selinux_sctp_assoc_established),
+	LSM_HOOK_INIT(mptcp_add_subflow, selinux_mptcp_add_subflow),
 	LSM_HOOK_INIT(inet_conn_request, selinux_inet_conn_request),
 	LSM_HOOK_INIT(inet_csk_clone, selinux_inet_csk_clone),
 	LSM_HOOK_INIT(inet_conn_established, selinux_inet_conn_established),
-- 
2.38.1

