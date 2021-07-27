Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21572
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 13:24:46 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso4260940pjb.1
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUaPm+vRvGPbiXQeo9s3ttcGUumCGJy/2CRiSr3WGEE=;
        b=QNYtXoy9S7XxXTlgb1I3UDpO4FjWk2A0ypM0h1KyJuS3A2PFFBoEg4IDhvwAJqVGYC
         dJaQiA6tELnnI098lqOj6xUEe5BPXZ28Umnb06L3zfbEb2YPdNGf0Ae9U0Ly1Xz1mV7I
         4X722fwi0x/378Zdfc9qjpLErFBhnVWCcqJzf5KQuXPNw2GuAHEYnERd8sjYK9fA3Ywn
         26FuSjVpxaUoZbSkX+rafiGmpcFvr9Xp/XZYlZO8w1QxHwGec0I7PlGggGDjTz9wUGPK
         rgpM1Wp590ur5N8JhnLjS2vlqsoLi9ExLSidsS7TyZq1zhpNepzimsKRSnt3yoP0xyoZ
         7asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUaPm+vRvGPbiXQeo9s3ttcGUumCGJy/2CRiSr3WGEE=;
        b=CUjZcc3JITWaIiQxr3E1VV0mthGNs+DtVLsu2FWxeJOJkIEu1YDHBDsNX1WYWfM/MB
         RgIDv7WdGXFO9SxoGzQSeJ+3RAdUF908KpzoaBsznLeuhrF4q9DwQJslBBI1AwZAwUoK
         iXIeRr0GXyuCGRH9H2ZEmPgN5rxIBSYzITguAY5bBP7UtT258ByldgGkHYfizGpmZtu1
         qBiPTimPYC0KNq06PL1oUDyOMkbl+q6zV1AgrDscATYNnLXPF+iew05hoWHfMrnRQE60
         /yjMKOyutnbZabXBbr+twH6SFXJ2PCvvMekaVGvaTTU7OLJ8I+8/TnYco/tJzBufwUg+
         RUEg==
X-Gm-Message-State: AOAM5320N4fZtg5Y22nb/AqfAGgFIY9gqLZ5pAwzoXit/vuxPQDnRhaM
	QjvA/mF788AMjfFrGI+B7r7JrU5Dfao=
X-Google-Smtp-Source: ABdhPJy14UiosTQeOg88jP01sJpAjeS+zMsX9F3R98WCPNDJps0oOSqlBoxMw+CjYLnHzHqL7Tm2Ww==
X-Received: by 2002:a63:686:: with SMTP id 128mr11159238pgg.55.1627392286059;
        Tue, 27 Jul 2021 06:24:46 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id j13sm3511066pjl.1.2021.07.27.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:24:45 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v6 mptcp-next 4/5] selftests: mptcp: add fullmesh testcases
Date: Tue, 27 Jul 2021 21:24:32 +0800
Message-Id: <cb461bd9ebbbfda680c2d1fea3bc7467596e3d5d.1627391588.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <10a327d0ce8f917d17166ae7de561a8b2af23ff3.1627391588.git.geliangtang@xiaomi.com>
References: <cover.1627391588.git.geliangtang@xiaomi.com> <703a40cb47f2f4c0ddb25bb61f97cfb4b973dc5e.1627391588.git.geliangtang@xiaomi.com> <87310b54d3987e94138953e171bad7b081b63df5.1627391588.git.geliangtang@xiaomi.com> <10a327d0ce8f917d17166ae7de561a8b2af23ff3.1627391588.git.geliangtang@xiaomi.com>
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

Reuse the above 10 address numbers for the fullmesh test.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 57 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 937e861e9490..2a27d6240f5b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -367,7 +367,13 @@ do_transfer()
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
@@ -377,7 +383,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.2"
 			fi
-			ip netns exec $ns2 ./pm_nl_ctl add $addr flags subflow
+			ip netns exec $ns2 ./pm_nl_ctl add $addr flags $flags
 			let counter+=1
 			let add_nr_ns2-=1
 		done
@@ -1697,6 +1703,46 @@ deny_join_id0_tests()
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
 }
 
+fullmesh_tests()
+{
+	# fullmesh 1
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 4
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmesh
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
+	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+	chk_join_nr "fullmesh test 1" 4 4 4
+	chk_add_nr 1 1
+
+	# fullmesh 2
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 11 slow
+	chk_join_nr "fullmesh test 2" 3 3 3
+	chk_add_nr 1 1
+
+	# fullmesh 3
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 5
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 5
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 12 slow
+	chk_join_nr "fullmesh test 3" 5 5 5
+	chk_add_nr 1 1
+
+	# fullmesh 4
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 4
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 12 slow
+	chk_join_nr "fullmesh test 4" 4 4 4
+	chk_add_nr 1 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1712,6 +1758,7 @@ all_tests()
 	syncookies_tests
 	checksum_tests
 	deny_join_id0_tests
+	fullmesh_tests
 }
 
 usage()
@@ -1730,6 +1777,7 @@ usage()
 	echo "  -k syncookies_tests"
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
+	echo "  -m fullmesh_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1765,7 +1813,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkdchCS' opt; do
+while getopts 'fsltra64bpkdmchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1806,6 +1854,9 @@ while getopts 'fsltra64bpkdchCS' opt; do
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

