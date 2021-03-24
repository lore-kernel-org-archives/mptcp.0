Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0676F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 08:51:58 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id l1so14152050pgb.5
        for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 01:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RMAuF2YnN8BVVuRGk2avjXW1FK/LXww3LyeO4/fu2Y8=;
        b=JM/ulNcayzrdnlMFmj3gAAARXnztaLftvFai+zzAvHtLDnzYfCO2iWixlVDhWuHfkJ
         YMZJEeo/cTC8CP9Ps2zq2hetvqIQpqyX4VjWkHAbZPry8roVUsOmjce8bEFyEb4T46a7
         pnARbUYyGjkO0OlCO8P7Xmfa/DFv4teGQM/PTZKRLjLLgT7Xlya001C79wMN//1bg5e2
         Srl13MkfAw3Qnpgoj+AsjJXseDNDvEhcevmmc1PaIBkMkM98/7WO+Ta9uEw5rW3WoH6i
         eSl/01TU7ZSMOpKLZRqXxH5lWHQjx9AlZk0rHaxX4K8dNKn+tgLeju181gR6sJe/x/5e
         LHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RMAuF2YnN8BVVuRGk2avjXW1FK/LXww3LyeO4/fu2Y8=;
        b=VSwUrHNWpivmmZtqPwm76kK8PQ+VuHkmR9iIy6Xei4p6vFS2FI7rk6lgXJq5huhNkn
         Q+xIzdCIfLvUAHO9mhOqdDPe3ohbM2oh6D8szyBnlAkPykg0yiG0oGEjvEjjXri6Ko6i
         csKphmmdLRIVj12FR5ZRnhPuN00feub5VEkMSE4/PkaWXhdpWk1z/tfaM7O+K0ePkbbx
         z5b0uQHan3J/8VNo45JSFYTIU/Fljolrsta4lVeaiiL6e6f0tC1sx4IekGLd96u3WNyj
         gPHEK5KmSXTnThO/0HFOeGyPsKyIjGMhhc+1y30bOy7WVWfroNM60wM5Z0dx6z3qwNab
         mgvA==
X-Gm-Message-State: AOAM530ktp09X8W/rY6dWsPiSO/PuDCHj7rr4GN7/5paYEpD5ASH3bWr
	pnFOSboSlC343rZ/Sxd3g/E=
X-Google-Smtp-Source: ABdhPJyaUYhow4YcfFvnZ61N6vhvXoO7Wj4hoHxTlaXNOhiUSppNzq8ZF4QpgoQgKPWciqkM43wumw==
X-Received: by 2002:a63:1c4c:: with SMTP id c12mr2082244pgm.179.1616575917946;
        Wed, 24 Mar 2021 01:51:57 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id k3sm1566825pgq.21.2021.03.24.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 01:51:57 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org,
	mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v2 mptcp-next 4/5] mptcp: add tracepoint in ack_update_msk
Date: Wed, 24 Mar 2021 16:51:38 +0800
Message-Id: <0662c0637222901b447135bb10aaad7dea9b4a49.1616575602.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <9b74169474a157c54953de796bc35ef54a710a18.1616575602.git.geliangtang@gmail.com>
References: <cover.1616575602.git.geliangtang@gmail.com> <6e606e2aeb7ea4bdd1618783cb24675bcde693b2.1616575602.git.geliangtang@gmail.com> <ffa353e9982d4795058abc87f1e2f52bc29e430b.1616575602.git.geliangtang@gmail.com> <9b74169474a157c54953de796bc35ef54a710a18.1616575602.git.geliangtang@gmail.com>
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
 include/trace/events/mptcp.h | 25 +++++++++++++++++++++++++
 net/mptcp/options.c          |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 503a6098909d..2b8ae5e81cd1 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -91,6 +91,31 @@ DEFINE_EVENT(mptcp_dump_mpext, get_mapping_status,
 	TP_PROTO(struct mptcp_ext *mpext),
 	TP_ARGS(mpext));
 
+TRACE_EVENT(ack_update_msk,
+
+	TP_PROTO(u64 data_ack, u64 old_snd_una, u64 new_snd_una, u64 new_wnd_end),
+
+	TP_ARGS(data_ack, old_snd_una, new_snd_una, new_wnd_end),
+
+	TP_STRUCT__entry(
+		__field(u64, data_ack)
+		__field(u64, old_snd_una)
+		__field(u64, new_snd_una)
+		__field(u64, new_wnd_end)
+	),
+
+	TP_fast_assign(
+		__entry->data_ack = data_ack;
+		__entry->old_snd_una = old_snd_una;
+		__entry->new_snd_una = new_snd_una;
+		__entry->new_wnd_end = new_wnd_end;
+	),
+
+	TP_printk("data_ack=%llu old_snd_una=%llu new_snd_una=%llu new_wnd_end=%llu",
+		  __entry->data_ack, __entry->old_snd_una,
+		  __entry->new_snd_una, __entry->new_wnd_end)
+);
+
 #endif /* _TRACE_MPTCP_H */
 
 /* This part must be outside protection */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c7eb61d0564c..87bd1bfde964 100644
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
@@ -942,6 +944,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		__mptcp_data_acked(sk);
 	}
 	mptcp_data_unlock(sk);
+	trace_ack_update_msk(mp_opt->data_ack, old_snd_una, new_snd_una, new_wnd_end);
 }
 
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit)
-- 
2.30.2

