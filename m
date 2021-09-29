Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B93FCB
	for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 07:35:26 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id y1so896894plk.10
        for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D1czgHb4cqajH/gvizEF6+XERd/QJi5ZDToHi+OE9hM=;
        b=ZnDQTgs81IdWfWskA+NAcKbgVzYiRHa/wH1YlbtvkY1nSO0dwob2OxZrhvBT0agi8U
         BnZmkHF9EgiE4/IR2eCeQAS3eaZHT7IAnZZGudlEAaKYnTa0tq5jhS1JpEu98iSLFhh8
         1IisqwsO16tKd8nQX88PCfOELzmDsZyqwcNMw0ZxiQcG1A+6fSl1NIW0mwGJvWYck9Dp
         vTycjVoYQtpbCT/sOOIU41YU9wducjt5fKTaG60Bc6NsNbVrmnww7t8+eDADxod3PTad
         EAvOl2ADbkhdjYiYNPeYbP/hDVyv44TqqfkLXdNUz2C64BGS8TNw4S2QNQiOUIN8gnsq
         jUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1czgHb4cqajH/gvizEF6+XERd/QJi5ZDToHi+OE9hM=;
        b=Ilia9pLSxag22gxc+wJsFvGBOKhOGUy9cvkYXfBxoKV4Tj6yMKCt+wHLiNnlk00/gR
         IdZ9FPtr7n1nA8ldcu5KYZ6hkBwzu897VC4lkVxYbmb0LFN6hdZw9kZP07fWsKN7cVQe
         H3LEYJl4d9Kpq9CW5EEeK5R0eWosIjJFpUydo1h+5ynXvHr04LVu2MpOuoKf63hG8vLK
         fZhUEl/v5PVamKLZjxya623JS6aIFxhr/m2f6k6c3B/y10tbYjJPXSCvr+xG46SuiNwY
         Ql7jlm/wWjv4gmnk5S7970OWgs+5TWQhyrdrfHyAgU/K0mlGlumwkBr57IRrgHYmWsAm
         4SHw==
X-Gm-Message-State: AOAM532LZCEbxHNOZP+Y/kKG+AtlwYLkabhUbhM3vYn6aCumwGQKeSlX
	0ZW90CzlJ0R7zA+uOHbTJ5FUFwTQzaIH3A==
X-Google-Smtp-Source: ABdhPJy5qLO4nUIdv7Ifk8SQLT+Sxxoz63rSB1/E1IVz7tLCOd6pM7TwJBrMLFaFbWzIUSbIG+EwOg==
X-Received: by 2002:a17:902:8488:b029:129:97e8:16e7 with SMTP id c8-20020a1709028488b029012997e816e7mr8876300plo.39.1632900925942;
        Wed, 29 Sep 2021 00:35:25 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id gn11sm937853pjb.36.2021.09.29.00.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 00:35:25 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v6 9/9] DO-NOT-MERGE: mptcp: mp_fail test
Date: Wed, 29 Sep 2021 15:35:07 +0800
Message-Id: <7c583cc5d31ad60063ea3a6b81e8cd60248c5dbd.1632900306.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632900306.git.geliangtang@gmail.com>
References: <cover.1632900306.git.geliangtang@gmail.com>
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
index 5122c4ea4350..d3b9f6894eb1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1292,6 +1292,8 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk, struct sock *ssk,
 	__mptcp_do_fallback(msk);
 }
 
+static int j;
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1426,6 +1428,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
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

