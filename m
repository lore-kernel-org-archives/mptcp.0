Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A5471
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 04:48:24 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id k19so4233749pfu.5
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 21:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ao2/Wrrbomw1R5ZvGnpFfM5ao9tL5fForOfn9fjnyYQ=;
        b=kdUi9XXx50pcjt3yEQcNkuqIWgGpiy1w8cXse4OGxydBhzSw9AInSa4+nVXhtR3k91
         AKDq3SwmG6d0vjFlHsgpxYHEmDPXFKztydLN7DyPd8TaTz/9pBY7YbL+gjodUQXmdLe3
         8BhrTCaebK68vYy6O0Av6HKPAJu+s4OrN/MSt+AkADSEOKNa8WDaYvWI3cJYIMwCb5SG
         fNOnh154zRLlc1oaX64XCvtkUzIII5nkd5m5MhUSKGLao2RcHlPl9iC6grCQLGlj5ugz
         1mn53Ws87Jva9318uj02lzezxIh1vkWY4nvYcwqlaXh1H302ousDG7Rx8h4e6RsCuFes
         kI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ao2/Wrrbomw1R5ZvGnpFfM5ao9tL5fForOfn9fjnyYQ=;
        b=eW/vSHEKmCqoD65D+tK6mSu6xMQ053FL0VyEf9hBs25BNRIVYuHZWXeXbF+FsmvF+7
         A3m/Fki62M1c17uM1pCsApFhzrb4GcnW/ck00m6CaQcswVkOr/JrxtbE7R9hNhboigAa
         UY09/vj/kv6TNi2T0CsbqHHhv4n9lWhP2mg4C4hO9AIem8ZrrNQP80DpAnrQxPI+kz7/
         udhLPjcmwaJucSBf+L6GeJIiNXfpCHulvAH7rGOQH1eQv9iPFkH5Hdi5lzK/IzXT1ymv
         EKQ68a2uG9bFUhc1QmfVWrb6T+Yz0i6d5rmMG0QdoAwuVzenFH0vW/844ZJIAoXyS0mn
         gZOg==
X-Gm-Message-State: AOAM533GB/7OSh0VY67dn4mNg8Soms8wxKG+5TNWSTFVE8gFEJhatJEn
	+Z/i20mxiB7LJJ3vRVqUJUEg+DzkNrk=
X-Google-Smtp-Source: ABdhPJwPps8Pgv99D+xRaaf9p8GyzkL0rwFnxPrBb8wlFa6UFFQCE+ECaaPU6l5WlQ7y4eQYO0DUrQ==
X-Received: by 2002:aa7:908c:0:b029:209:aacd:d8b with SMTP id i12-20020aa7908c0000b0290209aacd0d8bmr2667067pfa.74.1620276503668;
        Wed, 05 May 2021 21:48:23 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id u1sm786258pfb.97.2021.05.05.21.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:48:23 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v4 mptcp-next 4/4] selftests: mptcp: add deny_join_id0 testcases
Date: Thu,  6 May 2021 12:48:08 +0800
Message-Id: <ed92394edbba2809ad1efe9316b25343cfcf0ad3.1620275759.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <2b2c8a35b85111f472e735f29166e1f88ecc3909.1620275759.git.geliangtang@gmail.com>
References: <cover.1620275759.git.geliangtang@gmail.com> <025c3e92286c1c425b6ce65b4feac7e416947e54.1620275759.git.geliangtang@gmail.com> <75cdf44b996264eeacf424f60fecd873ebc47d39.1620275759.git.geliangtang@gmail.com> <2b2c8a35b85111f472e735f29166e1f88ecc3909.1620275759.git.geliangtang@gmail.com>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 57 ++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ef8341c851f7..4366fdadacf8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -139,6 +139,17 @@ reset_with_checksum()
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
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
@@ -1462,6 +1473,45 @@ checksum_tests()
 	chk_csum_nr "checksum test 1 0"
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
+	# ADD_ADDRs are not affected by allow_join_id0 value.
+	reset_with_allow_join_id0 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal address allow join id0 ns1" 1 1 1
+	chk_add_nr 1 1
+
+	# signal address allow join id0 ns2
+	# ADD_ADDRs are not affected by allow_join_id0 value.
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
@@ -1476,6 +1526,7 @@ all_tests()
 	add_addr_ports_tests
 	syncookies_tests
 	checksum_tests
+	deny_join_id0_tests
 }
 
 usage()
@@ -1493,6 +1544,7 @@ usage()
 	echo "  -p add_addr_ports_tests"
 	echo "  -k syncookies_tests"
 	echo "  -S checksum_tests"
+	echo "  -d deny_join_id0_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1528,7 +1580,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkchCS' opt; do
+while getopts 'fsltra64bpkdchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1566,6 +1618,9 @@ while getopts 'fsltra64bpkchCS' opt; do
 		S)
 			checksum_tests
 			;;
+		d)
+			deny_join_id0_tests
+			;;
 		c)
 			;;
 		C)
-- 
2.31.1

