Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79772
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 04:12:41 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id d1so2796401pll.1
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 21:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PpbDh/gqeiKd8iKLeWqJbw1lhzGa8/quxUMNzaHzgsk=;
        b=UKiaVya/grWNNprGcC48Ng2wkZdS99YGVsyvwe+LBe934xK71owXrBrn6fQJv+lUGX
         HYag5OX1l0BM/8pksVznNF+ztZSiuszTpHEv4dknseSP2jklGBlxCNg9crXn5T6WGb1k
         HdVhzvGxxqwY/HqJwRby7+8stAJDE2WraRR2ASvXMPqS9pXLPtz+wyZSFzAaKM/w49sN
         F4wGMg1L8+Rg4zgQEeWpsTxVKBk7ZIn+Ea32LK3Bx4pPTD5Rmr+qzVMVjUAzLsYg6N3Q
         rd+TTDeiM0XH1wMzogOHqfiqOF6o6fIsuV6NizwDUHPGgWh9UtmFN+ykGm+tjn6bVhA9
         Ns+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PpbDh/gqeiKd8iKLeWqJbw1lhzGa8/quxUMNzaHzgsk=;
        b=ZVtoeNbdAEGr5uRDxCDIGCj8tO1IVR95WpSd3NL17aefnAqJvUsEs3u45Sv3IzSbDb
         PWHlVuNmOmICcnrluwsofpMEThmncopBhwdyD670ZHT4DHo1uHe45S0H80itp7gpNnu3
         wwRMgFjQE8uqR8Wi9ObBDnHKbbbC2w0X560ezqB86M+xIUEZWt9MS8QHcMP5FEDrnKH3
         oRagCEAIyiL2ePclVEFmGmV4xBGHLPTugiHD5QdDU4VXEec16D+ujhqLps6SVmwv5A7F
         cFeSUdc7gl2TG2O6t+hP3yqGxKT49no/WdihiDl/HxfZrzHz+S8A3TqD9+Lwhhz0VTHO
         z7iQ==
X-Gm-Message-State: AOAM531Fk0SwwU7JSVN7lt+NRVXVvj63OevFd9wyYitbvNAOv9arPA/o
	8/zJwQZakoRfDn/N8tf0iw6Eh9hJIsLyUg==
X-Google-Smtp-Source: ABdhPJwpXE0Rx3dN1I34yifnbn22F+0tuLwQKKja0vUnEEup641UBA8iX3qX52lST+becAXeYLKuJg==
X-Received: by 2002:a63:a01:: with SMTP id 1mr16104068pgk.360.1627272761397;
        Sun, 25 Jul 2021 21:12:41 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id f3sm2608543pfe.123.2021.07.25.21.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 21:12:41 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v3 mptcp-next 4/5] selftests: mptcp: add fullmesh testcases
Date: Mon, 26 Jul 2021 12:12:27 +0800
Message-Id: <a0bc6c98c1d78ad6b2ef7bbca3b0a0ee1e7b6fd7.1627272435.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <3e4690d0d33f8285465e54870410266e22208acc.1627272435.git.geliangtang@xiaomi.com>
References: <cover.1627272435.git.geliangtang@xiaomi.com> <6f7aa2fec63dcaa337c7b78184a73a90d58b580f.1627272435.git.geliangtang@xiaomi.com> <043ce3b46a70bd59ae7aaa53ed1afdf44b7f3ad2.1627272435.git.geliangtang@xiaomi.com> <3e4690d0d33f8285465e54870410266e22208acc.1627272435.git.geliangtang@xiaomi.com>
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
index 937e861e9490..887b94eab64e 100755
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
+	chk_join_nr "signal address fullmesh 1" 3 3 3
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

