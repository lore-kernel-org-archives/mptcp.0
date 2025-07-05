Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402F41E832A
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751700306; cv=none; b=PGbj1XSZ+0t2iDA0fwYvhdeTUoVhH1VN7lnWYnprrt/18A+ffOSjlAdRw13W8VoKt8xlppWwT32wkOjU1i8lZJeOMAffA9GsovF+o5pZSZ5FwGIoxeuPrhf1m/gBdHaU68dDv5I0L2yuyHqcHtbNQyVwuqgmYZQ2eIQFkqPKtsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751700306; c=relaxed/simple;
	bh=3UdE8nDz3yKO0TcLJyjWu5fI513RkG85kFPLaJGW6xk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NB3leAuRQUnzRxH92ZBmXnpu4JoEykm57DEi/hCcHQNkpBvHXXXagh7tODYmlVi3bZHasrzgz4szdU0ZmLUsjar5IMepkTTgMiPvWH6QUXr/EYjEM4yci36DA85TSQTgckW6BL6s+Wz0XlT9Hi8qcl5d1Yx1523rQZFaPzmFdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQ037hXM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQ037hXM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751700304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/UJZt6eXZ3rLt6LaHP+FnToEe+9sEyt3IfRaOO1lgw=;
	b=OQ037hXMDhpBlOAAIKKP8V9CPvd23em8GkHHdFSFBxGGMpIjmbsdyVgYOGZS1jbK6Nr3Hx
	Y0ZAUTi6V8ijyG/UTVhgK6S1fFiho+ABqRzp52NeMJfavoPkUXzycGWStTZKbQdlnk99Vg
	8uPQ30hzfl62f/CxVHxNbitoC+mkUpo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-aWxjGGHSMVqPe_8owPiVnA-1; Sat,
 05 Jul 2025 03:25:02 -0400
X-MC-Unique: aWxjGGHSMVqPe_8owPiVnA-1
X-Mimecast-MFC-AGG-ID: aWxjGGHSMVqPe_8owPiVnA_1751700301
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24A9E1944A82
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:25:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1961B195608F
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:24:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 3/5] mptcp: fix status reset on disconnect()
Date: Sat,  5 Jul 2025 09:24:47 +0200
Message-ID: <a5a1798e9f474cf8f8c518ce1b47aebf4b7d5528.1751700000.git.pabeni@redhat.com>
In-Reply-To: <cover.1751699999.git.pabeni@redhat.com>
References: <cover.1751699999.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DzUb2iOHgC9Ub4FONNuWDQUm-t6Leu-Ghc3q8Ou-gHc_1751700301
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

disconnect() can still race with subflow fallback leaving the msk in
inconsistent status. To avoid such race, disconnect() must be blocking,
error out if the argument prevent such wait: the socket will linger
in SS_DISCONNECT state forever.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 71b258aebcd9..0dc55a17f274 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3119,8 +3119,19 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 	inet_sk(msk)->inet_rcv_saddr = inet_sk(ssk)->inet_rcv_saddr;
 }
 
+/* can safely clear the fallback status only if no subflow is going to
+ * push or receive any data on the wire
+ */
+static bool mptcp_can_reset_fb_status(const struct mptcp_sock *msk)
+{
+	return list_empty(&msk->conn_list) ||
+	       inet_sk_state_load(msk->first) == TCP_CLOSE;
+}
+
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
+	long timeout = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* We are on the fastopen error path. We can't call straight into the
@@ -3142,7 +3153,34 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
+
+	if (!mptcp_can_reset_fb_status(msk)) {
+		if (!timeout)
+			return -EAGAIN;
+
+		add_wait_queue(sk_sleep(sk), &wait);
+
+		/* __mptcp_close_ssk() will wake us */
+		do {
+			if (sk_wait_event(sk, &timeout,
+					  mptcp_can_reset_fb_status(msk),
+					  &wait))
+				break;
+		} while (!signal_pending(current) && timeout);
+
+		remove_wait_queue(sk_sleep(sk), &wait);
+
+		/* timeout/signal can prevent reaching the expected status */
+		if (!mptcp_can_reset_fb_status(msk))
+			return -EBUSY;
+	}
+
+	spin_lock_bh(&msk->fallback_lock);
+	msk->allow_subflows = true;
+	msk->allow_infinite_fallback = true;
 	WRITE_ONCE(msk->flags, 0);
+	spin_unlock_bh(&msk->fallback_lock);
+
 	msk->cb_flags = 0;
 	msk->recovery = false;
 	WRITE_ONCE(msk->can_ack, false);
-- 
2.49.0

