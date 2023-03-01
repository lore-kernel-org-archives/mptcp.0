Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5210EE
	for <mptcp@lists.linux.dev>; Wed,  1 Mar 2023 10:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677666256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGZSFKjGprqtFgCMcWlTMwjdu5ik7DT5xRhtKYqZsbc=;
	b=HGUfWYGKEEG/gA2xq6hWHo2XtdatvzQlPC2sx0aylCmyXWHbfS5scgDI0PbasW/O5vxgU3
	AHGwBh1biQl7ukJ43K8jr6Ba6UzycZ4KbWeCMwvsufEohc0haAw3VhEHv6d3AfwmmGdsUh
	kHf7j8ph5EahOjZugSMUy73Krju+wNA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-CCbCtwPCMSSQDbxcJ2Muzw-1; Wed, 01 Mar 2023 05:24:10 -0500
X-MC-Unique: CCbCtwPCMSSQDbxcJ2Muzw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E64AE185A78B;
	Wed,  1 Mar 2023 10:24:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.119])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 519762166B26;
	Wed,  1 Mar 2023 10:24:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH v2 mptcp-net 2/2] Squash-to: "mptcp: fix UaF in listener shutdown"
Date: Wed,  1 Mar 2023 11:24:05 +0100
Message-Id: <67613123c481880a3df5cb811bbb7ee7dc652c66.1677666206.git.pabeni@redhat.com>
In-Reply-To: <f2408481e722ba13f5303ab1e6328d97388487fb.1677666206.git.pabeni@redhat.com>
References: <f2408481e722ba13f5303ab1e6328d97388487fb.1677666206.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This just removes left-over code that should have been
dropped already by the squash-to target.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 02dc444026b5..db640483fbf6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2421,11 +2421,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		mptcp_subflow_drop_ctx(ssk);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
-		if (ssk->sk_state == TCP_LISTEN) {
-			tcp_set_state(ssk, TCP_CLOSE);
-			inet_csk_listen_stop(ssk);
+		if (ssk->sk_state == TCP_LISTEN)
 			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
-		}
+
 		__tcp_close(ssk, 0);
 
 		/* close acquired an extra ref */
-- 
2.39.2

