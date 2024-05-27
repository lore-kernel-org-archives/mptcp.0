Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78615E5BF
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815880; cv=none; b=ttwv35hUokaaa7gvmOPLduNPUTuOmTwg/LC4Pm7+V7vuSl4OzIK6nFECTV4AiNIgtkICllCAjhsdT6SKUoJ3IfnkAneviMeuF78zvugUozizpZ20Ww5WgwkXUWaT65ytXdj0qbVq/QRS5W3Xydvi56mxSeDHYxzLkV1FuyOwjVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815880; c=relaxed/simple;
	bh=nsBTkecATqzHM3QO3JS/FPfIjhlMoK8kLxRi5IlpLKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WTrdVSAehAZ4jvDwBCMWBKs8QYVlgcRz+9lnX38NPNGSHJ7WNyUeuwGQDNXEfWqZJthP4+KULrRAM4J2O57gfV7F+Dn+HrlIxcvC2GwN8MbWlE3j2Nrdbpp/uhAgH9ErYmMFqvlRkgr5Rez/K2uxa5MDyRwc99BlGrvhjPxXitg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/FDp7uA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/FDp7uA"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5788eaf5320so1886166a12.0
        for <mptcp@lists.linux.dev>; Mon, 27 May 2024 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716815877; x=1717420677; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSIciRmdHQu4QbxmKUtiqiP7hGZa1Sjl5uKXaNLDbps=;
        b=J/FDp7uAh3R408ALzKy5/yb/ezXW/fJmt27DqmMlI+R9Q7ECtx2rSg42zLOF/ycAZa
         EpPngV4FQFW5Wz7S5r/XvLrKkymnBrrX+Ja6s474zM8GQPHgG0r/BMGr7Ha0qSATPTei
         A5NqMJzjufv5/flHIQVKci28d4LJqRNOch+e1uNuxDWq7hVBvZHmuUon9rrqu3/TBP/t
         1KOQzu+Eyl5RQp1U/ibt+H8GlD2Ip93YSs0+6bXxFarAstt1W9ED35lvn3BQPNX2Vr/a
         qqHZlsVfxkFCK2AXZZy2Lrn9txFJV0o4P5asCr6sbFW/tMjW9t8/fH4rNmTTWfv0vSNa
         CY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716815877; x=1717420677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSIciRmdHQu4QbxmKUtiqiP7hGZa1Sjl5uKXaNLDbps=;
        b=G+MBa8oM86oFrRvzmrXvUaZFB/UI/k/2XlogBdgMtzB7q7Z24KXT6QjXvaR5U2t6Ph
         j83GrWnNPRDxAQBKqiMwnB4hbwioXcOnvJKV3xM+U2YRVfWK0Wkc4KAarvA9Zt3CH8kA
         tvDjI3HeKZrcX2V6N2rJG4rRoatR8BkUWb7Vv8CQKD1ngPm54sXjmnF9ZalCltSNR7yL
         nPsXUGuRKs2mg0xJP+zmfmwxpXur5TnYxMgoYilj0FPTXR5mDPZi0Nb6Y3hgJuBPX1o4
         hKOLHxD/FfLOkTTYHgLagiIXY0M08tfswfzKDz9fM+vuzxcYeru1DMYWyiEzoeUPjnUH
         mcUA==
X-Gm-Message-State: AOJu0YyAGTdS66q5x6Fd+W7iYx1Kq7AU2PIW0Y9wm7QKtnipw9Ecy0hD
	mkR2pckZEEUfmMrVS7As/y1aoRHnWLQ+sCyrq4Ac97lwFlQd88Ylk0gJBRFQ
X-Google-Smtp-Source: AGHT+IGAXOZdDx8RLRVqZxe6Mrjs4Q9V6sLLc17fB4N7Co2/otsr4WdIIAjH2bmXTZQFnbU9xzuFjg==
X-Received: by 2002:a50:aa94:0:b0:579:b6d:b8ba with SMTP id 4fb4d7f45d1cf-5790b6db91fmr4459626a12.22.1716815876675;
        Mon, 27 May 2024 06:17:56 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:700:80a3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785240d1f9sm5799272a12.51.2024.05.27.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:17:56 -0700 (PDT)
From: Gregory Detal <gregory.detal@gmail.com>
Date: Mon, 27 May 2024 13:17:55 +0000
Subject: [PATCH mptcp-next RFC 4/4] selftests/bpf: mptcp RR: send 1 MSS on
 each subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-sched_per_packet-v1-4-09a41d405f7c@gmail.com>
References: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com>
In-Reply-To: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716815873; l=2021;
 i=gregory.detal@gmail.com; s=20240430; h=from:subject:message-id;
 bh=nsBTkecATqzHM3QO3JS/FPfIjhlMoK8kLxRi5IlpLKQ=;
 b=SkxEDKsOXUvkFVVyL1JXeLB9eXdcA0jHlB9BQOUykG85FUwBdx7EYFbS53MyCkevjQeVNMqpg
 pNqCfQGCqqABMTAeJjc056ZuhQfWKI23wFprxzGscqE8HivXBCwztyS
X-Developer-Key: i=gregory.detal@gmail.com; a=ed25519;
 pk=TziJDop3YEG3Ywr6io7U9Iy2jaAY3l0hTh8KdwDKXQM=

This uses the helper and APIs to schedule one MSS on alternance
on each subflow.

This now really acts at a round-robin scheduler: packets are equally
balanced on each path

Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h    |  1 +
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 782f36ed027e..a289746666dd 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -6,6 +6,7 @@
 #include <bpf/bpf_core_read.h>
 
 #define MPTCP_SUBFLOWS_MAX 8
+#define MPTCP_SCHED_FLAG_RESCHEDULE (1 << 0)
 
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 638ea6aa63b7..42c11fa483b1 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -69,10 +69,28 @@ int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
 	return 0;
 }
 
+SEC("struct_ops")
+void BPF_PROG(bpf_rr_push, struct mptcp_sock *msk,
+	      struct mptcp_subflow_context *subflow,
+	      struct mptcp_sched_chunk *chunk)
+{
+	struct tcp_sock *tp = bpf_skc_to_tcp_sock(mptcp_subflow_tcp_sock(subflow));
+
+	if (!tp) {
+		/* Should not happen, in that case let default behavior. */
+		return;
+	}
+
+	/* Make sure to reschedule for each MSS. */
+	chunk->limit = tp->mss_cache;
+	chunk->flags |= MPTCP_SCHED_FLAG_RESCHEDULE;
+}
+
 SEC(".struct_ops")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
 	.get_subflow	= (void *)bpf_rr_get_subflow,
+	.push		= (void *)bpf_rr_push,
 	.name		= "bpf_rr",
 };

-- 
2.43.0

