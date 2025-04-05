Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D676FC3
	for <mptcp@lists.linux.dev>; Sat,  5 Apr 2025 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743863653; cv=none; b=AlHj1H6UHsKqXdBU0+d031oy+BNnVuJ5NeS7QpB0DFw8nyN6zEN/3fdm77ogomHeBrEJp/KICnWAVCZEyMgDRKYAvFq/DCpwdTySWhLZM1a1O/dRp4zWP33WMTmImAF/Wg7D3NYFIN2GpECfm6IdgbF6vQRABbSC7WYvlq7H1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743863653; c=relaxed/simple;
	bh=1r7bkUn0fYZrc7wQlBWd2U9XVyDgoGQybNAUjPCsyI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hr6cs8NVA+ZAprsqm9YWRQDOh0AZZsuYZdTupPHBSH5BRxm9Z/g9gCU3Uy/rigVNIgCmixqdAAfQshwTD53h2m+fL0yRTpuY85AVG/7Sx0rCX+aywK3D8b1SzLanSRQ6wtmBrpgTA5EH/C2nhkZQioGwo5IJAExv00CcVRLmYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4irkSYa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4irkSYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C5BC4CEE4;
	Sat,  5 Apr 2025 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743863652;
	bh=1r7bkUn0fYZrc7wQlBWd2U9XVyDgoGQybNAUjPCsyI4=;
	h=From:To:Cc:Subject:Date:From;
	b=C4irkSYaNv9JsAvN9Sl0AsH+uOp8JE7drEfGnWb4rTb6uT0xzKNBz3tsQruDmSBmc
	 pUS1f8EnMCTqknuK3ikyWlh9l2mKqTR3h9wHYIqXNHGCOrI4ZsZ780xV2v8wuOPXWR
	 Ki4ULMrqfM5rQCekgV1cC0wLUFdKLhfgkht6oG5qu853N8nv0ksze9/CkE47hHKY0i
	 2jDVy1TtBBG1ySE84pzt9AWQBbmonH1sqfmiZ7U2DRj4tmeRS3bP/yNNZRGLauSVUd
	 WJHM3lS08GaoPO5goL/q5PGMi642ZB1RmN7EyYRCMt6PZ5KhXxu2qbyn4dyO8XbrO5
	 LKJtt9M6DCsrQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] mptcp: pm: drop redundant mptcp_pm_send_ack
Date: Sat,  5 Apr 2025 22:33:26 +0800
Message-ID: <539ce4556220df3d2ea4826c311c5bc4e306f9a2.1743863553.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_pm_send_ack() is called twice in __mptcp_pm_addr_send_ack(), which
makes the code a bit redundant. The first call to mptcp_pm_send_ack() when
a non-stale subflow is found in the loop can be removed. Instead, we can
break the loop to use the second mptcp_pm_send_ack().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index be1e27ee393e..a4f9cb113018 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -225,8 +225,8 @@ void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
 	mptcp_for_each_subflow(msk, subflow) {
 		if (__mptcp_subflow_active(subflow)) {
 			if (!subflow->stale) {
-				mptcp_pm_send_ack(msk, subflow, false, false);
-				return;
+				alt = subflow;
+				break;
 			}
 
 			if (!alt)
-- 
2.43.0

