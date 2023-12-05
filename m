Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772AB12B76
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kUclUfIU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Gk1W+dPOV80/N51poqyCbbPZJTcpffkAQ97qEF4I/8=;
	b=kUclUfIURqvMhFL5syS+8mj4pv6NFXs1hxouVfjOCmM7BsOl2yj3YwkvUJW0/WRwTVcjRJ
	3FJpi3S3ZCCfME9kuNioWPsVUe7zHvLAnT8e8QTkg5Wr0a94JLjLc3WJ/lqk1n4Qhm7wPh
	IfNBFNVuWV4/HXVXL5T9/9k2Oo0zQjo=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 10/33] selftests: mptcp: add ss mptcp support checks
Date: Tue,  5 Dec 2023 15:00:57 +0800
Message-Id: <2afa3057efa52aee85c01acccca8b6a2341ec13f.1701759405.git.geliang.tang@linux.dev>
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

Commands 'ss -M' are used in scripts mptcp_connect.sh, mptcp_join.sh,
and mptcp_sockopt.sh to display only MPTCP sockets. So it must be checked
if ss tool supports MPTCP in these script.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 ++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 6 ++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index e19b1fe67408..b554c2e9750e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -145,6 +145,12 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
+ss -h | grep -q MPTCP
+if [ $? -ne 0 ];then
+	echo "SKIP: ss tool does not support MPTCP"
+	exit $ksft_skip
+fi
+
 sin=$(mktemp)
 sout=$(mktemp)
 cin=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7dec65a5ed75..57a9ea9db2ec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -141,6 +141,12 @@ check_tools()
 		exit $ksft_skip
 	fi
 
+	ss -h | grep -q MPTCP
+	if [ $? -ne 0 ];then
+		echo "SKIP: ss tool does not support MPTCP"
+		exit $ksft_skip
+	fi
+
 	# Use the legacy version if available to support old kernel versions
 	if iptables-legacy -V &> /dev/null; then
 		iptables="iptables-legacy"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ff49ee9b9cc2..2c11cad6b607 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -85,6 +85,12 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
+ss -h | grep -q MPTCP
+if [ $? -ne 0 ];then
+	echo "SKIP: ss tool does not support MPTCP"
+	exit $ksft_skip
+fi
+
 # Use the legacy version if available to support old kernel versions
 if iptables-legacy -V &> /dev/null; then
 	iptables="iptables-legacy"
-- 
2.35.3

