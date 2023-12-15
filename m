Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D21A705
	for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAwxbUMM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702631538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tWff2um6McdoPsE962MpW5AyGTdqvznZkA+dCh/vU08=;
	b=PAwxbUMMKeO28ETQU7ATrmQEhcaK4TmKCozpLOU+cPxzXPxJDPxloME31OVLTAM8Hm2wmw
	bcwk2o4kZ29qqE9/9cjHUr3lrr21k0r/o2II8iBxVut1m8rZMr8hDQiC+SkQQKvXZELcY/
	EbT1ZoS1UUa6wQyqZiBWmPWrglcK9ZY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614--utJEHkTOuOxnBXc0qn1vg-1; Fri, 15 Dec 2023 04:12:15 -0500
X-MC-Unique: -utJEHkTOuOxnBXc0qn1vg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 972DF85A589
	for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 09:12:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.176])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 254B8C1596E
	for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 09:12:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: prevent tcp diag from closing listener subflows
Date: Fri, 15 Dec 2023 10:12:11 +0100
Message-ID: <f6371f65b1ebabc0f308528494ec39c9bdf786fd.1702631517.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP protocol does not expect that any other entity could change
the first subflow status when such socket is listening.
Unfortunately the TCP diag interface allows aborting any TCP socket,
including MPTCP listeners subflows. As reported by syzbot, that trigger
a WARN() and could lead to later bigger trouble.

The MPTCP protocol needs to do some MPTCP-level cleanup actions to
properly shutdown the listener. To keep the fix simple, prevent
entirely the diag interface from stopping such listeners.

We could refine the diag callback in a later, larger patch targeting
net-next.

Fixes: 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the sk status")
Closes: https://lore.kernel.org/netdev/0000000000004f4579060c68431b@google.com/
Reported-by: syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 64302a1ac306..1f98bec264a6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1981,6 +1981,17 @@ static void tcp_release_cb_override(struct sock *ssk)
 	tcp_release_cb(ssk);
 }
 
+static int tcp_abort_override(struct sock *ssk, int err)
+{
+	/* closing a listener subflow requires a great deal of care.
+	 * keep it simple and just prevent such operation
+	 */
+	if (inet_sk_state_load(ssk) == TCP_LISTEN)
+		return -EINVAL;
+
+	return tcp_abort(ssk, err);
+}
+
 static struct tcp_ulp_ops subflow_ulp_ops __read_mostly = {
 	.name		= "mptcp",
 	.owner		= THIS_MODULE,
@@ -2025,6 +2036,7 @@ void __init mptcp_subflow_init(void)
 
 	tcp_prot_override = tcp_prot;
 	tcp_prot_override.release_cb = tcp_release_cb_override;
+	tcp_prot_override.diag_destroy = tcp_abort_override;
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	/* In struct mptcp_subflow_request_sock, we assume the TCP request sock
@@ -2060,6 +2072,7 @@ void __init mptcp_subflow_init(void)
 
 	tcpv6_prot_override = tcpv6_prot;
 	tcpv6_prot_override.release_cb = tcp_release_cb_override;
+	tcpv6_prot_override.diag_destroy = tcp_abort_override;
 #endif
 
 	mptcp_diag_subflow_init(&subflow_ulp_ops);
-- 
2.42.0

