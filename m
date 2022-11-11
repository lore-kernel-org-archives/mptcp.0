Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A3D2596
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 11:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668165549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1J1LvAj2IQo3vVf7Pi3vsTkccwKQ9X+J6wg1C/5+O5s=;
	b=Jf99qRZ6b1aUlZfhihozhKZdjyqfSV5QMM891zVxJQdFbQ9/Oy8b1UUf9uH3rlOlQN8xAx
	HNOpgFktUd3EVhX/aYyrAHCvz/v2Yjz69E2/y7p2Ntm7zZZQoyhzaxjApusWA7peTK+JoA
	B8wtJKmFHMMVNjaOl5J5bS1jANrZCtc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-UI2BxaVJML2EhC58t_QFuw-1; Fri, 11 Nov 2022 06:19:06 -0500
X-MC-Unique: UI2BxaVJML2EhC58t_QFuw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6CA2280D724;
	Fri, 11 Nov 2022 11:19:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 28233C15BB2;
	Fri, 11 Nov 2022 11:19:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH mptcp-next 2/2] Squash-to: "mptcp: add subflow_v(4,6)_send_synack()"
Date: Fri, 11 Nov 2022 12:18:59 +0100
Message-Id: <08853d114ad67bbb0ad66b40493b0880ca1ae862.1668165456.git.pabeni@redhat.com>
In-Reply-To: <00a831a7ae3ffb0573dca58f270a98799f5230bf.1668165456.git.pabeni@redhat.com>
References: <00a831a7ae3ffb0573dca58f270a98799f5230bf.1668165456.git.pabeni@redhat.com>
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

Follow-up to the previous patch, splitted here to hopefully
simplify processing/merging.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 10f901e281f6..330a19392f55 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -17,7 +17,7 @@ void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subfl
 	tp = tcp_sk(ssk);
 
 	/* mark subflow/msk as "mptfo" */
-	msk->is_mptfo = 1;
+	subflow->is_mptfo = 1;
 
 	skb = skb_peek(&ssk->sk_receive_queue);
 	if (WARN_ON_ONCE(!skb))
-- 
2.38.1

