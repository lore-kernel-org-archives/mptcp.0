Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E3625C71B
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804394; cv=none; b=tc6AQckoDo/koByxHY0Y3E2U71K+470urBwvwg4LcGSK6HZcpt+BW7Vp05kbWtHOH9IX2XDSTS4F719Mcu3adqFGvhAysNxCRC8gqbouvvOd3vPtz/VtmEsC22rfrwQUx6zv/rU9IdBoMDdc1k/XbvTFeWEYD+3z3wlESEoUdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804394; c=relaxed/simple;
	bh=BXGTvkft48Pz1dNbiMCp+7S4/NhhiPI1UvstLtFjoHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sa1FNihrjJFUaNLeYUwC0OyLDLuxb2FCLRAbEIxQByUIVGj9S6DydbS4dlxNKR/oNWRS/ax159Kar4SLvsVbALmFV7GYwEHqirQ2/eABBMNFQs1l58Z9JI4Hbdh4WCYiq34Fd7YRvGZSwuALxrvktAc3Po82c2IUSneyCQ5yeAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJmy+OHb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJmy+OHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47721C4CEED;
	Mon, 24 Mar 2025 08:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742804393;
	bh=BXGTvkft48Pz1dNbiMCp+7S4/NhhiPI1UvstLtFjoHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJmy+OHba0s5dStJZn0LYtMlLhplXWeDelIRZ+P2vKCGbHUhQTX3NgZVDK1foMZfv
	 6MjdAmG6hgm5LKt2HPNvuwJj4mmey3J0pI99Y+KjSjrbTOkpW1tN/GS4hdxbDXnXWt
	 zzoD2ArLpjTuP4Yozb3ZLwOiwVrMgtVVmJ9CJgfPV1AfYXepZBsyncn0RMSZ+4I0eK
	 LvvmFmEQHKko7avAL3d2lOiX4jGTZSHVt7Tm2yZEd0Y9pPdY7gdLkIlsDlZ5dW4fsd
	 HEMh5ZtR6nWEVK5brr6C4wtX7mho8dnZPoBZJN6GjKbegBXLcT5gYatyM2Jf22POMY
	 JgS191gDOARdQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/9] Squash to "mptcp: pm: add get_local_id() interface"
Date: Mon, 24 Mar 2025 16:19:35 +0800
Message-ID: <7fe68131f39121b2265856a91429f072332eb642.1742804266.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742804266.git.tanggeliang@kylinos.cn>
References: <cover.1742804266.git.tanggeliang@kylinos.cn>
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
2.43.0

