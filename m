Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5944B111BC
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h4vSytb+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702974038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ERiB6Pet9ivx6wj4QdFsUs/qDRxTIgiskMJwm/GxbRs=;
	b=h4vSytb++WfoBuK8kEQQaSUgKs8AZ9loEpjp429v2gUkeknLwdgVIX7kY/jCJZRs6INokM
	dNe+ucqytgiC3vapPoXmtrJX+/c8NPYU1Cmmo+mOyvkcI37GnxjgAtD7zu6AwWpOB+T1EP
	2MygQnPkvuqfYjqiNb2C1VLVEaASGuo=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v3 08/14] selftests: mptcp: add check_output helper
Date: Tue, 19 Dec 2023 16:19:19 +0800
Message-Id: <39b18d670f19c9f2c9b0431905c9c8b9167fd85b.1702973751.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702973751.git.geliang.tang@linux.dev>
References: <cover.1702973751.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Similar to check() in pm_netlink.sh, add a new helper check_output()
in mptcp_join.sh to check the output of the given commands.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3a5b63026191..25d3f32644ed 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -21,6 +21,7 @@ cinfail=""
 cinsent=""
 tmpfile=""
 cout=""
+check_output_err=""
 capout=""
 ns1=""
 ns2=""
@@ -186,6 +187,7 @@ init() {
 	cout=$(mktemp)
 	evts_ns1=$(mktemp)
 	evts_ns2=$(mktemp)
+	check_output_err=$(mktemp)
 
 	trap cleanup EXIT
 
@@ -199,6 +201,7 @@ cleanup()
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
 	rm -rf $evts_ns1 $evts_ns2
+	rm -f $check_output_err
 	cleanup_partial
 }
 
@@ -3357,6 +3360,30 @@ userspace_pm_rm_sf()
 	wait_rm_sf $1 "${cnt}"
 }
 
+check_output()
+{
+	local cmd="$1"
+	local expected="$2"
+	local msg="$3"
+	local out=`$cmd 2>$check_output_err`
+	local cmd_ret=$?
+
+	printf "%-42s" "$msg"
+	if [ $cmd_ret -ne 0 ]; then
+		mptcp_lib_print_err "[ FAIL ] command execution '$cmd' stderr "
+		cat $check_output_err
+		ret=${KSFT_FAIL}
+		return $cmd_ret
+	elif [ "$out" = "$expected" ]; then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	else
+		mptcp_lib_print_err "[ FAIL ] expected '$expected' got '$out'"
+		ret=${KSFT_FAIL}
+		return 1
+	fi
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
-- 
2.35.3

