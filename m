Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF111CB0
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689334199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZQZiIPDlavpQfBnrC6Rc66+z1u60ZGYJd8qeUuRdHA=;
	b=cG4cSY5IGagV318zeEGcJZolkL6CTStXcyIvGs8EZNsUf04F1CXbZ2Yu/wlEKP89NLH9c+
	T6KJkTp9Gpx6ZWdNiNXNdrjhowHN7YEOHdnVR7m79S4kSiGBvXuN1mgmcQ/c7Yww8SuyZc
	7slqOjBaibHCnpOChD2F21r1VlcwSjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-5pJaxtUAMSKm2yYjHSqcxw-1; Fri, 14 Jul 2023 07:29:58 -0400
X-MC-Unique: 5pJaxtUAMSKm2yYjHSqcxw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8772801CF3
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:29:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79AF12166B26
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:29:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 01/13] mptcp: avoid unneeded mptcp_token_destroy() calls
Date: Fri, 14 Jul 2023 13:29:32 +0200
Message-ID: <897413a66c948b6a462c8d05e2628b85d58a668b.1689334116.git.pabeni@redhat.com>
In-Reply-To: <cover.1689334116.git.pabeni@redhat.com>
References: <cover.1689334116.git.pabeni@redhat.com>
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

The mptcp protocol currently clears the msk token both at
connect() and listen() time. That was necessary before the
mptcp protocol gained a full disconnect implementation, but
after commit b29fcfb54cd7 ("mptcp: full disconnect implementation")
such calls are no more necessary and a bit confusing.

Just drop them.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8b5c78f582f7..17174bdae1ca 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3634,7 +3634,6 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 
-	mptcp_token_destroy(msk);
 	inet_sk_state_store(sk, TCP_SYN_SENT);
 	subflow = mptcp_subflow_ctx(ssock->sk);
 #ifdef CONFIG_TCP_MD5SIG
@@ -3753,7 +3752,6 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
-	mptcp_token_destroy(msk);
 	inet_sk_state_store(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
-- 
2.41.0

