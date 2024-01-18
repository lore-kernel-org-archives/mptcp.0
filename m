Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4B8F51
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558346; cv=none; b=B6R9eCEIMdjp5np/OCOnsabppvLvxq58N/cPvVscPm+6inhoUWI0R5/u+vnwRS85ghzrt1mjMQ9mMW51hV8XdjjeKtp3a49czK5nVJDrRgH3CqNgSSfwSqxy7QARjfFe8p/fIVkR+2KUNXBeED0ZyBBWEIzNRxYwHvNnKERq6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558346; c=relaxed/simple;
	bh=T9k/GMdCd2AwDOgtpravWZEHCJsp8pFYszNmnMGiuio=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=DkhkqdslrhpvjilNnMXt3ldimWf3AmehXmVbZBAib8F6bn+ANbVTUqMYrxbFhBDjdtoJ4SBqn2T5hpY+4WbBLlpaR9tRd18Z9+MqxLB+qwK6rnFjY8N7qVQOgec/QRKf0Fk9uZduID/wSvI1m4tzjzREpw6zX41QxHXtuZITc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTEdIUAn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTEdIUAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFD3C433F1;
	Thu, 18 Jan 2024 06:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558346;
	bh=T9k/GMdCd2AwDOgtpravWZEHCJsp8pFYszNmnMGiuio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jTEdIUAnWb6zOugydOE9yiAKOhbAXuXay5GfhWyVOhU8acm2OAzNXwp1RH5WddTKx
	 zdTn/UiJgyDA8S/eA97oR1HW9AGMSWZbE0yayYHOIW6Kj3KIC2xKmVhEfG4cvdORW3
	 QCuTdHs8jFeukukAhBUqeHgp/NkPHIoyLcIf9I7Qx/ASm7AawQP8bMEjRLJE3TP2ue
	 nHaCxpE2RRkGNYcqxMJeOpLCFsElccd9CjFrNsvdD3URiz7Ktaj9RwBnnSkKJ+vgtX
	 kwZA/weSU7CkCYeYvzh05xKLietrKu2ZbcMwVaXcaQyeDJgZGdLFLCl8aLkiQMo6BF
	 Uk98LvDSDpj1w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 13/23] selftests: mptcp: add check_output helper
Date: Thu, 18 Jan 2024 14:11:53 +0800
Message-Id: <a7f379ba4bb9802bc7d37c022b0170ddfd299b85.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
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
index 915ec79f5030..f4043baa59c6 100755
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
 
@@ -3358,6 +3361,30 @@ userspace_pm_rm_sf()
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

