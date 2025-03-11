Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F336360
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675608; cv=none; b=N66AijobjDHeyHzh+ZUOly70N3Y8MtpIOqo08MNI6cTuGuQ14UtFFbW4j5Hpe9/jjs6fYa9uvSyBqS/U544JLscvQEebg5YHTGiamWSzdENO/QATvbaAyBUVfUkNwIq/bnLASdHnufVdrjw9Q8UFDOLqlwGqEGaFiLk9uIkoxVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675608; c=relaxed/simple;
	bh=MKe8F/fmlAEcIbExfzRf3fT64Ho8ImNHvcose8ARXjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ig6bnLpiFzXi0Ml0sFOkkR6Hp7H5gGfKoY5yMyONBs8fd7A2Mr8PuzD58bC0h0P2Cq3ViVA5nS901zj/24iVV6C+pQdL0WlWmjUa9izlEPRqxA5l9S11sLejb7YWFOmJZevoN7fPJUQ7kBrpp7qHNg/oKd7uxOPVYenYnh6UuhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKnKUWT5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKnKUWT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777D1C4CEE9;
	Tue, 11 Mar 2025 06:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741675607;
	bh=MKe8F/fmlAEcIbExfzRf3fT64Ho8ImNHvcose8ARXjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKnKUWT5dmVK5LLm4nZyOKVmXJgEDKwBANb0dPJPTqvkoiHk1jFmHTGM7n0B/Iyvs
	 lOIqcRJB+j0sL6cFH+XkeJv8762Pgclj5ZUsp3dBOV6OomWo3nCudHSI6wd69FJhSn
	 MuB/WjW7wJFRWlPkbQm6YFlmquCSy1+ob6zzJklBuyscrX8H+F/AlG+LYJwgiK6xZ4
	 4DHMb+Dd4yyKq2jtQMHvR24QI+BhTqm40t7iummy/xfMNL2QC7J0FlcjJE9JzGvVh5
	 JyxLSRARkNiR7Xs0UY8mHcs54iWuFVsrSCJyqhuDLBffeEQrqux2H1iSsrTOHTISvh
	 o821vKybiJOJQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH RESEND mptcp-next v11 08/10] mptcp: sysctl: map pm_type to path_manager
Date: Tue, 11 Mar 2025 14:46:25 +0800
Message-ID: <b723f9705135b69e2d788bb0ff4020e819f558a2.1741674285.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741674285.git.tanggeliang@kylinos.cn>
References: <cover.1741674285.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20250311064625.jOuaWCthes9yE4ZoPPPhhJ2PeHuAqMhhFw0hSBDVl9g@z>

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new proc_handler "proc_pm_type" for "pm_type" to
map old path manager sysctl "pm_type" to the newly added "path_manager".

	path_manager		   pm_type

	MPTCP_PM_TYPE_KERNEL    -> "kernel"
	MPTCP_PM_TYPE_USERSPACE -> "userspace"

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/ctrl.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index cb0811e636ff..4d8b31f32eb5 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -230,6 +230,29 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static int proc_pm_type(const struct ctl_table *ctl, int write,
+			void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct mptcp_pernet *pernet = container_of(ctl->data,
+						   struct mptcp_pernet,
+						   pm_type);
+	int ret;
+
+	ret = proc_dou8vec_minmax(ctl, write, buffer, lenp, ppos);
+	if (write && ret == 0) {
+		u8 pm_type = READ_ONCE(*(u8 *)ctl->data);
+		char *pm_name = "";
+
+		if (pm_type == MPTCP_PM_TYPE_KERNEL)
+			pm_name = "kernel";
+		else if (pm_type == MPTCP_PM_TYPE_USERSPACE)
+			pm_name = "userspace";
+		mptcp_set_path_manager(pernet->path_manager, pm_name);
+	}
+
+	return ret;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -274,7 +297,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
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

