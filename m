Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B81917CB
	for <mptcp@lists.linux.dev>; Sun, 22 Sep 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726966833; cv=none; b=SWt1nfl6f45slRTq4Zz4S+oFAi/pq+aqTgf4VjuGqrW+AAp2JyqcRvL0uypkti7oikmDFoLpGtTw4H8ZRLw6JYQ+QQyGfinMKmA5XcfXCuzOZcMSI3/XkMO2qEljpcBmOPdgoMvZwFGcPpLDe02wCZRaZJtnTc7t9eljKxnPttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726966833; c=relaxed/simple;
	bh=JrjP+cxxwQctHpBi6PyjZFtDkVVFpWStd9Gbslehly0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c31bK5W8FfyiBPU8dIhnP0A0GpK6pKxyVDWEGPR8l1cQRyuN+erscsir97FjuPX+JdljlRN0W6aXaelFqqcrcPor00ZdicQmBiFtTJ3Dx9jxuG5X1M7fY3pi/xgmIqEpIIlvtz4C86jKe6XMb12usXwfvw9uAKYo5Q7x9Ta0D6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw+yn29N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw+yn29N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E3CC4CEC6;
	Sun, 22 Sep 2024 01:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726966833;
	bh=JrjP+cxxwQctHpBi6PyjZFtDkVVFpWStd9Gbslehly0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fw+yn29NqbG6ChUtcYwCKeFRwmY9x+2qDYq8+J7L4WVoIrWL2WnDAxfasC89onOmY
	 PYFzS6PrEPpCe7YTfES45MSufzFUOadEH2WWUniZCQhIeVdaujaJChQPopCgqGRAUQ
	 11d+H7fr96ElQVf7fPa0BDbiUY+oJWe8UpbzfCq2tr62ubTFCXYcY84uyon7Q/87Xt
	 P9yNaYy0iFsFy9LBqMz7WQ4nWde2GxkoF8f+x9oe0k2DmYCrwPybhd4o2zrney50fA
	 dWdyRCEVkrOyA572g4sosE4Jbe29G89z/4hoxulW474nxeUg/7EmGOQXiiuV0mcosS
	 b8iMKQuCSJH9w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/3] Squash to "selftests/bpf: Add getsockopt to inspect mptcp subflow"
Date: Sun, 22 Sep 2024 09:00:24 +0800
Message-ID: <351e163948d4d7fb1608585074561f56730d18f3.1726966638.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726966638.git.tanggeliang@kylinos.cn>
References: <cover.1726966638.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use can_loop instead of cond_break as Martin suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 928a1e5ad8db..c3800f986ae1 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -26,10 +26,10 @@ static inline int list_is_head(const struct list_head *list,
 #define list_entry_is_head(pos, head, member)				\
 	list_is_head(&pos->member, (head))
 
-/* small difference: 'cond_break' has been added in the conditions */
+/* small difference: 'can_loop' has been added in the conditions */
 #define list_for_each_entry(pos, head, member)				\
 	for (pos = list_first_entry(head, typeof(*pos), member);	\
-	     cond_break, !list_entry_is_head(pos, head, member);	\
+	     !list_entry_is_head(pos, head, member) && can_loop;	\
 	     pos = list_next_entry(pos, member))
 
 /* mptcp helpers from protocol.h */
-- 
2.43.0

