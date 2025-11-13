Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC84337BA4
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032284; cv=none; b=D1leyakC95MKsLnB5dv2uZ1YrH1tamuaJlnorBJZcQSE8Yj3ByWp5nKQWBuFnBMz2/lojYgCRZ7QmzjQnMfqD90IKb18573DqeWQIzCHR0q0mpFK35Qe5sNPNlqeSNwhnWukOQH5HWzkNQy9K3rZdCb250usQi1G491cZ8LYFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032284; c=relaxed/simple;
	bh=DU2rzgWoRpF16o7ZNruD6PLCvK45dE3P9ckh8FA8Qrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Eim5E58qrFoWr34GVIiC74NLnYF65+5R5ZD9mKQZ5IZOe7JRCWhYwJRMwO1GkkR/znd9t0KVpG8W5XTF1G1A/bdjWeOlNKeoo9ZqF4p+zS9DdjgNjxgRDASfE5vaFcItEX57+lt5LiMoMr0MlzZNL/QTnuGHG6CQMpfYEIIH2yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URy4RCJp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URy4RCJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D72C4CEF8;
	Thu, 13 Nov 2025 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763032283;
	bh=DU2rzgWoRpF16o7ZNruD6PLCvK45dE3P9ckh8FA8Qrk=;
	h=From:Date:Subject:To:Cc:From;
	b=URy4RCJpeMz5nTtCfNp3ZVbRBBYPBETCvIjgP0qaeLUX2E/Ae0xDQ19sCD/b+LRv+
	 UlHnIY55lNzK+6u/7olXWNLsP+1w1CgJFnJE1EwZG/Mye8k0VDlj4d8iLs75UeqNuZ
	 OJcysx0rsIQSwSottV3oy50NrFz7JexwTGxRyZhC0yIqRsqT0QiXRLNMngtUGVLm2C
	 g0UPudmQzlfj1BW+1xYoiigxaXzB4pxNmZuqY7YqhUrEQbt5CfYBHl2MyuxXzQZ9dJ
	 AmADUerSc1HDZ63bp4zp2h5s2JHkjmo00+7OtJC5LadmqpSBFVBaH4F+o2ccZqfKRw
	 3EXdO3aVXU4Vw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Nov 2025 12:11:15 +0100
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: get stats just
 before timing out"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-slft-timeout-stats-kill-v1-1-9a09d8f46392@kernel.org>
X-B4-Tracking: v=1; b=H4sIANK8FWkC/x3MwQqDMAyA4VeRnBdYamVsrzJ2KC7VsFpLE4cgv
 vvKjt/h/w9QrsIKj+6Ayl9RWXMDXToY55AnRnk3g7u6gYh61BQNTRZeN0O1YIofSQm99/eevBt
 CvEGrS+Uo+//8hKXYWDDzbvA6zx83OW7zdQAAAA==
X-Change-ID: 20251113-slft-timeout-stats-kill-444931425af7
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3567; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DU2rzgWoRpF16o7ZNruD6PLCvK45dE3P9ckh8FA8Qrk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJF99yaGqmpeFXC8/iRAJda5tNp//+kuqe/WPnGMCsgZ
 fPcpr8RHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPJm8DI8Hr+jEc3Jz2s1XYy
 K3NdeuHtCpvme+psRvqiXfx7mic01DD8j7epmnVESCZ5iueSB9dO2DNGsD4IfZl2smS561Kxkx9
 usAMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Geliang reported that mptcp_connect.sh test runtime got increased after
this patch.

That's because the previous 'kill' command was only killing the
background job, but the 'sleep' command was still running.

It is not very clear to me why there was a delay at the end, but
switching to mptcp_lib_kill_group_wait to kill the background job and
the running command fixed the issue. The new code is also looking
clearer I think, so that's good.

Link: https://lore.kernel.org/2a6869ca39bda7ddf8b486cd03e0867b30e0d565.camel@kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 7 ++++++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 7 ++++++-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 7 ++++++-
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 7 ++++++-
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 458b07673910..a6447f7a31fe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -415,7 +415,12 @@ do_transfer()
 	local retc=$?
 	wait $spid
 	local rets=$?
-	kill $timeout_pid 2>/dev/null && timeout_pid=0
+
+	if kill -0 $timeout_pid; then
+		# Finished before the timeout: kill the background job
+		mptcp_lib_kill_group_wait $timeout_pid
+		timeout_pid=0
+	fi
 
 	local stop
 	stop=$(date +%s%3N)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 222babd43682..7a72efcf1403 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1063,7 +1063,12 @@ do_transfer()
 	local retc=$?
 	wait $spid
 	local rets=$?
-	kill $timeout_pid 2>/dev/null && timeout_pid=0
+
+	if kill -0 $timeout_pid; then
+		# Finished before the timeout: kill the background job
+		mptcp_lib_kill_group_wait $timeout_pid
+		timeout_pid=0
+	fi
 
 	cond_stop_capture
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 326466f2f6eb..ab8bce06b262 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -193,7 +193,12 @@ do_transfer()
 	local retc=$?
 	wait $spid
 	local rets=$?
-	kill $timeout_pid 2>/dev/null && timeout_pid=0
+
+	if kill -0 $timeout_pid; then
+		# Finished before the timeout: kill the background job
+		mptcp_lib_kill_group_wait $timeout_pid
+		timeout_pid=0
+	fi
 
 	mptcp_lib_nstat_get "${listener_ns}"
 	mptcp_lib_nstat_get "${connector_ns}"
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index cc4d40d149e2..806aaa7d2d61 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -178,7 +178,12 @@ do_transfer()
 	local retc=$?
 	wait $spid
 	local rets=$?
-	kill $timeout_pid 2>/dev/null && timeout_pid=0
+
+	if kill -0 $timeout_pid; then
+		# Finished before the timeout: kill the background job
+		mptcp_lib_kill_group_wait $timeout_pid
+		timeout_pid=0
+	fi
 
 	if $capture; then
 		sleep 1

---
base-commit: 6861f291b7a3bc40235e996f5605c477f55ce9e0
change-id: 20251113-slft-timeout-stats-kill-444931425af7

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

