Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549012C469
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343938; cv=none; b=c06rwEX5DUfatLfSMaeTsPXHHf3q2aQKasObqCZegdTtbWQDOS6JwyiRHpS9NubR2R/VdbhQojvk4hf6nBwj5vCzbHqbPNId8uhkAZA0A+RcFUsAI3muzkIcrJBqEsvkTDxoHS7Gj5KgDA/UelEl8N/AGsmu5M08W7NbPKMp37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343938; c=relaxed/simple;
	bh=9+NXcmGwyt344ac+65+IFERA0aeIWelc23La2k0MJFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CkTEGSrMJQoH5W5mG5QgLkSkiKoO0Y4kqvKV62xzEBIDRG7VVYr+npAWuvZ5hGRQCuKB3M+9JdRo9g4ppGv+887xG1Kt91xgRjh5MqD7arOo/qKwlI2Gmp0dN0SXRds1qBkk5d9EOs2xeO5z6FS59KtuLWFh9UJfRepgeLis9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JENumfJ/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JENumfJ/"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e51398cc4eso49685885ad.2
        for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 01:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713343936; x=1713948736; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXPsQyON3TFtDQR7bYganuNlYsXI10vIvS6F+4BgaXc=;
        b=JENumfJ/IXnZ2r5pZnmEE2PtVmV0TYRzrwSeLdNV8hp/F2ankDTr5p8TuizYR/50jf
         STrLfHCLvU6anM3ukRik3+r+a/JB9u/u1w3sPOyngu7n4fF7DXS7P0tcNcsnvp44KuxK
         LkYTp7DMafO+7CCMqNaDByaz6NkxO6A6li8K3LpZA1lcXxlUqUopW6cmCqlENqb2orlC
         ZGWAN4O3VASZMxlU9BvixT9SuJJ2MnHedDgJl+20TIZQaV5r8d7QTYERUjZQJec4ecJX
         V60vQEM6kO9RAokHOL3b9Uh+sjb8alDQk/gA/WHR8Y7f7/NBaJJ+qG2hNLTvKWhgk2fb
         df3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343936; x=1713948736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXPsQyON3TFtDQR7bYganuNlYsXI10vIvS6F+4BgaXc=;
        b=pjrz4XaNMso0TWFFuqkP56FGJlh3YGld+n7nSl2vLGzy2VmCLMU4gorsRg1oTjHN9J
         8c/ii/wAEh3boiI8GN8r3F5NSWjJ2CAO8dnLpZ9dGgtGemzBd6rdWBAfB8XIgsYUHOXz
         jhqmfCAQkawzYmYNdObSGhDGC3SVBty3/dC+LZay0yPc7joNwP7pro1Ohip7ISyt3qrY
         W4nph86GJSsCF5pURmGBbUqvPY1GIiR9rhw/NObhnW+ZFV4MzHGmFfF0CY8UYjNOeOMZ
         PxtkWFHJT5+o8Wp0x37+zAPafQD5sbml9IajwLd5KPhJBO1HgjqCSgUUtnrNNd4E8cc1
         zdcA==
X-Gm-Message-State: AOJu0YzSTG5AoTFtVT6vmhK2jUu/vy4HT9b2uS6pOUIdYibm9WPjRqL1
	nhO8N2R/INsfTiTCGDBFfl7CquipAPmjYcnMGWoQ5SF3VR3JX1Qf
X-Google-Smtp-Source: AGHT+IGpyr2TT4oCCA250B5rHj8g9n6uOg+JRF31TmN7I0IAFPbNd+V2kkEZb14DBv3LVjmfH0GqdA==
X-Received: by 2002:a17:902:d4ce:b0:1e5:5cab:92ee with SMTP id o14-20020a170902d4ce00b001e55cab92eemr19923004plg.33.1713343936501;
        Wed, 17 Apr 2024 01:52:16 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b001e452f47ba1sm11348611pli.173.2024.04.17.01.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:52:16 -0700 (PDT)
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
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 6/7] mptcp: introducing a helper into active reset logic
Date: Wed, 17 Apr 2024 16:51:42 +0800
Message-Id: <20240417085143.69578-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240417085143.69578-1-kerneljasonxing@gmail.com>
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since we have mapped every mptcp reset reason definition
in enum sk_rst_reason, introducing a new helper can cover
some missing places where we have already set the
subflow->reset_reason.

Note: using SK_RST_REASON_NOT_SPECIFIED is the same as
SK_RST_REASON_MPTCP_RST_EUNSPEC. They are both unknown.
So we can convert it directly.

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
index fdfa843e2d88..82ef2f42a1bc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -12,6 +12,7 @@
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
 #include <net/genetlink.h>
+#include <net/rstreason.h>
 
 #include "mptcp_pm_gen.h"
 
@@ -581,6 +582,16 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 	WRITE_ONCE(subflow->local_id, -1);
 }
 
+static inline void
+mptcp_send_active_reset_reason(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	enum sk_rst_reason reason;
+
+	reason = convert_mptcp_reason(subflow->reset_reason);
+	tcp_send_active_reset(sk, GFP_ATOMIC, reason);
+}
+
 static inline u64
 mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bde4a7fdee82..4783d558863c 100644
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

