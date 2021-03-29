Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139876F
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:48 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so5706442pjg.5
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zznaWsjWT7GzfWDIUkgAMr8RnCnd72vJQXQnzszEOZw=;
        b=CLnx3ZBCtNPaumnyWOt/EIPTzpXO75ER3b2EMVprSiv4Rr6XxbzzHg4TwkMwAxEgxL
         U82xIEFb9EngDNBSc1ayJBE9vsYE3b92hKmqFikHdOYTtu1vkaX52edmxI6vpp9N1+Fv
         5KzBRtXTVeRFDbI7oH+1PwU2jTqnZeRsPORVHDAznZ4nYjilLEUDEOIzYyok+14PMsMl
         a90nUU40pRJ9nlH046aSnki/BxIOUykieC39yYgKxVGEo/pvjQZVUEj5vFX7DuAd6Gt4
         jdXIcsxpx8Ir2srL6yq1pyAfSkUFMoRXENG7Vb8CTR1e7KDtPgK50esvW3YNn2Xqz5ZX
         VqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zznaWsjWT7GzfWDIUkgAMr8RnCnd72vJQXQnzszEOZw=;
        b=r7pNuHQkseABUqrGhpuE4q+Mi+LgqqpFtJi8495HcnW6gVWXk8/Ob1qPhTPQBTBAsU
         LwAbhwSbALd+UMXR/hdhyNEwmWk4K6x4Hk24deeD8iNqs8ueAgOXXONEBWnpZUZzJ05o
         0Kv7YTEu2tmgJrvcKcx8S7tBdJEL6OqqYaPDZpR5UmKl6fod/JGJsFfKWcwzKVTRxygV
         8E0LunFNQK8SVH5Ec0XWT018VPREmA+s7UWn8Ud8auQ6kcvnjvp7MvMc81cL2A5H15Mo
         A7WxGMYYxpatNpVpGsagOY0zraLfPCGD0c9+3tcTMrc0HBGuY2v8+DIpclelvMcQVtoi
         el/w==
X-Gm-Message-State: AOAM533uv1C5GnCzLo3JIXSrph7u2CF+wdLQUqKJb0SD9gUXurkNm+yI
	V1NVGViZRH5bwWuLumBQ2q2lbLFglmIOpQ==
X-Google-Smtp-Source: ABdhPJxd6jC+qAyHIrzXZn2JDoNxsbuThDbkPDmtRk+YXJGH2hSVHTf0eMSfn3L0cvGl2b/13C8kkg==
X-Received: by 2002:a17:902:c154:b029:e5:e7cf:9627 with SMTP id 20-20020a170902c154b02900e5e7cf9627mr27710810plj.68.1617014507328;
        Mon, 29 Mar 2021 03:41:47 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id y4sm16132019pfn.67.2021.03.29.03.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:46 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 16/16] selftests: mptcp: enable checksum in mptcp_join.sh
Date: Mon, 29 Mar 2021 18:40:47 +0800
Message-Id: <3e75bdccce3b88e974ffc3f90a9b7b74ac6b067c.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <fa2e5e2e8eee03798175cc42e73810518b47d29b.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com>
 <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com>
 <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com>
 <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com>
 <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com>
 <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com>
 <1c0a240472edcc1afbcb822bd9af3cf03800759e.1617014019.git.geliangtang@gmail.com>
 <4c7e346e9d1005e8838dd8cf742d8324ef7553c0.1617014019.git.geliangtang@gmail.com>
 <4a289b981d90fcfda872ade12ec94d27d47bc01f.1617014019.git.geliangtang@gmail.com>
 <07856073b42a0343f81e6b6e468d6965b693fc5d.1617014019.git.geliangtang@gmail.com>
 <95dff6615e84496cab649de3d74917790f6a571f.1617014019.git.geliangtang@gmail.com>
 <44262de5d6a76c02e585ba148117af9b81355d0d.1617014019.git.geliangtang@gmail.com>
 <5364f608199436bf7125d8f89a4fefcaad2b5eb3.1617014019.git.geliangtang@gmail.com>
 <c231d3aa6b38374c1e28709e4d4b94e179c6e13c.1617014019.git.geliangtang@gmail.com>
 <fa2e5e2e8eee03798175cc42e73810518b47d29b.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new argument "C" for mptcp_join.sh script to set the
sysctl checksum_enabled to 1 to enable the data checksum.

In chk_join_nr, check the counter of the mib for the data checksum.

The output looks like this:

 01 no JOIN                            syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       sum[ ok ] - csum  [ ok ]
 02 single subflow, limited by client  syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       sum[ ok ] - csum  [ ok ]

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 40 +++++++++++++++++--
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fd99485cf2a4..b98ff993bcfe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,6 +12,7 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
 capture=0
+checksum=0
 do_all_tests=1
 
 TEST_COUNT=0
@@ -49,6 +50,9 @@ init()
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
+		if [ $checksum -eq 1 ]; then
+			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
+		fi
 	done
 
 	#  ns1              ns2
@@ -517,6 +521,28 @@ chk_join_nr()
 	else
 		echo "[ ok ]"
 	fi
+	if [ $checksum -eq 1 ]; then
+		printf "%-39s %s" " " "sum"
+		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDSSCsumErr | awk '{print $2}'`
+		[ -z "$count" ] && count=0
+		if [ "$count" != 0 ]; then
+			echo "[fail] got $count data checksum error[s] expected 0"
+			ret=1
+			dump_stats=1
+		else
+			echo -n "[ ok ]"
+		fi
+		echo -n " - csum  "
+		count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDSSCsumErr | awk '{print $2}'`
+		[ -z "$count" ] && count=0
+		if [ "$count" != 0 ]; then
+			echo "[fail] got $count data checksum error[s] expected 0"
+			ret=1
+			dump_stats=1
+		else
+			echo "[ ok ]"
+		fi
+	fi
 	if [ "${dump_stats}" = 1 ]; then
 		echo Server ns stats
 		ip netns exec $ns1 nstat -as | grep MPTcp
@@ -1404,6 +1430,7 @@ usage()
 	echo "  -p add_addr_ports_tests"
 	echo "  -k syncookies_tests"
 	echo "  -c capture pcap files"
+	echo "  -C enable data checksum"
 	echo "  -h help"
 }
 
@@ -1418,13 +1445,16 @@ make_file "$sin" "server" 1
 trap cleanup EXIT
 
 for arg in "$@"; do
-	# check for "capture" arg before launching tests
+	# check for "capture/checksum" args before launching tests
 	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"c"[0-9a-zA-Z]*$ ]]; then
 		capture=1
 	fi
+	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"C"[0-9a-zA-Z]*$ ]]; then
+		checksum=1
+	fi
 
-	# exception for the capture option, the rest means: a part of the tests
-	if [ "${arg}" != "-c" ]; then
+	# exception for the capture/checksum options, the rest means: a part of the tests
+	if [ "${arg}" != "-c" ] && [ "${arg}" != "-C" ]; then
 		do_all_tests=0
 	fi
 done
@@ -1434,7 +1464,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkch' opt; do
+while getopts 'fsltra64bpkchC' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1471,6 +1501,8 @@ while getopts 'fsltra64bpkch' opt; do
 			;;
 		c)
 			;;
+		C)
+			;;
 		h | *)
 			usage
 			;;
-- 
2.30.2

