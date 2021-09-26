Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB28F3FCB
	for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 14:29:57 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id bj3-20020a17090b088300b0019e6603fe89so9791002pjb.4
        for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jt1KMRIAZMC1n0qcBDwo+awr5yycCMAD2SaHZUIXMV0=;
        b=ODCkjHueSb4z6GxTUE2KyMZnPYfO1ldvqw88PND/6EmCXXTlyXQVMQHqvo5eUb1j8w
         UeiFykoaFdAfRHHuE2R0LavRMl27soowsg196olt7yYMy/piMQ3PWayHLHkOUqWr2SS6
         vlA0J0PHw2GjaGzYYZLu3huw95ew0fzExTr7kgxvijhLeqXag2z20cMYbOz6wdOTqgjF
         0ya77wamcRx9TL2yYkwn/RHlXCUF7e+TwVM98BqX7uEh9fit9X7ui1zezpn7PThocHqZ
         NoGTtb5KyEYq6bntiq9weZk0RNRC0JLKduP5KjYsYwtAukmxwvzkItd6YX8CUzIXY3Rd
         9Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jt1KMRIAZMC1n0qcBDwo+awr5yycCMAD2SaHZUIXMV0=;
        b=3z9gaeIlI5kkg2OIWldAueuu1+745jTrRgAg+9beyeoqfG1DFFrDEKz0+aBumA4nUU
         eTnngcUmI7zfEvWkzzH8U28kqIo2t3JyaSe9kQPwRBBT8L1Y/maeINIgeOg4ffTrIygc
         B3/DovFQJWA5yTJNGVC1SC6C+rfgXutamZUb/Sdz2dbb1FacbM3CWtDsGFw85vy+yhJG
         U+TyvpT18SeKH+TeNw0JoRFX2BZBeLu/uKqaS91NX9tm982afAGi7Ff7ckSq3sf+ZiGg
         P3Dn1fpRN5QdTuSmbLX65x/9DRuOrlBqAh68k5obORoKrmk7WkbCoTudYXAIY52EnB4V
         gNOQ==
X-Gm-Message-State: AOAM531oHYN29ojOT47ho8Are8q7nIsLE3bavpUvqG1vk4wUvak97zHB
	KI6zoMbPsdxv5nqMU43oGXvDFAr3Bq4=
X-Google-Smtp-Source: ABdhPJy7TEv3nx5sLsdV1k6PxAm6gS8Gnbn62TnacE5Ta2DG4Rha6qajtnxK4KnCfsCXb7cdvccs1Q==
X-Received: by 2002:a17:902:c789:b0:13c:a112:6383 with SMTP id w9-20020a170902c78900b0013ca1126383mr18291300pla.42.1632666597364;
        Sun, 26 Sep 2021 07:29:57 -0700 (PDT)
Received: from MiBook.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x9sm2421082pjr.44.2021.09.26.07.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 07:29:57 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v5 8/8] DO-NOT-MERGE: mptcp: mp_fail test
Date: Sun, 26 Sep 2021 22:29:38 +0800
Message-Id: <20b70e7c602d039f1b073321ec1e87a3641315e7.1632666254.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632666254.git.geliangtang@gmail.com>
References: <cover.1632666254.git.geliangtang@gmail.com>
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
index c735adc6b835..dec87c05361b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1295,6 +1295,8 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk, struct sock *ssk,
 	__mptcp_do_fallback(msk);
 }
 
+static int j;
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1429,6 +1431,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
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

