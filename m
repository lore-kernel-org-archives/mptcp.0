Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C232FAE
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 08:15:35 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id f129so4844704pgc.1
        for <mptcp@lists.linux.dev>; Fri, 03 Sep 2021 01:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0r8xkabuMTnFKOLePBis2c8/koRRx5UZF7RmXhOtk8=;
        b=WcmfAohf4+E6+PH9nlkVaY+Hj8KWGEjXdIsX4THzsAlFOaOF6gfaPxqTy8mkpQhazq
         m7gDIInyH/b+18ydcA16ci8okZCp9FyO/5jgFmsNdz958pCHHeGir1i5MOiYSVhyAnqT
         25NzY/XJICxvMFilnVfcvlfhRr0LyEQjXRLKu9Od9jQ8XHHOGC/VZ0fpBoIkbW0PbtuY
         Pzj2w2+j5t5jr7o/5wkspCNMmFLznIk3ZNQAWPtpJPG2LEyB0jEesm4CnmHioEBDZIrY
         xC6eqmlbyIBd3a6ucIUaUftTbrfTIUXIL3FGf0OTL8gDFag37oRpRfChGEIEBqATBN01
         bTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0r8xkabuMTnFKOLePBis2c8/koRRx5UZF7RmXhOtk8=;
        b=QpvJ8DXz0t9HDxPUXQyh0q+vDCl5TP/8eTg9fxgRd3a3oJh/EmqvmrV0t6fElQDWZl
         7LLl7cZm1s7gboFOye/wU3GRv+b12gk4XeTBnBhS9m9bEJPoCbrYEb+KJ/0odZPDHPV9
         WNYyO66QtyHrP1Av8a4WRcwQouWZZRu0IpdXNJZOnopU8dkwb4MzxWkcZ/OHO0DigqVw
         GOEdnlbHCApxsqmivw/mOt5zl4R8J+gk80C6zwT91Ymm2grHIBx/Phqn/zGMNRIJwtq5
         uK2CLJITVBCmU55gPSP5BTfSo9DuZBwo9sC5rTUC6w0gj55Sy259/y3QaFzIZi8U1OJP
         5Egw==
X-Gm-Message-State: AOAM533YQmAVOX/PUko33+b0EMFlutbfrji2Rl8lxOjbRFyVZb+BzuGs
	c/CygaGAE03TRahILYkTsr46gSP2VC8=
X-Google-Smtp-Source: ABdhPJwzYZPqJPNT43We1G+U3Dn2lsng7M7Fd4/OtiGl155w9kwb5NWfAuV8Y/42pikL9DcxokdnRA==
X-Received: by 2002:a65:6283:: with SMTP id f3mr2515774pgv.369.1630656934551;
        Fri, 03 Sep 2021 01:15:34 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id j6sm5254452pgq.0.2021.09.03.01.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 01:15:33 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH RFC 5/5] DO-NOT-MERGE: mptcp: mp_fail test
Date: Fri,  3 Sep 2021 16:15:13 +0800
Message-Id: <a02cf200d137b30aa20fa879b0159fb2a847dcb9.1630656206.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <8c484be5b9db1c3b81690bdba044042f57bf14b1.1630656206.git.geliangtang@xiaomi.com>
References: <cover.1630656206.git.geliangtang@xiaomi.com> <c9504a9a84a501016ddc53ebbf644f827233b7e0.1630656206.git.geliangtang@xiaomi.com> <7d43c0b1c5f336641d9c8edef80cd0e37b93b668.1630656206.git.geliangtang@xiaomi.com> <3a3eda61ce3b885b2c43cbe63320ecf068bf8267.1630656206.git.geliangtang@xiaomi.com> <8c484be5b9db1c3b81690bdba044042f57bf14b1.1630656206.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

./mptcp_join.sh -Cf

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/protocol.c                           |  8 ++++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh  | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4987909991cd..2d05236ad759 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1301,6 +1301,8 @@ static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_e
 		 mpext->data_seq, mpext->subflow_seq, mpext->data_len, mpext->dsn64);
 }
 
+static int i;
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1413,6 +1415,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (READ_ONCE(msk->snd_infinite_mapping_enable))
 		mptcp_update_infinite_mapping(msk, mpext);
 
+	pr_debug("%s i=%d", __func__, i++);
+	if (i == 20)
+		tail->data_len = 1;
+	if (i > 40)
+		i = 0;
+
 	mptcp_subflow_ctx(ssk)->rel_write_seq += ret;
 	return ret;
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 255793c5ac4f..16fa761607e4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -939,6 +939,24 @@ chk_link_usage()
 
 subflows_tests()
 {
+	# 1 subflow
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "1 subflow" 0 0 0
+
+	exit
+
+	# multiple subflows
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "multiple subflows" 2 2 2
+
 	reset
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN" "0" "0" "0"
-- 
2.31.1

