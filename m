Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CBC1CFB9
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215271; cv=none; b=HnS2kNeCRLsZc55r4+O3+nyjrc6nnsvydoR67ZwHSk9AR2cT4E02uYXARTb8xCpGFCANdSDX/0/3B31jZ9sJaqgFqDBR4mH4H3qpkORoH1HvEScezqHtUyZXgI0RyJuF5eRQ/swdWnE4alCHuG6zlVnEIqCdEeL851nAjQwryHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215271; c=relaxed/simple;
	bh=mlfxcIg4+Phml4qIdFRVfQLahA9cOJbdd5MjdoBa8Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JpDnYQ8LIaoy8sEXlptOGNbuWx9rMQum20COabt0ge31UJZJ9A3Ht5RgRa++YA8ztesqFOReb593MA47qJuhwVWjX+C84L04CR9PoERdKX7Y/kAdRZaaGG1l+nQrUj5ioVkZ+221mXEzfuNSsYxO/tZOqtUyKMJo+mEIbwFc4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2YXkAbn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2YXkAbn"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e24c889618so5636025ad.2
        for <mptcp@lists.linux.dev>; Thu, 04 Apr 2024 00:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712215269; x=1712820069; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS2aNr/EX+hXSh4C6UyaT13e9lWbB8QJ2EHpJCpiGRg=;
        b=M2YXkAbn7RWp5rtn+5DeM856BRSu+Bg5Q5e4nAJkoL3/DELrbnlKnHP1MMmHP0b1Vi
         6iLwfDwqFpP35KRpdjzONWRqcjRLK1yjbGYM4oGkWh+OK2mVGZXY6cA2Y6wZ+zDSRWkz
         7PQ97JeW0HL4bor5oSbinjPZSOJcYS64oBIANKIkxdpdlpk84QW6Xag5ONHlT8BH53Qg
         67mujGid4oRze8VMEqiypnBI4Up5tAUselfy/wG1C0ogaecBaRHHAzdJ+XUegn1+zpYO
         BkhoS6lp7abIG9bfITU2IS2o4K16zDpp8tKP4YSxnQdnZMlb6nMSo6tbgZA5Lc8L0AmN
         qbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215269; x=1712820069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PS2aNr/EX+hXSh4C6UyaT13e9lWbB8QJ2EHpJCpiGRg=;
        b=Qrj8FP6cdC8ispKoYlNTXS1u1Zezt9s9vbtJPM+sXhOy+wBv0daVzK+xmAIKetigo0
         e7HPjd+OViXFDEI9zrwtnHcNG5bSbMkuqnGOj2sUdmPJCI78STORo5fq5ZDoJFpu2vd2
         MYSHAA7vXSKy+mJs4LNfdcR4JWwNkXlB5eY8CSBiA+YpVoqu/bJj9aPWf7nlQ2Q8R9hs
         Y1UYUpvyE2ZN/mFcXABfM1wCVTnpRMtFgluObauvzp9Xqy0ZCI6yZJGVIFHDvv6QCBKX
         a/HAfxO4Vt+GX+BCrjRLLhAMX2+X5F501PALYHRRO4eWYiA5QVvwrRPo3ps7Bk91xc/p
         4JKw==
X-Gm-Message-State: AOJu0Yy71r/pmS+YtT+tMwPLg4wXRok8UxtWMfPKU5P7v6Hv9OXk5weB
	caeZ3zFzhuo2tcRbCX65H0PAbIUPdEz+TAbtnhkpiuQvUDYLerql
X-Google-Smtp-Source: AGHT+IFqACoDiCGh47ZlFyQWHCBFfEQL6pgRBMfAWw1iIHgA/ggpEsgoSQPWZh/7MXUCK0bkoNY9lA==
X-Received: by 2002:a17:903:228a:b0:1e0:b62a:c0a2 with SMTP id b10-20020a170903228a00b001e0b62ac0a2mr1834529plh.51.1712215269320;
        Thu, 04 Apr 2024 00:21:09 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709029a8200b001db5b39635dsm14606399plp.277.2024.04.04.00.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:21:08 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 1/6] net: introduce rstreason to detect why the RST is sent
Date: Thu,  4 Apr 2024 15:20:42 +0800
Message-Id: <20240404072047.11490-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240404072047.11490-1-kerneljasonxing@gmail.com>
References: <20240404072047.11490-1-kerneljasonxing@gmail.com>
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
index 000000000000..24d098a78a60
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
+static inline int convert_mptcp_reason(int reason)
+{
+	return reason += RST_REASON_START;
+}
+#endif
-- 
2.37.3

