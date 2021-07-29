Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C970
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 08:40:29 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id f13so6165391plj.2
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Acflo4de9oIkKoAYozy+e+mNa2LCU3k7qVc76MLFU5A=;
        b=FgZXEf4QrwOvtWU1JgkRPFg33D1whw8NcfRPEWcJdubqcvnI9bSdwBkQbZCyOfmrto
         5HuVCPDyvOY9oxwPKbI8aZQAdZk5uAlLeo3OjFDVGyjC0257cag7f2CbW7zn08YAXtWY
         VvGbBjtU7k6IPjJQURlDs5IV2ARpItz6SAwsJXigUZIdNl9yHRhEbHEGQa7CX4frfp5K
         mWAbhVuAyJyPtzVD0a32j6aH8FjC5OUZrmQmhfrsASX8HWN9KnQKPEWKAkjVsz5EFFri
         Pr2TZNa4nEVy6jGFHta340YOL7MqhTeR7Yar6cxQV7jjU32BaslFqPgFjkBJAlUAi2DT
         r7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Acflo4de9oIkKoAYozy+e+mNa2LCU3k7qVc76MLFU5A=;
        b=n9rCcTyIGGl3xbZCc45TPZfjGRQv1a9kZ29l9mJXakewFQeCWRLDgv0NAA9bMc34uW
         YmNJ4Tn1jW9O8F7CR9lq/Wnu7AHgdUXLBgcX3IAO1t2igAU4JkPGw8tMSh7LBNn3drXE
         Za3/1Dz+w8Cdm5euKEuUGIihKBltCYtGwA8V4AMf9FRaih+ijnXJ1lMa7SjAHTHOaSI5
         bltL7KUmZxEY4uMyoJjFfxTJ88OKgt3G/Z5HclHclMwvEpgw5LkogrwkoDRfZFE/BW1U
         C3WUyoQEFMVo0mCKiyQe+j/NR1IMGCH8Gn9zGaiBDZJ7zoYcTXGpTvTmEXBItzXD0z5J
         WIFg==
X-Gm-Message-State: AOAM531P00Xen6u7yoWZRPJcY/GnzaPfsAQylUdb3QCEqcZgnmNJ1G4H
	IvlmFDJQwA2vwfht1KiQVhitJAIQRrc=
X-Google-Smtp-Source: ABdhPJy6vlARknTcNFn7KLrygUTP7qWrBCVDb2g+om3VKcgP42IRsP6Qgqn3hEpOVY9xRBze7sN7QQ==
X-Received: by 2002:aa7:97bd:0:b029:32c:56cc:8fa9 with SMTP id d29-20020aa797bd0000b029032c56cc8fa9mr3822017pfq.65.1627548028660;
        Thu, 29 Jul 2021 01:40:28 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id f5sm2401539pjo.23.2021.07.29.01.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 01:40:28 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v7 mptcp-next 5/5] selftests: mptcp: add MP_FAIL mibs check
Date: Thu, 29 Jul 2021 16:40:13 +0800
Message-Id: <5a7d1ff8e4b688095bb0c2675ea76f6e18fac950.1627547666.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1ad053e0160d44c3bc998149aeef9a55306e3eb4.1627547666.git.geliangtang@xiaomi.com>
References: <cover.1627547666.git.geliangtang@xiaomi.com> <d04456a7439e4cdab65aea27a035e5b89d5c0e2a.1627547666.git.geliangtang@xiaomi.com> <0c155f43f4bc75c90cf45283e07ea48432178d48.1627547666.git.geliangtang@xiaomi.com> <cfc2f48712c35a61be26ee92db8e900decc07217.1627547666.git.geliangtang@xiaomi.com> <1ad053e0160d44c3bc998149aeef9a55306e3eb4.1627547666.git.geliangtang@xiaomi.com>
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

