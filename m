Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D2168
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 11:08:39 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so13649593pji.5
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 04:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4f3YsuJzilEkaiGWtUdRU8k7oqKGzamLrxruOFlxUaQ=;
        b=o6oi0N9nRrdZVsjttFZ4g7D7irdAkBFL1oEo98rUUYFpeMxBhD57L3+8aNLjEvWFll
         fe2xVUE0juA6qP2mEMm5FbJTo0UwseC8hJfrD0Rn+MznJpGoeLukFLwGNyy7OgUH2yS8
         LCz6lJsghAsahCnI+JvVoIfeMI6npNH2xy6a7XwPNogbrrgD1fOcaaVJXa32O4aACOLt
         9Cf1M6btZZJ3cxdnhXu8iRq8ZUh3RdgB0/zhOCCWnIX0ZvWxgI2S0/1QQZkwLpsHeAgh
         S3xbq6LfQSw4qEOm3oRc9xoc+KVX46eo2QI5rLH4eqjQaIU1vAUH/v2+lnUhC42vTh08
         cpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4f3YsuJzilEkaiGWtUdRU8k7oqKGzamLrxruOFlxUaQ=;
        b=j+JDehBmGZJymeg9Dii+SeTK0aszxJESMgs/+/39wys5Ryb8VVPeaR7C4gIcN9jXvg
         2H2E5ruE0Nx/Oc6kpl+m4gfqnhHuxDiVTUUXIm2EnkTZA86oGyY3jyj6pc3uiZtt9aJg
         7+srwqC2o3ZS8tSmclTajo0cbxQTYyWgl5xBkezISrEnd5iJmLMfG7oASc+ivQJINHKp
         VayunMHWp2KCWS6gD8g1Ia2Ag7LvEvZl+5G0fmzKfHUqSCpImFo7uKJzd39nNy+88Os0
         UFlzw9kRHmPW6NkAaT7CWsVaoO26W7lPk60gO/9u/IW8ZolByRV5lZpuVnNPcwZokPt8
         M5zw==
X-Gm-Message-State: AOAM532L93wZzEUpFtYjjp2p2ktk54Mpl1Hd5/cx6wuKP7JX1HqbcJ/B
	4/RXgzINhhqXwqOl2ea6gi5RX61ZjtA8pg==
X-Google-Smtp-Source: ABdhPJymLXaZRLZUluAYQEpFucJIb9iVFVtz/Xs3WvOGUpNkMVu2cIGUMYYuk73J4VeZE4JH1xyyqQ==
X-Received: by 2002:aa7:8591:0:b029:326:3e03:d7d8 with SMTP id w17-20020aa785910000b02903263e03d7d8mr17512773pfn.11.1627297718641;
        Mon, 26 Jul 2021 04:08:38 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id e30sm50282700pga.63.2021.07.26.04.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 04:08:38 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v4 mptcp-next 4/5] selftests: mptcp: add fullmesh testcases
Date: Mon, 26 Jul 2021 19:08:25 +0800
Message-Id: <17cd11f1f902cd545ade9930d03ab0d82e0272df.1627297096.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <0c40709e5ccf24e810c5a5b073a47baa0946f41a.1627297096.git.geliangtang@xiaomi.com>
References: <cover.1627297096.git.geliangtang@xiaomi.com> <457db25d2c745babb98b8f29c6d2ace3d6348ff5.1627297096.git.geliangtang@xiaomi.com> <afc79f9b4d6b8afb6492a52e9c1ccdc780fcca90.1627297096.git.geliangtang@xiaomi.com> <0c40709e5ccf24e810c5a5b073a47baa0946f41a.1627297096.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added the testcases for the fullmesh address flag of the path
manager.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 49 +++++++++++++++++--
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 937e861e9490..9ceb6052b513 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -325,7 +325,13 @@ do_transfer()
 	cpid=$!
 
 	if [ $addr_nr_ns1 -gt 0 ]; then
-		let add_nr_ns1=addr_nr_ns1
+		if [ $addr_nr_ns1 -gt 10 ]; then
+			let add_nr_ns1=addr_nr_ns1-10
+			flags=signal,fullmesh
+		else
+			let add_nr_ns1=addr_nr_ns1
+			flags=signal
+		fi
 		counter=2
 		sleep 1
 		while [ $add_nr_ns1 -gt 0 ]; do
@@ -335,7 +341,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.1"
 			fi
-			ip netns exec $ns1 ./pm_nl_ctl add $addr flags signal
+			ip netns exec $ns1 ./pm_nl_ctl add $addr flags $flags
 			let counter+=1
 			let add_nr_ns1-=1
 		done
@@ -367,7 +373,13 @@ do_transfer()
 	fi
 
 	if [ $addr_nr_ns2 -gt 0 ]; then
-		let add_nr_ns2=addr_nr_ns2
+		if [ $addr_nr_ns2 -gt 10 ]; then
+			let add_nr_ns2=addr_nr_ns2-10
+			flags=subflow,fullmesh
+		else
+			let add_nr_ns2=addr_nr_ns2
+			flags=subflow
+		fi
 		counter=3
 		sleep 1
 		while [ $add_nr_ns2 -gt 0 ]; do
@@ -377,7 +389,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.2"
 			fi
-			ip netns exec $ns2 ./pm_nl_ctl add $addr flags subflow
+			ip netns exec $ns2 ./pm_nl_ctl add $addr flags $flags
 			let counter+=1
 			let add_nr_ns2-=1
 		done
@@ -1697,6 +1709,28 @@ deny_join_id0_tests()
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
 }
 
+fullmesh_tests()
+{
+	# fullmesh 1
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "signal address fullmesh 1" 2 2 2
+	chk_add_nr 1 1
+
+	# fullmesh 2
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 11 slow
+	chk_join_nr "signal address fullmesh 2" 3 3 3
+	chk_add_nr 1 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1712,6 +1746,7 @@ all_tests()
 	syncookies_tests
 	checksum_tests
 	deny_join_id0_tests
+	fullmesh_tests
 }
 
 usage()
@@ -1730,6 +1765,7 @@ usage()
 	echo "  -k syncookies_tests"
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
+	echo "  -m fullmesh_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1765,7 +1801,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkdchCS' opt; do
+while getopts 'fsltra64bpkdmchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1806,6 +1842,9 @@ while getopts 'fsltra64bpkdchCS' opt; do
 		d)
 			deny_join_id0_tests
 			;;
+		m)
+			fullmesh_tests
+			;;
 		c)
 			;;
 		C)
-- 
2.31.1

