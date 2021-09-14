Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB523FC5
	for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 09:19:31 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id f65so11572046pfb.10
        for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/61neoQuJvUboPoxEMvmqYnrY3sD4YlQp7a9H/I488=;
        b=BndIU4gc+CixysnBvEv6aW0ZCWwjDFFO/i5TLk8I0n/qcyLw6n2AvIgNGxn5T2KYFw
         BMwz2RK6h9YEGBbA4pmLIBog9964+g1nCEufTK20/4NLLyNyvdedbpF/GS5vwXqrJYzC
         mJlrw8hidjHorxxFZCYhhws3yLH10/oBuSK7A5/lt7vTPCJ57PdtqZmkc1xir+pbME83
         RQnvI4HIDbOagdJyFsvYoyHlysK4WzToOOxhpZE756CA4lRJQ7qiW5+1ujrB5+PH8jcB
         8+qBJiudOd2kPmLtgNNlnazp5lTtEitXtfPj7oR0k7gbD9sILcXHCr2erYNeqpPgLJy5
         sBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/61neoQuJvUboPoxEMvmqYnrY3sD4YlQp7a9H/I488=;
        b=qaeT8WpR5Q6wfYnlumazirhpvRMjoA52AwEKDAjMyrkGvVC0BgdUmYpIkiue0RPl79
         TRzmBNk4aL6L5GSksQliskNh9yVKSpuEpkYZe/TT3Wu9zDJGjEOQ2bxw4P0J37QTJR9a
         K6heMU/thUJn4D6AxFYwrG8mDCZDMyumKB3h6MIf6U2e9sKPWZtYJmkn4JGAhi0Ulgmz
         BYBAHPJx28q3zjxMaDsbGuOFi9vznq3lD4pWTG0/++2Vi1TryQYscWzV7p2h3UVSR4Ed
         A19yU0+TiRoXz6+/DBl7AvfINgXe+KhVn8GY07gbUw25KEI2EyUsW3gYObYz7G7ZgbZn
         9EEQ==
X-Gm-Message-State: AOAM532MTd5OpylEwxFo7plOymuXVelfPnCTknVRHCAZAxs1m7qZg2xK
	f6IAGwhGUDZ7Gg2B2tIFEQ2RN+IUsA8=
X-Google-Smtp-Source: ABdhPJyTz31QHAxoxHro2/eRVw/D+gMXZ2jiJnbQWNdyDIbILuFadYPjk3hJbi6yz67ha8828zKg+g==
X-Received: by 2002:a65:648b:: with SMTP id e11mr14544760pgv.138.1631611171270;
        Tue, 14 Sep 2021 02:19:31 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id i21sm10851317pgn.93.2021.09.14.02.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:31 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v3 8/8] DO-NOT-MERGE: mptcp: mp_fail test
Date: Tue, 14 Sep 2021 17:19:07 +0800
Message-Id: <c7bb8d7be4947f76df126f4878ac0c270c83e374.1631610729.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631610729.git.geliangtang@gmail.com>
References: <cover.1631610729.git.geliangtang@gmail.com>
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
index 48e0f55c9e45..0e4c2b7ab264 100644
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

