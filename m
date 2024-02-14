Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34F1AAA9
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910864; cv=none; b=ZZ2ybXypTkOJ2KQ/5+mit3PNS875sIsHoLk1OUNC5XXwF9bdRNHcPfeeZMHH0gYT7RwKbVQRBsnPscQU+dVKn9UKFKju9PfSGjvfisIK1Hrn0e951mYA5UzbJDnclgsav23ZM14a0LUcmSlwaq8GXCYj2GXlBT1FYLob5sAItSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910864; c=relaxed/simple;
	bh=7CQceAejj3W08wWdJklwKurfMvevtJGX5GQuyammQfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UneiQ1iP7nJ1PBgBhVR9TjHJ3DaDN01Ph1iZVW8NfwiMfBHds3hWir9CgQ2x8dj+5sztECJk1CVoDYpuC+PFXCG/7iVJDfC+vnU5YrYGJ6iG1xlYtK/qJd9RkAyt4rEGtyWK1IjU7kUY9+PtrYJwsE29EIFpskaWOaBe6yYFPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3oFQWHm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3oFQWHm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B15C433F1;
	Wed, 14 Feb 2024 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910863;
	bh=7CQceAejj3W08wWdJklwKurfMvevtJGX5GQuyammQfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3oFQWHmA4r5CZt7A1sAVBGUowovAnPoPy0MJJfHnIC1yrW83WtRiRCJ/MnjPObL3
	 NmhIv9LGuWlEJu0oWgQTdlNIhDFWPW2Oruvyn67Jf6aukjB/boLR1Gwu4ngfSw0iA9
	 nADMriho1y8j/boWgsxOkaZSwEune0ZvBrvRfyw7Qx4zoTfaHpnZLuPWxST78nT4kG
	 txrHI7oHY31ceY08b501vS3dc9Lt517LjORWHHxE3TGPohfEdaCgqdN0qaeYu7XpIp
	 Y59XNIASCIgl/fJSOuuY6A8KEGEKYlfk91BCkgYiDzJTacPwVvb8erz3X1k8J2U5Z3
	 fsxkstBkL4yJA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 09/15] selftests: mptcp: dump after creating id 0 subflow
Date: Wed, 14 Feb 2024 19:40:00 +0800
Message-Id: <1da1277a5ecdf0f575932f483ed784a5663022d9.1707910454.git.tanggeliang@kylinos.cn>
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

This patch adds a new helper userspace_pm_dump() to dump addresses
for the userspace PM. Use this helper to check whether an ID 0 subflow
is listed in the output of dump command after creating an ID 0 subflow
in "userspace pm create id 0 subflow" test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d92d233ddccf..dcb146c426dd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3354,6 +3354,18 @@ userspace_pm_rm_sf()
 	wait_rm_sf $1 "${cnt}"
 }
 
+# $1: ns
+userspace_pm_dump()
+{
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl dump token $tk
+}
+
 check_output()
 {
 	local cmd="$1"
@@ -3514,6 +3526,9 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		check_output "userspace_pm_dump $ns2" \
+			     "id 0 flags subflow 10.0.3.2" \
+			     "      dump addrs id 0 subflow"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.40.1

