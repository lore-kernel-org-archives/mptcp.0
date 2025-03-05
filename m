Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FD2046BF
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172411; cv=none; b=Fp5ABMrmh6dcIMINWo6qWV2lej44V0tDZf3A6xS0LYyPk9e+9P4LNaVe29dJnJ3Y3rltLV4OPGqkjDXn0SO5PxNM14ns/MEMqiseZK0o5HYfEqvTNfLx+SB5i0EOKKbJFsKN9XCWx0p1qztZF49k5PyzT3dZUVH6mfBW6wnJpCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172411; c=relaxed/simple;
	bh=ncPlHSpl3wroyFeG6CM2MYz0Q+Tyexe5AhYAyEAY8/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJpriv2OpkgciuI2e9qkJm1fiJ+UeiwzC6XHlw8M1TNFWDA5qnz5HjZnUsTzdaLhyI9luDXIblSipwz1+NGMCnY1SpxjgAicRvU05x3Jcj38bYi9qxVBwyXPZWEcZDOKgq0O30qjT0nQJ9gfSseUh3ZWE32EqfiXruUwQCkJ58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOny7tKn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOny7tKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AF6C4CEE2;
	Wed,  5 Mar 2025 11:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172411;
	bh=ncPlHSpl3wroyFeG6CM2MYz0Q+Tyexe5AhYAyEAY8/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOny7tKnSC8GbMTdzoauMZiHWQQwHOkt8M/jh9+bTYpc0cM4vV2FqRSw68dqPuG24
	 KWo+XFEdwPtbMFY/EiBfnm0Cd/BLMwgyj5AGXi0sNpS4iRB8G8xWgm4vX7Qwf2A6+l
	 XHPJivucppQ5hHNV5ARlTMKJFSakMHxC0cBYFefuwQLKKAwxfLnsprSOekCa2gxzps
	 6Atyv6H+JK13ls6HnMwUa+oHHGg6v1I/rJtaX0rxRWVE5Yj86tRWSl2EXgQD5CpVhw
	 kCy8Rl167rr7zM45TrU0BZC4VEhzaQHmaEQ0wuMMsT38hWtDjF9JmiflTQAJq+r5Av
	 CKdJK6WH7PyhQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 04/12] mptcp: sysctl: map pm_type to path_manager
Date: Wed,  5 Mar 2025 18:59:45 +0800
Message-ID: <8cc85a63af73b3460868905e15678926a01cebe3.1741171898.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741171898.git.tanggeliang@kylinos.cn>
References: <cover.1741171898.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new proc_handler "proc_pm_type" for "pm_type" to
map old path manager sysctl "pm_type" to the newly added "path_manager".

	path_manager		   pm_type
	MPTCP_PM_TYPE_KERNEL    -> "kernel"
	MPTCP_PM_TYPE_USERSPACE -> "userspace"

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/ctrl.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index fe06be11dc83..a158a337cdb5 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -226,6 +226,32 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static int proc_pm_type(const struct ctl_table *ctl, int write,
+			void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct mptcp_pernet *pernet = container_of(ctl->data,
+						   struct mptcp_pernet,
+						   pm_type);
+	u8 pm_type = READ_ONCE(*(u8 *)ctl->data);
+	const struct ctl_table tbl = {
+		.maxlen = sizeof(pm_type),
+		.data = &pm_type,
+	};
+	int ret;
+
+	ret = proc_dou8vec_minmax(&tbl, write, buffer, lenp, ppos);
+	if (write && ret == 0) {
+		char *path_manager = "kernel";
+
+		if (pm_type == MPTCP_PM_TYPE_USERSPACE)
+			path_manager = "userspace";
+		mptcp_set_path_manager(pernet->path_manager, path_manager);
+		WRITE_ONCE(*(u8 *)ctl->data, pm_type);
+	}
+
+	return ret;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -270,7 +296,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.procname = "pm_type",
 		.maxlen = sizeof(u8),
 		.mode = 0644,
-		.proc_handler = proc_dou8vec_minmax,
+		.proc_handler = proc_pm_type,
 		.extra1       = SYSCTL_ZERO,
 		.extra2       = &mptcp_pm_type_max
 	},
-- 
2.43.0

