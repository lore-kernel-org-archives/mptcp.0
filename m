Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58BBA923
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 04:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707797684; cv=none; b=f8d6t0qNBQZdEoWRDQwNAb7EtWX3jvTF+tPED1GaYFKyRNnoFtVSfV5/CK9b3fPrQHkSP/fVA5TcbdEApr20RqFIRMq0uDb2PtiYORCW+P7F2zgkQO8ADaiiKjFwW6k+MaoMV5EWu+29oMIE64erMJlC0cBBpW58qf1D6vFL2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707797684; c=relaxed/simple;
	bh=YKo5QkEnKiFzKdLEwklZRSdVPoqrxs9UOO3iTW4tMMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FdejnZFMl4aH2LUpFEaM8jmJw/OXREVbm1rH6O1hO4OGmC1Syfe8UQgI82ACh7FFZ/JbO5LOqj/eSR4sdfsevwUBeB5Y5K3gItao1A8ByyVqIPI9s8njmIyd0gzAdwSc3qxcweh7PKO3h0cwIM5i87QcwUzDR+3FpSdAI/rVEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4L5FJ01; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4L5FJ01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DE3C433C7;
	Tue, 13 Feb 2024 04:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707797683;
	bh=YKo5QkEnKiFzKdLEwklZRSdVPoqrxs9UOO3iTW4tMMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4L5FJ01gyGHMXkrcfnVfOiR7kIetNomav/54sjL2zKjt/eRZl7sdwQPaIgcCZElE
	 ggV35RCWlNzgbMPmECNFU3Hy4VjKs9WlXZ2Ikp2FIEpAGDZE79I2LJ6N+KhxMYGFzc
	 uBTFCWZDCb80HVLueWRAjyZmPBZfRBWWJ01roxqwHA9Tdb8KKYQb1+TNA3/adz1gHp
	 f7VPrkn27EpGiP2eM/DbcpcDTMMpWgfdVygbpYXRoeYsBE2nno/qid5MbvGphOEk6f
	 ZucDmYxwmImlfe2Mp6Mlbpp/BSfq5DDeB9Nvenie6qa7hLD/qjbZiJSzAh3Y9YNN85
	 QvWV3WGHoV4DQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 3/5] selftests: mptcp: add ss mptcp support checks
Date: Tue, 13 Feb 2024 12:14:26 +0800
Message-Id: <8f1e695491d199be96ea6a7a9e38ffd45a30388b.1707797566.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707797566.git.tanggeliang@kylinos.cn>
References: <cover.1707797566.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Commands 'ss -M' are used in scripts mptcp_connect.sh, mptcp_join.sh,
and mptcp_sockopt.sh to display only MPTCP sockets. So it must be checked
if ss tool supports MPTCP in these script.

Fixes: 767389c8dd55 ("selftests: mptcp: dump more info on errors")
Fixes: c2a55e8fd80f ("selftests: mptcp: dump more info on mpjoin errors")
Fixes: dc65fe82fb07 ("selftests: mptcp: add packet mark test case")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 ++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 6 ++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7898d62fce0b..c49351d85cae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -154,6 +154,12 @@ if [ $? -ne 0 ];then
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
index c07386e21e0a..5ca1512c3eae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -161,6 +161,12 @@ check_tools()
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
index c643872ddf47..1b6ecbeda5a1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -96,6 +96,12 @@ if [ $? -ne 0 ];then
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
2.40.1

