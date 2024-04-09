Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A75281723
	for <mptcp@lists.linux.dev>; Tue,  9 Apr 2024 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657445; cv=none; b=T1p3N2+RO/2pmmBs9V6gM0j18bFUZonCDL2Wk9vT9U+Yaq+Q8r4ROe54/Ij8D3/FemmRct8OlHYL5Pp7hy6RnTUC35LHJ+gwHE947VOnRAI3Y+VkuyZ1ONG4ycBLZPo/DpG94XMs0Y8u5y8SED78sGu69RrrvD6M+rcvTD9dhqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657445; c=relaxed/simple;
	bh=Y/8HgQQjlovau521QIfVwKJBdTaDRD9zhXD5pUNy9N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZiFVcc/hDaNjUmdwpLqkZ+z3RIa35+77JDwJO4x4hjZsbNTyfORV9EXFKf14JmCMxqOuPnIYaNjQ2DZtmVw5LeSND9JRISTFpX4kaKDmueZWmFNu9CKgHwMhnFMBivPfLJqix0hX8IAcI/bNVkCvKajPvF0ksn/cORiC304WbhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGhADNF2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGhADNF2"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ecfeefe94cso2672452b3a.0
        for <mptcp@lists.linux.dev>; Tue, 09 Apr 2024 03:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657444; x=1713262244; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyP0X0s/RRDLWOFYnS+O0fVDoFb4YMkN1n74QkjCNuk=;
        b=WGhADNF2D+lc7lwSSrIM0LqoF+xe44JYKQuvvr2NCU2kXO0abAFGjzIsZVawRlMeSO
         vPBO42BpkkEpnHv9VUFmCcsGrf3Rd6YiAosTs7Szaev9rdbi2E6zdAJfW1gI1wdayMJL
         jqc2YclXU26bZsMx4rlXY9Cq50iaiJKsKPiN6jtgp5rq+RcVoblVkIge6kzMvx4kILCH
         wNMXe18QyD9iGbmzWOUWJazQWrqwiWIUSZCKvnEIYyfWagwj6GeEl4wBjCV8/FhowtWM
         /tjNOzwHEh7KY7aloqHOORjaugwsB5jfO2uzS6HHio/AoQYZNSJlCqYo5DmjtBILzmsM
         2vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657444; x=1713262244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyP0X0s/RRDLWOFYnS+O0fVDoFb4YMkN1n74QkjCNuk=;
        b=nz0/ZVBYqJ+CJWPi8Slm3pYvweBrvZg3/tKNfXrECNqYPNhnoLW53qnzqd6s7Ptox4
         LPg6mLGYezItboU/hgWR9LTKLrWWrjwBtgxpytN37mVGPzwhln4J5E2i+nWTeqhiDtku
         3AnLlzV4mTU5lAiQGRyecUM91BpWx29gHZWZYc9YXgVRE9mi4W6Rso2pdDmG45LM9SjP
         IHvoCVANLh+wO2wTvKR2LbGKU80H8BuFKWX9GwaQwzVckztgp4V6AkQf/0741NCUkeWJ
         CTvjJ+VWjz6oGNgL3H8FiYHDQR/9l31nEDvg4bgccNVt6NLHqvOs2L3oBMYXEh8z6uAM
         5NXA==
X-Gm-Message-State: AOJu0YyeFzEMkX+6LFaZVoEoH7DQVMEJKSxmCiJVSdqi4tO6gbkHvIrA
	KjhGFllDTncblVsf/tu0aM90Ov8EG9HkVOvQxO/rOPIrW+YccE6n
X-Google-Smtp-Source: AGHT+IHYp3yQASFgSLFWBPFE5s3oxcfZtkD+LHZnpUnEDTeZwpGM4uHWT8Jayb/o9K/S1NF5FlZr/A==
X-Received: by 2002:a05:6a20:a11f:b0:1a7:5102:c09a with SMTP id q31-20020a056a20a11f00b001a75102c09amr3345928pzk.26.1712657443798;
        Tue, 09 Apr 2024 03:10:43 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.26.66])
        by smtp.gmail.com with ESMTPSA id fn12-20020a056a002fcc00b006e5597994c8sm7959130pfb.5.2024.04.09.03.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:10:43 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 6/6] rstreason: make it work in trace world
Date: Tue,  9 Apr 2024 18:09:34 +0800
Message-Id: <20240409100934.37725-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240409100934.37725-1-kerneljasonxing@gmail.com>
References: <20240409100934.37725-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

At last, we should let it work by introducing this reset reason in
trace world.

One of the possible expected outputs is:
... tcp_send_reset: skbaddr=xxx skaddr=xxx src=xxx dest=xxx
state=TCP_ESTABLISHED reason=NOT_SPECIFIED

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/trace/events/tcp.h | 37 +++++++++++++++++++++++++++++++++----
 net/ipv4/tcp_ipv4.c        |  2 +-
 net/ipv4/tcp_output.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  2 +-
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 5c04a61a11c2..9bed9e63c9c5 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -11,6 +11,7 @@
 #include <net/ipv6.h>
 #include <net/tcp.h>
 #include <linux/sock_diag.h>
+#include <net/rstreason.h>
 
 /*
  * tcp event with arguments sk and skb
@@ -74,20 +75,38 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
 	TP_ARGS(sk, skb)
 );
 
+#undef FN1
+#define FN1(reason)	TRACE_DEFINE_ENUM(SK_RST_REASON_##reason);
+#undef FN2
+#define FN2(reason)	TRACE_DEFINE_ENUM(SKB_DROP_REASON_##reason);
+DEFINE_RST_REASON(FN1, FN1)
+
+#undef FN1
+#undef FNe1
+#define FN1(reason)	{ SK_RST_REASON_##reason, #reason },
+#define FNe1(reason)	{ SK_RST_REASON_##reason, #reason }
+
+#undef FN2
+#undef FNe2
+#define FN2(reason)	{ SKB_DROP_REASON_##reason, #reason },
+#define FNe2(reason)	{ SKB_DROP_REASON_##reason, #reason }
 /*
  * skb of trace_tcp_send_reset is the skb that caused RST. In case of
  * active reset, skb should be NULL
  */
 TRACE_EVENT(tcp_send_reset,
 
-	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_PROTO(const struct sock *sk,
+		 const struct sk_buff *skb,
+		 const int reason),
 
-	TP_ARGS(sk, skb),
+	TP_ARGS(sk, skb, reason),
 
 	TP_STRUCT__entry(
 		__field(const void *, skbaddr)
 		__field(const void *, skaddr)
 		__field(int, state)
+		__field(int, reason)
 		__array(__u8, saddr, sizeof(struct sockaddr_in6))
 		__array(__u8, daddr, sizeof(struct sockaddr_in6))
 	),
@@ -113,14 +132,24 @@ TRACE_EVENT(tcp_send_reset,
 			 */
 			TP_STORE_ADDR_PORTS_SKB(skb, th, entry->daddr, entry->saddr);
 		}
+		__entry->reason = reason;
 	),
 
-	TP_printk("skbaddr=%p skaddr=%p src=%pISpc dest=%pISpc state=%s",
+	TP_printk("skbaddr=%p skaddr=%p src=%pISpc dest=%pISpc state=%s reason=%s",
 		  __entry->skbaddr, __entry->skaddr,
 		  __entry->saddr, __entry->daddr,
-		  __entry->state ? show_tcp_state_name(__entry->state) : "UNKNOWN")
+		  __entry->state ? show_tcp_state_name(__entry->state) : "UNKNOWN",
+		  __entry->reason < RST_REASON_START ?
+			__print_symbolic(__entry->reason, DEFINE_DROP_REASON(FN2, FNe2)) :
+			__print_symbolic(__entry->reason, DEFINE_RST_REASON(FN1, FNe1)))
 );
 
+#undef FN1
+#undef FNe1
+
+#undef FN2
+#undef FNe2
+
 /*
  * tcp event with arguments sk
  *
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 03c5af9decbf..4889fccbf754 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -871,7 +871,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	if (sk)
 		arg.bound_dev_if = sk->sk_bound_dev_if;
 
-	trace_tcp_send_reset(sk, skb);
+	trace_tcp_send_reset(sk, skb, reason);
 
 	BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=
 		     offsetof(struct inet_timewait_sock, tw_bound_dev_if));
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 6d807b5c1b9c..710922f7d4d6 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3610,7 +3610,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority, int reason)
 	/* skb of trace_tcp_send_reset() keeps the skb that caused RST,
 	 * skb here is different to the troublesome skb, so use NULL
 	 */
-	trace_tcp_send_reset(sk, NULL);
+	trace_tcp_send_reset(sk, NULL, SK_RST_REASON_NOT_SPECIFIED);
 }
 
 /* Send a crossed SYN-ACK during socket establishment.
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 6889ea70c760..3c995eff6e52 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1131,7 +1131,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 			label = ip6_flowlabel(ipv6h);
 	}
 
-	trace_tcp_send_reset(sk, skb);
+	trace_tcp_send_reset(sk, skb, reason);
 
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
 			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
-- 
2.37.3

