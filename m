Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7868072
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 07:21:10 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id a20so5974660plm.0
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gywm6drJnrkHUyHo4/wfyzlnjnVNvjqM3yXnkmpRCu8=;
        b=J0yn1MGQylU2WgYui0203QKAHtCi9G5EMsSss0luSgnpNhDc7HS0waiWPO3PnAfC3H
         laCAplPSTDBU7SUqPzDPh+lg6pY3EH2OeSbMNH/ewyU9cKaDPu1evJpZZF1H3vRh9uRS
         lLYM1iuJYRywpoyG8KZ8WoaD7aDP9XbxEi90GS9YasLghx4Bffzv1MjkQhNec1tOMRnn
         F25WSTMY2Da+uo2dQ+MqlZRTkpDX5xvYrQIGBjq/Nq2twSULzDfIP/MrT22SpjDkiIyt
         WeDIv9JZiVGKxHzRp4lOpbpVWR9clXy/jziFnDb/TIXnsJCQ3FNW0YIszUPJCG/PsHYx
         M1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gywm6drJnrkHUyHo4/wfyzlnjnVNvjqM3yXnkmpRCu8=;
        b=UrKbZkN8HTuGyq9s/KdJA7njTgN4AuhpUvKYakzpfJAVtUZxf/PfHQz2ry0b66fqrl
         sRI4mwD1wchXwyEr9c6ZrU/kNcz5kABW4pdNcUFfbFbsrF1B2PGjFkDHrYRdLKmp1FAR
         upL822201kYLd6vf2b/aMhfnalrn81mPf2DP6gtW1izjNdNqS+hxwTaJe4dKdvwz42hd
         fVaWVyzftnF5UbpDhmukwbookWMyZpYuSl7t/t+ElN5KD2LSupGwZskq3gkoe4belldq
         ODRgdqyjUWaYiQKn3odCPlRZr/iYGGrBPURmmxVY1pbH90KlYbOxejwPKwznrcnL3jHQ
         NrHQ==
X-Gm-Message-State: AOAM531yAX2xgYhsZCEvTguPpM8XX8Tf/hrJBWxH+/rj7rBQw2VTTIZu
	6z2jWNIv94wQfEKFrJIphpd3PlN7OWo=
X-Google-Smtp-Source: ABdhPJzKaqR4TzQtcUITwSYutvzB10tmOhRMR2ygePGKgkehiPZIONm2H/0P0Iz9osS7AETGOtyIXA==
X-Received: by 2002:a62:4e0f:0:b029:329:20be:287a with SMTP id c15-20020a624e0f0000b029032920be287amr3702283pfb.55.1627543269988;
        Thu, 29 Jul 2021 00:21:09 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id p17sm2211550pfh.33.2021.07.29.00.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:21:09 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v7 mptcp-next 5/6] selftests: mptcp: add fullmesh testcases
Date: Thu, 29 Jul 2021 15:20:54 +0800
Message-Id: <6acd8786b4c151c4c9f01a0370bd6a12aaae6107.1627543032.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <ae4edd8c446c94e57b981c16498f4f407d6b3e78.1627543032.git.geliangtang@xiaomi.com>
References: <cover.1627543032.git.geliangtang@xiaomi.com> <1244ff06f1715f714ccc21bb164c6c082e8a26f5.1627543032.git.geliangtang@xiaomi.com> <af7def3b48c96f1f0c68360326d2e9cfe2500826.1627543032.git.geliangtang@xiaomi.com> <349c97cf4d1091f28aa62e8200ebfe4fa0f5f2d5.1627543032.git.geliangtang@xiaomi.com> <ae4edd8c446c94e57b981c16498f4f407d6b3e78.1627543032.git.geliangtang@xiaomi.com>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 66 ++++++++++++++++++-
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 937e861e9490..cb5f9a43baa1 100755
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
@@ -1697,6 +1703,55 @@ deny_join_id0_tests()
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
 }
 
+fullmesh_tests()
+{
+	# fullmesh 1
+	# 2 fullmesh addrs in ns2, added before the connection,
+	# 1 non-fullmesh addr in ns1, added during the connection.
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 4
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmesh
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
+	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+	chk_join_nr "fullmesh test 2x1" 4 4 4
+	chk_add_nr 1 1
+
+	# fullmesh 2
+	# 1 non-fullmesh addr in ns1, added before the connection,
+	# 1 fullmesh addr in ns2, added during the connection.
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 11 slow # 11 here meams creating 1 fullmesh subflow
+	chk_join_nr "fullmesh test 1x1" 3 3 3
+	chk_add_nr 1 1
+
+	# fullmesh 3
+	# 1 non-fullmesh addr in ns1, added before the connection,
+	# 2 fullmesh addrs in ns2, added during the connection.
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 5
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 5
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 12 slow # 12 here meams creating 2 fullmesh subflows
+	chk_join_nr "fullmesh test 1x2" 5 5 5
+	chk_add_nr 1 1
+
+	# fullmesh 4
+	# 1 non-fullmesh addr in ns1, added before the connection,
+	# 2 fullmesh addrs in ns2, added during the connection,
+	# limit max_subflows to 4.
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 4
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 12 slow
+	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
+	chk_add_nr 1 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1712,6 +1767,7 @@ all_tests()
 	syncookies_tests
 	checksum_tests
 	deny_join_id0_tests
+	fullmesh_tests
 }
 
 usage()
@@ -1730,6 +1786,7 @@ usage()
 	echo "  -k syncookies_tests"
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
+	echo "  -m fullmesh_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1765,7 +1822,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkdchCS' opt; do
+while getopts 'fsltra64bpkdmchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1806,6 +1863,9 @@ while getopts 'fsltra64bpkdchCS' opt; do
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

