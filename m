Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A015C2569
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645462473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wHxivpAhOyJTP0gmeN2cbQpML6aHErtOTYK8YfzgirM=;
	b=VbQwwiFW9kzMe4k5YYqPJkX8LiJgdo0ktEt5NpvDr1Z6dqcxrd6NBEX3awVFxUWf0+b2g0
	58ObVGp0osBkBsQnaXcKRFtiIaA91TxCAA74egWEYl0O2Mv0J/+QDR+QuMzcwqXpFtzY3A
	oJVqGPe/E+IN8vgxTrPP6CT0IJcy/PM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-ZKvErc5aMq2CGcrqUWEkyw-1; Mon, 21 Feb 2022 11:54:32 -0500
X-MC-Unique: ZKvErc5aMq2CGcrqUWEkyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E556814243
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 16:54:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D585284A29
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 16:54:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] Squash-to: "mptcp: more careful RM_ADDR generation"
Date: Mon, 21 Feb 2022 17:54:13 +0100
Message-Id: <a38625a058afb93ca629e300124cfc07a0bc43fa.1645462092.git.pabeni@redhat.com>
Precedence: bulk
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

When the self-tests flushed the subflows on both sides of
the MPTCP connections, the number of subflows actually deleted
on each side is unreliable.

The test code always flushes  first the client side, but the
actual delete operations is performed asynchronously, and one
on more subflows could be processed after that the other end
already deleted it.

The grand total of the deleted subflows is expected to be
in the [nr_subflows: 2* nr_subflows] range.

Address the issue checking the total number of deleted subflows
in the simult flush cases and enforcing the above constraint

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 39 ++++++++++++++++---
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8e6a5292175a..58320856a392 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1130,16 +1130,24 @@ chk_rm_nr()
 {
 	local rm_addr_nr=$1
 	local rm_subflow_nr=$2
-	local invert=${3:-""}
+	local invert
+	local simult
 	local count
 	local dump_stats
 	local addr_ns
 	local subflow_ns
 
+	shift 2
+	while [ -n "$1" ]; do
+		[ "$1" = "invert" ] && invert=true
+		[ "$1" = "simult" ] && simult=true
+		shift
+	done
+
 	if [ -z $invert ]; then
 		addr_ns=$ns1
 		subflow_ns=$ns2
-	elif [ $invert = "invert" ]; then
+	elif [ $invert = "true" ]; then
 		addr_ns=$ns2
 		subflow_ns=$ns1
 	fi
@@ -1158,6 +1166,25 @@ chk_rm_nr()
 	echo -n " - sf    "
 	count=`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}'`
 	[ -z "$count" ] && count=0
+	if [ -n "$simult" ]; then
+		local cnt=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
+		local suffix
+
+		# in case of simult flush, the subflow removal count on each side is
+		# unreliable
+		[ -z "$cnt" ] && cnt=0
+		count=$((count + cnt))
+		[ "$count" != "$rm_subflow_nr" ] && suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
+		if [ $count -ge "$rm_subflow_nr" ] && \
+		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
+			echo "[ ok ] $suffix"
+		else
+			echo "[fail] got $count RM_SUBFLOW[s] expected in range [$rm_subflow_nr:$((rm_subflow_nr*2))]"
+			ret=1
+			dump_stats=1
+		fi
+		return
+	fi
 	if [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
 		ret=1
@@ -1646,7 +1673,7 @@ remove_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows and signal" 3 3 3
 	chk_add_nr 1 1
-	chk_rm_nr 1 1 invert
+	chk_rm_nr 1 3 invert simult
 
 	# subflows flush
 	reset
@@ -1657,7 +1684,7 @@ remove_tests()
 	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows" 3 3 3
-	chk_rm_nr 0 3
+	chk_rm_nr 0 3 simult
 
 	# addresses flush
 	reset
@@ -1669,7 +1696,7 @@ remove_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush addresses" 3 3 3
 	chk_add_nr 3 3
-	chk_rm_nr 3 3 invert
+	chk_rm_nr 3 3 invert simult
 
 	# invalid addresses flush
 	reset
@@ -1953,7 +1980,7 @@ add_addr_ports_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
 	chk_join_nr "flush subflows and signal with port" 3 3 3
 	chk_add_nr 1 1
-	chk_rm_nr 1 1 invert
+	chk_rm_nr 1 3 invert simult
 
 	# multiple addresses with port
 	reset
-- 
2.34.1

