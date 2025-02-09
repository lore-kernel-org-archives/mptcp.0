Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B5339A8
	for <mptcp@lists.linux.dev>; Sun,  9 Feb 2025 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739095348; cv=none; b=cyKhAiEE/mQmxu6Kd575/wr061bVav9t9MGKyAeF4t2MzMcYz6YZQ2QXNzized0xafnXBjIyJvG7YUbdpaVwXP76Yl7WB3Y77QNE2W19HTqNdV6MoIHlMI4ISVTCuIje+5PGF5JbV7QFE4zUV7JIB+r6WaSkxWutTuQRQiAJJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739095348; c=relaxed/simple;
	bh=QH8lswTyWVWhcaVom/XLC2qNwS0O3SXO+M66ZfsxXTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CINWRvcu0AvKMxlqWeKZfIQl3aFjGYYJ0TvXRoTctr/QeSyob3GtHSpImUhTkzXOd0KTTd8mWK6zJxegpL3iWsEu42cOEguXTw8NAjsUq/viwlbh0A+Dybj70cX5Ac7jI1NEfM0x2aMrs1a/8LeP6scdLmUI28BqRIl7pV0N9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwRJBQJ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwRJBQJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4110EC4CEDD;
	Sun,  9 Feb 2025 10:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739095348;
	bh=QH8lswTyWVWhcaVom/XLC2qNwS0O3SXO+M66ZfsxXTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kwRJBQJ2XwY0vNeZq6W8IVS5iOihQqoRRBbd2ahRGH6qpSNV0qzkZOLXfeiXRS2cu
	 KvkLFgG9xFUijqkstWg8FsPKEyhF1HvuC226jv/EhDRV/CFP+bcQcvrTZU/0Zo2g+O
	 cQtIztQU2OVSDmeo8+rwIhWvbvlCqtI6jZaN9+mlTYXMMxpN2Tdn4dA33H7pUoIajy
	 Ypn796pueufMAFLkPmfsoxIHCc97yiIkhKXTBv0TNGFj2oALkHFzviGbWD4PsUUJ5a
	 FCPsK6iLQtWQOeyEAuS8L6UIrR7vjx2Evz9rCxrEg/I78y5M6JgLc+rr5dKG7F1O2k
	 XHZpktwAIWzgg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 8/8] mptcp: drop subflow contexts in mptcp_sched_data
Date: Sun,  9 Feb 2025 18:02:07 +0800
Message-ID: <de2c471ad3f461c54b4da89a72b0b575fbbd4fb7.1739083794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739083793.git.tanggeliang@kylinos.cn>
References: <cover.1739083793.git.tanggeliang@kylinos.cn>
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
"contexts" and the size of it "subflows" in struct mptcp_sched_data. And
keep struct mptcp_sched_data for future use.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 2c85ca92bb1c..df87114deb1c 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,11 +100,7 @@ struct mptcp_out_options {
 #define MPTCP_SCHED_MAX		128
 #define MPTCP_SCHED_BUF_MAX	(MPTCP_SCHED_NAME_MAX * MPTCP_SCHED_MAX)
 
-#define MPTCP_SUBFLOWS_MAX	8
-
 struct mptcp_sched_data {
-	u8	subflows;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-- 
2.43.0

