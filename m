Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314CF46BA6
	for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856934; cv=none; b=ZjyEkScOIMVaUT9fqB+w/iag7W7wBhBMqP3LAJDFSZ2Dv/yNA83PHCDlU5sD+UdMDxXZDOoiQ6YH8m3w3MxtH22XST04AiPpkM1LLhOnKqnPDrW1vju/kPRQfak+K2SKYw8QgzOM1eQZnjRedC/fa3mEPlRtzNuLnL68vaFJ+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856934; c=relaxed/simple;
	bh=W8emu7Uhr0PFYvV1IkGCPABc0JTat4PRGf0fu2O3/Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvJHrcLul1TXJOa6lml0gGjBCnUF6ROCt1vtexQ6MI/3kj9IDZeXAEPSa+Go9WoPzVr6Ywp6w1jt6FrwKd+BG9tNjrEaXDcFKjCf2NEuANoY7bGjdNSqaYCjzNiOeiTOc1WOm95lrzMyzef2NbNQNX+nN48NKTc/c4/dmU/wEd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzVXtBZ5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzVXtBZ5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e40042c13eso38707195ad.2
        for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713856932; x=1714461732; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A7PFq1XU0pMIlNCoQyVyDpSUuyBsJ2vncVyMNRpTjc=;
        b=JzVXtBZ5fMZrKcu/o3uyPKTQpx05fwjM71v5IpfGgoBNKdtKaM2rgsKWcVaQmKAHIQ
         euDhVBE83e8AyZJEZYzIsmKou9WWk5aHy54Nrxmag7xqHYp2LMOY50n4cj8JDVZ799S4
         baaU74EKbIF45+OA0R7howTOz+pfigRcw0LPnfjZUEQCa7KMOB+dyud3eHqdWVwn9Los
         c5WUt3W1DxHfyaY2Avo7c1kTCqwYK1i1O41YBQFQfI8xzg72GxJVY6CiQNoyQJiPL+KG
         oFIUVmaNVBijBQha60m8CUZ/Em2tKMCY0KiRGHkHHbt5gpHxHyt8TxRHz5S0daPDA5XL
         SnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856932; x=1714461732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2A7PFq1XU0pMIlNCoQyVyDpSUuyBsJ2vncVyMNRpTjc=;
        b=mWwQ9sZT134NDtkcFqC13mHZKpJ5/JEu4AEY6S6oM2mZd8l84017VfUsKOCvNsMewA
         HhtImHdUqHh9W2EvMUNoiOz1gqyRzQ+W9+ZcpS9vmw9q1PsSbfQZBJhfQSBsoMjF0N8r
         FHb9KSSq64P1h9k3CxTw/LdmhV+O+x5lL+C+4YSypfDnq5fcPOmevilj9puvFidA5MnJ
         iCQy44dyr6A3Dibhtc7nlCqixrDiTtvebNVKxscQ+YDn6oCYXFmdE5soTMNL5d2IBkxy
         T7hW2kiQnNeAS3TbPw8FfgDugA+JtbfpnkHUcBpmLKQxfGNVCsQRk0oAJ9/sZEYlMxo7
         HQOg==
X-Gm-Message-State: AOJu0Yx6Omo3BokSx5cRSc1FxSz4YSAfGy3Cj2nO0kgzFJMDtTVZGIh/
	cxgT68NBde3Y80rZCFHMKP8ffD53qQXWEzi7f+7fLfUs/nY6SEaH
X-Google-Smtp-Source: AGHT+IFD2zQQTCMFWkonG3rsQKTWKu17VKv7sCQXLFM/aEjDALU2sXkcWN7BkJK8Ap/DQ8Ht9rWL+g==
X-Received: by 2002:a17:902:c20a:b0:1e0:f504:a6f9 with SMTP id 10-20020a170902c20a00b001e0f504a6f9mr10348140pll.27.1713856932560;
        Tue, 23 Apr 2024 00:22:12 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001e0c956f0dcsm9330114pla.213.2024.04.23.00.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:22:12 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org,
	horms@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v8 6/7] mptcp: introducing a helper into active reset logic
Date: Tue, 23 Apr 2024 15:21:36 +0800
Message-Id: <20240423072137.65168-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240423072137.65168-1-kerneljasonxing@gmail.com>
References: <20240423072137.65168-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since we have mapped every mptcp reset reason definition in enum
sk_rst_reason, introducing a new helper can cover some missing places
where we have already set the subflow->reset_reason.

Note: using SK_RST_REASON_NOT_SPECIFIED is the same as
SK_RST_REASON_MPTCP_RST_EUNSPEC. They are both unknown. So we can convert
it directly.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
Link: https://lore.kernel.org/all/2d3ea199eef53cf6a0c48e21abdee0eefbdee927.camel@redhat.com/
---
 net/mptcp/protocol.c |  4 +---
 net/mptcp/protocol.h | 11 +++++++++++
 net/mptcp/subflow.c  |  6 ++----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 065967086492..4b13ca362efa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -21,7 +21,6 @@
 #endif
 #include <net/mptcp.h>
 #include <net/xfrm.h>
-#include <net/rstreason.h>
 #include <asm/ioctls.h>
 #include "protocol.h"
 #include "mib.h"
@@ -2570,8 +2569,7 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 
 		slow = lock_sock_fast(tcp_sk);
 		if (tcp_sk->sk_state != TCP_CLOSE) {
-			tcp_send_active_reset(tcp_sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+			mptcp_send_active_reset_reason(tcp_sk);
 			tcp_set_state(tcp_sk, TCP_CLOSE);
 		}
 		unlock_sock_fast(tcp_sk, slow);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bbcb8c068aae..d40ad4a2f1b8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -12,6 +12,7 @@
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
 #include <net/genetlink.h>
+#include <net/rstreason.h>
 
 #include "mptcp_pm_gen.h"
 
@@ -609,6 +610,16 @@ sk_rst_convert_mptcp_reason(u32 reason)
 	}
 }
 
+static inline void
+mptcp_send_active_reset_reason(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	enum sk_rst_reason reason;
+
+	reason = sk_rst_convert_mptcp_reason(subflow->reset_reason);
+	tcp_send_active_reset(sk, GFP_ATOMIC, reason);
+}
+
 static inline u64
 mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fb7abf2d01ca..97ec44d1df30 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -20,7 +20,6 @@
 #include <net/transp_v6.h>
 #endif
 #include <net/mptcp.h>
-#include <net/rstreason.h>
 
 #include "protocol.h"
 #include "mib.h"
@@ -424,7 +423,7 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
-	tcp_send_active_reset(ssk, GFP_ATOMIC, SK_RST_REASON_NOT_SPECIFIED);
+	mptcp_send_active_reset_reason(ssk);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
 		mptcp_schedule_work(sk);
@@ -1362,8 +1361,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			tcp_set_state(ssk, TCP_CLOSE);
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
-			tcp_send_active_reset(ssk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+			mptcp_send_active_reset_reason(ssk);
 			WRITE_ONCE(subflow->data_avail, false);
 			return false;
 		}
-- 
2.37.3

