Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08F2F9D
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 15:34:30 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id y62so11358818pfg.4
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 08:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THOLEwhRiEp2K2UoagJ9LmEmB821Rj35Btg2RCkXVtc=;
        b=rvx5OdN7C8jASJlC6iGyHlCpmMcJCY4IFnspTD/rw6VXIqpiAcI5hM0VR5sbcaAVBj
         J58EjZBCuKZBU1ySAtmmlplbe5kWpxX3ApcLKxbjP2TPH0ordy2aYNj0m1lagz1qAfNW
         j27hinHm3wdf20U5CMP13aTtVM+Shj2BS6D61nhSxtwWJNemOGm7dXwjxyHpvEJ4Tb14
         oNPmOhW2KWz4c4fuW74ls/WMMWnzJF/DpXTaOKy+FR9AiKMEMEy4G653l4aWoRu9SI8K
         Ai+HEqiZJ6L5gO9rqSlpmRelpWuEKiKYtu16N79x8TTDiAA1FFKZvr1pQouy81CqNmRM
         mlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THOLEwhRiEp2K2UoagJ9LmEmB821Rj35Btg2RCkXVtc=;
        b=n3tfwynDjoYmPsLdCsrRD1usNJTwEnOTRyNu7UA6GM0L2Gb/mm7v40ak6OZpFWiQqK
         g2pRWS4FQthPtzdbKfPt/vh2QE4X1xOKTx8SdfedJEYETz8M8hivIoOJS6kKm9LYUPP9
         jIBeH/neW8DjF8/721saY6kC1ybuhpbyoEFzIYe0hWkNTlXMR4hInk7moTMakGhz2OTu
         xwSu7cQCTnvtUkR0C7r6z9NU7TdljY8ZNKCWJo1n/lmuLU+/VhwYhE4RwR7J3P/JiPqk
         jvjW7oJe6ngxok+H1bT7ZqHSzXfswbZae4BMA+e1flyVJieZFUSJ1dNW90DLAdB7BMwj
         PGOg==
X-Gm-Message-State: AOAM530lxnKjYBRdhkBKmf9Bf7LTXfIZMEsQJHsUnVMxH/rccw4eWR/o
	y+PAc5FKqdKRLoBhDPEGj3OIvDlqvI4=
X-Google-Smtp-Source: ABdhPJwZVjWC9mXCOzcV63fGc+J+KjMxcbimwUG2CnII7zpe+tBNbQWrQcbaxr5Lz0ozht6VMss7Vw==
X-Received: by 2002:a62:7ace:0:b029:25e:fcfc:4873 with SMTP id v197-20020a627ace0000b029025efcfc4873mr28639109pfc.4.1619624069837;
        Wed, 28 Apr 2021 08:34:29 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id a20sm119652pfk.46.2021.04.28.08.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 08:34:29 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v3 mptcp-next 4/4] selftests: mptcp: add deny_join_id0 testcases
Date: Wed, 28 Apr 2021 23:34:17 +0800
Message-Id: <27fb0c4de87cc7e2c1d015538fa6bd5d95e9ac6b.1619623735.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <45fac7966d2bfeae3027a9105ba9a6a2f35d6029.1619623735.git.geliangtang@gmail.com>
References: <cover.1619623735.git.geliangtang@gmail.com> <952b920c38ab98adfdb77a0e941ff43c05461a0d.1619623735.git.geliangtang@gmail.com> <972a77ea8b999cd2e0f8e32912156d5ac4b9a17e.1619623735.git.geliangtang@gmail.com> <45fac7966d2bfeae3027a9105ba9a6a2f35d6029.1619623735.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new argument '-d' for mptcp_join.sh script, to invoke
the testcases for the MP_CAPABLE 'C' flag.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 55 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fd99485cf2a4..feabc3ab88eb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -124,6 +124,17 @@ reset_with_add_addr_timeout()
 		-j DROP
 }
 
+reset_with_allow_join_id0()
+{
+	local ns1_enable=$1
+	local ns2_enable=$2
+
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns1_enable
+	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
+}
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -1374,6 +1385,43 @@ syncookies_tests()
 	chk_add_nr 1 1
 }
 
+deny_join_id0_tests()
+{
+	# subflow allow join id0 ns1
+	reset_with_allow_join_id0 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "single subflow allow join id0 ns1" 1 1 1
+
+	# subflow allow join id0 ns2
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "single subflow allow join id0 ns2" 0 0 0
+
+	# signal address allow join id0 ns1
+	reset_with_allow_join_id0 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal address allow join id0 ns1" 1 1 1
+	chk_add_nr 1 1
+
+	# signal address allow join id0 ns2
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal address allow join id0 ns2" 1 1 1
+	chk_add_nr 1 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1387,6 +1435,7 @@ all_tests()
 	backup_tests
 	add_addr_ports_tests
 	syncookies_tests
+	deny_join_id0_tests
 }
 
 usage()
@@ -1403,6 +1452,7 @@ usage()
 	echo "  -b backup_tests"
 	echo "  -p add_addr_ports_tests"
 	echo "  -k syncookies_tests"
+	echo "  -d deny_join_id0_tests"
 	echo "  -c capture pcap files"
 	echo "  -h help"
 }
@@ -1434,7 +1484,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkch' opt; do
+while getopts 'fsltra64bpkdch' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1469,6 +1519,9 @@ while getopts 'fsltra64bpkch' opt; do
 		k)
 			syncookies_tests
 			;;
+		d)
+			deny_join_id0_tests
+			;;
 		c)
 			;;
 		h | *)
-- 
2.30.2

