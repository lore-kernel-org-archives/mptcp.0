Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F2C1946C
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910862; cv=none; b=pXUwyUAvot3Y2V54FZPIoghM7ezjzvkzxVYY02lulOlSluxm4zrmsJrLGQW1K2QKA9ZXUEtGf0tWKQezlNsp5HimewGuARdE+bWqCj+uuBoCurg1k9JyVXYaTDFgbbPja45Zj+B26Q2lirwZCV39Cwt2Wg+OKmLBCX7i24hNxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910862; c=relaxed/simple;
	bh=Uil6XPcXZUO0oQhVf+9A/tKdEoaEyAMc3M3yo5i3Vgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEsq/yli0cJ7VmNuUf9JaV87cdQfmXfe04J/h9UoMv2lqo37SR2P7RCLrPGBUxnByhxTv2ATuMrvcDyKMR4w7XaRFfHmE0TrsC0NLM0X+x01GB8ouiB65e1DGLHisz62ETB6p0bzMh63PO+i1K001CdTbjxxpGkKiooe0AretiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AButSW+o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AButSW+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD67C43390;
	Wed, 14 Feb 2024 11:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910862;
	bh=Uil6XPcXZUO0oQhVf+9A/tKdEoaEyAMc3M3yo5i3Vgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AButSW+o3R/eCKuxwa/tPKpLr+nDWGfUx8L0vI/ESpKkv9xndVz1ofjTGAHlFDOjO
	 J/+Y6PeC/NdVhb9RFm+3nb2sWhU01/Gd3IE6+ByZauNBFsKcu4Yr9boQm5kt4MqSLX
	 u8h6xwAy8cvLNb9fu4s7+IhJEibGA49pHDF/sQC2kyS/q+xl8SE6X3ixSqUSkrHO5L
	 kV0X5XHq/zSJEK/0FG/UEcnXW7a1SwIvUjLgteyzBUnDMuJ3UetHUW5Qx4unVT2xDO
	 FB9GVvTb4Dq/cjtbrMGh6Ur5Htixk5rn8QpqKoXSV+xeVgBUJpsHRo3yiOWlBFFE2n
	 NTxvJa8etrQjg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 08/15] selftests: mptcp: add check_output helper
Date: Wed, 14 Feb 2024 19:39:59 +0800
Message-Id: <6446092d53bd92ceb77405b5129f38606b901c02.1707910454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707910454.git.tanggeliang@kylinos.cn>
References: <cover.1707910454.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to check() in pm_netlink.sh, add a new helper check_output()
in mptcp_join.sh to check the output of the given commands.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e68b1bc2c2e4..d92d233ddccf 100755
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
 
@@ -3351,6 +3354,30 @@ userspace_pm_rm_sf()
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
2.40.1

