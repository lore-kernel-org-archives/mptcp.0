Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001C2F83
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MvQWXLRjd7uUl9+Ukn3rnSg1SuoaDCf/3c94cZpa0GM=;
	b=c9sta1Tp/dCTzOsU7erhabkKLvjRZXIEnQLaUwaHwatpslnqwRZ56QAa5AefvhtoHcSI0z
	wIh4J7rnzDR2//st/vPCKOjsWtu6QcFif9ulktYaOM0reeSMvp+e4+DO/jCCgIr7IgzsSm
	TX7SjxQAFi5+b0bznj4vXcpGBJWCKEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-YbYUlTLlM3m5Ldcdpxls3w-1; Wed, 21 Apr 2021 16:21:06 -0400
X-MC-Unique: YbYUlTLlM3m5Ldcdpxls3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61435343A9;
	Wed, 21 Apr 2021 20:21:05 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6EBC16085A;
	Wed, 21 Apr 2021 20:21:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 21/21] selftests: mptcp: enable checksum in mptcp_join.sh
Date: Wed, 21 Apr 2021 22:18:10 +0200
Message-Id: <9cf9acd3f435ca3812d6491d14b9cfd37c3c44bf.1619035356.git.pabeni@redhat.com>
In-Reply-To: <cover.1619035356.git.pabeni@redhat.com>
References: <cover.1619035356.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

From: Geliang Tang <geliangtang@gmail.com>

This patch added a new argument "-C" for the mptcp_join.sh script to set
the sysctl checksum_enabled to 1 in ns1 and ns2 to enable the data
checksum.

In chk_join_nr, check the counter of the mib for the data checksum.

Also added a new argument "-S" for the mptcp_join.sh script to start the
test cases that verify the checksum handshake:

  * Sender and listener both have checksums off
  * Sender and listener both have checksums on
  * Sender checksums off, listener checksums on
  * Sender checksums on, listener checksums off

The output looks like this:

 01 checksum test 0 0                  sum[ ok ] - csum  [ ok ]
 02 checksum test 1 1                  sum[ ok ] - csum  [ ok ]
 03 checksum test 0 1                  sum[ ok ] - csum  [ ok ]
 04 checksum test 1 0                  sum[ ok ] - csum  [ ok ]
 05 no JOIN                            syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       sum[ ok ] - csum  [ ok ]
 06 single subflow, limited by client  syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       sum[ ok ] - csum  [ ok ]

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 107 +++++++++++++++++-
 1 file changed, 103 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fd99485cf2a4..ef8341c851f7 100755
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
@@ -124,6 +128,17 @@ reset_with_add_addr_timeout()
 		-j DROP
 }
 
+reset_with_checksum()
+{
+	local ns1_enable=$1
+	local ns2_enable=$2
+
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
+	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
+}
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -476,6 +491,45 @@ run_tests()
 	fi
 }
 
+chk_csum_nr()
+{
+	local msg=${1:-""}
+	local count
+	local dump_stats
+
+	if [ ! -z "$msg" ]; then
+		printf "%02u" "$TEST_COUNT"
+	else
+		echo -n "  "
+	fi
+	printf " %-36s %s" "$msg" "sum"
+	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDSSCsumErr | awk '{print $2}'`
+	[ -z "$count" ] && count=0
+	if [ "$count" != 0 ]; then
+		echo "[fail] got $count data checksum error[s] expected 0"
+		ret=1
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+	echo -n " - csum  "
+	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDSSCsumErr | awk '{print $2}'`
+	[ -z "$count" ] && count=0
+	if [ "$count" != 0 ]; then
+		echo "[fail] got $count data checksum error[s] expected 0"
+		ret=1
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
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
@@ -523,6 +577,9 @@ chk_join_nr()
 		echo Client ns stats
 		ip netns exec $ns2 nstat -as | grep MPTcp
 	fi
+	if [ $checksum -eq 1 ]; then
+		chk_csum_nr
+	fi
 }
 
 chk_add_nr()
@@ -1374,6 +1431,37 @@ syncookies_tests()
 	chk_add_nr 1 1
 }
 
+checksum_tests()
+{
+	# checksum test 0 0
+	reset_with_checksum 0 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_csum_nr "checksum test 0 0"
+
+	# checksum test 1 1
+	reset_with_checksum 1 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_csum_nr "checksum test 1 1"
+
+	# checksum test 0 1
+	reset_with_checksum 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_csum_nr "checksum test 0 1"
+
+	# checksum test 1 0
+	reset_with_checksum 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_csum_nr "checksum test 1 0"
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1387,6 +1475,7 @@ all_tests()
 	backup_tests
 	add_addr_ports_tests
 	syncookies_tests
+	checksum_tests
 }
 
 usage()
@@ -1403,7 +1492,9 @@ usage()
 	echo "  -b backup_tests"
 	echo "  -p add_addr_ports_tests"
 	echo "  -k syncookies_tests"
+	echo "  -S checksum_tests"
 	echo "  -c capture pcap files"
+	echo "  -C enable data checksum"
 	echo "  -h help"
 }
 
@@ -1418,13 +1509,16 @@ make_file "$sin" "server" 1
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
@@ -1434,7 +1528,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkch' opt; do
+while getopts 'fsltra64bpkchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1469,8 +1563,13 @@ while getopts 'fsltra64bpkch' opt; do
 		k)
 			syncookies_tests
 			;;
+		S)
+			checksum_tests
+			;;
 		c)
 			;;
+		C)
+			;;
 		h | *)
 			usage
 			;;
-- 
2.26.2

