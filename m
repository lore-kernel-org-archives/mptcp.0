Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1595D8EB
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055794; cv=none; b=LbwEMN5tJTOXHbxnnnFcGRBTBUA4JcWzeFRDtozFlwhbGpJIZ9/lX0kOlZ2ftyATTeSwFguhxkw9flATUSCv9D64trzF/hIGxiw8dUjWtnZ1Pnljj7elJrMeMaE+ZUOZya0iGfm7nSbFBlggmY7Am82p+bEm1dcgNM1Bc7KAkoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055794; c=relaxed/simple;
	bh=SGEkdUZ6zT8NCJypNNzJFKr/PzCPH2SDGUf/52d0d1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cIVEEu6+dM97A9FnD3kMVxo7LANDh8Ro73hHYx7Hdf5jtMj0D5kJZpmi1dKZ+LuOmNMJiF6+tyc4/kevykU6BtWHb+UBtsAEHOtitSwiyrGJk1iQxTF6509OauM3sK11cgYSBqLbPxy30hrsaNPoFzABXCVDdDJyQl2R/G3w2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH8u/Box; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH8u/Box"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BAFC433F1;
	Tue,  2 Apr 2024 11:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712055793;
	bh=SGEkdUZ6zT8NCJypNNzJFKr/PzCPH2SDGUf/52d0d1c=;
	h=From:To:Cc:Subject:Date:From;
	b=lH8u/BoxPz3X7YixYBUeUApo6idkRTQp2fvl/wlL4srXYvEAH+e6JIOckz7MzEwN4
	 XckNOP8gNiPex9h3qlQDbD1Zvz0He90A4pusxp/Ib7idLmSKSO97FGXfE9SXPEiGxg
	 EuIdkr3Pf9HrAg6bPVNxRzquQjm46Sa1nFYV66Of1ipfA/89YPQPRcrmrHi8U7PJFC
	 v+XewXmScKELJ2BnL4tjQuxWKhtrDCYcpvln7ub7H3WdYi+hHFJfBVkyJ4OSGQtFfv
	 CNSjoTbqw4uMl2lj0G4iCkEw/XSFTk7dIXDcGFuZ6JzLbf3m7SfBWYq3K7B9GKDbeA
	 /dwGv/GeOV97A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: test last time mptcp_info"
Date: Tue,  2 Apr 2024 19:03:07 +0800
Message-Id: <a8e3172f85fd0abf99207c7c4b9147ec2388f05b.1712055782.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Fix shellcheck errors. Fix a typo, cnt, not cnt1.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 3d60e6544e5f..1c72e328ee34 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -214,15 +214,16 @@ chk_msk_info()
 	local port="${1}"
 	local info="${2}"
 	local cnt="${3}"
-	local now=$(msk_info_get_value ${port} "${info}")
-	local delta_ms=250
+	local now delta_ms=250
+
+	now=$(msk_info_get_value ${port} "${info}")
 
 	mptcp_lib_print_title "....chk ${info}"
 	if { [ -z "${cnt}" ] || [ -z "${now}" ]; } &&
 	   ! mptcp_lib_expect_all_features; then
 		mptcp_lib_pr_skip "Feature probably not supported"
 		mptcp_lib_result_skip "${info}"
-	elif [ "$((cnt1 + ${delta_ms}))" -lt "${now}" ]; then
+	elif [ "$((cnt + delta_ms))" -lt "${now}" ]; then
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "${info}"
 	else
@@ -236,9 +237,11 @@ chk_msk_info()
 chk_last_time_info()
 {
 	local port="${1}"
-	local cnt1=$(msk_info_get_value ${port} "last_data_sent")
-	local cnt2=$(msk_info_get_value ${port} "last_data_recv")
-	local cnt3=$(msk_info_get_value ${port} "last_ack_recv")
+	local cnt1 cnt2 cnt3
+
+	cnt1=$(msk_info_get_value ${port} "last_data_sent")
+	cnt2=$(msk_info_get_value ${port} "last_data_recv")
+	cnt3=$(msk_info_get_value ${port} "last_ack_recv")
 
 	sleep 0.5
 
-- 
2.40.1

