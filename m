Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0AA358D21
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863325; cv=none; b=F2h7MdTMHCF9KvPK0qnQT65UhgHEe58yqC93VS6cNSza2e75cS6uyMjaEjZ6fJVECqqw2TQO4LrNXgozZMgVZW4RLh4vr2llEhfibJ6dbzy1JDVbB4LmTISlT+Xr14DG3Tu+Qb3MHumHS83X33hXsvA/kLyg7IBLtyiYIhzX5T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863325; c=relaxed/simple;
	bh=8hWQd6TSJNK5DPb3b2IcURpBQDYA2RC3RdGSE5EV/3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kurqi+gAqRNN/wxNNIoOcomY1rGqJPUkyvGvmgqKr/QXJ3CtJ58GRtmX+l6EN8enTY0KvUqUx9XW94Nx52L5hkx4Qscu9s+6fdowBcbk/l8twYQgv0JJj4SYuBRSLQxBIvjauK8mfiLjCtGwaPm+wC/ThaBswePcu9JS04oTZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEuc0Jrr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEuc0Jrr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F06C4CEFB;
	Tue, 11 Nov 2025 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762863324;
	bh=8hWQd6TSJNK5DPb3b2IcURpBQDYA2RC3RdGSE5EV/3s=;
	h=From:To:Cc:Subject:Date:From;
	b=OEuc0Jrr6T0ZYw5B17l0VooXFxJG4EzdUfy/o794r9IW88FgKGdowmIJciQgTxVCb
	 OzSRKvGAbzJIHL1ve4sL+13iy1v/JU6c4vE7WILTHtAO0MC8MRBjk1daZt1Epy9Wrq
	 +3QjkEFX6UyyXxXOoWnYY3dR/5ynfBSzUFToJNos3xQAQ9poNS++O8Bq/Yb9dlW7m8
	 0NzDpJkRD3wLO1ybGsA8HlV8lEEhzDjXquApZC/IZHH/84UJs/l2DuQhZ7lETA7+aw
	 iSc7Qs+tJPI2G7qxXRqOicioxI+aAz/2q6t3YV8Ax+tnEkxjmfoAnz0C2dWXDfB5K5
	 srIpN9E8wfNUA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-net] selftests: mptcp: join: fastclose: remove flaky marks
Date: Tue, 11 Nov 2025 13:15:17 +0100
Message-ID: <20251111121516.141312-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=matttbe@kernel.org; h=from:subject; bh=8hWQd6TSJNK5DPb3b2IcURpBQDYA2RC3RdGSE5EV/3s=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKFNa4GZM8Mq375qvy1xFmji7l8vxSkFxbee8BgYVAiu 8jl+TyBjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIk4VDH8FbzF93NWzYO3eo3N zN7XdKZssf35PXL/t4rV7Oo3TfN4njIydE/Q1v+mxNt73vWKVrLz9eyFHdObTVcWLl/FVT3vVkM oGwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

After recent fixes like the parent commit, and "selftests: mptcp:
connect: trunc: read all recv data", the two fastclose subtests no
longer look flaky any more.

It then feels fine to remove these flaky marks, to no longer ignore
these subtests in case of errors.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
This was originally a Squash-to patch for "selftests: mptcp: join:
fastclose: drop plain RST", including the revert (without this change).
But just to ease the applications of the patches, I already did a full
revert and applied Paolo's patches. This patch is then going to be
applied after Paolo's patches, and just after having been sent. I'm
sharing this, mainly because I kept Geliang's RvB tag: please shout if
you want me to remove it.
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 98d78ecae8c6..74c7adf5fcbd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3500,7 +3500,6 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=client \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
@@ -3509,7 +3508,6 @@ fastclose_tests()
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
 		join_rst_nr=1 \
-- 
2.51.0

