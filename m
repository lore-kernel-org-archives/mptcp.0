Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E47A212D6F
	for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737554154; cv=none; b=TvN0l00pqATot4s2Chnxf/6+GzfzZu/rPlr1jwQgGKC1bdh7JXaZpHozkPI9r4pqsDCa7pR8MrQ4iGMhMwm08GHyJ9oaqftLN8GOsq82yr34Ko0dY8JBtb+LK87yHmQm1QYBDNNjdWzJ/b5lxHgoRTuKgP+ggozXTfnuYlNzNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737554154; c=relaxed/simple;
	bh=6my1Uy8RssU82hoTwXzmuisKAx+h+mBEB3b5QQX3fC0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CPGuiHLg2NfcRdexclx9XyYd+t6fFxH7FwiFz9tPU2cOXATNxp8O1UexiOuYbfmUIWYSKzurz6QFwPLhn3qApnb/hmr/TVbcXfk3Z0ZYWuYmLIIh3+HS3w/fAPvzSk7rCjYdTrMMzVsQ/ImIPEMZy4eMhnYR8AUoZUO8qCFxBBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9sU/v5f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9sU/v5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF67C4CED2;
	Wed, 22 Jan 2025 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737554154;
	bh=6my1Uy8RssU82hoTwXzmuisKAx+h+mBEB3b5QQX3fC0=;
	h=From:Subject:Date:To:Cc:From;
	b=F9sU/v5fR02s18bJ2HsL/ELnWerRkoKhISDQ6LiiEKi1gAaU1Ca+YDTxNmL+BjTvA
	 sL5aMsyDEl8C9VQGDOYhIXYJXQPyyAC411RnKCe0yuxy5kiVFEoUqQk5KA4EfLmvCu
	 8pZZ6nORnhVTPzrlLe3pZF/O6YfWXCRNCqUc7Oudud6lmU9mJQjqHaonLb/B4uVRBn
	 8NupSXZyFGBynl/+fEb/Cb0it06dg8L/sEQqPKbwXEyA+c6qTLSsNbfpa+99MUBuHm
	 HqF3kbkfsLsoMC3dbnGJU2tSbnCQaZoTkUJo/+2RyjOxJiXIbGNKmVqmslyNqH8azn
	 NyuCrwqRnPsEw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v3 0/2] mptcp: pm: only set fullmesh for subflow
 endp
Date: Wed, 22 Jan 2025 13:31:43 +0100
Message-Id: <20250122-mptcp-issue-540-v3-0-4aeed3022f23@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC/lkGcC/3XNTQ6CMBAF4KuYrh3TKeXPlfcwLloYoFELabHBE
 O5uUzca4/Jl3vtmZZ6cIc+Ou5U5Csab0caQ7XesGZTtCUwbMxNc5ByxgPs0NxMY7x8EueQg6xZ
 bnWWyUDWLq8lRZ5Ykntm7bGmZ2SXeBuPn0T3Ts4Cp8dcNCAiaayUaFAXp6nQlZ+l2GF2fsCA+g
 fIXEMBBYS1LyTudVfwL2LbtBeCEzTv8AAAA
X-Change-ID: 20250116-mptcp-issue-540-49d1db3346a9
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6my1Uy8RssU82hoTwXzmuisKAx+h+mBEB3b5QQX3fC0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnkPjoC4QJBH26jnSNYj1YJNCF57NYW+nksMJsH
 SADhkMB09mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5D46AAKCRD2t4JPQmmg
 c7b3D/0S6YQ/1jsgKxgNX51WHn/cx4r841b/0Ebh8JSzr2GXFl4Li8xcOpMbTBUGoAYRdzoYYj9
 Lak7OmuA1ZwAtfOGzBV4nfL/rO4CbpwJifvObok+KwOSl7tOHTnb9pt15IV7Rw2tE9aIQrANyVa
 MW33A4H421CvMPY3kBXzcfm6xMEyAd1Mv/VdZ+XH93urCUwR9bRETBU7g16m3jVxWrKYngeSZfk
 F0+CJfvclixyMXu31I3ATQnMRcsr+P80+Jp4SKmOF4qOfJnY9tSs7kQfRe4yNejyd/oRj5nFRaX
 qUAWSsISOY2n+4poYrzoZx0qyPoqFiudfQElQIwKC49Rx5v9L/GfYHR4MH0KqOvJNXElTUAnDCB
 Z4rsH7uuysG9gcs9543HIz5jfjFCdwxxo4dCuV1Mju9xezlt3NWdX4+0J0l6m38isPNp6QMOFRR
 yQZgklGkjb6wRSKFOF09Ugfj3ssZsZlGvzrmB13/mcO5Tl9FJwHFUNz6/zRqCLjDym+XfmCK427
 ryQxKVHpqYqdzGucjeFOtBvGPpWaVX7Kxw2d1sw7PQtwzeAzan4DO0EsGL8H42zmrttIpg2hnpT
 23sh623xNe7AAhobKhA6Jt516XydVNyfStuyIn5gj4Nr/64mWWRCQ5l3kDptQ+sJDJJ+gZ7d8KN
 DUaZRCQvJzaVfFQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are a few patches linked to the 'set-flags' interface with the
in-kernel path-manager.

Patch 1: a small cleanup. For -next.

Patch 2: a small optimisation not to iterate over all subflows to do
         nothing. For -next.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- the previous patch 1 has been applied
- patch 1: add Mat's RvB tag
- patch 2: clarify the modifications: new comment and description (Mat)
- Link to v2: https://lore.kernel.org/r/20250117-mptcp-issue-540-v2-0-a194740fb380@kernel.org

Changes in v2:
- patch 1: check the two flags in one instruction. (Paolo)
- patch 2-3: new patches, for next.
- Link to v1: https://lore.kernel.org/r/20250116-mptcp-issue-540-v1-1-b0ba2c126eb8@kernel.org

---
Matthieu Baerts (NGI0) (2):
      mptcp: pm: remove unused ret value to set flags
      mptcp: pm: change to fullmesh only for 'subflow'

 net/mptcp/pm_netlink.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)
---
base-commit: 8c4d55afa2c3c2391af5d975ab3b1a5bcc140101
change-id: 20250116-mptcp-issue-540-49d1db3346a9

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

