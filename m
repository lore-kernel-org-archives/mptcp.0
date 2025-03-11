Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE413C3C2
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674749; cv=none; b=Rv83Kev57OYjmYB06+OWCT4xevE+EdeZp78ZwTvzqWfEZakYYSFKsZPkzuAbBe2wOG8ZSf+2GVjBrivw/Qe5u1oJ2sdqDgx396Kvh319ypmW0V6g8QLoFiHfG7mWXCoYZ/T/y9SlnS1klRrmWyE8Hsg2HOCu27S2/Eob1rG+JgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674749; c=relaxed/simple;
	bh=MKe8F/fmlAEcIbExfzRf3fT64Ho8ImNHvcose8ARXjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8VyHXpyyLc8JMD3bSrUhT85j+9TouNP4UXoOThDBa1a3cWOH6ZVZRgiuTG3U6ZDe7ItuyRtwmKkZBxHbGdE2UzwWH3MKvmu+RWfz/2ZZeGbAHaw9mv0KZAHf4II9BwvcbyTcKNtPOVGjsb+tcYqxIDIZ8Wsu/3wPZ6NHhvvFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvapMtBZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvapMtBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D456C4CEE9;
	Tue, 11 Mar 2025 06:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741674749;
	bh=MKe8F/fmlAEcIbExfzRf3fT64Ho8ImNHvcose8ARXjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvapMtBZLrxQj7vm6SQfNtd37uXyrtdL2lY6Q8WHIK3M5FRZPVtwstmL0wbvPagXr
	 J7/2rGRq97MBMvghyYWCEKfKH4XxtVxeCCzwD9loETB9I6aU9o68VA69+TjmwyPWRz
	 9xW+7gPw0HQa/82eczW9NkAvTGL9UGSYjZP62ObjVh0KUgdwRYR9LIqP7jNE4tgjcz
	 UaVp+q7ycN+7PFFmK61F+y6TAj11kzVkP6N+J4YlVcR5dJ8Pqee3dDKrESoCIrWxjS
	 V/T81arPaCT9AvNEPNBk+GJF1MLXmZVYGSM4Ltvc+zVpV7pKwHmepjFhM92Naohmo7
	 xhbcIAD6JgsvA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 08/10] mptcp: sysctl: map pm_type to path_manager
Date: Tue, 11 Mar 2025 14:32:00 +0800
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

