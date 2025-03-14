Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B972E3379
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920347; cv=none; b=U/1JnWULvun8J4rJ6bb4KSYQxWkV0G+gce7pm2x5+DcRfXsMEC4VrpusDGgllxTZxkx23ZT/R5ezQ1JmlsO7jnzw6JLoTZzwpGtZHcCmIWbWEirxSorYuX+Zo6+lKppDlq0jL45SYJXWTIXn/w6yTSqP9Dzfd3h23xtf3s5Mps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920347; c=relaxed/simple;
	bh=jxN6Jp3cF7jlyth5tUdvMOCnefAqTq9+QLNcAbbt8W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+6VDCxWpveujk5jURWj9UKPNTcFan8lkTcZyq0gOxy0AwNsQicvkw1f+OL+/cHV/iMWEtYXombqDVrnbWe820y5A303t5g/Ul3I+rdn2TjV6lIqhoKAIPCP3cZuRi4CmQ4l42XEDbtXpnzjXWdNIvFEe42BVSnBmwsfjGfsL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpuXFzFV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpuXFzFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2AEC4CEEA;
	Fri, 14 Mar 2025 02:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741920346;
	bh=jxN6Jp3cF7jlyth5tUdvMOCnefAqTq9+QLNcAbbt8W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MpuXFzFVTxbV/KXiUvV/i9xU0XZ6HmIg2U5L29Z2F/zoou6cadbfwK6LcXQ0Fg+qe
	 cTLLDbd22TfMRvZvafi/cgF+lvPBFt9egPkZKdvH8q0uWJL2oSJA30/uPjGu0DK54J
	 cKeNy1LBRBLjTj/aLXGsnPv+7e6+24fPbGdOAuKaMJtQXce3iLzr6KwR1a4SXKFUW1
	 vP3CLr3ZEe38kZeHiNTOi+8bEzhFNEAm9J6FckZPO0F+k5DX3+TflAchQcTmMQcDLG
	 xSSL7r7+B+sqK0884kWvlSMdnkLzqQUijCv+9s8aj++rNk2H6htJsFo6LBx93CcKv0
	 3EjM2L7M3OQWQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 02/10] Squash to "mptcp: pm: add get_local_id() interface"
Date: Fri, 14 Mar 2025 10:45:23 +0800
Message-ID: <37165e0d3996fa182e40c743c1b9f5575b38998a.1741919893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1741919893.git.tanggeliang@kylinos.cn>
References: <cover.1741919893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add /* required */ comment for get_local_id and get_priority.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6a08ac862bbe..9f28ef550e10 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -118,6 +118,7 @@ struct mptcp_sched_ops {
 #define MPTCP_PM_BUF_MAX	(MPTCP_PM_NAME_MAX * MPTCP_PM_MAX)
 
 struct mptcp_pm_ops {
+	/* required */
 	int (*get_local_id)(struct mptcp_sock *msk,
 			    struct mptcp_pm_addr_entry *skc);
 	bool (*get_priority)(struct mptcp_sock *msk,
-- 
2.45.2

