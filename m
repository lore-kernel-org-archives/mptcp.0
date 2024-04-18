Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC41E4AD
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447184; cv=none; b=TR5jlW4+TXW4GTMosIQ6rtmNogjE2m0LTWIvWpM3d9ylLyREzJC/A+YBbqClCjZCsOaNKHNb7pgNgMRjWcDi3qyYnFYjUInleRBciFVyz0lzFgQPDPTLqfkLsp1ffSMxIl1gpf53se7UU/BLGb65r8ilQh+ATDIz48NMenr+/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447184; c=relaxed/simple;
	bh=RJnbFc5JHAO9cPZZJOzJbZBugWtXN/ZrYKzKfwfgFG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNJletSnEEaSVPxqzsuvuZWMI68iWNkAL6XXGtk4uv+6+bMU0Gs0Gpo05GU0l+RF7leS4Op2gM6sy8wyW5D4vfY8KKvdNkaeQO57HlfeYOIsrgJH33oeqHFggu+1+5Dnii7kvV4K4Zy6kjzWv1ng6wHm4bzbeWQW0H1RI/YpFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbWhgnJE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbWhgnJE"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a53b331400so664407a91.1
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447182; x=1714051982; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UH4meUAVHMlL8PvFN7UeOC3D/JlMgEbNXoAK969ZI8=;
        b=CbWhgnJE2RnBnHu7+YCn8N7d1a/8QKhN7Xg2l52BK8KTMFNhosF2TE3gt0N4BxT9hH
         LLegy1pNOdouJMd89gpg0YLNP/+3PclwLzTO+LIRSizRuAJOpEE6B7gz9eX5FbJhVHmQ
         OMNhY3+22R5Xpco9LB7/LgxtqYgl/qn510Qw7bMgBbcSuCeMpwyQ1povXmQXfWKpgttI
         YCIZvaRMCGNv+Ou9BgVqnV1b1QBpHGGeq/J6/K2n+5+uPC8l7/PYdXKg7IEg+DBRX2uc
         +GapxN5v4GewPdiZPu2Wn2oPReiB0hqY+Ch9BimVwQvkQsMmNjF/I50QoX4gxDvT7Jez
         XUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447182; x=1714051982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UH4meUAVHMlL8PvFN7UeOC3D/JlMgEbNXoAK969ZI8=;
        b=t8hrhbzq6a16s9S4Ih14unNHCafIbkonb1IC/BkTo7B/vdYNQcY0xA3m2NMgG6Wvyj
         BAlg5mZnFTC1feWHSLufsJCiHbYQqjasO7qdTCWoebA+oyVH+Aa526DmtU3Tz7l53Ydh
         0hmW7PXZ6OEHFh5Zf+HfuO5wnwJXcLjnbsKKOhQ0eAs9vImr9cZPGy9AMBrEzIriC5hX
         9J7YvjVIMxu5Lpz/WyFSB1Tdq+bkkm3biDvmjH5PNR4BBGEstm4yxRZ8as+YFU5TuFqJ
         sNSzA0vadjOm2wwLbmqrzEFIxZgnJhMXAnxDSlTWqOfbpEP0FxC6DVEeKa2DecmKOGgg
         gRGA==
X-Gm-Message-State: AOJu0Yz7WncQmMGIrAYSzm4k8HJBMN3+UJHV2aZJb9QoWDxyt7/vKmNu
	qRKIFr+mV7EBhvZBdeD8Z7BVwexczg+1np0bOTtBcfbfijQ49ulF
X-Google-Smtp-Source: AGHT+IG31XCqYyXm7yKhKzmNVht96b9dF5lC1StriyAdJI4/TfU5MoNFCeIav8+eawaN49I0SCJ3kw==
X-Received: by 2002:a17:90b:124e:b0:2ab:de86:d667 with SMTP id gx14-20020a17090b124e00b002abde86d667mr1547185pjb.48.1713447182115;
        Thu, 18 Apr 2024 06:33:02 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id bt19-20020a17090af01300b002a2b06cbe46sm1448819pjb.22.2024.04.18.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:33:01 -0700 (PDT)
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
Subject: [PATCH net-next v6 1/7] net: introduce rstreason to detect why the RST is sent
Date: Thu, 18 Apr 2024 21:32:42 +0800
Message-Id: <20240418133248.56378-2-kerneljasonxing@gmail.com>
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

