Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215C55C29
	for <mptcp@lists.linux.dev>; Wed,  3 Apr 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129526; cv=none; b=KWYuqLS3UvB33QRKdt9ZFLjRtHka6ZdVp0/qsqDUVG3GvfslCvrh/xvvlT4XOV0NEkFjTJuP8OogHvfK1zUO5bzIELsCQTQyiGamiO/MyW7Fq0w0n++aTRoQ6Lp9bUPyu6TdcFsYzV6kFXzhnUeq6PvYekrrE8H30KvsPhNQqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129526; c=relaxed/simple;
	bh=mlfxcIg4+Phml4qIdFRVfQLahA9cOJbdd5MjdoBa8Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5EFOn4+vGUY60JgNUiVgZ/anBzzoSSLuJf7siXwWnJ8CqxHHkhRN04rCHwkORS/DCFNfKHazFNHQkvUjek9eEM5j1fApJoPjaZDaZ4qum2mhkO17tuloodwpZJ8hqvqR0Yb/4e9EatHzZhnomEeHSAHoCDg4Mu8kfrpi4zRyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyTsnihf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyTsnihf"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0d82d441bso54427625ad.3
        for <mptcp@lists.linux.dev>; Wed, 03 Apr 2024 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712129524; x=1712734324; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS2aNr/EX+hXSh4C6UyaT13e9lWbB8QJ2EHpJCpiGRg=;
        b=kyTsnihfHP1ER966XfLZ+8qgy2f6aOgjY3QafIxDtQbYDRqXoRczFWwVycVHHtX2wC
         JDN95G+isSj/JBaC2j8XNZhKDFeKpX0TKgIhshzPz8XgyahIaHdG6mOxAR0iwAhZd9Jy
         Ok7egTKxCGv1BzjWHf39mB/nwSZ03RnSYaHq7BLYwiZLdH9qTjySHTPamBjhk99R4i2N
         RyDBvrvFb8TPfNZw58MSW3QObxKnO9Z90QYSqLJAUQr1eDTF02BckS8ZJFmeXA5iLu8G
         4tinuRg3iZLhmhA8WcwnzfjiCbvdJ1zNZPRJFjiQj/6H/Zlm+4sCVzIM4z2df7Dr7FxD
         WwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129524; x=1712734324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PS2aNr/EX+hXSh4C6UyaT13e9lWbB8QJ2EHpJCpiGRg=;
        b=mkdYZ6+/ZQnpfIhmH0hlylqZ7NPyOcTqLtz0ANIav4QzXtcMMtQ4037fq3fCDWXY0m
         bPA+80LfCO9LnQD+/WxnpuGFBStRD2pWLAjrNWrukxubHJdvOtac8YaVFpTdTXygNhjJ
         jOWVfd/TyJjb8cmVKmKEbbdP3WfN6kmYQ70n2wntXEWMYlE9F6iHiTwYTbCjbisdms9J
         +SmFvbQrL1PXbk2DEJEUVuz6aAHo3xVVHwEvFEo/R6QrTqn2SMKrsNqePWym/f002ius
         Ddw4/h0rzYAbTaWpFaVUYeJi9tiknhaZVk54JKpHh8pa6OIuIooBmJRjyiUPVYV6ZfeF
         TVKQ==
X-Gm-Message-State: AOJu0YyleM9LvYTNVq4Nki8dMnyBQVwl7ngpMifp8eAwYEc/6vraJCqG
	yS9Cvu6o9wKC9c3UrnaVoe5A2cNxe3b2+g/7dBlW2v487g1hI/kP
X-Google-Smtp-Source: AGHT+IEq39ZufbwhA+BmTcV9hmUNMfaHPyNs+0nOyZkKR0v/03C01OveuPqj5H80nkzjEzAIaaIsYw==
X-Received: by 2002:a17:902:e741:b0:1e0:b3a8:7db4 with SMTP id p1-20020a170902e74100b001e0b3a87db4mr2397777plf.45.1712129524467;
        Wed, 03 Apr 2024 00:32:04 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b001e03b2f7ab1sm12563067plg.92.2024.04.03.00.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:32:03 -0700 (PDT)
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
Subject: [PATCH net-next 1/6] net: introduce rstreason to detect why the RST is sent
Date: Wed,  3 Apr 2024 15:31:39 +0800
Message-Id: <20240403073144.35036-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240403073144.35036-1-kerneljasonxing@gmail.com>
References: <20240403073144.35036-1-kerneljasonxing@gmail.com>
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

