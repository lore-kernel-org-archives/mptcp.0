Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74740370598
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040056; cv=none; b=ug5WlzGmt2I5VGJqCoD6sM/+G35XY6RxRyUUCnYJJw7OAPuK7PRuWHJUB/xfxEjNK54giwvyBfZ/Qurpt+54pIlEimML8zP3qK9UE9a/mxpvlo9Huq9nIHioktepDlKYJ2HMshGENXUHicQ3BKXdoVTABYa8J6EeKUz4PE2buGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040056; c=relaxed/simple;
	bh=gyssziIGGEdsOXefNv/wfttrrrysWJBAmDQrvxcN8Q4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=f/sDt/AGAgdjvCl13YoYx3tWBVsy/jRzKb42C6/xon6uF3Z35VTNNFlPSJnyaD4HMs/S4mQEiKmpzPVMh4RjKpP2HXlwGq1wYnAGREXfj/UlUSUL7AMx/wqrgbyxr0uRRoQVBz6Z6MyDv+AFyG3fnYp8aRCjkaGqUDLyEwJuAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inZuKTvu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inZuKTvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758040053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mODELDa4hnLanuBFOLGRgzvjm8PQk5jvijnPBkcUn78=;
	b=inZuKTvubUCpkEB0wPkw57dD92MByoK/GI2M74z7vgIrtEhSbAWNeanoAtC/qbrtOTPjYo
	O5nM+HGP7+bXuhZlG9bvUox0ONjvh7egFqkOarx62fMRhLH+5P4oA/4LMn2WugjYnA4pAR
	JpokzlZhlh5fdWS0KpjkzrVMiIULAf8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-OS3swH79MieErlguErFc6Q-1; Tue,
 16 Sep 2025 12:27:31 -0400
X-MC-Unique: OS3swH79MieErlguErFc6Q-1
X-Mimecast-MFC-AGG-ID: OS3swH79MieErlguErFc6Q_1758040050
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4B96195609F
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.160])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECFC519560B8
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next 02/12] tcp: make tcp_rcvbuf_grow() accessible to mptcp code
Date: Tue, 16 Sep 2025 18:27:12 +0200
Message-ID: <53625108d8a976163497ad5cd44cce2eebab119c.1758039775.git.pabeni@redhat.com>
In-Reply-To: <cover.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -Lhh2ZyPdBgv2NmVJ1VmULRVy0bdpSTVhvv8SS63weo_1758040050
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

To leverage the auto-tuning improvements brought by commit 2da35e4b4df9
("Merge branch 'tcp-receive-side-improvements'"), the MPTCP stack need
to access the mentioned helper.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/tcp.h    | 1 +
 net/ipv4/tcp_input.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2936b8175950f..8298029f2d0f7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -346,6 +346,7 @@ void tcp_delack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, int *karg);
 enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
+void tcp_rcvbuf_grow(struct sock *sk);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a52a747d8a55e..f9f5705390430 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -744,7 +744,7 @@ static inline void tcp_rcv_rtt_measure_ts(struct sock *sk,
 	}
 }
 
-static void tcp_rcvbuf_grow(struct sock *sk)
+void tcp_rcvbuf_grow(struct sock *sk)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
-- 
2.51.0

