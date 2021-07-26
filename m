Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657E70
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 06:45:31 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id n10so2749499plc.2
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 23:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Acflo4de9oIkKoAYozy+e+mNa2LCU3k7qVc76MLFU5A=;
        b=gIO2f2fSTrdkZLZ4JIPdg06ZuuOY411jBgiABxFYkOEpf2r2rIJP8GGqK9XqgxAIEs
         /0T9kwtDpWLGQoXi8jegpUmiEhEHOhLBpJe44HmryoB02dHx5AdRmLAnWIdHinzDSafj
         7Wtv5Kg1MoswCKdzfzJzGkB4Rhbb6kEdoIzgHs/airLjLzCGMeyuc/gNA77CPQx50OJ4
         ye0/iYp9SGw+4H9t7tNTJkUbiW6chSfg93diIRkzjGp+zCWi/fbZ9nWZQcC9olcwrq0X
         dwJLaPttR84+hKaUY0jetMocbtXgsr7tq4ftUwPS5IU660EOCiqIDq+xeF+oxVnzs1BF
         7yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Acflo4de9oIkKoAYozy+e+mNa2LCU3k7qVc76MLFU5A=;
        b=d7147sPttB0vIWVLV/i7OBvYBVLfXv7G/0+4iQeOyKQ/IJGa0s7Foi6iu5NbkQlbo2
         BGviasAmdrjmSU3Apx3/CiZmKcxgUqS1FgV3hVyklF2IQo/M32i1TbOx5MGeE53renUO
         aLZT8dfc2v3zbYMbFTIWxEUtvl9hNUexOPCyVhWMT78Xi5iD5oTsbUPHkedXReigBXTY
         rziMQT2luxUA/buP9X205EEAB/eylc5Knl8tKqX+LVd270ellyhxGUMbT5rh85KQ+Jvb
         E6MhiHFHpnvGCP5dfGReJusWb7NbfpL0rY9ToOmYrnOBTGOTS0erLKIiMu62fKm6InqZ
         Y4xg==
X-Gm-Message-State: AOAM530U9iIgflvcaZFX268DkrE24yEt8QBVYsWrNnISNOAV6R7e8KEA
	936n46oYpVnijbhBz6uimEq9lubAVnPjWw==
X-Google-Smtp-Source: ABdhPJyb2Dbi+FguLfWcwBBvZDUNnnxqxL5qTLHt/JZF+Hk4RQXw/NhbcGV6Z938W7LRdrezbgilBw==
X-Received: by 2002:a62:8f0b:0:b029:356:ba53:a041 with SMTP id n11-20020a628f0b0000b0290356ba53a041mr16897216pfd.10.1627281930987;
        Sun, 25 Jul 2021 23:45:30 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id k11sm10634697pgc.30.2021.07.25.23.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 23:45:30 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v5 mptcp-next 5/5] selftests: mptcp: add MP_FAIL mibs check
Date: Mon, 26 Jul 2021 14:45:15 +0800
Message-Id: <d7a43020153c99a15c2d0d0ac041cd210c3525e7.1627281326.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <35c5e28e2846f7e2efc7c672d20dcafa3e70828e.1627281326.git.geliangtang@xiaomi.com>
References: <cover.1627281326.git.geliangtang@xiaomi.com> <fce3d982e418e791fc38dd2e9f116de84e429d21.1627281326.git.geliangtang@xiaomi.com> <bcdbfa514af7e5dc3741c16bb692c070ed50f3df.1627281326.git.geliangtang@xiaomi.com> <8bfbc479bd4513a51a96542b5174b6f75d33c656.1627281326.git.geliangtang@xiaomi.com> <35c5e28e2846f7e2efc7c672d20dcafa3e70828e.1627281326.git.geliangtang@xiaomi.com>
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

