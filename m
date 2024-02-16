Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613B217C6D
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069358; cv=none; b=kFTTTwoOFYbhxtKeQ2hiBY370zCEOmuyYbcUQg26CbToSfmoO8SVk8AVuK4ZWYK1ySnQ4fW5viRvKQEeMHXqwMDyg1RPOxjZsF9UzWru+RcNlX8sg253Wr+LQd+b/7lL0Ok0AIOjyXD47yFg2YVyQ8M3By7Lai2VC0E0r6MYi7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069358; c=relaxed/simple;
	bh=1CIpqj9s8cE27kK05kuEnNFqaioyDYscoQ7EB+FKFG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0pm3HQOV0vmkGxC1HigbQgjjBADs0DlWbmRBIp1u0qRygwtcpWl9avZI67vy252VF50sXQYy2ZOoUwXbleoWOhtZBQ9E4dKdm9CbETtmrNAyKV7r280EbSGNuEb49C/dgIdvDrN1C/OfJkCMAjU45FfJC5FZCIsk58QXdPgzXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg/MP3gx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg/MP3gx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDA1C433F1;
	Fri, 16 Feb 2024 07:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708069358;
	bh=1CIpqj9s8cE27kK05kuEnNFqaioyDYscoQ7EB+FKFG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dg/MP3gxhMo9AJmac04oL4akOykqINAbARtyQjrPYSPbHfYFF/YUXv5wk04YCtdCy
	 hliHJYedtuhY3G+c2Dt/EtvqUxX1SIIz4VyULxCYVu2bnQzZws7xvKCjCRO9MiPwri
	 7PvDDfwOH+8EkD0VRJzf0ahsIqRC+HMZAYDzE2kUOu0QY0iz9Z9dbMOIwmOHLzO5TM
	 bu1XcaybHU/E+g+IxGJvIxLYkGD36bqq0VnVVTJtTmHhLnBLwiyKyUzxxzuvay6gPm
	 8K1y5fochEjhA4gQq9QHFrH7qUDWV8rugFgs/hGLiOTIs/bskROrpMsrWprSUvSdUo
	 qm7BwzTY4gfVQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 08/14] selftests: mptcp: add check_output helper
Date: Fri, 16 Feb 2024 15:42:10 +0800
Message-Id: <203718fd9b34ac092a198737bed0e36baa447d69.1708069036.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708069036.git.tanggeliang@kylinos.cn>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
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
index b807e2a42c61..6f7e83f61707 100755
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
@@ -182,6 +183,7 @@ init() {
 	cout=$(mktemp)
 	evts_ns1=$(mktemp)
 	evts_ns2=$(mktemp)
+	check_output_err=$(mktemp)
 
 	trap cleanup EXIT
 
@@ -195,6 +197,7 @@ cleanup()
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
 	rm -rf $evts_ns1 $evts_ns2
+	rm -f $check_output_err
 	cleanup_partial
 }
 
@@ -3347,6 +3350,30 @@ userspace_pm_rm_sf()
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
+		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "
+		cat $check_output_err
+		ret=${KSFT_FAIL}
+		return $cmd_ret
+	elif [ "$out" = "$expected" ]; then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	else
+		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
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

