Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6227A
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 06:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655362323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=THx0NjOxNkUhsKM+gRYeN5FJwnj/dCCToPdXiCcNG2g=;
	b=i4Bp2FJGamnfl/fyryNo1i8SGyh8pTdw+CI1O3dBk8+lnzGppG9wJtv8r6Du7qsOdSF3ZA
	dZq8AIpKiO+HfJgi1LcK/p25vDHhjzIT+PxDhgvGVMCNGnDfijSf71x4rYtVTYdIn/ZqAJ
	3GQafjGxTqEO0AixJcYXIodcdKXoHX4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-w1epVuvPPgWmWtwfw9HyNg-1; Thu, 16 Jun 2022 02:52:02 -0400
X-MC-Unique: w1epVuvPPgWmWtwfw9HyNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3F8785A581
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 06:52:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6722E2026D2D
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 06:52:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] selftests: mptcp: more stable diag tests
Date: Thu, 16 Jun 2022 08:51:56 +0200
Message-Id: <f318c8ca562695b07272ea3753a52f950555c18a.1655362313.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mentioned test-case still use an hard-coded-len sleep to
wait for a relative large number of connection to be established.

On very slow VM and with debug build such timeout could be exceeded,
causing failures in our CI.

Address the issue polling for the expected condition several times,
up to an unreasonable high amount of time. On reasonably fast system
the self-tests will be faster then before, on very slow one we will
still catch the correct condition.

Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 40 ++++++++++++++++++++---
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 9dd43d7d957b..ee2f238255ec 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -61,6 +61,39 @@ chk_msk_nr()
 	__chk_nr "grep -c token:" $*
 }
 
+wait_msk_nr()
+{
+	local condition="grep -c token:"
+	local expected=$1
+	local timeout=20
+	local msg nr
+	local max=0
+	local i=0
+
+	shift 1
+	msg=$*
+
+	while [ $i -lt $timeout ]; do
+		nr=$(ss -inmHMN $ns | $condition)
+		[ $nr == $expected ] && break;
+		[ $nr -gt $max ] && max=$nr
+		i=$((i + 1))
+		sleep 1
+	done
+
+	printf "%-50s" "$msg"
+	if [ $i -ge $timeout ]; then
+		echo "[ fail ] timeout while expecting $expected max $max last $nr"
+		ret=$test_cnt
+	elif [ $nr != $expected ]; then
+		echo "[ fail ] expected $expected found $nr"
+		ret=$test_cnt
+	else
+		echo "[  ok  ]"
+	fi
+	test_cnt=$((test_cnt+1))
+}
+
 chk_msk_fallback_nr()
 {
 		__chk_nr "grep -c fallback" $*
@@ -184,7 +217,7 @@ for I in `seq 1 $NR_CLIENTS`; do
 	echo "a" | \
 		timeout ${timeout_test} \
 			ip netns exec $ns \
-				./mptcp_connect -p $((I+10001)) -l -w 10 \
+				./mptcp_connect -p $((I+10001)) -l -w 20 \
 					-t ${timeout_poll} 0.0.0.0 >/dev/null &
 done
 wait_local_port_listen $ns $((NR_CLIENTS + 10001))
@@ -193,12 +226,11 @@ for I in `seq 1 $NR_CLIENTS`; do
 	echo "b" | \
 		timeout ${timeout_test} \
 			ip netns exec $ns \
-				./mptcp_connect -p $((I+10001)) -w 10 \
+				./mptcp_connect -p $((I+10001)) -w 20 \
 					-t ${timeout_poll} 127.0.0.1 >/dev/null &
 done
-sleep 1.5
 
-chk_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
+wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
 flush_pids
 
 exit $ret
-- 
2.35.3

