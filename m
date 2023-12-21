Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A746BB58
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nWPHrLl8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703158415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQPh6opO3nQrxrMG0C3/2eiQCZkfXs3ArfsYbhnGZUo=;
	b=nWPHrLl8qPY4d57B2s5PSnDOvDoxrD6T1z8717yDec15VwZIC7R/MRPPcYDyB5LJoNCrIM
	HvHGm3r1kw4u99/jfVyMPVJIOXGDyFcoy7WE0FFuLgtDaC02vCNdMauQXzNk1ISVhJzSHJ
	hP5Mxv0AZNbPmW8LC0FrqZ+/3+b6MJg=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 12/15] selftests: mptcp: add ss mptcp support checks
Date: Thu, 21 Dec 2023 19:31:15 +0800
Message-Id: <3703ecf29474dcec0d376f1888f3d5b4fd0d4d4b.1703158128.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703158128.git.geliang.tang@linux.dev>
References: <cover.1703158128.git.geliang.tang@linux.dev>
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
index 8a4fda253ee9..c5456066ef55 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -144,6 +144,12 @@ if [ $? -ne 0 ];then
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
index 50ef210894eb..ee514d056f0d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -142,6 +142,12 @@ check_tools()
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
index 1982078b2b45..760a024e5b14 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -84,6 +84,12 @@ if [ $? -ne 0 ];then
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

