Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD90710E3
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 01:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121749; cv=none; b=VAikYQKsZpV1bDkhvNyWO59JNAXuLgHf44myASeT4fSrtMJIIzIC40vJ0K4LS2BFsdqqSa3usJQh59N44HpfIMUE5BJvRPCBXkhUvQjWjNwYI6ZFr5QMVaho2rPwGHedemkjD2o9QPTFO0RRCkwd3KVgQKwx/uHW3yhpDearSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121749; c=relaxed/simple;
	bh=Agq2MimJBt7kTMS64kfA5TLKPOMVxzDK6h2Zcfsud+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ExLdTeyzFuNBGUCn+dYA6bi/oJwfUWCvwHsU7jkUIz7MFIMHPGa96AGKfACvE8K3vgs4ciLmn1bFHDHMhSA1CZ7272+MCjlzwVPRkkn7VMBFFw4jnZycaAiUqnnKngWfakBuheKuYlFG56BObTcokCgpRTBAoy29CwV2NpLXpAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZo1rsNy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZo1rsNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3816CC433C7;
	Mon, 11 Mar 2024 01:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710121749;
	bh=Agq2MimJBt7kTMS64kfA5TLKPOMVxzDK6h2Zcfsud+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZo1rsNyStu+VfBCAb6FfpWq+pFG49xmtrTQC7zXLUoJ7zexwv/SazP4S88tbCGWB
	 qy0ig7bXhgb40Wj6kzoQhyF/pQ1DgfraRBz4UEPKD3xVjtJOd51nk1do6Ypb+I0Ez9
	 2J05G7euGehZ9WcTy7s2kktIB+4g0nSGV+z/fCmSepQuIXxdURZIjlFIIuSdaOcjHa
	 XUfy5X8/CgbwXmUDRWtJfTqyyY0MDXOM/6HW82YdC6QxXFlnWyUf+0qDNHk8W184KS
	 YcuCJHN+J7wZ2k8BPjOCyu03WUaWP2G8dIPMiLA2Nf6Xnxc089/rWfqZsUO5CuiFPe
	 c7lNAk/6dbXFQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 09/10] selftests: mptcp: add ip_mptcp option for more scripts
Date: Mon, 11 Mar 2024 09:48:46 +0800
Message-Id: <912bbd3e2158f5bb4f189a16416169090501395b.1710121590.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710121590.git.tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
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
index 84cf00f8bb7f..bc315e04b267 100755
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
index 183146e58ec2..5cffc748ee2f 100755
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
index 2cacd3ed9955..d2c38b183b7f 100755
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

