Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC55F14F6F
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d4DxseCw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yhmzt2uJ/3/WEUlr/OF15tMloJsv0oiYV/qEInGAMLQ=;
	b=d4DxseCwLygEfemF3W8FsOrLAYwZl6swDl421JoFBklT09ITjwCfHvKJtcUeS8sryn4rc/
	PclNmXv9qB4BhW+NkS0tswrpaesRFn/+GdaZ8+sOJCJMDP71gbTIH7CHpGxbs6h2DGuRcR
	3o7tcP1h3svx2Xaah3a3tcFfCrroWes=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 17/33] selftests: mptcp: connect: add PORT instead of TEST_COUNT
Date: Tue,  5 Dec 2023 15:01:04 +0800
Message-Id: <344a857e9bab13204de27b46797f1b3e1edc221c.1701759405.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1701759405.git.geliang.tang@linux.dev>
References: <cover.1701759405.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds a new counter 'PORT' instead of TEST_COUNT to increase
port numbers in mptcp_connect.sh.

This can avoid outputting discontinuous test counters.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index e566b57d5cc1..8e28e9859415 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -28,6 +28,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+PORT=0
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -305,8 +306,9 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+$TEST_COUNT))
+	port=$((10000+$PORT))
 	TEST_COUNT=$((TEST_COUNT+1))
+	PORT=$((PORT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
 		extra_args="$extra_args -R $rcvbuf"
@@ -688,7 +690,7 @@ EOF
 
 	mptcp_lib_print_info "INFO: test $msg"
 
-	TEST_COUNT=10000
+	PORT=10000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.35.3

