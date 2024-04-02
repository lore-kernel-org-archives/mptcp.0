Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3969458226
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050125; cv=none; b=DEatQIoe9/IwUaGmCbMl4cGzCjeIdUMR/V69Pva59LnVqoLJ+zrgilpCfrKIj9DO07xx3DdZIDbbnglTpaF12KBsgjaJgliIS5JVyPUzZH20u67wBhfa/6aIxNuJPjxwplygRjUV0YqNXzKhOr/5XD0tl5J/SECNL1u7jmXUHhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050125; c=relaxed/simple;
	bh=CX7MsCyfoNrkdYrWOUssbVbe+vug6Wpy8y0RRF56ATY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q0LuhRY7YUMgQVTkqapZgBGciZPfFdg+99PzSaoM0x0Jru497Y8RD0mvzwrLeLYwQDGPwaoVqv/UiGCpKk5VAvJjj9y9xJKOrJz3EPBS7s8ML4A5LGNcuylXjkCROeTzlIOxvxBY9mqebrvLBHn4h6cJIOu2yHUbqc8V/x8sFUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp1l96TZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp1l96TZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F324EC43390;
	Tue,  2 Apr 2024 09:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712050124;
	bh=CX7MsCyfoNrkdYrWOUssbVbe+vug6Wpy8y0RRF56ATY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pp1l96TZoGNFSizd8PU8bWzr0sRWMciUkprjRxPCtqOEW4nQGuVo05snPn3eV9zAB
	 1qQa5U/3ukD5Jg0i5VhBt1mPndfftLY7So21sVWjZNjoQC+3pIXV4nuN95KMkHzxZp
	 dIC4P/tiVYYB3STS7+WyF1nZ+xHVM9zS6wv9DiG1BBKio49rXSUFM8QWbi0Q7DfBYu
	 PwsXGDqXw3JadTB7Ea4wtIlAPspFkiIV3ssqXF5fXNgui2iHXToAmvL7L/9KqL0eqh
	 DdwJvVZYp4VBjSBwk1kS0Wff3oc6ca7yPUUSdV1UJRpZc7CoJhAiQQjkvFnasKn+ES
	 mGLkGNCdUvaVw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/2] selftests: mptcp: test last time mptcp_info
Date: Tue,  2 Apr 2024 17:28:36 +0800
Message-Id: <0e14deb5db6de99fcfd30673ddf54aa9a1191007.1712049966.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712049966.git.tanggeliang@kylinos.cn>
References: <cover.1712049966.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper chk_msk_info() to show the counters in
mptcp_info of the given info, and check that the timestamps move
forward. Use it to show newly added last_data_sent, last_data_recv
and last_ack_recv in mptcp_info in chk_last_time_info().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 48 +++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index bc97ab33a00e..3d60e6544e5f 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -200,6 +200,53 @@ chk_msk_cestab()
 		 "${expected}" "${msg}" ""
 }
 
+msk_info_get_value()
+{
+	local port="${1}"
+	local info="${2}"
+
+	ss -N ${ns} -inHM dport ${port} | \
+		mptcp_lib_get_info_value "${info}" "${info}"
+}
+
+chk_msk_info()
+{
+	local port="${1}"
+	local info="${2}"
+	local cnt="${3}"
+	local now=$(msk_info_get_value ${port} "${info}")
+	local delta_ms=250
+
+	mptcp_lib_print_title "....chk ${info}"
+	if { [ -z "${cnt}" ] || [ -z "${now}" ]; } &&
+	   ! mptcp_lib_expect_all_features; then
+		mptcp_lib_pr_skip "Feature probably not supported"
+		mptcp_lib_result_skip "${info}"
+	elif [ "$((cnt1 + ${delta_ms}))" -lt "${now}" ]; then
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "${info}"
+	else
+		mptcp_lib_pr_fail "value of ${info} changed by $((now - cnt))ms," \
+				  "expected at least ${delta_ms}ms"
+		mptcp_lib_result_fail "${info}"
+		ret=${KSFT_FAIL}
+	fi
+}
+
+chk_last_time_info()
+{
+	local port="${1}"
+	local cnt1=$(msk_info_get_value ${port} "last_data_sent")
+	local cnt2=$(msk_info_get_value ${port} "last_data_recv")
+	local cnt3=$(msk_info_get_value ${port} "last_ack_recv")
+
+	sleep 0.5
+
+	chk_msk_info "${port}" "last_data_sent" "${cnt1}"
+	chk_msk_info "${port}" "last_data_recv" "${cnt2}"
+	chk_msk_info "${port}" "last_ack_recv" "${cnt3}"
+}
+
 wait_connected()
 {
 	local listener_ns="${1}"
@@ -233,6 +280,7 @@ echo "b" | \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake "
+chk_last_time_info 10000
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2
-- 
2.40.1

