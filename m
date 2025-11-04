Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5A34678B
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293124; cv=none; b=PK276rOkfnK6gMfwsY6mlP+TYrN4g0+25WFChjTrOCQQDnod2ZGItIoOP9BaI6gYaGBgwU6/2gwX0iIxgeBxXeqYjuttfuvKxOJhZGDQp4TcdaweQaZIDDJvR+MRzG9HHSP8NoXi0uBeJfwkPvgn6BXt1sf34nZs/LyGNR/uEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293124; c=relaxed/simple;
	bh=WxFehIMK7FonvL9E1qFx+I+NaZx7yMO68SDAIqOl/QI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pTDQrw+dRNMXw/LXT7WXMrcIDytIvjWsgAXAkpGPgRe2QNYH3u4ylBHDrjKOHj+6uELKSXJP1iya7WhHlRJhS5HHjjYZv45yaf+885dKStztxPtUDaLRh9xweGUF7F6sYWtdNShxiPzll9QcwjmsBuBlAeEE8uDLoWIdLkEAwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRwyj+1F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRwyj+1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762293121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SxLshViev8Rp+T51omzgDSjDQP6r1mlLDBl7r5EFOg=;
	b=LRwyj+1FdgdEiJT0X3+TPy9hHHGEg2nU58/N1KU2Plt5AH7nmaxxwqzfRYTeb7J/ukfU7F
	QJ1rT9n7JE8OeyMKXrfgBWGTIoHpZXu4SGuh1H4Pwcy4a+0xAs/nMrNDLC9axk1EAu9+li
	mM4t41Yy19Wa3o46gI6fG2Hw71EIj44=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-GU3I5JVNMbK2lNXeBAn5qA-1; Tue,
 04 Nov 2025 16:52:00 -0500
X-MC-Unique: GU3I5JVNMbK2lNXeBAn5qA-1
X-Mimecast-MFC-AGG-ID: GU3I5JVNMbK2lNXeBAn5qA_1762293119
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A9F9180034C
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:51:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6FC5119560A2
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:51:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 1/7] trace: mptcp: add mptcp_rcvbuf_grow tracepoint
Date: Tue,  4 Nov 2025 22:51:35 +0100
Message-ID: <5b1042b7f934b9a749dee435b7494a414adb57ce.1762292476.git.pabeni@redhat.com>
In-Reply-To: <cover.1762292476.git.pabeni@redhat.com>
References: <cover.1762292476.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ys-K1s8cIm28HNt-pxBA-DzPMrG-JD-EIkBLNL53EUk_1762293119
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Similar to tcp, provide a new tracepoint to better understand
mptcp_rcv_space_adjust() behavior, which presents many artifacts.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/trace/events/mptcp.h | 74 ++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c         |  3 ++
 2 files changed, 77 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 085b749cdd97..71fd6d33f48b 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -178,6 +178,80 @@ TRACE_EVENT(subflow_check_data_avail,
 		  __entry->skb)
 );
 
+#include <trace/events/net_probe_common.h>
+
+TRACE_EVENT(mptcp_rcvbuf_grow,
+
+	TP_PROTO(struct sock *sk, int time),
+
+	TP_ARGS(sk, time),
+
+	TP_STRUCT__entry(
+		__field(int, time)
+		__field(__u32, rtt_us)
+		__field(__u32, copied)
+		__field(__u32, inq)
+		__field(__u32, space)
+		__field(__u32, ooo_space)
+		__field(__u32, rcvbuf)
+		__field(__u32, rcv_wnd)
+		__field(__u8, scaling_ratio)
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+		__array(__u8, saddr, 4)
+		__array(__u8, daddr, 4)
+		__array(__u8, saddr_v6, 16)
+		__array(__u8, daddr_v6, 16)
+		__field(const void *, skaddr)
+	),
+
+	TP_fast_assign(
+		struct mptcp_sock *msk = mptcp_sk(sk);
+		struct inet_sock *inet = inet_sk(sk);
+		__be32 *p32;
+
+		__entry->time = time;
+		__entry->rtt_us = msk->rcvq_space.rtt_us >> 3;
+		__entry->copied = msk->rcvq_space.copied;
+		__entry->inq = mptcp_inq_hint(sk);
+		__entry->space = msk->rcvq_space.space;
+		__entry->ooo_space = RB_EMPTY_ROOT(&msk->out_of_order_queue) ? 0 :
+				     MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq -
+				     msk->ack_seq;
+
+		__entry->rcvbuf = sk->sk_rcvbuf;
+		__entry->rcv_wnd = atomic64_read(&msk->rcv_wnd_sent) -  msk->ack_seq;
+		__entry->scaling_ratio = msk->scaling_ratio;
+		__entry->sport = ntohs(inet->inet_sport);
+		__entry->dport = ntohs(inet->inet_dport);
+		__entry->family = sk->sk_family;
+
+		p32 = (__be32 *) __entry->saddr;
+		*p32 = inet->inet_saddr;
+
+		p32 = (__be32 *) __entry->daddr;
+		*p32 = inet->inet_daddr;
+
+		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
+			       sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
+
+		__entry->skaddr = sk;
+	),
+
+	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rcvbuf=%u "
+		  "rcv_wnd=%u "
+		  "sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 "
+		  "saddrv6=%pI6c daddrv6=%pI6c skaddr=%p",
+		  __entry->time, __entry->rtt_us, __entry->copied,
+		  __entry->inq, __entry->space, __entry->ooo_space,
+		  __entry->scaling_ratio, __entry->rcvbuf,
+		  __entry->rcv_wnd,
+		  __entry->sport, __entry->dport,
+		  __entry->saddr, __entry->daddr,
+		  __entry->saddr_v6, __entry->daddr_v6,
+		  __entry->skaddr)
+);
 #endif /* _TRACE_MPTCP_H */
 
 /* This part must be outside protection */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 01114456dec6..443406bc4a54 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -28,6 +28,8 @@
 #include "protocol.h"
 #include "mib.h"
 
+static unsigned int mptcp_inq_hint(const struct sock *sk);
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/mptcp.h>
 
@@ -2101,6 +2103,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
 		goto new_measure;
 
+	trace_mptcp_rcvbuf_grow(sk, time);
 	if (mptcp_rcvbuf_grow(sk, msk->rcvq_space.copied)) {
 		/* Make subflows follow along.  If we do not do this, we
 		 * get drops at subflow level if skbs can't be moved to
-- 
2.51.0

