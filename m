Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A566972
	for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 07:22:47 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id f129so11922246pgc.1
        for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 00:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2ZLfYN3oNiOEaWlZbpsbKLfQ6k89+mYkXtjSrzW7Zk=;
        b=LZBORIYqF1xzkcHzjBKmgokjqoTcEDUesabdcRfc/uQz/E1cQcUHPqj63lKC5a4mMh
         Y4WmktgMd/pIPsMnMTWyxSJrapV2QdYz0+kw3868RFyC5ioIkBHCqQXEe9DTZ7Lg5QKg
         sLsUg/C7Pp3+JGqrj5KlrjSNLxLCBR/SeETKuYn7p11GpFFFm2Yx1uTwVUYe9geO9QRr
         RoGZgK6UB9iKqL/4oUCofObhSW11Ajnk8mkPMBpUz5FLw5fqU77NHjVYeJ1CPl6O0I0l
         4ROMGmkeXLdKL6ko5mZJhwGAwIKGxB2ouqDVlVM2uRGIGC8q8CHiDyUjF2Exk19aXfN5
         HThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2ZLfYN3oNiOEaWlZbpsbKLfQ6k89+mYkXtjSrzW7Zk=;
        b=xCftNq1Mxg4ELEqmZOxpMzabWZk0UTZNQhA2COcxNV7pd+WNnmwi7fyFnCaS6x94EA
         xl9ckpmGIorVKIau6I9uO56Iw9WEqC4wFISiH6sT9lgVvMbrV4bSwDviajWd4wZS4geQ
         Y1ZLO02ciDWw+kPXGzYicXMliu4HWlEQoAZcta1xS7Zt6iceRhqOAVqpvFIlVMhv0lIM
         RJDDRk+V68mJHoTHI0YtzwEUmiEmkGmXZaGfrHfaX2EwewsdmDrBU/EzL0hTP/y71wBP
         B+1/uOEacgLfoSSp8fg5AyJ9Hs6KNXfUfmuVPrWnN9Dxhn4zHOzlEt1bUVJHfAxC01IY
         jn+w==
X-Gm-Message-State: AOAM5335dG3X8DSFwH4jv2FvpPiYlQneVvFVLrjJf+B5GaDyCJzNWHj5
	h7phjVMIWQDoBocgqphhDOYsLYgBcmw=
X-Google-Smtp-Source: ABdhPJzPAquE0sP63Hn3NIRYSEG8si3IPwF4polXAZrnJiYel5Iw+5jamRAdsG3XXniUAWu3yWu0ng==
X-Received: by 2002:a63:1262:: with SMTP id 34mr13456392pgs.356.1631949767136;
        Sat, 18 Sep 2021 00:22:47 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 77sm8040214pfu.219.2021.09.18.00.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:22:46 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v4 8/8] DO-NOT-MERGE: mptcp: mp_fail test
Date: Sat, 18 Sep 2021 15:22:23 +0800
Message-Id: <54f45be86bfb22cbe8b1af851054c28eed9461cf.1631949480.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631949480.git.geliangtang@gmail.com>
References: <cover.1631949480.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./mptcp_join.sh -Cf

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c                           |  9 +++++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh  | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d035119b41cb..5be8023f27ca 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1297,6 +1297,8 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk, struct sock *ssk,
 	__mptcp_do_fallback(msk);
 }
 
+static int j;
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1431,6 +1433,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mptcp_update_data_checksum(skb, copy);
 	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
 		mptcp_update_infinite_map(msk, ssk, mpext);
+
+	pr_debug("%s j=%d", __func__, j++);
+	if (j == 20)
+		skb->data_len = 1;
+	if (j > 40)
+		j = 0;
+
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 	return copy;
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fe0c8f3164a7..38663f6373b8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -977,6 +977,24 @@ chk_link_usage()
 
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

