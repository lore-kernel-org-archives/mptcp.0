Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAE93FE1
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 11:51:34 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id m26so1551370pff.3
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYx3YyFoHwDg4nx5uFvbO2npW+beq7yD9VEjzpnMdSw=;
        b=KWlDzq+hz104k+oXeOveEJnYzZxwmUA05C6m9Jn6+6DESdzkcWa+8ksFF4G8sm/AEn
         Tv7Ul3WKusyw+ZjTkGBnffkTq/ky/lXxfY2HmE4Ak0ZrWzjf7o3fgeAHMRPrAk3/6iAL
         mm+gQv/oQJORGPMe6J/LJRCtlEh9mZPfum00aB4Wj7smTC4hPUlNZ8E9mkYAHgVXaXQa
         FwefGSroqx/nrLDwEflJixi9BaL7Q6ziANz1/JB3dgkkn8uyJgQJFoQSqdrMxH8zhcob
         8NrkHU4CSwn/YESinlDC58fY5WH13cgUBRWvyueyLaNNdmdXfJORMOVDCGvqWrXy4mVY
         rEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYx3YyFoHwDg4nx5uFvbO2npW+beq7yD9VEjzpnMdSw=;
        b=UqNI7/mCK3fXBmPVwAjbRTqOBD9xKVm8zUV+Gj/BmDDIbfd4tC8gy6RxzayDbLufuB
         opChXJhIvYLQ1YuDjOKP483HBa/P2TdLJTlWisOzFDXYXytWMMhFj0sOcGwOLcGmp8Hj
         lQEGYMB53qAbDBD4Agql8KMlZWF6TX3WvuyZTgMQ2QIdmHbM/S6A4wnLni4R38pYDYBo
         sfknw3vKwugdrzgcdy34WV0W4CG9agViMkgDc6JYF7/ctGqBZs+c28pbcau8iXgm5e2a
         ce0zln0OgLQcRrSWWUC/MPTqiVWnKAD50DdnIvvGuu6foMFGOIuHJR2W/GPorlcBOv+r
         eBdw==
X-Gm-Message-State: AOAM5312wRpFlxxqr1mRPouRe5Z3DAKmBWpuBrovq1z4sBYL1k5LcZ9r
	qzeylNkh0arK+13/WHGweowNdAopylo=
X-Google-Smtp-Source: ABdhPJzv/eFmcXbclo6ZOIDdYBMffzukdkN3LFAMFZuIvSw01uZ1ri22pU1j2R78BjKNfI70fob8FQ==
X-Received: by 2002:a63:480b:: with SMTP id v11mr2276552pga.413.1631188294176;
        Thu, 09 Sep 2021 04:51:34 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n14sm2458225pjm.5.2021.09.09.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:51:33 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next v2 8/9] selftests: mptcp: add infinite map mibs check
Date: Thu,  9 Sep 2021 19:51:10 +0800
Message-Id: <a6dd276c9d82e06b9beefa02e94f82edaeafccd3.1631188109.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631188109.git.geliangtang@xiaomi.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added a function chk_infi_nr to check the mibs for the
infinite mapping.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 255793c5ac4f..fe0c8f3164a7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -615,6 +615,43 @@ chk_fail_nr()
 	fi
 }
 
+chk_infi_nr()
+{
+	local mp_infi_nr_tx=$1
+	local mp_infi_nr_rx=$2
+	local count
+	local dump_stats
+
+	printf "%-39s %s" " " "itx"
+	count=`ip netns exec $ns1 nstat -as | grep InfiniteMapTx | awk '{print $2}'`
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$mp_infi_nr_tx" ]; then
+		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
+		ret=1
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - irx   "
+	count=`ip netns exec $ns2 nstat -as | grep InfiniteMapRx | awk '{print $2}'`
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$mp_infi_nr_rx" ]; then
+		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
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
@@ -665,6 +702,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_infi_nr 0 0
 	fi
 }
 
-- 
2.31.1

