Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA64139B
	for <mptcp@lists.linux.dev>; Sun, 17 Mar 2024 00:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637151; cv=none; b=cqTt9w9vbilnFvltoBZbArhEtRUTF2wciDsdVEoZu3YHUH2DHhF3k3oIu7wOtxT4CEVVPkapz0WxmyY2vdmCrZRSQXsbr1G/uUPfRtS4MjGrN83o/YR1vCjBRxcbQryKMg5Szxaz7ruHFtWoVI4EcKsOYcsFO+8mZeqytZCCofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637151; c=relaxed/simple;
	bh=QWiv38Q4fe8tuiZOaS3XklqP/wtVcoV0FQwjm97jYNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWySTFju5YqSDUwYcwd8ghEt8BTN8PsosceYh/UCL4cKOk0D511gc4Ap9DefBFVjZsjiUAPlcKd0u6LsvPykDC4hYtQQ5wX4ugDmVHJZliUZ2sXTqeyzoRNwSxPlMIe3DTaKhu//rFulutt7RkoNcOixY3lidDN7Q7p9H5mnbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqeKn4GK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqeKn4GK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC5BC433F1;
	Sun, 17 Mar 2024 00:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710637151;
	bh=QWiv38Q4fe8tuiZOaS3XklqP/wtVcoV0FQwjm97jYNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GqeKn4GKHWJV0JfxlbAn4b7WPk85Q071gscwIc6XoHmJDjiR4hH6cgoW5F7v+2ZNP
	 I64wtTEDEdCydmlJ9sg2vq/Wa0oA/ArugAi+i0czXo5WKnU0n9brs40W26Lif7Ugl5
	 xNOGhMXtNUtUKGBA+JTy2lmu6IS1xNVxMpUa4mFhoDBcYYHFOkvQzK/PBZfMZd4mJh
	 lhCmMALQ5Ih/SgjmVINB/pf07wvAvRfnU+8Y8eqeu5fT4A+qLxn05SMtCGxx19iheO
	 9lvWNqQoFXU2ovBp2VcxUisIgVODSPM7/7IGit8oClqfK16TlXuouPvIJwb2bZlxjJ
	 EQX+prza/ntUw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 11/12] selftests: mptcp: ip_mptcp option for more scripts
Date: Sun, 17 Mar 2024 08:58:10 +0800
Message-Id: <9c36f8e5a6c24bd03bd31f0387f0ec8f91ba605c.1710636726.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710636726.git.tanggeliang@kylinos.cn>
References: <cover.1710636726.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds '-i' option for mptcp_sockopt.sh, pm_netlink.sh, and
simult_flows.sh, to use 'ip mptcp' command in the tests instead of
'pm_nl_ctl'. Update usage() correspondingly.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 22 +++++++++++++++++++
 .../testing/selftests/net/mptcp/pm_netlink.sh |  9 ++++++--
 .../selftests/net/mptcp/simult_flows.sh       |  8 +++++--
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 36e81383f0e2..68899a303a1a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -22,6 +22,28 @@ ns1=""
 ns2=""
 ns_sbox=""
 
+usage() {
+	echo "Usage: $0 [ -i ] [ -h ]"
+	echo -e "\t-i: use 'ip mptcp' instead of 'pm_nl_ctl'"
+	echo -e "\t-h: help"
+}
+
+while getopts "hi" option;do
+	case "$option" in
+	"h")
+		usage "$0"
+		exit ${KSFT_PASS}
+		;;
+	"i")
+		mptcp_lib_set_ip_mptcp
+		;;
+	"?")
+		usage "$0"
+		exit ${KSFT_FAIL}
+		;;
+	esac
+done
+
 add_mark_rules()
 {
 	local ns=$1
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 31f7021734fe..b48476d73e9e 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -11,16 +11,21 @@
 ret=0
 
 usage() {
-	echo "Usage: $0 [ -h ]"
+	echo "Usage: $0 [ -i ] [ -h ]"
+	echo -e "\t-i: use 'ip mptcp' instead of 'pm_nl_ctl'"
+	echo -e "\t-h: help"
 }
 
-optstring=h
+optstring=hi
 while getopts "$optstring" option;do
 	case "$option" in
 	"h")
 		usage $0
 		exit ${KSFT_PASS}
 		;;
+	"i")
+		mptcp_lib_set_ip_mptcp
+		;;
 	"?")
 		usage $0
 		exit ${KSFT_FAIL}
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index acc49fa652a2..d0b39c2e38a3 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -27,10 +27,11 @@ capout=""
 size=0
 
 usage() {
-	echo "Usage: $0 [ -b ] [ -c ] [ -d ]"
+	echo "Usage: $0 [ -b ] [ -c ] [ -d ] [ -i]"
 	echo -e "\t-b: bail out after first error, otherwise runs al testcases"
 	echo -e "\t-c: capture packets for each test using tcpdump (default: no capture)"
 	echo -e "\t-d: debug this script"
+	echo -e "\t-i: use 'ip mptcp' instead of 'pm_nl_ctl'"
 }
 
 # This function is used in the cleanup trap
@@ -259,7 +260,7 @@ run_test()
 	fi
 }
 
-while getopts "bcdh" option;do
+while getopts "bcdhi" option;do
 	case "$option" in
 	"h")
 		usage $0
@@ -274,6 +275,9 @@ while getopts "bcdh" option;do
 	"d")
 		set -x
 		;;
+	"i")
+		mptcp_lib_set_ip_mptcp
+		;;
 	"?")
 		usage $0
 		exit ${KSFT_FAIL}
-- 
2.40.1

