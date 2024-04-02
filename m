Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DFD7D07A
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062405; cv=none; b=tQ0gmwft0S3BxAmeYotxVoUOHR/MiUZRv5NLfYVyXBJKFLWY6J3B7vovY/3ao0JCxR48uacZ5jErS/9iyuAK3fermWHTwE1wBXgc2cfZjkdD741qFeiLe/c5R4Rb9Y1I8SRU13wDdXf+coFvqrufq8J5xWKuqn6xtTXBz+2+Zls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062405; c=relaxed/simple;
	bh=TzOix3iQQVmPX8tYyMe+/A7p1vkfKz8ChldQDvTkXdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iC52O8WB+oPsOFVKsw1lLfsp8CIYTbQndxQHWRJilykamzeOCUofJUAfD2J+kvmOeOZgci10nMS1LwMAmMy/yMenPyJ3PvgyuHirb1kJY8ApDQWduLGiZnCfE3qbw/iPBT1/eMZiQt2CO7jWWlg2uV/KdBF/xMctHi2zeKNzLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qE+W35QU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qE+W35QU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF20C433F1;
	Tue,  2 Apr 2024 12:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712062405;
	bh=TzOix3iQQVmPX8tYyMe+/A7p1vkfKz8ChldQDvTkXdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qE+W35QUyyEf2EVxLk6EB7y9SHYyYSaG4mk5uSTkkF5UcKqI+qwpsSbIl5GmnwRhK
	 SFhz3i2jI7brXefN3EKVmGHgDN06yrhEV45nPGGnrASY/0ACN4NS8ePXf+OCq5JsAH
	 8S7IZI3NMcwfZwqt68419ScyYslfviddaFz7APuEYqXkbKd5eog3ojx8QjyAvQaQwV
	 QGDlW/hD7h/UCK0a0lx9YUDRADAioTEZpmLQI3WvQZY+ZwPjdhPUfie5JY1UzFpI+/
	 xDzqcgZnseNaS3oN4DwmmLb8gOf+dRkBKzErsMgbi25AnIvIOOYQ/VYZ+WeNbMx/5C
	 PEYRqofJefrCQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/2] selftests: mptcp: test last time mptcp_info
Date: Tue,  2 Apr 2024 20:52:55 +0800
Message-Id: <a8b3d8258a995034348b7e5fd370346fc3af368c.1712062199.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712062199.git.tanggeliang@kylinos.cn>
References: <cover.1712062199.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/diag.sh | 51 +++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index bc97ab33a00e..911920f3edbb 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -200,6 +200,56 @@ chk_msk_cestab()
 		 "${expected}" "${msg}" ""
 }
 
+msk_info_get_value()
+{
+	local port="${1}"
+	local info="${2}"
+
+	ss -N "${ns}" -inHM dport "${port}" | \
+		mptcp_lib_get_info_value "${info}" "${info}"
+}
+
+chk_msk_info()
+{
+	local port="${1}"
+	local info="${2}"
+	local cnt="${3}"
+	local now delta_ms=250
+
+	now=$(msk_info_get_value "${port}" "${info}")
+
+	mptcp_lib_print_title "....chk ${info}"
+	if { [ -z "${cnt}" ] || [ -z "${now}" ]; } &&
+	   ! mptcp_lib_expect_all_features; then
+		mptcp_lib_pr_skip "Feature probably not supported"
+		mptcp_lib_result_skip "${info}"
+	elif [ "$((cnt + delta_ms))" -lt "${now}" ]; then
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
+	local data_sent data_recv ack_recv
+
+	data_sent=$(msk_info_get_value "${port}" "last_data_sent")
+	data_recv=$(msk_info_get_value "${port}" "last_data_recv")
+	ack_recv=$(msk_info_get_value "${port}" "last_ack_recv")
+
+	sleep 0.5
+
+	chk_msk_info "${port}" "last_data_sent" "${data_sent}"
+	chk_msk_info "${port}" "last_data_recv" "${data_recv}"
+	chk_msk_info "${port}" "last_ack_recv" "${ack_recv}"
+}
+
 wait_connected()
 {
 	local listener_ns="${1}"
@@ -233,6 +283,7 @@ echo "b" | \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake "
+chk_last_time_info 10000
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2
-- 
2.40.1

