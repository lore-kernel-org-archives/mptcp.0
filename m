Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551B50A73
	for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832596; cv=none; b=E9sRqFmuRohzZGaMFM0YdT65u9gB8RLCxFzi50pIfeZ5saf0FEhaGxgtHi3E8Kq93h4fORO+GU8jSo3/zZa1rgOWMXlMvw1jJFSNdqkgn3hb51yliOyTmDsluOegS6+EYvIEGqWoP/4UQU6WXZ43y98VIP6M6YSbrv9dUFp13Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832596; c=relaxed/simple;
	bh=B1xC2MwNl6pjqglDQrdOpZKw860weyNFCTwgKDnepw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OH+lOw3CTQufSNpd3QxVCuOau7hyhlOHfrAIgW9ojAdYbgvVDIOl8OZdSPRQVxA+qSvbGMvdZW+TbJSWf4aVQ3F/3fTfeTb64EwG8Yn2iZP4BbpD1Wa4g73uplvKz//lA/ceVhb0HhlCGIzV/vFPHYZr7NLBSPTYuXAw2MzqSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piM9IZbx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piM9IZbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090B1C433F1;
	Tue, 19 Mar 2024 07:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710832596;
	bh=B1xC2MwNl6pjqglDQrdOpZKw860weyNFCTwgKDnepw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=piM9IZbxsLzwpa0KnwPhmJIgHjR+Zp3bgJ15E0cKSKrCZAJrLPSsOtN4dYduYUWsm
	 /1dIkwsqAUbnZpYmd1lgkBVBu2WW6+VLiD5eIwLCN7zBiYHDTXxNq1FX+PI0cPZJfy
	 5o74QVuShXn0Nk1vsToiT6pC7Z4IybZONHfZrkRDW47LeNrzb/Mxdn4rNBtRIJUAzW
	 DCQZIG/StwqD3CWIdkOLfYf3NppY0eQnkIWSot9JR93R2EavLXUf7VU5lYFxNyPATo
	 /pDPV2i0gwXM+yu7ZbmUzV02bH0aG/Fotyvt+e50DgDOrOCx4SPX4ZytOaqz9duMDW
	 MqyOhmBd+qwaA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 8/9] selftests: mptcp: ip_mptcp option for more scripts
Date: Tue, 19 Mar 2024 15:16:14 +0800
Message-Id: <86866b21e3489cb30c87b333083cd48fc67fedc4.1710832493.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710832493.git.tanggeliang@kylinos.cn>
References: <cover.1710832493.git.tanggeliang@kylinos.cn>
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
index d648383989d2..f48d13081d5c 100755
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

