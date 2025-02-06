Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBCC225A23
	for <mptcp@lists.linux.dev>; Thu,  6 Feb 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832723; cv=none; b=sZhwXqog2yWO+/xyWWT8Ua5dLxvCIh1IumYdQP2olxcLs6t6ayuHW7I5AudHcI+wSSBNwSV0R+4h7vo2alBo0Pow4Xp4ai5JCA1QGA9VOoy1D8pq6yBTtPCXst8O7BjDLvFkRiNMAwZ5w/FO1DcT+k5oOvyGhfGxOCsXlr8+juk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832723; c=relaxed/simple;
	bh=y5iRi1GPK3WrbYkk7tVB/B1By0XI7T6LhwuLpU0JvMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9plkD2lM4V7vU1LyGqBcaBfNV/lwl5jvka4LzLBp5G1ZlEBC75hZB1QGnKTDF7s9BqyQRTQagR/FO9NlE9/5oHtVgHZxcSj9gRM1RkR//OlXIPOKrDpr2Iq955XVAmb1sqbKY/WJ1CZ786pmH5uxFTvlF1BuL1bn2mBLfYeDDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwjHptrj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwjHptrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6E0C4CEE0;
	Thu,  6 Feb 2025 09:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738832723;
	bh=y5iRi1GPK3WrbYkk7tVB/B1By0XI7T6LhwuLpU0JvMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwjHptrjQKyu4W02Sop6vIWipG1zRfTswygSNeEdA3gNS60fQ+j9dAJTGlhEZeU0z
	 LnXpZDeUu0iNLXDPpRrsFqAk9eqcY9QR7R/B4i/1fuCHTSQ5O6KIJrM9tJ20p069Ww
	 HucHIx9HBuPtPel25PBLexpMcxIaM3KNS56vaRbM6snDGHHRLytYniotcctMbkIGCC
	 Aeu4u86jI9TQVz2maFu6sFNRK0Y38tZY1rHS6WOIUuHnh3eX5tyD+ZDkrvDLDITWgw
	 DbRutHQXUuXss5O5LfyRz0HzwL8vHxx3HP5oa+37GcltjuhfnxeIhH4l7sdtrqrICS
	 J6kUZDzJdf/Jg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 9/9] mptcp: drop subflow contexts in mptcp_sched_data
Date: Thu,  6 Feb 2025 17:04:59 +0800
Message-ID: <675476a73878d2aa9509adbba512376c9d13e508.1738832147.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738832147.git.tanggeliang@kylinos.cn>
References: <cover.1738832147.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp_subflow bpf_iter is added now, it's better to use the helper
bpf_for_each(mptcp_subflow) to traverse all subflows on the conn_list of
an MPTCP socket and then call kfunc to modify the fields of each subflow
in the WIP MPTCP BPF packet scheduler examples, instead of converting them
to a fixed array. With this helper, we can get rid of this subflow array
"contexts" in struct mptcp_sched_data.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 2c85ca92bb1c..9f154f509b67 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,11 +100,8 @@ struct mptcp_out_options {
 #define MPTCP_SCHED_MAX		128
 #define MPTCP_SCHED_BUF_MAX	(MPTCP_SCHED_NAME_MAX * MPTCP_SCHED_MAX)
 
-#define MPTCP_SUBFLOWS_MAX	8
-
 struct mptcp_sched_data {
 	u8	subflows;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-- 
2.43.0

