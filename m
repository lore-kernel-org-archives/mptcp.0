Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D33207
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504347; cv=none; b=MKaE/yrfZuR5wXp9XmBtg4OI+rZ1mwB02hs+VokTB8diGPEREx6KsVpdj3dxN7DQwJgHahWkiEubI7OFqddSmjcnIEwO1oPkZqvIaCDbW8AwgQc1Mavamn2Q8ANwSXF4bTQxLSWlTXLPMzcEhO/T94C+kgUDXG0YtLvkpv6WZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504347; c=relaxed/simple;
	bh=1Hc3kX7b2Qjds4E4ckHMY39pjKPgKFWB7eAnh624kWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=cCRg0nCBoXad/oCJ7Glie4YoPLDiIipPEmgAkrSlvRGpbIT8DYViMHcDfabpD/vHlBO5A7GOfo3kPPvksBeE5+PtQc7bRQmtX7FVepNODJ33W6akg5C+I4/91WZwYOtojjc5VuDn61HPEp5rZc7km1wwKXGS3B5MZGxx5lzxrKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGYteB58; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGYteB58"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762504344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7hG/sIcv2TRPO8epr0Cjoy4xYUJ8nqYOJ7PH6xjFFI=;
	b=hGYteB58h6dJUpm2oGSCGd6Pamc+i55qrgllY146gBuupRSiR2gJwH8eKbnhnVKjMSLqnx
	3brKNRDv5hYZlZm2oo87KaOaOH7F7yxDRQcmZgeIAElKmDhWw5dLNVbh3agiAthqPQjjuG
	ntAvi4l7qN7Gmi44xq7DqtFKxTSCo2w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-bi-k44q5OOy2H8jfJ5FZKw-1; Fri,
 07 Nov 2025 03:32:23 -0500
X-MC-Unique: bi-k44q5OOy2H8jfJ5FZKw-1
X-Mimecast-MFC-AGG-ID: bi-k44q5OOy2H8jfJ5FZKw_1762504342
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 525A819560B2;
	Fri,  7 Nov 2025 08:32:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.157])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2674018002A6;
	Fri,  7 Nov 2025 08:32:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Subject: [PATCH v3 mptcp-next 1/7] trace: mptcp: add mptcp_rcvbuf_grow tracepoint
Date: Fri,  7 Nov 2025 09:32:05 +0100
Message-ID: <58467c663646d2ee937e6c2fde18439971efa49c.1762504059.git.pabeni@redhat.com>
In-Reply-To: <cover.1762504059.git.pabeni@redhat.com>
References: <cover.1762504059.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kC7t3me49z7wLMAR_spLcUUgqDdvyzG1dOW7L9sjnic_1762504342
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
index 24d4fa8227b7..31154e2df5ee 100644
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

