Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF272
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 09:35:29 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id d1so1985913pll.1
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Acflo4de9oIkKoAYozy+e+mNa2LCU3k7qVc76MLFU5A=;
        b=RE3nYr0Q9GtxbSGYMjfD03KhuWWuQp58Hwo5cdk9bY4xW0tBuDsBBc4/tv0OsVrR3F
         wN0zdx7PLcIuz9uCVJdKn5Fz9MuZ7J/YMf36XSmCM5CeiN9CB1HdFbvOwP73kZUEtx1H
         w105IniVGkAZYRwSuIWW2TXdVcAYsLW48ynZIDC5GoLKFsK7ETf9mjoETZSRHflXYW4Q
         B15piQyOdgANyDb8zdg2m7t/dVvS+yZ0zqn+OzeJJwSM9HCpeba85F23+TQ85K5omE+I
         pBWcZpLlvOLYnRJXXl8+BdQP9OBlh5T5dJYWYgt3/kvh6CrJJSt+ObjEc8LT44d4yTCD
         r3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Acflo4de9oIkKoAYozy+e+mNa2LCU3k7qVc76MLFU5A=;
        b=GCWxUwNsgbWR0eUBJwMR3gHDfr2GKSJ49timYjg7ysiIvHftKKDNEJJnEVmuEHpCT8
         YXGlwUJxb8bnKHgKIu5eDTU5yFzcmYJBGVbf81PRfNYqJOjoSk89s8ty4sul3zpDqPfv
         v5T0pE8ec2FN1xbkPthiKySwJNFuN0zhE0+FcOq7L5qXJnzw4qp+XB+UENEcsIZkSURS
         Q9V/q5cE7BnGcJdlTz2wRzpk0aYhWkMlYl/mg7K4LIBa8ypPr9xj5P2uA6pHcmN4td2a
         EkruVwwPicsnzp5Dg/ps9smOxKo99uloLtMaHaGAUC9Ow9bbq8j7VbvlA4nqhD54Ohgh
         75hw==
X-Gm-Message-State: AOAM531732uGd2N67plVowkH/WAK5ItkVMqtC3/Bwl6g8hhkaqIpWb4B
	oZCL+KyMikqcoMj3bhX9Saa82mKlf6s=
X-Google-Smtp-Source: ABdhPJyvjy+ddv02twGhCERhW8BPS0qKBDrkskWHac06lYIqQWp8pqPpcHlxU+Tq8oKm1KpYNwJczQ==
X-Received: by 2002:a17:90a:5a4c:: with SMTP id m12mr8958434pji.15.1627464928804;
        Wed, 28 Jul 2021 02:35:28 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id v10sm5312560pjd.29.2021.07.28.02.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:35:28 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v6 mptcp-next 5/5] selftests: mptcp: add MP_FAIL mibs check
Date: Wed, 28 Jul 2021 17:35:12 +0800
Message-Id: <ac289cd8bbfb3a6f6e3a41e792a88e458b57591d.1627464017.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <0e7f6c209ba05ef9e5b7300f490f8b6db4df3334.1627464017.git.geliangtang@xiaomi.com>
References: <cover.1627464017.git.geliangtang@xiaomi.com> <277ac1e6d1fde4c180eba3f1bb1846ea58679915.1627464017.git.geliangtang@xiaomi.com> <a39b8f2a49c2798d4ff80ed527cd8990e64f8def.1627464017.git.geliangtang@xiaomi.com> <19469d95c33169d6e4dd553394ab4466756ff001.1627464017.git.geliangtang@xiaomi.com> <0e7f6c209ba05ef9e5b7300f490f8b6db4df3334.1627464017.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added a function chk_fail_nr to check the mibs for MP_FAIL.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 937e861e9490..551fcce7c2f2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -566,6 +566,43 @@ chk_csum_nr()
 	fi
 }
 
+chk_fail_nr()
+{
+	local mp_fail_nr_tx=$1
+	local mp_fail_nr_rx=$2
+	local count
+	local dump_stats
+
+	printf "%-39s %s" " " "ftx"
+	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$mp_fail_nr_tx" ]; then
+		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
+		ret=1
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - frx   "
+	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$mp_fail_nr_rx" ]; then
+		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
+		ret=1
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
+	if [ "${dump_stats}" = 1 ]; then
+		echo Server ns stats
+		ip netns exec $ns1 nstat -as | grep MPTcp
+		echo Client ns stats
+		ip netns exec $ns2 nstat -as | grep MPTcp
+	fi
+}
+
 chk_join_nr()
 {
 	local msg="$1"
@@ -615,6 +652,7 @@ chk_join_nr()
 	fi
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
+		chk_fail_nr 0 0
 	fi
 }
 
-- 
2.31.1

