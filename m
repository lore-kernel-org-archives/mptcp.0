Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05D128809
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267624; cv=none; b=diHN41oBVHZf3anzECMqH7esd3gWF87ukOERAXCDz9J1pMujKxLSsJ32KHKFjMRNJDkQK9T9ZTptUVWZsWqTOvaqCVrI2a7Z41lPbHXP5LKRmVB36aqexr5GkHUb0FhQ88+lKf9ASvY6+Q1pHkue1afMMDNXtTZjEeCWZ+6z/Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267624; c=relaxed/simple;
	bh=RJnbFc5JHAO9cPZZJOzJbZBugWtXN/ZrYKzKfwfgFG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2YyUCtXf+SudxYam9v0GHfSBykIxVLw1YJ/dlBnUaxieKmyULuSzBSq7YoiBYJ2jG1vkkJEDle5Rbve7D6TLMxIul0QMTmyoBdYMO+gUQPbuuo/yjteKZ+e3vIFFre5hTw2yjZrTeliXH/B6MWRvjJJmxOkKV7Wi1w/RDDTM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H82fPff/; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H82fPff/"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-232f2b86e4fso2087136fac.3
        for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713267622; x=1713872422; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UH4meUAVHMlL8PvFN7UeOC3D/JlMgEbNXoAK969ZI8=;
        b=H82fPff///+G1doV9MLHtLVmx8CirWdWTCQ902oN5O3jkWuDul/laBeoNuqTPvJbHy
         /cjWiOwKa5u/YmpECGVKab1N5Qd9PTHVs0AuBBwD+e5sTjghcJCOfy3HCkrZVI0WmmLB
         cE51df8H0HlXfB/5/FVda3hR1xoyzjLYynfLzBrE2Xi4/FeHAdRKt5rnxp3ucWeCfBu/
         or2TJ7wRb1xz1/FWKeGzMKMFkwWctaoG+9g/T53mJuyYZ7clralJSc6iWR2EtPnG7l9L
         qYB8xZkpVw92kBfwihkWqpqs+ma7I1nSOLHwuwmlD19NnjBPdKpdvdMUHYATtiba121r
         qy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267622; x=1713872422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UH4meUAVHMlL8PvFN7UeOC3D/JlMgEbNXoAK969ZI8=;
        b=SPscFpLzadelIi1yGQpk3R9uisjYGWrlGBUxeEy2V7z6M2/OWSfNFRQ85UJ5eaQ+B6
         UW6ujzGjPONTtp8OFYFQRQhM3v31rMHpU2RvWY+Tw2+OFSEuU9jDUEwok8b2MJXKC/gb
         2ZqKCNXjGv6A4hYFtOkhpi6/Zj7CyRf68kJr1fPx3fDnJ6JjjbZQRv3Y3c1XUaxXWlnv
         QQJWs7L1JgxusOfhznmb7ncAbUAcJ4IM5A6SLx10vBPEnBAdBRnBYmFAMW0gLLSHicgH
         6McVF1+m2SEwKkyYekElbs/ThHr20RAA5S35P1XyrX8h4P3KXbMrIdJEQJAsjdleU+AD
         yiTg==
X-Gm-Message-State: AOJu0YzgEYs78EpUwl5MogAnITF5SrQohRw5wtsJqWMlpvYK8xUK4Cbo
	Qu28pq2mGMMcMrbPOGlmt2OS7j0wAV5SaYsK3CCQXPpbM8fQx+JI
X-Google-Smtp-Source: AGHT+IG0uu+2aacCqrUFlmiuiLMgv4QcVanCDLIWG6wQyK6aBj9DGPhtrmVjFSdgM3BKuR42EM3dpQ==
X-Received: by 2002:a05:6870:f286:b0:222:a91a:63cd with SMTP id u6-20020a056870f28600b00222a91a63cdmr13449674oap.45.1713267621604;
        Tue, 16 Apr 2024 04:40:21 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id a21-20020aa78655000000b006e6c16179dbsm8862045pfo.24.2024.04.16.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:40:21 -0700 (PDT)
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
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 1/7] net: introduce rstreason to detect why the RST is sent
Date: Tue, 16 Apr 2024 19:39:57 +0800
Message-Id: <20240416114003.62110-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240416114003.62110-1-kerneljasonxing@gmail.com>
References: <20240416114003.62110-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add a new standalone file for the easy future extension to support
both active reset and passive reset in the TCP/DCCP/MPTCP protocols.

This patch only does the preparations for reset reason mechanism,
nothing else changes.

The reset reasons are divided into three parts:
1) reuse drop reasons for passive reset in TCP
2) reuse MP_TCPRST option for MPTCP
3) our own reasons

I will implement the basic codes of active/passive reset reason in
those three protocols, which is not complete for this moment. But
it provides a new chance to let other people add more reasons into
it:)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 93 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 include/net/rstreason.h

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
new file mode 100644
index 000000000000..0c3fa55fa62f
--- /dev/null
+++ b/include/net/rstreason.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_RSTREASON_H
+#define _LINUX_RSTREASON_H
+#include <net/dropreason-core.h>
+
+#define DEFINE_RST_REASON(FN, FNe)	\
+	FN(MPTCP_RST_EUNSPEC)		\
+	FN(MPTCP_RST_EMPTCP)		\
+	FN(MPTCP_RST_ERESOURCE)		\
+	FN(MPTCP_RST_EPROHIBIT)		\
+	FN(MPTCP_RST_EWQ2BIG)		\
+	FN(MPTCP_RST_EBADPERF)		\
+	FN(MPTCP_RST_EMIDDLEBOX)	\
+	FN(NOT_SPECIFIED)		\
+	FNe(MAX)
+
+#define RST_REASON_START (SKB_DROP_REASON_MAX + 1)
+
+/* There are three parts in order:
+ * 1) 0 - SKB_DROP_REASON_MAX: rely on drop reasons for passive reset in TCP
+ * 2) SKB_DROP_REASON_MAX + 1 - MPTCP_RST_EMIDDLEBOX: for MPTCP use
+ * 3) MPTCP_RST_EMIDDLEBOX - SK_RST_REASON_MAX: independent reset reason
+ */
+enum sk_rst_reason {
+	/* Leave this 'blank' part (0-SKB_DROP_REASON_MAX) for the reuse
+	 * of skb drop reason because rst reason relies on what drop reason
+	 * indicates exactly why it could happen.
+	 */
+
+	/* Copy from include/uapi/linux/mptcp.h.
+	 * These reset fields will not be changed since they adhere to
+	 * RFC 8684. So do not touch them. I'm going to list each definition
+	 * of them respectively.
+	 */
+	/* Unspecified error.
+	 * This is the default error; it implies that the subflow is no
+	 * longer available. The presence of this option shows that the
+	 * RST was generated by an MPTCP-aware device.
+	 */
+	SK_RST_REASON_MPTCP_RST_EUNSPEC = RST_REASON_START,
+	/* MPTCP-specific error.
+	 * An error has been detected in the processing of MPTCP options.
+	 * This is the usual reason code to return in the cases where a RST
+	 * is being sent to close a subflow because of an invalid response.
+	 */
+	SK_RST_REASON_MPTCP_RST_EMPTCP,
+	/* Lack of resources.
+	 * This code indicates that the sending host does not have enough
+	 * resources to support the terminated subflow.
+	 */
+	SK_RST_REASON_MPTCP_RST_ERESOURCE,
+	/* Administratively prohibited.
+	 * This code indicates that the requested subflow is prohibited by
+	 * the policies of the sending host.
+	 */
+	SK_RST_REASON_MPTCP_RST_EPROHIBIT,
+	/* Too much outstanding data.
+	 * This code indicates that there is an excessive amount of data
+	 * that needs to be transmitted over the terminated subflow while
+	 * having already been acknowledged over one or more other subflows.
+	 * This may occur if a path has been unavailable for a short period
+	 * and it is more efficient to reset and start again than it is to
+	 * retransmit the queued data.
+	 */
+	SK_RST_REASON_MPTCP_RST_EWQ2BIG,
+	/* Unacceptable performance.
+	 * This code indicates that the performance of this subflow was
+	 * too low compared to the other subflows of this Multipath TCP
+	 * connection.
+	 */
+	SK_RST_REASON_MPTCP_RST_EBADPERF,
+	/* Middlebox interference.
+	 * Middlebox interference has been detected over this subflow,
+	 * making MPTCP signaling invalid. For example, this may be sent
+	 * if the checksum does not validate.
+	 */
+	SK_RST_REASON_MPTCP_RST_EMIDDLEBOX,
+
+	/* For the real standalone socket reset reason, we start from here */
+	SK_RST_REASON_NOT_SPECIFIED,
+
+	/* Maximum of socket reset reasons.
+	 * It shouldn't be used as a real 'reason'.
+	 */
+	SK_RST_REASON_MAX,
+};
+
+static inline enum sk_rst_reason convert_mptcp_reason(u32 reason)
+{
+	return reason += RST_REASON_START;
+}
+#endif
-- 
2.37.3

