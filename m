Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6FF15ECE3
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815878; cv=none; b=fWa7SoHvsb6+cUMfLalyYIK3xwbfa+MWO2el6A331eVGIWunPeZ2BoIq3UMMJ9jVjCLk4uv1yUv9QgZeXwno2SrE/mUPleOLF/QpUmznVucUHqw888VKQSZeT6JHF6i7LH/wnWWKfmoCD/OH1PvECeVr6YcjO+G78dL2lXrTHKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815878; c=relaxed/simple;
	bh=g7EDhSxCSMNsPPgPv6KeWREiZqxNoyiIJ36js9dxiHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X31Y7UWewKi/zbNk6zjjEmERGPZC05WvigQntjyHriUyZX00W4ZVC5+1S0UcY8hkaMZRugwsBCIK1a3TzvwUhYS5uMVlskq2MPubgc5cwboiP79cEam1dF9+0D34iluiUdY/C5Efg0Cck6PzaXj1vBZkddtfGdXsdF0WaMEF2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joI5nJM8; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joI5nJM8"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5788eaf5320so1886143a12.0
        for <mptcp@lists.linux.dev>; Mon, 27 May 2024 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716815875; x=1717420675; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LhiC0DdBoLVXrqDaIMNvcANv1XZT3ikWxvfOr0To5A=;
        b=joI5nJM80z4X/OnG2RjfXfdR0AT2/wK3cyx4+t7v8av2At9pN9nxbyMF7P+kpssc9g
         IA37HcR703UIc7MB7pRshO+lLiOjkkZmkYUy2h97SBWpRBU7z73AucXqTetg2oiS02oH
         2uXulxK7TPUSr41J0KaxaoBnEaykoTZdoLZX1RSsGOsMwnUb2OhI2BaSQwk5L+HZqGjq
         W+xTSwNnZiyoPaazKGqj9oHFRjQZw+QXIkPRlEt0xJ80vCrH2/u2+dK/meqNv5e2BexO
         wR4GBYd673Ts3pJv8CgOLQMjFN7xlJ33na+pofGCrODsknsX3IVZ73364wqpkZdACBAc
         3Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716815875; x=1717420675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LhiC0DdBoLVXrqDaIMNvcANv1XZT3ikWxvfOr0To5A=;
        b=gpqec0GsniLud23mNQEdKy4VMxSXwb+Pj+yPeHw6hBE7S9iBzDORMSXqrAq6wVnHgX
         8UjhpidESE6iT6tEG5fVCOnxo1AuJRa9+nARfkq4QNkTyw+O7u+Ix7vdExfg3sIKEyPG
         SZKOibs30UqNpKDZedTOGM4qVMWT6Zwfxq80Llvvwh1avVG67P/tgOfUm3dkiWOsGq43
         T+rZ46FSQAAqR+zFeRO83Bk46nT26/XAcZXWacN5QaEDRaYLeub6YMuEdzDu+qvbYg9k
         GOVVSKy6Z3y8Zk/9ti9HG7A7jFcrITKa4f6kmq0uxndA+jjBBQIIIV2KXlIgUo0FKl1N
         iUPA==
X-Gm-Message-State: AOJu0Ywwjm3FgANxAT4hhfdzFDHxlWhGz4ZZAQd49mjvKvyJtPHhq/l/
	YYw5Cc7h9vy5Z79czVECobKltArOwfGOkY2tw5AJW0z5kOl/iG1WhKTT7bNj
X-Google-Smtp-Source: AGHT+IELaGLizZ5ZdJXqBe5CN0E0UYfGU4Dkug0u3fdxuRUvbns30Cpk10RJiDoYh0RrlGjCTHtT1Q==
X-Received: by 2002:a50:8e04:0:b0:575:954:6e5 with SMTP id 4fb4d7f45d1cf-578519a3137mr6484048a12.31.1716815874952;
        Mon, 27 May 2024 06:17:54 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:700:80a3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785240d1f9sm5799272a12.51.2024.05.27.06.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:17:54 -0700 (PDT)
From: Gregory Detal <gregory.detal@gmail.com>
Date: Mon, 27 May 2024 13:17:52 +0000
Subject: [PATCH mptcp-next RFC 1/4] mptcp: add push sched callback
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-sched_per_packet-v1-1-09a41d405f7c@gmail.com>
References: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com>
In-Reply-To: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716815873; l=2018;
 i=gregory.detal@gmail.com; s=20240430; h=from:subject:message-id;
 bh=g7EDhSxCSMNsPPgPv6KeWREiZqxNoyiIJ36js9dxiHU=;
 b=bRv0QjIP1TdboNGWdfN119NKLcFE3zPITSAKyKP9nZHnOr7WtQU7IAXhd9ZFeVecYVPpcjGH3
 P5tOfm4u1bRC8DkY07sniaYU0NXuRQNWAXVNxbFRanGKRTkmdW5U6Wg
X-Developer-Key: i=gregory.detal@gmail.com; a=ed25519;
 pk=TziJDop3YEG3Ywr6io7U9Iy2jaAY3l0hTh8KdwDKXQM=

The callback is optional. It takes the current subflow and the current
chunk of data that is scheduled on that subflow.

When defined, a scheduler will be able to:
 - update the limit field to limit the number of bytes sent on the
   ongoing scheduled subflow.
 - set the flag MPTCP_SCHED_FLAG_RESCHEDULE to force the get_subflow
   to be called again after sending the chunk.

Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
---
 include/net/mptcp.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 0bc4ab03f487..2e00ee6b56f6 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -108,10 +108,39 @@ struct mptcp_sched_data {
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
+/* MPTCP scheduler push flags */
+#define MPTCP_SCHED_FLAG_RESCHEDULE BIT(0)
+
+/* Represent a chunk of data that will be sent on a subflow */
+struct mptcp_sched_chunk {
+	/* The data sequence number of the first byte of the chunk. read-only. */
+	u64 data_seq;
+
+	/* The maximum number of bytes to send in this chunk.
+	 * Update this value to limit the amount of data to be sent.
+	 */
+	u16 limit;
+
+	/* Define the behavior of the scheduler to apply to this chunk.
+	 * Available flags are:
+	 * - MPTCP_SCHED_FLAG_RESCHEDULE: the scheduler will be called again
+	 *   after processing this chunk (potentially limited).
+	 *
+	 * 0 means default behavior, ie. full chunk sent and subflow continue
+	 * being used for further chunks.
+	 */
+	u16 flags;
+};
+
 struct mptcp_sched_ops {
 	int (*get_subflow)(struct mptcp_sock *msk,
 			   struct mptcp_sched_data *data);
 
+	/* Called before sending data on a subflow. (optional) */
+	void (*push)(struct mptcp_sock *msk,
+		     struct mptcp_subflow_context *subflow,
+		     struct mptcp_sched_chunk *chunk);
+
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;

-- 
2.43.0

