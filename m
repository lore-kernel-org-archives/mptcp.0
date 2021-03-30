Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68B670
	for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 09:17:00 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so9134054pjb.4
        for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKMPZJPpqP57OSH54f8MDZFS+gMfkaiXqZpsYjf+kTE=;
        b=EPBlIdqcsF5hopa0+XL20MbVQDNGF4R1eFZ1XC4n6PjJxYYGR7h1IBLKeNvVqtFKpa
         Z9ddrUsikFV3jvPuC8b8wsFBZB+6KlLSUmARodHUj7D6DW6tHSEbyWNIwCRZ3Ywn94eb
         EotKuNQAwXSxEfn+90x9hm2bBQXt1Sl+WJ1gqksNGSEZt33Sj9obuMOwx8N0zYIgbfeu
         DYPec07MvnJ9iSN/4hny4Hn4rH5lGH0tNYvMnBDyWzySvYpyt514mFjz2p3+sOJTh/ey
         orTqJaj0nhqDV136gcbtTANUcr5tKu39C5NoGCI6oG96Ydf9KEuh1PVzJtVjtJkdBDAX
         ybbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKMPZJPpqP57OSH54f8MDZFS+gMfkaiXqZpsYjf+kTE=;
        b=BYCeM4KlSbNtzaE4c6d+kqlEXANy7gN58FayTFDeeuzDcoXlS/bF80pND8OhA4Yfuy
         X2GxAqANpcaFZrpQiIu2gAj2KYKyfWIyhrERgySVkDdR4xy2LmaU2YzwL5jdyJMMo+94
         zYrpKLpcK3F8Lj1d/sjgnuSXB5/IwF3Xsz/Vl92JMFmE5VgG8+VuGukLfk4RgrZJrhps
         kag840sYpYTXvTqkVAVvLf5s9izWO6AFe/Y2mBhgjs0MjQiaaymDAWcmR+BQY8IBYMWG
         tiivO/ZJLchL74F19Fp2qX/Y/5/7Hmo8X+V//Hfkv4reek537ntgDi6RdjGDHMuBprta
         /fXg==
X-Gm-Message-State: AOAM533qEG3QuBDbP9HExKZ2bk0hhxYx4bPgp+LeONsaKPwaWVL+Wz0t
	/P/wpuUBvBWHCw4FSlFpB+MipyccErA=
X-Google-Smtp-Source: ABdhPJxiMUHoboVAv7TU4dD2gwpvCwl4sDE2dN/x7d5TD439W4DPsALrWhuzMVDWUu+ZlU49T1FEmQ==
X-Received: by 2002:a17:902:d4cd:b029:e5:dd6d:f9b3 with SMTP id o13-20020a170902d4cdb02900e5dd6df9b3mr31963641plg.43.1617095819943;
        Tue, 30 Mar 2021 02:16:59 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x4sm19247485pfn.134.2021.03.30.02.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:16:59 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v3 mptcp-next 3/4] mptcp: add tracepoint in ack_update_msk
Date: Tue, 30 Mar 2021 17:16:45 +0800
Message-Id: <9ad9ef463c1dff8f022abec2e683f4fbee0f4a96.1617095554.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <f4084ca4e2f287461cdf552619b89596a429d042.1617095554.git.geliangtang@gmail.com>
References: <cover.1617095554.git.geliangtang@gmail.com> <c69ce9cc277fd134a5254dee68436f6035ab594e.1617095554.git.geliangtang@gmail.com> <f4084ca4e2f287461cdf552619b89596a429d042.1617095554.git.geliangtang@gmail.com>
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
index 02b80cc662f9..b390317bd98a 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -91,6 +91,38 @@ DEFINE_EVENT(mptcp_dump_mpext, get_mapping_status,
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
index c7eb61d0564c..81db91dd1b84 100644
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
@@ -942,6 +944,10 @@ static void ack_update_msk(struct mptcp_sock *msk,
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

