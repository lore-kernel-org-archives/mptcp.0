Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A42FF170
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940478; cv=none; b=cKBvTPk4Dn7povqB8tnRhSOSpFgmF7ONoR7Z6q4+IydTn+a8bsmqJ/JMYeF2RQNo3uMlixTd0EDiG4hUMaSviRza8dK/3EUooiQzOjh+D5xBE6QmJ4ecPqGjJIq7OM7ZjuF01LJ/ryTR1F/VxxQ2qjeMayP7ZdAUHMZvPY5Xekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940478; c=relaxed/simple;
	bh=hWekfqISMwawK6ou/hsekClkoXSJFPaBKEf5ZNlDHCI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Deem/Kn8uydrPlfl3ijZW2onM2f+/OqDZyrD88BE+cNGCh690YSvpHVYVbQ+olyrIaEFXHwZtDxpGaA54UzKyceEbZxMP/qjPLgTNJoMXErXtQMTAxKETbVdQae1AYf8O8aqqlgvb0akBvdmRmq4TZ+TV8Akuo+0o6RNXn+hKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQvFB8GG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQvFB8GG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nP0t32H+9s+S3v+S0jNJrHRkqU7yammwQNK7phn+5ho=;
	b=PQvFB8GGr/dIAodSTraQ17rOzojyt1L3ExFryA3VTZlV+efWUcQhX3380FAdUt8XJ9Y6vp
	EN7DxV3lHQvpr/NH0Fjj5hB08YP/cc7IrxmiwFEw9glIAqy/AiX/Yupxy+AWEFrsfqHIip
	XvfJ27GAsBPRX0bH5m4aOgkf4q2EisY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-oQf1EOyfPgSE9AuPi-x2wA-1; Wed,
 12 Nov 2025 04:41:14 -0500
X-MC-Unique: oQf1EOyfPgSE9AuPi-x2wA-1
X-Mimecast-MFC-AGG-ID: oQf1EOyfPgSE9AuPi-x2wA_1762940473
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E7621801234
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F3D7196B8F7
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 1/6] trace: mptcp: add mptcp_rcvbuf_grow tracepoint
Date: Wed, 12 Nov 2025 10:41:01 +0100
Message-ID: <3446e68d2b4ea00475f82f3630a3b0a33a4b7b56.1762940290.git.pabeni@redhat.com>
In-Reply-To: <cover.1762940290.git.pabeni@redhat.com>
References: <cover.1762940290.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W09LgBSkTc4Qtfb9dpGfdMD-JlWbXFsCgwNKGFIWhtg_1762940473
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Similar to tcp, provide a new tracepoint to better understand
mptcp_rcv_space_adjust() behavior, which presents many artifacts.

Note that the used format string is so long that I preferred
wrap it, contrary to guidance for quoted strings.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - use __entry->family; note that its value is show as raw number
    instead of string, as show_family_name is available only to
    net/core/ trace and I preferred not moving the mptcp traces
    there as we need mptcp-specific helpers, too.
---
 include/trace/events/mptcp.h | 77 ++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c         |  3 ++
 2 files changed, 80 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 085b749cdd97..0f24ec65cea6 100644
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
@@ -178,6 +184,77 @@ TRACE_EVENT(subflow_check_data_avail,
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
+	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u "
+		  "rcvbuf=%u rcv_wnd=%u family=%d sport=%hu dport=%hu saddr=%pI4 "
+		  "daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c skaddr=%p",
+		  __entry->time, __entry->rtt_us, __entry->copied,
+		  __entry->inq, __entry->space, __entry->ooo_space,
+		  __entry->scaling_ratio, __entry->rcvbuf, __entry->rcv_wnd,
+		  __entry->family, __entry->sport,
+		  __entry->dport, __entry->saddr, __entry->daddr,
+		  __entry->saddr_v6, __entry->daddr_v6, __entry->skaddr)
+);
 #endif /* _TRACE_MPTCP_H */
 
 /* This part must be outside protection */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dce9f7a1b0eb..7510bc634585 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -28,6 +28,8 @@
 #include "protocol.h"
 #include "mib.h"
 
+static unsigned int mptcp_inq_hint(const struct sock *sk);
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/mptcp.h>
 
@@ -2103,6 +2105,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
 		goto new_measure;
 
+	trace_mptcp_rcvbuf_grow(sk, time);
 	if (mptcp_rcvbuf_grow(sk, msk->rcvq_space.copied)) {
 		/* Make subflows follow along.  If we do not do this, we
 		 * get drops at subflow level if skbs can't be moved to
-- 
2.51.1

