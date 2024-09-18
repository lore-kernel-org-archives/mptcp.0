Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C34A1D
	for <mptcp@lists.linux.dev>; Wed, 18 Sep 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647928; cv=none; b=JeWLcffbZc1p6Wrc9gwuwyoYQSe2dKTOm0SfgUSQMGmyduVfdqrp75l++TSCtqGIcHPeQUf8JbknWbDrKfJHERm/RkD2/wVfgAdiEXDnrk7iMWuT3aDsJqCeL3dGIlZVAdS1EhbLbGinrU2tpnvbJNy/0M88+2XZ1vOzTMFdVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647928; c=relaxed/simple;
	bh=JrjP+cxxwQctHpBi6PyjZFtDkVVFpWStd9Gbslehly0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOsVacNgBOXo+YtmekmP7dFmzy6HCS7pC5T5XyhToMfmwjTMr3QfYiKI9gfy45nCUsjgJy1NRKWLTpRAkeZ4s0mEilb1wcC6mzQwJ/KHSHh2c8QnZ8Xq7yq2gTWdlMXCcaxrOQpMIpoq9t5ti2wvLJGMvTek7yus8h+Sr94e/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dci08xQs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dci08xQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469E3C4CEC3;
	Wed, 18 Sep 2024 08:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647927;
	bh=JrjP+cxxwQctHpBi6PyjZFtDkVVFpWStd9Gbslehly0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dci08xQs+rA99K5my1RjRxwtXYoJ3hoXkT8iaivwjaTplbMC9rdH6F17pvpr2qTFc
	 yuq07BgPLxJzmFVXzX5YcXUm3LUCQoUFvKRNQxleoSmNjDs8hnLAk3rg3xQN30xbU9
	 OzD5HJ1PMGdycp+Y8fFimA50uYGw/1qnqeLV9E7wzOb9CAkNgTsn33aj1dlPDb+eA3
	 8vJsUbeH1as6lcMjiWuj0HmYinhYMV4FKVtpWnqOcSAlN8cq1OLK5u3bQ3ke6bhvWz
	 SuqYWfdgoNlUJxB/dMfO9q1x0chio2n0yKSbQsFN0lFsxqHrAS57xzjL8egDcZcKml
	 hYa2sTbyq89eg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/6] Squash to "selftests/bpf: Add getsockopt to inspect mptcp subflow"
Date: Wed, 18 Sep 2024 16:25:13 +0800
Message-ID: <a52d982b832d80c33fbce67a307ad034415c710a.1726647599.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726647599.git.tanggeliang@kylinos.cn>
References: <cover.1726647599.git.tanggeliang@kylinos.cn>
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

