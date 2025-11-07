Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86A26462E
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500197; cv=none; b=jus5dTznIqahC0aerUzXVqF4Ft8D0qovQ3a8M/ZijSb7/Ikh18O7Z5A4VyWBhQek7LkG5Y0zzWTGlm36M3pprUAJvS4gQdGc5O5I80HmdBFeqhc8dpr4fNLqa+zW7HGQYnZvm+u1/w1mDQ+3xqufqv5aVHWwe8OkAYUlZRzaPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500197; c=relaxed/simple;
	bh=2YwtKR4mx905FfZ43qrIWW7fGqnXNDhGTdmCdBRyIzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=aQzcuAoG4Y5emUUbctcOGKhawzSsZumptq8+LnkJzBkXgSF3xI1LnCjYcFJw7wJQ7zit7eeXwjkHrM5vCJ87kgiOM7i3gaYCLVBl60fUuU3+8c/mHCpR0HAaGcPnKRZJwAJNVuPIIlUtKrgMHkJo/wAnNvpGAbqiVGU7nS2X+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpD9UVHu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpD9UVHu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762500194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMwDml48iEqLKQNe+a1cHe0LETOykt21cfy1PDRoX/M=;
	b=dpD9UVHueYAIS4UJFX2lIA97wx5pPyU7YuKpwqY4eU753ASZ7BplY/cQ0lt6Nl5jrRMvUI
	aLKRD+FFeodOKP7NEiICkLhG4TbKipcd8cBYH0otN69XJlwhZ33BrTtCWR3sk6Ktn6Aj3v
	/Ldqsab/mnwLykkoPhN2gFscECyou/0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-5XvemQEXO32FBg-pS2kdcQ-1; Fri,
 07 Nov 2025 02:23:12 -0500
X-MC-Unique: 5XvemQEXO32FBg-pS2kdcQ-1
X-Mimecast-MFC-AGG-ID: 5XvemQEXO32FBg-pS2kdcQ_1762500192
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDD48180028A;
	Fri,  7 Nov 2025 07:23:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.157])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F2761800362;
	Fri,  7 Nov 2025 07:23:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org
Subject: [PATCH v2 mptcp-net 1/2] mptcp: decouple mptcp fastclose from tcp close
Date: Fri,  7 Nov 2025 08:23:03 +0100
Message-ID: <235288b5bd06f28f5df094cd27bcd33bdcbf34f3.1762500073.git.pabeni@redhat.com>
In-Reply-To: <cover.1762500073.git.pabeni@redhat.com>
References: <cover.1762500073.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QUSFZ3ayKhCE0SdKn_Nw_Qf7CQi8zD1MeJYUKmmiEUY_1762500192
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

With the current fastclose implementation, the mptcp_do_fastclose() helper
is in charge of two distinct actions: send the fastclose reset and cleanup
the subflows.

Formally decouple the two steps, ensuring that mptcp explicitly closes all
the subflows after the mentioned helper.

This will make the upcoming fix simpler, and allows dropping the 2nd
argument from mptcp_destroy_common().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1506fde9a6da..0301e0b0de05 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2884,7 +2884,11 @@ static void mptcp_worker(struct work_struct *work)
 		__mptcp_close_subflow(sk);
 
 	if (mptcp_close_tout_expired(sk)) {
+		struct mptcp_subflow_context *subflow, *tmp;
+
 		mptcp_do_fastclose(sk);
+		mptcp_for_each_subflow_safe(msk, subflow, tmp)
+			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
 		mptcp_close_wake_up(sk);
 	}
 
@@ -3289,7 +3293,7 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 	inet_sk(msk)->inet_rcv_saddr = inet_sk(ssk)->inet_rcv_saddr;
 }
 
-static void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
+static void mptcp_destroy_common(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk = (struct sock *)msk;
@@ -3299,7 +3303,7 @@ static void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 
 	/* join list will be eventually flushed (with rst) at sock lock release time */
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
-		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
+		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, 0);
 
 	__skb_queue_purge(&sk->sk_receive_queue);
 	skb_rbtree_purge(&msk->out_of_order_queue);
@@ -3333,7 +3337,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
 	 */
-	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
+	mptcp_do_fastclose(sk);
+	mptcp_destroy_common(msk);
 
 	/* The first subflow is already in TCP_CLOSE status, the following
 	 * can't overlap with a fallback anymore
@@ -3521,7 +3526,7 @@ static void mptcp_destroy(struct sock *sk)
 
 	/* allow the following to close even the initial subflow */
 	msk->free_first = 1;
-	mptcp_destroy_common(msk, 0);
+	mptcp_destroy_common(msk);
 	sk_sockets_allocated_dec(sk);
 }
 
-- 
2.51.0

