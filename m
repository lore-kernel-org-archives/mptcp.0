Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B995392
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674767152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=on+1nkZYPamV+4HNcadgrFs5GhA4YQX+FmsXWgsIFLc=;
	b=YbZlOI+7VPSai7NJu76tS/r8NrH4Oajy2Gl6JP2T7L2hnI/wtjvpSRagf/6bRdATH/BEgG
	DvaZPmPrn6MR+axVyPQC+av4cR7ZmgpnWUuD83/yrMUsrl0JRihVaaq4SDl/buSFoN7602
	9ffAIH6FIwD634DQ/cLP3sP48xhiYYQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-fuQpvmzAPOGG6jI-rKDfKQ-1; Thu, 26 Jan 2023 16:05:50 -0500
X-MC-Unique: fuQpvmzAPOGG6jI-rKDfKQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AB512801E4B
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0F4E8492C14
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 15/15] selinux: Implement mptcp_add_subflow hook
Date: Thu, 26 Jan 2023 22:05:20 +0100
Message-Id: <4d5c94f133002e76ecb74c3303ab350df9175e90.1674767058.git.pabeni@redhat.com>
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

Newly added subflows should inherit the LSM label from the associated
msk socket regarless current context.

This patch implements the above copying sid and class from the msk
context, deleting the existing subflow label, if any, and then
re-creating a new one.

The new helper reuses the selinux_netlbl_sk_security_free() function,
and the latter can end-up being called multiple times with the same
argument; we additionally need to make it idempotent.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - cleanup selinux_netlbl_sk_security_free() (Paul)
 - inherit label from msk (Paul)

v1 -> v2:
 - fix build issue with !CONFIG_NETLABEL
---
 security/selinux/hooks.c    | 16 ++++++++++++++++
 security/selinux/netlabel.c |  8 ++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3c5be76a9199..1e0ca10a6c02 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5476,6 +5476,21 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
 	selinux_netlbl_sctp_sk_clone(sk, newsk);
 }
 
+static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
+{
+	struct sk_security_struct *ssksec = ssk->sk_security;
+	struct sk_security_struct *sksec = sk->sk_security;
+
+	ssksec->sclass = sksec->sclass;
+	ssksec->sid = sksec->sid;
+
+	/* replace the existing subflow label deleting the existing one
+	 * and re-recrating a new label using the current context
+	 */
+	selinux_netlbl_sk_security_free(ssksec);
+	return selinux_netlbl_socket_post_create(ssk, ssk->sk_family);
+}
+
 static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 				     struct request_sock *req)
 {
@@ -7216,6 +7231,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sctp_sk_clone, selinux_sctp_sk_clone),
 	LSM_HOOK_INIT(sctp_bind_connect, selinux_sctp_bind_connect),
 	LSM_HOOK_INIT(sctp_assoc_established, selinux_sctp_assoc_established),
+	LSM_HOOK_INIT(mptcp_add_subflow, selinux_mptcp_add_subflow),
 	LSM_HOOK_INIT(inet_conn_request, selinux_inet_conn_request),
 	LSM_HOOK_INIT(inet_csk_clone, selinux_inet_csk_clone),
 	LSM_HOOK_INIT(inet_conn_established, selinux_inet_conn_established),
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 1321f15799e2..33187e38def7 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -155,8 +155,12 @@ void selinux_netlbl_err(struct sk_buff *skb, u16 family, int error, int gateway)
  */
 void selinux_netlbl_sk_security_free(struct sk_security_struct *sksec)
 {
-	if (sksec->nlbl_secattr != NULL)
-		netlbl_secattr_free(sksec->nlbl_secattr);
+	if (!sksec->nlbl_secattr)
+		return;
+
+	netlbl_secattr_free(sksec->nlbl_secattr);
+	sksec->nlbl_secattr = NULL;
+	sksec->nlbl_state = NLBL_UNSET;
 }
 
 /**
-- 
2.39.1

