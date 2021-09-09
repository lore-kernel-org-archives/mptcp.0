Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175B3FE1
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 11:51:22 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id s11so1505425pgr.11
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 04:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=My8AdwXLxPTR7ooNlnm5cXkTz6oQnDg8G4GI2E33QC8=;
        b=UFrz+5zmKqZpsFTXuuCdmDDE1CS6+rwFkO0zKyEte3zw1Juf/lFqJoZgTWwzsjoG5G
         oRCUpmuuQ4D3RxALoIrEK/PlocRZnHpo9r58VMqwMP8f5g5qmP41r9dPzR2u2KgrvZhV
         WI+I8MMEmIvrE/uJhOFl4Mv/h2AGlXi9LAzMChb5SS2jwiXMcKLHqSr+O2AInoQh+J+/
         F9H3COe+bOBNQ0Vm/31jmmPg6r9HgaCX9xHw49LcRVOUP2Nw/udSKPblsh28FJiLdxnB
         NfXSgwGRRm+lpEiLjCbXBVRjCkAtw6O4u8g4atJ8+HvCo4zRGoaE1otPk4katwg6ZJe/
         jxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=My8AdwXLxPTR7ooNlnm5cXkTz6oQnDg8G4GI2E33QC8=;
        b=jOxNHfy4kETzNONiNRMD2Pobt/AaO8aqOPS6cTjJdtwYqp6HRyjvmyEkOuv3KbOuSy
         9gLAO74lhuGKv8NpU2cv36ORvrC3zs8y2gP3GViZZLBiM4BmR7BXK42m5nvLIWzozOl+
         gCN9+4kx+p2F1wPxuDE+ZOPoKC6TF8sAi7b1axjR7OKGUnnnCx4SkHDvRycH47cOBgW0
         kTJhW8rqW6STdqoWPyzNXYdpnEirtGFeEuXwlKSK5mIuV0IDZWpHR7zz0aLhSngOorOG
         24mdBedvss7kVWUAkrv634iM2XBrwCs0JtEl9TqkK4OfMhWoH+GeSr4+yxTaBnw6/uhz
         IqLA==
X-Gm-Message-State: AOAM532fTM14uTS2NUIi3GMsMeGTvWHdmfFh8WvdhW8EdiI8AXmhr0z+
	LU7J25YlfxX6kfjcDBSOkEDpm3NI+Ns=
X-Google-Smtp-Source: ABdhPJzD35e9aK2epe27GFYfEBhTJttqlTTI/vXXXR7L4mcKnxS8TTg+jV8fqTG3IneL+BWRVmC0BQ==
X-Received: by 2002:aa7:9693:0:b0:412:448c:89c6 with SMTP id f19-20020aa79693000000b00412448c89c6mr2796286pfk.82.1631188282002;
        Thu, 09 Sep 2021 04:51:22 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n14sm2458225pjm.5.2021.09.09.04.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:51:21 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next v2 2/9] mptcp: add MPTCP_INFINITE_DONE flag
Date: Thu,  9 Sep 2021 19:51:04 +0800
Message-Id: <436686041e03ec619d507cf4d517e9137f7bd27a.1631188109.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631188109.git.geliangtang@xiaomi.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added a new flag named MPTCP_INFINITE_DONE. Define
mptcp_do_infinite and __mptcp_do_infinite to set this flag, and
mptcp_check_infinite and __mptcp_check_infinite to check this flag.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/protocol.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 011f84ae1593..5644a361b9c7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -123,6 +123,7 @@
 #define MPTCP_RETRANSMIT	9
 #define MPTCP_WORK_SYNC_SETSOCKOPT 10
 #define MPTCP_CONNECTED		11
+#define MPTCP_INFINITE_DONE	12
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -870,6 +871,38 @@ static inline void mptcp_do_fallback(struct sock *sk)
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
 
+static inline bool __mptcp_check_infinite(const struct mptcp_sock *msk)
+{
+	return test_bit(MPTCP_INFINITE_DONE, &msk->flags);
+}
+
+static inline bool mptcp_check_infinite(const struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
+	return __mptcp_check_infinite(msk);
+}
+
+static inline void __mptcp_do_infinite(struct mptcp_sock *msk)
+{
+	if (test_bit(MPTCP_INFINITE_DONE, &msk->flags)) {
+		pr_debug("Infinite mapping already done (msk=%p)", msk);
+		return;
+	}
+	set_bit(MPTCP_INFINITE_DONE, &msk->flags);
+}
+
+static inline void mptcp_do_infinite(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
+	__mptcp_do_infinite(msk);
+}
+
+#define pr_infinite(a) pr_debug("%s:infinite mapping (msk=%p)", __func__, a)
+
 static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
-- 
2.31.1

