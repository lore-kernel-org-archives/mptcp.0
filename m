Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6843FD2D
	for <mptcp@lists.linux.dev>; Tue,  4 Aug 2026 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837062; cv=none; b=dht+3C5BNKipO6LahaJdyOV8e1xQoSe2caXNZLXprosw3+zD2w9fLZWyM41+fqDU302kBRs/bMfRHOvkPNqWjxrUplfrfIpficRd7X0KIE9vCK7HTZFTJqWPY6CiEeEZB6qXpcDnzmdBwLUlF5zk0wAoGJpoJv9ahjfN8spv21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837062; c=relaxed/simple;
	bh=CXhrDt2N1ZKsuvoyPZevD5brYgEi/7BxYv7KLNTjNVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YtC04+8HeK+jO50gmQcR8ipPgu7ocNYqbgifGW38L23Iomqe6jCUOrA05xmpcYgSFKZS6Pw5swwuich4nq26MzPT4SPULR6XrGTcmVCVd0V7aNBRWYb11V6gnMa0THQLhjmIaO3NOiX3/9x9VrA8P74a6rcB2X879Jz5dcH3f8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=MpMATb4b; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="MpMATb4b"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so34044646d6.1
        for <mptcp@lists.linux.dev>; Tue, 04 Aug 2026 02:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785837057; x=1786441857; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PERyMvv//ZV8JmFeNOxGHBbrhQ702Zt9Cubl7TxpCpg=;
        b=MpMATb4btQVxfjepVjIdPo6el/S3C6W9dTwx1cgPIThnIjS5IRVIbNZhKEwPWwVbCF
         +4BvnhyhTV1zxUCpSZiLikh+ofVVdOVdMm+3c8EHvNlmdd2FqwU2jmsdjO8zRxEMjSxm
         PJtTsMN/UlHs4ht36fY/9z1d6KunZg1M0MnwYycT5uDGOqGwgps30M2JkmupgWBbOxqg
         Ci/FgwmNvB+OeJc+K6UzOUEcKnQ3y2qY62Fq5X0HhW6Z7hM3VmKVwP2ZSLqTaut73THQ
         R6T471ybnw28ZRpXp8sFN2vOxv/1gpBsjJwOQRxyPCV2MpUgODU1b9xapdK3jLkzLCzi
         G+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837057; x=1786441857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PERyMvv//ZV8JmFeNOxGHBbrhQ702Zt9Cubl7TxpCpg=;
        b=hm+ms9CS08ZtVkKovhfAnhvTQ9kuzd046WnIM+xDWCHQndAyu5V2OQQLXsn6i9l3X8
         y7vSOkd5LmlbZOAXDAl3N1fEWLD0bmQr2xCqTOs8dVWDsWjNyQISuO5z9JtBhqXD4EDo
         jb7D+Ay4Supl/pRzULAPmlJOg1LaIxoxyMQQqO3R7gQyMes5HxcVSh+0Jgls5ji3A9Tr
         aQczd+/Z8tZCIhr1LRQcJoltmb2ID4IEO0/Qr6tApyGciFMOnJti1Jpvp1XOgc2uyRnh
         2vsCbjkPzEm+BibDe9Vk3Bi/qzq2Jp/GYgZNCAaWNtpY0s24rfEK53+igWq7NRrGrJTo
         vIGA==
X-Forwarded-Encrypted: i=1; AHgh+RqXCA88rE8MPvPBNHqNVgxNVh2obHAPG2j0c9udDvSIlANIo94pSrkezT0w3sdse2zd1LfpJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKBt7/P71G6PPZGoR4Fqg1JX0z9HfMfqlwZn/xGF8hHCBw72cx
	oEjYWO81yI3AKb44+xDSUByzVqo6NRxoiAKFR/BHXFD5dmPZTK8RNdD8Vv4tAniXlxM=
X-Gm-Gg: AR+sD13Uxxl6+nDEmUaPhLYytX8mYxwMR+XZ9N+LoRG0yMuRkiM1wEqQHs6pUzdZSB3
	MGo3gzZjeo/KLJ6Lzma5AGge3ju1uPiq519smIwLLi23OROI8hgN95f1Tj6LDSdOH7t4W8LNxj7
	R4s1hXK8m/fyhK4ZPQEzUHHDlsIos/aZI0Z6hg9JZJU3OjuI5OR5w88Sh0gwUOq2gz/YXmbJlv6
	EJm18iDsOIOmNKtSgOkhdMhYUZM5HE+XznDGOfb9I4dpc/6fLxspe19OrO5pLwltKvIF09eJGJ8
	b9dARarMbIQaUD0J0jOnL0KjcxNbyi/dUK+1clFhitZmrrKsmFhYFTDd0E47wVtuuc08sPqurUa
	MvTaONofc2iKnkuPkeuD5SRoTpSX5l2IoWlStCPnrukNd3CGNvWszwaRbNgM7Yfvo1yjcbEjvvb
	Jn++XNeQXs/aqoTKHP8zmILuNgK2hRo9X8KTast+cFtSjPSMa+7tAknIxY8JI/oZuEEA==
X-Received: by 2002:a05:6214:5d0f:b0:908:25a2:6bbf with SMTP id 6a1803df08f44-908496b3d1emr290394186d6.30.1785837052734;
        Tue, 04 Aug 2026 02:50:52 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-908434a2c2asm95469626d6.19.2026.08.04.02.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 02:50:52 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	geliang@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net] mptcp: hold msk reference when cloning request sockets
Date: Tue,  4 Aug 2026 09:50:49 +0000
Message-ID: <20260804095051.715355-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

An MP_JOIN request owns the reference stored in subflow_req->msk.
inet_reqsk_clone() byte-copies that pointer when migrating a request,
but does not acquire a reference for the clone.  The original and cloned
request destructors can consequently drop the same reference, leaving
one request with a dangling msk pointer.

Let cloned MPTCP requests take their own msk reference.  The source
request still owns its reference while it is being cloned, so sock_hold()
is safe.  The clone's normal destructor balances the new reference on
both successful and failed migration paths.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 include/net/mptcp.h             |  5 +++++
 net/ipv4/inet_connection_sock.c | 10 ++++++++--
 net/mptcp/subflow.c             |  8 ++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 71b9fc5a5..51d4b02f5 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -223,6 +223,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
 					       struct sock *sk_listener,
 					       bool attach_listener);
+void mptcp_subflow_reqsk_clone(struct request_sock *req);
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb);
 
@@ -309,6 +310,10 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 	return NULL;
 }
 
+static inline void mptcp_subflow_reqsk_clone(struct request_sock *req)
+{
+}
+
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 56902bba5..f3ef9c15a 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -17,6 +17,7 @@
 #include <net/inet_timewait_sock.h>
 #include <net/ip.h>
 #include <net/route.h>
+#include <net/mptcp.h>
 #include <net/tcp_states.h>
 #include <net/xfrm.h>
 #include <net/tcp.h>
@@ -946,8 +947,13 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 	/* We need not acquire fastopenq->lock
 	 * because the child socket is locked in inet_csk_listen_stop().
 	 */
-	if (sk->sk_protocol == IPPROTO_TCP && tcp_rsk(nreq)->tfo_listener)
-		rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
+	if (sk->sk_protocol == IPPROTO_TCP) {
+		if (tcp_rsk(nreq)->tfo_listener)
+			rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
+
+		if (rsk_is_mptcp(req))
+			mptcp_subflow_reqsk_clone(nreq);
+	}
 
 	return nreq;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899c..1b6aa5e8c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -47,6 +47,14 @@ static void subflow_req_destructor(struct request_sock *req)
 	mptcp_token_destroy_request(req);
 }
 
+void mptcp_subflow_reqsk_clone(struct request_sock *req)
+{
+	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
+
+	if (subflow_req->msk)
+		sock_hold((struct sock *)subflow_req->msk);
+}
+
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 				  void *hmac)
 {
-- 
2.47.3
