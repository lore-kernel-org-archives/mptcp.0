Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775FA2F80
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 07:01:21 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id y62so10452349pfg.4
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 00:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THOLEwhRiEp2K2UoagJ9LmEmB821Rj35Btg2RCkXVtc=;
        b=kiIbTNnad6V/75YNb7y4TKfzLLeCOmZQdkW4KxNnniuGwnPSlu1GYvxvtIgVgmcuKB
         FtfqzWpRrFo5IWJseH+p9+6AG1Y69SKNpwvYxQ1nIq9Ve9QUYbTeYl/5hWgxZ4JKW7UG
         jYWKdoFMJF5oIazjYWyuvOTGSplBgqOZ1JW4/Q1OZxM1NaKdmfIB5cY6Ls367jbvSymi
         zWLkI6iAhpF3wX1Dqkm9i75nvWBcB/EpFveoG3YI/xVgGC1qd8jytrM3fGq4KMAbfcc0
         AEDvjk+cAjuJw5Y0SAj/nyrRIUjsYStF+sd3hmy+tGrQxHTgBu7kcQJwKAop0Jq29Apw
         smSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THOLEwhRiEp2K2UoagJ9LmEmB821Rj35Btg2RCkXVtc=;
        b=E9D2zgBy9n1bsh1sfDl+vt1c1MkXJm39r4AcV2o49arAYKAXe/b/x3XeBnBaM/ytub
         dGc6n4NrpTC1/g0VEYLZBC2AdSH0iCUpebxhxD4+OVLmDPqwVI1/naVJ7FU7QzlUZHUF
         WnFIRKLg1flYEW64zW2hHFZ5dKgoNI87SVe9GGsTJwo7KDR9VmDLEkQJ1p9CG4hDVXca
         CYzzIA3YHrQXHH+y1JQb/wU+feIthrYJJjFas5ZXOMBw+xsaNEVMrrqZgJ60S740Z9dM
         9hfw26nu3hQ23Ry4W/1T0mZOrs+zCZN4+GsWJdtBrnH8g/wuQ1NWftN/hDa/D7pqgS2j
         /Pdg==
X-Gm-Message-State: AOAM533G7OElpVNDotGd83emsNqrjnGR/hEfcik9c/xgI8QnGGu9Rzq1
	GUsl1FKvn/s8k3Ng6RC0i78dFd2q4Lo=
X-Google-Smtp-Source: ABdhPJy2Ls8IqSahR7C5o32KhUx1CKZlDGpLyzB4KYW8qSywYOXiCh7cKK1PtPEauS4/PxVuKv5rnA==
X-Received: by 2002:a63:a19:: with SMTP id 25mr25784829pgk.177.1619593280910;
        Wed, 28 Apr 2021 00:01:20 -0700 (PDT)
Received: from localhost ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id r14sm3989820pjz.43.2021.04.28.00.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 00:01:20 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 4/4] selftests: mptcp: add deny_join_id0 testcases
Date: Wed, 28 Apr 2021 15:01:06 +0800
Message-Id: <a2a791a4a73a6d7c47335d93c88a8be8c199dd5e.1619592361.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <c166cd5a8d0a2357650f0bb83f987deb4140ed23.1619592361.git.geliangtang@gmail.com>
References: <cover.1619592361.git.geliangtang@gmail.com> <51758a7f629764dc91186acbf09665992e5b8e69.1619592361.git.geliangtang@gmail.com> <65d1e4e729dfbeb5d0e51760affe2745e211cb50.1619592361.git.geliangtang@gmail.com> <c166cd5a8d0a2357650f0bb83f987deb4140ed23.1619592361.git.geliangtang@gmail.com>
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

