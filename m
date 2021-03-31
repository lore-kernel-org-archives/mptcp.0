Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994F5F
	for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 07:23:54 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id q5so13895860pfh.10
        for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 00:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPogr1DmJo65E6N20GsPcFPrFOeOt5K9Gvdww1Y5aNk=;
        b=r4puUcb8nXMGgWaJXj8yxFDEnCF8YwnmVVlx9WGOl97yM8Tf5bdXmYBW5+W9wjt0fB
         aFn47D/9KgAG60br2B4D9P9lZChxEHLuUgLH9RWu2FDnkZr9GU7kYwRjuJ83xk/XCdDD
         3PZpTeyF2d4d6R3rOJA30UrOlUBo4aDOOlyEapYS4ETkDjjChtw1mWccO9FcgYwgj2Th
         vlkMpsG4UiGH90rFOnkJrjj+8yTZRN+fXPBYx1B99bmykCmVp8qxOE95N9Yq4agryG8a
         0DO2F1qfZV3jBcP9J46cgBRjPmeFXllfHtoTUzCIIrrXzcafuLBTQKKN4VzAau7E65v1
         FvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPogr1DmJo65E6N20GsPcFPrFOeOt5K9Gvdww1Y5aNk=;
        b=uCOMGx54DHnph77JxQ7pfLXI9XP9uHjW4dv2HE7R5hdYp27so8yAHAoqxxW3pvgaDv
         mvCrod9GM4we1cs1myjw99NVZxEQ8ZgvkW0Bucfl4TIOfXVbPsOvfGME4M41Dz2VMbkt
         EDjcHT1kBRCZb7UTbqdGgxs2I3r9cQMD8WahUDrr0bFRDNVsfkyCbDnDBLnkAsU9Stra
         Tbh/IQao1JuKEA6YtUWX4M/EeOZVjbm3BbpCMH899MERneFMa8UDhs/SNek6SyhaadWO
         xtRS/cij+c860h5hbIe+UardZNrM5CXzwmOPLEvDXr7lbDP/BB4zU+ApBkIkbEattOli
         BV0A==
X-Gm-Message-State: AOAM5313cxQy2kGyWfDG4qe5E6dL0B0DEvPic/rvbKFie7vN23ddUYzc
	HmbVmqQIKIks6qcYdaPDeuN2NZJdqNU=
X-Google-Smtp-Source: ABdhPJwqXpeNkaWRLkehbmDxl7cRZvu3zme9HSt9Pv1kyWvshN7KajK/7BvA7qPKXuvFCMKLZXfstw==
X-Received: by 2002:a63:604:: with SMTP id 4mr1954015pgg.267.1617175433739;
        Wed, 31 Mar 2021 00:23:53 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id q22sm1100981pfk.2.2021.03.31.00.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 00:23:53 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v4 mptcp-next 4/5] mptcp: add tracepoint in ack_update_msk
Date: Wed, 31 Mar 2021 15:23:35 +0800
Message-Id: <5142b94c3a4af83d619c964e96c04decb8907959.1617175133.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <e2100f55ef22c52ba10b699c8362189d501d4ca1.1617175133.git.geliangtang@gmail.com>
References: <cover.1617175133.git.geliangtang@gmail.com> <69be5c2c98752dfe6cfe572ef5f13ff701618bd0.1617175133.git.geliangtang@gmail.com> <9a7fe804a654722cab2b7b4cd97f21a5f27ec2cb.1617175133.git.geliangtang@gmail.com> <e2100f55ef22c52ba10b699c8362189d501d4ca1.1617175133.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a tracepoint in ack_update_msk() to track the
incoming data_ack and window/snd_una updates.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/trace/events/mptcp.h | 32 ++++++++++++++++++++++++++++++++
 net/mptcp/options.c          |  6 ++++++
 2 files changed, 38 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 4a6cc475fb73..b4e6ca941bb7 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -99,6 +99,38 @@ DEFINE_EVENT(mptcp_dump_mpext, get_mapping_status,
 	TP_PROTO(struct mptcp_ext *mpext),
 	TP_ARGS(mpext));
 
+TRACE_EVENT(ack_update_msk,
+
+	TP_PROTO(u64 data_ack, u64 old_snd_una,
+		 u64 new_snd_una, u64 new_wnd_end,
+		 u64 msk_wnd_end),
+
+	TP_ARGS(data_ack, old_snd_una,
+		new_snd_una, new_wnd_end,
+		msk_wnd_end),
+
+	TP_STRUCT__entry(
+		__field(u64, data_ack)
+		__field(u64, old_snd_una)
+		__field(u64, new_snd_una)
+		__field(u64, new_wnd_end)
+		__field(u64, msk_wnd_end)
+	),
+
+	TP_fast_assign(
+		__entry->data_ack = data_ack;
+		__entry->old_snd_una = old_snd_una;
+		__entry->new_snd_una = new_snd_una;
+		__entry->new_wnd_end = new_wnd_end;
+		__entry->msk_wnd_end = msk_wnd_end;
+	),
+
+	TP_printk("data_ack=%llu old_snd_una=%llu new_snd_una=%llu new_wnd_end=%llu msk_wnd_end=%llu",
+		  __entry->data_ack, __entry->old_snd_una,
+		  __entry->new_snd_una, __entry->new_wnd_end,
+		  __entry->msk_wnd_end)
+);
+
 #endif /* _TRACE_MPTCP_H */
 
 /* This part must be outside protection */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d51c3ad54d9a..99fc21406168 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -13,6 +13,8 @@
 #include "protocol.h"
 #include "mib.h"
 
+#include <trace/events/mptcp.h>
+
 static bool mptcp_cap_flag_sha256(u8 flags)
 {
 	return (flags & MPTCP_CAP_FLAG_MASK) == MPTCP_CAP_HMAC_SHA256;
@@ -943,6 +945,10 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		__mptcp_data_acked(sk);
 	}
 	mptcp_data_unlock(sk);
+
+	trace_ack_update_msk(mp_opt->data_ack,
+			     old_snd_una, new_snd_una,
+			     new_wnd_end, msk->wnd_end);
 }
 
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit)
-- 
2.30.2

