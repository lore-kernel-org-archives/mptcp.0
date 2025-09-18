Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D7F314A6C
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215714; cv=none; b=hgCBo+ieuKvvFj+k180spzPDd+IrF2OowKTAJ53LsN/fMMX7fklOXfNwJdil2WCnMZCvKuZb6cDa+HTp4I04rIovBhUBI0AE12bIG/4s+55hh3/Bcwyw8nZjN/+l6MUy7N2S7dWBQ/JZSgOSPnaNia8cMOXkanGJWK1xerboHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215714; c=relaxed/simple;
	bh=tMExn1IsFOK6NEPy0uH8d8BK68rl0lIh1v4quOwp3dY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gzftvIJLbwBS5owXac817csUNWqXL8mU4RMAeURwRxpdNNuGED1/wyb5uSuB/JLEBf2iOwj6CsEEOMrSwa5zlMSEAXP13oWut/mMdUP3/rvI7GUSx/lKtW6R3kB9DtMfVcot3szFEgmYC5GDL7Kg2TKB4vW6WqRnkBOpxWZ/FL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=clor8Wdz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clor8Wdz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758215710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sdSkfbpAoGK6JYNSnnHhnjgT+GYMBNrk05mXISMMuY4=;
	b=clor8WdzL4pFut2faoKjZ8ajJqQUgTR4WrMEVtOw5T+5DsjWVTlWIWzoqxVsjqXfFvanPX
	0NKUXmUR0smtcaHa/Z8XxPCN8mXPE7JHONIf/pwRT1RLx79o+by0cjbtSQMKGwVyvtvbNp
	dDHJ3y81rKqS0GhWSPpVgTLSW9yAu0g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-hW1aS_lzO-mGnmU1sLjmLg-1; Thu,
 18 Sep 2025 13:15:08 -0400
X-MC-Unique: hW1aS_lzO-mGnmU1sLjmLg-1
X-Mimecast-MFC-AGG-ID: hW1aS_lzO-mGnmU1sLjmLg_1758215707
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 879E118002C0
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3E0F30002C5
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 02/12] tcp: make tcp_rcvbuf_grow() accessible to mptcp code
Date: Thu, 18 Sep 2025 19:14:44 +0200
Message-ID: <d5fe01b8d262752dea8db8653e12aa9e9685b7e7.1758214563.git.pabeni@redhat.com>
In-Reply-To: <cover.1758214563.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t-P0Fmjqo3S4tIvxesncMH_OZmH7rhMi2QFPlBBhvX4_1758215707
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

