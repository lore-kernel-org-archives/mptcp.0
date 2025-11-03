Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1654502A
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197593; cv=none; b=Lmq2tAJpxZZMs2hcH5i2socnZre++rZ9wUWYqN9D00T/bYPcoJ34IAjch2IKNsl4/hc9RplhExhzEm5vnTjXg2Z2EJfI0Itgl8PDZAKCnOlYzn0LjGxA9ZmRbZoPgZqAUnq0bFtPtDeIr2Rjun4LCyrqo3fZFzRtIXbiYF2xNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197593; c=relaxed/simple;
	bh=ljyGXwfq0oOXZrLe2P2sS7nT3NURSWz4bUh0HRIHF8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cn5VU5iAYEyTGK+QYT4iNcaVH/8kEw7DeUAxH5tOQ8Aypw5SwqIYUUotc2sYdPosIdOIbMn4luX4wkLCapL9s1OIYT/CHnSMk/LXjaBAXjY1KxT3a0oE2L4IJbGpJ+7aWDEWa65HhscJb9k5oDCbta8b087sa1sRYSLDgwWFspE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8Z78CEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8Z78CEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04F7C113D0;
	Mon,  3 Nov 2025 19:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762197593;
	bh=ljyGXwfq0oOXZrLe2P2sS7nT3NURSWz4bUh0HRIHF8o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r8Z78CEgLDu+sCMPzP15AIz0+T9RQksqNdzT2odOUriui5HhH2IoxywaUMogj0wsW
	 7FjMvmgOJ4U2uKHUeq+3yl8ceFLFxdv+0Xhk2G9yIPcYxpaQwS8kEwjaS+Yfhxt58P
	 JajI5BID9dv0iZrPmo6V2KHgqtImxasPP57qAolG0jURM/ZS6ceTz7v9oTdLBiY5UW
	 HZ4BX0GCgh/VF1wjNU4yBjRURtwr4I/eRW2VEk5pnrKQYhjJnYumig7WIP4F9HiLfB
	 Jvt0hmgGAM3tpavgWbknrGV+fPlovUivIUkHTnV+iXcP6qHBShVccEPhASKKj8sJpx
	 91uxOEtVwq+YA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 03 Nov 2025 20:19:32 +0100
Subject: [PATCH mptcp-next 2/5] selftests: mptcp: lib: remove stats files
 args
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-slft-nstat-cache-v1-2-56025c09e56a@kernel.org>
References: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
In-Reply-To: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4498; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ljyGXwfq0oOXZrLe2P2sS7nT3NURSWz4bUh0HRIHF8o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI5GYJm3D/5Vrv2lpD+Rua8kr/CzDuN7oU2zQi02/Fat
 ag8eH5NRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESifjEy3BB0VvDe/zEz32Te
 xFW9F7S+mgZJeb3cxDvrQUtT4Ko3aowM8/8u/3W0YVvBS/WiprMOc4NaeYMnrtuU9vVq0r2CG6U
 dnAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Now that these files are written from MPTCP lib helpers, the stats file
paths are uniformed. Then, no need to specify them from the each
selftest.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  3 +--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 15 ++++++++++-----
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  3 +--
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  3 +--
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index e1f34508490a..4ff2d02429d3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -444,8 +444,7 @@ do_transfer()
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
-		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}" \
-			"/tmp/${listener_ns}.out" "/tmp/${connector_ns}.out"
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 
 		echo
 		cat "$capout"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ee24adbcfb0c..ad0981e0b377 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1088,8 +1088,7 @@ do_transfer()
 
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		fail_test "client exit code $retc, server $rets"
-		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}" \
-			"/tmp/${listener_ns}.out" "/tmp/${connector_ns}.out"
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 		return 1
 	fi
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d03aa817ac27..22ab39749ca2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -106,23 +106,28 @@ mptcp_lib_pr_info() {
 	mptcp_lib_print_info "INFO: ${*}"
 }
 
-# $1-2: listener/connector ns ; $3 port ; $4-5 listener/connector stat file
+mptcp_lib_pr_nstat() {
+	local ns="${1}"
+	local hist="/tmp/${ns}.out"
+
+	cat "${hist}"
+}
+
+# $1-2: listener/connector ns ; $3 port
 mptcp_lib_pr_err_stats() {
 	local lns="${1}"
 	local cns="${2}"
 	local port="${3}"
-	local lstat="${4}"
-	local cstat="${5}"
 
 	echo -en "${MPTCP_LIB_COLOR_RED}"
 	{
 		printf "\nnetns %s (listener) socket stat for %d:\n" "${lns}" "${port}"
 		ip netns exec "${lns}" ss -Menitam -o "sport = :${port}"
-		cat "${lstat}"
+		mptcp_lib_pr_nstat "${lns}"
 
 		printf "\nnetns %s (connector) socket stat for %d:\n" "${cns}" "${port}"
 		ip netns exec "${cns}" ss -Menitam -o "dport = :${port}"
-		[ "${lstat}" != "${cstat}" ] && cat "${cstat}"
+		[ "${lns}" != "${cns}" ] && mptcp_lib_pr_nstat "${cns}"
 	} 1>&2
 	echo -en "${MPTCP_LIB_COLOR_RESET}"
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 343615908558..42d533b95ec7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -198,8 +198,7 @@ do_transfer()
 	print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
-		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}" \
-			"/tmp/${listener_ns}.out" "/tmp/${connector_ns}.out"
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 
 		mptcp_lib_result_fail "transfer ${ip}"
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index fbd1685d1adc..503cb59571a4 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -200,8 +200,7 @@ do_transfer()
 	fi
 
 	mptcp_lib_pr_fail "client exit code $retc, server $rets"
-	mptcp_lib_pr_err_stats "${ns3}" "${ns1}" "${port}" \
-		"/tmp/${ns3}.out" "/tmp/${ns1}.out"
+	mptcp_lib_pr_err_stats "${ns3}" "${ns1}" "${port}"
 	ls -l $sin $cout
 	ls -l $cin $sout
 

-- 
2.51.0

