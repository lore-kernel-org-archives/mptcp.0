Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48F6372AA5
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763589277; cv=none; b=QFomk0mKw9e5XcY47CN45FZ672Vt9bIo4O/fsADz8gpJ+W4WAWq2jyQl4Upw/HncZW9r6BQqrKdisKaWTwSP+dtzFzGESEtI7rpEsDy0A3WO/ftPblq2dvqHd1Tsb9ew+xFh4FN3P+liV3oOJaoIEnKKn9E/HW6loCPCdeGWxq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763589277; c=relaxed/simple;
	bh=aURQQXEryRFfJjkaU6HdjVlmD3kMg+HHLP7Rbjx7jeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OpKyjPOKH+fIo9Gu4zI2GKmUE3xV1fsdG411WM/GDdqzjcVp0xaMqyk/yQSOgElv+QT2R6CG/Ohs94hA+Df4FRGdPsVHBTjTKRLgYL0fPpNMccNWtf7lD+H9aftuVfmftFnvcdmV2g5BKaW2a82+u29uFLnT4N94Jzlwqn17UUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmBD0x6U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmBD0x6U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763589274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVyLFxsoy29T4gggCzNi54Gin1PHAW9O695ZnK7TPeY=;
	b=dmBD0x6UAice1BG+WEpfFMJMM+lEX51z2YJ/ws+mIWu3w+lWsXJO4HFb8VNVrHXEFUvL/W
	k91VaS4hQwCYVbLcOFTms/7tmS5P3QKypqh2RN2OCVFyJfvyY4GQVmNZRIIKdPFVasMPoZ
	+k+PFMeu9cVJdjnf5u84HnV7v1753AM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-cBFf3jYQNO6f4NtPJNA1Gg-1; Wed,
 19 Nov 2025 16:54:32 -0500
X-MC-Unique: cBFf3jYQNO6f4NtPJNA1Gg-1
X-Mimecast-MFC-AGG-ID: cBFf3jYQNO6f4NtPJNA1Gg_1763589271
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 875A6195608E;
	Wed, 19 Nov 2025 21:54:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.89])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71DB118004A3;
	Wed, 19 Nov 2025 21:54:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: martineau@kernel.org
Subject: [PATCH mptcp-next v6 1/4] trace: mptcp: add mptcp_rcvbuf_grow tracepoint
Date: Wed, 19 Nov 2025 22:54:20 +0100
Message-ID: <80017719d0443742e0d5a26de64da5570a85fc54.1763588352.git.pabeni@redhat.com>
In-Reply-To: <cover.1763588352.git.pabeni@redhat.com>
References: <cover.1763588352.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 93JvExES3R6xOmVrwxGGy7UEkcWT-Oy15HLStfzcpxY_1763589271
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Similar to tcp, provide a new tracepoint to better understand
mptcp_rcv_space_adjust() behavior, which presents many artifacts.

Note that the used format string is so long that I preferred
wrap it, contrary to guidance for quoted strings.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
  - fixed a couple of checkpatch issues.

v2 -> v3:
  - use __entry->family; note that its value is show as raw number
    instead of string, as show_family_name is available only to
    net/core/ trace and I preferred not moving the mptcp traces
    there as we need mptcp-specific helpers, too.
---
 include/trace/events/mptcp.h | 80 ++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c         |  3 ++
 2 files changed, 83 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 085b749cdd97..269d949b2025 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -5,7 +5,13 @@
 #if !defined(_TRACE_MPTCP_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_MPTCP_H
 
+#include <linux/ipv6.h>
+#include <linux/tcp.h>
 #include <linux/tracepoint.h>
+#include <net/ipv6.h>
+#include <net/tcp.h>
+#include <linux/sock_diag.h>
+#include <net/rstreason.h>
 
 #define show_mapping_status(status)					\
 	__print_symbolic(status,					\
@@ -178,6 +184,80 @@ TRACE_EVENT(subflow_check_data_avail,
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
+		bool ofo_empty;
+		__be32 *p32;
+
+		__entry->time = time;
+		__entry->rtt_us = msk->rcvq_space.rtt_us >> 3;
+		__entry->copied = msk->rcvq_space.copied;
+		__entry->inq = mptcp_inq_hint(sk);
+		__entry->space = msk->rcvq_space.space;
+		ofo_empty = RB_EMPTY_ROOT(&msk->out_of_order_queue);
+		__entry->ooo_space = ofo_empty ? 0 :
+				     MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq -
+				     msk->ack_seq;
+
+		__entry->rcvbuf = sk->sk_rcvbuf;
+		__entry->rcv_wnd = atomic64_read(&msk->rcv_wnd_sent) -
+				   msk->ack_seq;
+		__entry->scaling_ratio = msk->scaling_ratio;
+		__entry->sport = ntohs(inet->inet_sport);
+		__entry->dport = ntohs(inet->inet_dport);
+		__entry->family = sk->sk_family;
+
+		p32 = (__be32 *)__entry->saddr;
+		*p32 = inet->inet_saddr;
+
+		p32 = (__be32 *)__entry->daddr;
+		*p32 = inet->inet_daddr;
+
+		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
+			       sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
+
+		__entry->skaddr = sk;
+	),
+
+	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u "
+		  "rcvbuf=%u rcv_wnd=%u family=%d sport=%hu dport=%hu saddr=%pI4 "
+		  "daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c skaddr=%p",
+		  __entry->time, __entry->rtt_us, __entry->copied,
+		  __entry->inq, __entry->space, __entry->ooo_space,
+		  __entry->scaling_ratio, __entry->rcvbuf, __entry->rcv_wnd,
+		  __entry->family, __entry->sport, __entry->dport,
+		  __entry->saddr, __entry->daddr, __entry->saddr_v6,
+		  __entry->daddr_v6, __entry->skaddr)
+);
 #endif /* _TRACE_MPTCP_H */
 
 /* This part must be outside protection */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f8756521b2e2..64f592a7897c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -28,6 +28,8 @@
 #include "protocol.h"
 #include "mib.h"
 
+static unsigned int mptcp_inq_hint(const struct sock *sk);
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/mptcp.h>
 
@@ -2118,6 +2120,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
 		goto new_measure;
 
+	trace_mptcp_rcvbuf_grow(sk, time);
 	if (mptcp_rcvbuf_grow(sk, msk->rcvq_space.copied)) {
 		/* Make subflows follow along.  If we do not do this, we
 		 * get drops at subflow level if skbs can't be moved to
-- 
2.51.1

