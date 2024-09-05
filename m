Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F82F870
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546543; cv=none; b=IIjwdePA1AYFEMZ0AdXbjJK3VaJvqYkewQcqdwJwnV5QW24QMUJ1Ao9K5JsZ0KYX2JkO+Ev7jr8t9J+5oQibfCZMHU3XlHWFxytcu9/sys4nhuQFADowJoTcvG06CZ7wML8zkKxLCM3No5frZP8FSdQlUpnxNtezZKQTS4MeVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546543; c=relaxed/simple;
	bh=oRPddNFGFo6Z+dCpJXlJ8VLO4VG3VnIN7OuGV5N+jBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzoD2D2+2rhml4T3EjSy2pk8eaU1S35lPPCpsb8c/kG8erctbYVSnP2Fxr1OuzrOu9hJFSmt420LDsNopl+2qoe2KKnWZ7dYClC//aa9bUlekcsIwFOJKh/XYIL5+5WrDDOPjqYZzkGDr8snWtdlzQ8JU0/NgAjGaN9sN9lz/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0DcxPaT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0DcxPaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB696C4CEC3;
	Thu,  5 Sep 2024 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725546542;
	bh=oRPddNFGFo6Z+dCpJXlJ8VLO4VG3VnIN7OuGV5N+jBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r0DcxPaT8ZzhOfx6dbUvkblv26556PBLBBscMNCoPS/eZhhS/QSHJlV/Hy7NDz1yS
	 QFmUAkTSZumGDq47xqu1neNV3WcyMyHNuF7E+FPRjWafKNMw8tR7qCAd+KDaz24Iqd
	 twbl7lC9ngNtAvSNO1M+wuNAqL+vajvAd/aOykmkio7oIe3av6ZrKB+8WHupmtDVuR
	 XXgSHYQlctkQ9hWXbxxNPn2tkOQfXF5gF1JdDa4P0dv7DMD/PdpOV4CWBoh1YwjW8h
	 PbAEvwcZrBCZShE8TglEwxJszIUAmLoNlZeCXOYwwUIJ/xUphHw1wpgViOZiJPmgMy
	 HqFV+ALyfVO0w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Thu,  5 Sep 2024 22:28:50 +0800
Message-ID: <48a40bc2bfb3a428092d7fe7385e236a32232398.1725546472.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725546472.git.tanggeliang@kylinos.cn>
References: <cover.1725546472.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper mptcp_subflow_set_scheduled() is used to update the scheduled
flags of a subflow. BPF schedulers are not allowed to directly modify
this flags. So the write access permission for this flag shouldn't be
allow.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 9672a70c24b0..6414824402e6 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -60,9 +60,6 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 		}
 	} else if (t == mptcp_subflow_type) {
 		switch (off) {
-		case offsetof(struct mptcp_subflow_context, scheduled):
-			end = offsetofend(struct mptcp_subflow_context, scheduled);
-			break;
 		case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
 			end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
 			break;
-- 
2.43.0

