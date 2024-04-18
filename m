Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9C13247D
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447208; cv=none; b=HXuyV2PoR3jY4WnXPtEB7RCRPyh5ZevMhan09xbH7EmS11m344mPnchJBTV6gr1s1HOJ+bb/9+Byuu3ScunGjB3Fb3OsE2gSylUhm7feOMsKefxeTthtifjVsyuybojIT4ELjz7tv3bSMeYgwGoDYesW5+H2xK9GfZHAR/IfoAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447208; c=relaxed/simple;
	bh=9+NXcmGwyt344ac+65+IFERA0aeIWelc23La2k0MJFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=moJRuILwkeY9XsGwmqtPF1ulJLiWZAUbeGdXl3LRphY9puc0QjGMNlwJxQ33/kfpbYzF4Eo8TM4xF3jkQU6D7cwMpSyKIV+6aQB2KAc5K2iKh9csRXYV1bCvLBTGqaLa7fdv50nPudTur/pDC8C5FDZTLo4e9fbDTjAxBJpw0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFwP0Aoh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFwP0Aoh"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so8466655ad.1
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447206; x=1714052006; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXPsQyON3TFtDQR7bYganuNlYsXI10vIvS6F+4BgaXc=;
        b=MFwP0AohWWtRzmXeRH/leS7BtXyUpZexvux7x1gfIu/5NJMAh+mxzT0GQL8MS6S8aT
         r07/z/YQGGtIOTE2EL+ee1+qtp6LGDCy8/rw0B0ckb0LxdrIj/Ns4DKmx0aMsFnwi+R9
         JTADhXRIEumDarIQ7TqjQOKjGCNuFTt19b8wlmGQfXiXVO9tyOkc9GIl3aYBrhMxNTKH
         OfIpd2jZvnD5bcozUrqTzQim861Gw8Q+WER3U0GlGe0HfXaWO3DjrU8bQXgVMKnaWXmo
         f6HiVYkDzWOuVsaAWQQBHwgbXjiMa+VXvUeieOw1EBbD3y6Tft0STNi4tcWxhAdpr8Uq
         4jDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447206; x=1714052006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXPsQyON3TFtDQR7bYganuNlYsXI10vIvS6F+4BgaXc=;
        b=HpQKKieS33wKwcYR/or4qIxTEAp5L8mwTgpr0stYyOFQHLV2c1iA3GB14I95tvumqS
         sWGZwRwb5s2+RS2a6OiB1LBbglSTpDiKnNQamiEnj1YsF57snjdvFvxiZ1Tj2PobzEIk
         jMY2Jh36M5onJ3oGUcQXTK+K0V9NIvKM/ES2NMc7MWp09tJM6EG/0jrdb8GORl0/fMEC
         WkvWXJc7Ef+OStI4pknV6hXIt3/O8geVTgWBxtlb8axWniCrOprJNK8t67D89M/6VwqK
         qd/Wkv3hX8mreiKd6u4SWOYYTD8jxEbjfCKQpXLZ1L9rD+kmwHy30e+PwVdzWIsBmQCZ
         y50g==
X-Gm-Message-State: AOJu0YzMbJFA5oXy7LB2NvnTzHO8xFXnVYT225G3ST1F7cdIqXVz7RB1
	8sIQGTRSfZXDJAHQ2Dpp6X2qHXSE9VVHnIGq29EsdmuchON81k3x
X-Google-Smtp-Source: AGHT+IET4uBkWueYvNuE9jr28hGuSH8072k7It7gJTltNpltgeOa5nNSgKoCviy8RWdgleE+lXkN3Q==
X-Received: by 2002:a17:90a:db4e:b0:2ab:ca7d:658b with SMTP id u14-20020a17090adb4e00b002abca7d658bmr1905825pjx.4.1713447205673;
        Thu, 18 Apr 2024 06:33:25 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id bt19-20020a17090af01300b002a2b06cbe46sm1448819pjb.22.2024.04.18.06.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:33:25 -0700 (PDT)
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
Date: Thu, 18 Apr 2024 21:32:47 +0800
Message-Id: <20240418133248.56378-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240418133248.56378-1-kerneljasonxing@gmail.com>
References: <20240418133248.56378-1-kerneljasonxing@gmail.com>
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

