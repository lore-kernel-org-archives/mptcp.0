Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377A70
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 08:40:25 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id t21so6086369plr.13
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GN48nuQg3tB2z/fe244G9A21kEE0e2/ZY6GzA3HtgfQ=;
        b=fj6jZvjqQ2Mn8sHrdtR8ddBX5FLE792Gsgnx4tpAmhN5Y/6zFnasVOdD7toPEQ+DSp
         yuIcbapVgzgpEW73FgJI3vFVW8QlVsJGUI2Xohcd+4pH7hItFbfllCKhL5i8gaF5+Tyg
         2QxznT3IZX/Bjiw81rrpqX2fSJ0ORe4lI3TVNghqKYFqOdNqJlMrod5uqO5CnfIG9anK
         82zYAjTKTjGdrkOhGRilWfUbxvX3S/v2XAGUxsfulzdDm4vLR6CLEnHZJFwehrksdmzu
         dWK3ITZL7MXXCywYViuszaz5OaZJZBah/ySJZJwCkHFD1QNWgV2rfTDfful0TODwBZU1
         R+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GN48nuQg3tB2z/fe244G9A21kEE0e2/ZY6GzA3HtgfQ=;
        b=GXqg+ZAmCp+XrWPTjDK1gXtaLlwWUAkcyN/kKzGiF0qfU5915BgrFXgPtTBvmubuEU
         nojEZbhZTtrUSNt94TTixahzv6YKFXgRJJCXBH1hjui1NXJ0JYbcwvozB6y/c5+AqrKZ
         A9dyQtT8b8AL7mKCmMWZz015nVTjPaKJpFY90wogdF8hrNVOCpv9FUc7XKZR+HDkr5H4
         ffDCSs0g4+06CU/DCA/KxRZf1x94JgXyS2nArkL5nbaj3xE3XXmqSgCyLI8u2D64fl4q
         TcmNvVGB+rY45Vc0/I5O+ToEe4anIsSDMwehRDfjL2hK1tMC1cBVnklvMnSSN8vWH4Mb
         fHsg==
X-Gm-Message-State: AOAM532fnezsSQSbVR7P3y0IcwKiabO7CJq9cbVVA3STdjkw4Y1XAuMx
	GCxzI1earit6IuIcBR6Qg1d5pah5IyU=
X-Google-Smtp-Source: ABdhPJyJaXhhBzrVQYxd5w6PA0jyX9ybH8spvKFVbdKMqFvObmDRb9GnjtIukjNrMUdVfk19EIMnQw==
X-Received: by 2002:a63:490e:: with SMTP id w14mr2926555pga.93.1627548024782;
        Thu, 29 Jul 2021 01:40:24 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id f5sm2401539pjo.23.2021.07.29.01.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 01:40:24 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v7 mptcp-next 3/5] mptcp: send out MP_FAIL when data checksum fails
Date: Thu, 29 Jul 2021 16:40:11 +0800
Message-Id: <cfc2f48712c35a61be26ee92db8e900decc07217.1627547666.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <0c155f43f4bc75c90cf45283e07ea48432178d48.1627547666.git.geliangtang@xiaomi.com>
References: <cover.1627547666.git.geliangtang@xiaomi.com> <d04456a7439e4cdab65aea27a035e5b89d5c0e2a.1627547666.git.geliangtang@xiaomi.com> <0c155f43f4bc75c90cf45283e07ea48432178d48.1627547666.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

When a bad checksum is detected, set the send_mp_fail flag to send out
the MP_FAIL option.

Add a new function mptcp_has_another_subflow() to check whether there's
only a single subflow.

When multiple subflows are in use, close the affected subflow with a RST
that includes an MP_FAIL option and discard the data with the bad
checksum.

Set the sk_state of the subsocket to TCP_CLOSE, then the flag
MPTCP_WORK_CLOSE_SUBFLOW will be set in subflow_sched_work_if_closed,
and the subflow will be closed.

When a single subfow is in use, temporarily handled by sending MP_FAIL
with a RST too.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/protocol.h | 13 +++++++++++++
 net/mptcp/subflow.c  | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 09d0e9406ea9..6888d2690e79 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -615,6 +615,19 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
 }
 
+static inline bool mptcp_has_another_subflow(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk), *tmp;
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
+	mptcp_for_each_subflow(msk, tmp) {
+		if (tmp != subflow)
+			return true;
+	}
+
+	return false;
+}
+
 void __init mptcp_proto_init(void);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int __init mptcp_proto_v6_init(void);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1151926d335b..d405385d2e7f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -910,6 +910,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
 	if (unlikely(csum_fold(csum))) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
+		subflow->send_mp_fail = 1;
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
@@ -1157,6 +1158,20 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 fallback:
 	/* RFC 8684 section 3.7. */
+	if (subflow->send_mp_fail) {
+		if (mptcp_has_another_subflow(ssk)) {
+			while ((skb = skb_peek(&ssk->sk_receive_queue)))
+				sk_eat_skb(ssk, skb);
+		}
+		ssk->sk_err = EBADMSG;
+		tcp_set_state(ssk, TCP_CLOSE);
+		subflow->reset_transient = 0;
+		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+		tcp_send_active_reset(ssk, GFP_ATOMIC);
+		WRITE_ONCE(subflow->data_avail, 0);
+		return true;
+	}
+
 	if (subflow->mp_join || subflow->fully_established) {
 		/* fatal protocol error, close the socket.
 		 * subflow_error_report() will introduce the appropriate barriers
-- 
2.31.1

