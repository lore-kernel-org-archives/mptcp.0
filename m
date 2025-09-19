Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1792505AF
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297225; cv=none; b=kc3OMmyJqE5NAejUDzl+AD6WFxshC3ws99CLsdzDu9Pxqkeae2uIqBa+eycY/urKhlH1CfdUA1ucq8Gx/6p1p8T34FURtvA9gTqW8G4Eg+16VYpOWL+VTZhExWoWcpRTpWE34gF5Ft7cDHpBq5FiXc5jyJt1lY9UsO49O5kwhJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297225; c=relaxed/simple;
	bh=GW5qJEs97fTHG9Vu/ULSl9rFKuTuAR3QGb0ChaZXjdQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Ws3QewWka++nDpaRnoGfNCKeDsrTDkADtCA7OKmreRL9Xo1D5qBCDIZyo9OSkIiPQ60x7MNBSEw3Ly5z4LZMre0MUq09u7Ip3JQg55gxqbN+soJ1AvOBWGQ2rRMyGllJjcTMQJye90TJtr83WB6Vb4u6AjE0EiNEvDDBtSZR58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbbGKsBN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbbGKsBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3etxw24/n6GV8m/GDWSYf7hWuOKJrNtAg0hggNiRTc=;
	b=VbbGKsBN4DhGeNWp1s8T+uegawXw2fyct6Pkb/FlRfeOwecd21uJ4BcYeveK9w8vtbUGuP
	PH8s3zwbgW4ELo6X3wMCKanQiW2K6F+12DyGgerua4ut9SSr/3P81fpY1scxAbNMtHJY00
	X7x2K4SuSaA9OjLNtFwmdLa/eJFB85o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-kHJPSaJ2NWu_6wHuYfrOfA-1; Fri,
 19 Sep 2025 11:53:41 -0400
X-MC-Unique: kHJPSaJ2NWu_6wHuYfrOfA-1
X-Mimecast-MFC-AGG-ID: kHJPSaJ2NWu_6wHuYfrOfA_1758297220
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47DC81800365
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69502180035E
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next v3 02/12] tcp: make tcp_rcvbuf_grow() accessible to mptcp code
Date: Fri, 19 Sep 2025 17:53:16 +0200
Message-ID: <657458419130e9dc4ccfdfb7e89b6d8e86a9cd96.1758296923.git.pabeni@redhat.com>
In-Reply-To: <cover.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PV8wmiiVvdI6UBh8-RPBwr6OL0kCmHnKnIsoHzbHPzA_1758297220
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

To leverage the auto-tuning improvements brought by commit 2da35e4b4df9
("Merge branch 'tcp-receive-side-improvements'"), the MPTCP stack need
to access the mentioned helper.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/tcp.h    | 1 +
 net/ipv4/tcp_input.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e25340459ce4a..db2a4e05147fa 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -356,6 +356,7 @@ void tcp_delack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, int *karg);
 enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
+void tcp_rcvbuf_grow(struct sock *sk);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b2793e749cfd9..ad09995a1aaec 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -701,7 +701,7 @@ static inline void tcp_rcv_rtt_measure_ts(struct sock *sk,
 	}
 }
 
-static void tcp_rcvbuf_grow(struct sock *sk)
+void tcp_rcvbuf_grow(struct sock *sk)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
-- 
2.51.0

