Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBDE221F2E
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172410; cv=none; b=TIZ7q3otl61Rl+ze90QJDHWFETjbJ9+0sPSQG3iSejhoJUdsXL/PTNgK3lmqiH9KF8Hpd0/p37f11KK/yU5Z6sr2TilRpSRLbjOfYMD6iE2wJFc2gAKH6lTO/1cOoQgM3hel17q/oVrYtypmwMi6zUWtsi4IQWCgMuwiSE8t+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172410; c=relaxed/simple;
	bh=ppIVdsbAzhhY0inaSHQyxu5FUK3NzRkLg0s4dP9jnYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6Osf8AYfMBGB8NzIBW4UgZvmMgYQnrqgth3vA2zNFVhJ3JNsn2PMhg3dhqJKYCafiH3+jumqNry7BGDBigvWGnz7HngYKIe/u/ee39bJaHi1dR8BrFSlNC95UwwqrufV3kRRm/N9Rq/eAaKN5+9yQID/dXeRje/cphfyFUNwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkm+Kc/v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkm+Kc/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C2CC4CEE8;
	Wed,  5 Mar 2025 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172409;
	bh=ppIVdsbAzhhY0inaSHQyxu5FUK3NzRkLg0s4dP9jnYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkm+Kc/vtPmb/bxncsAnlZTz5uJd7AHoB1PMgxjYkR/zLZOObfNmuDp5ZtLBOzw55
	 6OVqELQFyoqfzG5gfFUXVcxqt1QWrcp5hcetSxJiMm6gwgmzJXb/8fsuH1gTZGkZuX
	 Vrauou2qlr8vkya+/QEXk76paG6mijgfjUzae7yDtlkhFTV7waWNp9bMdbFaE9ZGP9
	 KfHM9/ulV9eg/D/jP2h3VWEy9PVeHPbG6CjFhHtEwtxgRG78r9cHRr6dfPcdijrAgb
	 qk65Pm9Yf5EpVIFB3d9bD2zZLZi4Cbj+XgPnvD7jN4kIf/fptUZk/O6JikGNO4SSkS
	 Z7wOHml+HpzMA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 03/12] mptcp: sysctl: map path_manager to pm_type
Date: Wed,  5 Mar 2025 18:59:44 +0800
Message-ID: <1a5c165f2e139c2afffb71e4032fc2090b4d4b08.1741171898.git.tanggeliang@kylinos.cn>
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

This patch maps the newly added path manager sysctl "path_manager"
to the old one "pm_type".

	path_manager   pm_type
	"kernel"    -> MPTCP_PM_TYPE_KERNEL
	"userspace" -> MPTCP_PM_TYPE_USERSPACE

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/ctrl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index d64e6b4f6d1d..fe06be11dc83 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -200,6 +200,9 @@ static int mptcp_set_path_manager(char *path_manager, const char *name)
 static int proc_path_manager(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct mptcp_pernet *pernet = container_of(ctl->data,
+						   struct mptcp_pernet,
+						   path_manager);
 	char (*path_manager)[MPTCP_PM_NAME_MAX] = ctl->data;
 	char val[MPTCP_PM_NAME_MAX];
 	const struct ctl_table tbl = {
@@ -211,8 +214,14 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	strscpy(val, *path_manager, MPTCP_PM_NAME_MAX);
 
 	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
-	if (write && ret == 0)
+	if (write && ret == 0) {
+		u8 pm_type = MPTCP_PM_TYPE_KERNEL;
+
+		if (!strncmp(val, "userspace", MPTCP_PM_NAME_MAX))
+			pm_type = MPTCP_PM_TYPE_USERSPACE;
+		pernet->pm_type = pm_type;
 		ret = mptcp_set_path_manager(*path_manager, val);
+	}
 
 	return ret;
 }
-- 
2.43.0

