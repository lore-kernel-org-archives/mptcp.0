Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776731FCD00
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088451; cv=none; b=RwHdFKlT1/p8x1CNpLLXcMuC6nemB092kjJdfPorsIaK0kXhUrzvMtNCOJcUdbct6uhH67fHQP+XjplHn4A3W+hppHS5Z6n93BR4YCGKze+wdiznvCVPXosLWmqBOMbD/hA7LG+4NsXUL1UK8bk38Ba6KK/nqLuhtQhPQMOQSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088451; c=relaxed/simple;
	bh=PG/XnEEn89IvGx7J1zeFTk0Clq2WvrZ5pQN/VQ+Xphs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qM1oJ46hv8LzQtvNSWkySDVyf3I/JW6IBzTIZOd+Xd2S2M1Yx67yXun+txmMWIz7v1pyfDvZXYSKEZ2gRBvSBx0d3CRWwwXa6sRAuGvVU60/7T9FUevme2Xn1jK2oyoYbgYUE/6HoYj0tIcYz8561Tfup8NllIKQDySxEoyA+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRVR10tp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRVR10tp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292FAC4CEE5;
	Tue,  4 Mar 2025 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088451;
	bh=PG/XnEEn89IvGx7J1zeFTk0Clq2WvrZ5pQN/VQ+Xphs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRVR10tpn1XQMDUyPjEbCX6320/VnVLRFHHIAKKUEJIi9SudVA/q0HuiB3oXVV9l5
	 +DzucWPGsGi3PG7Yz2g3XcH3FctixdY+MyHy43QvKY2NWCeaBjBcRuMWzWLwMVg6Df
	 an5m2ovHWL2Ghv95CjCLTL0ADEo+rHIXOAQSL159SrtH4AbY4z6azbNqAKf0F18xZi
	 OT/e1ISnxcpxWbNQec58LQHzl41o8KCwaxIEe4ml+SkpP6sefvzleAA+twOT9t0qPf
	 2T6t+9LBPQlFRvJm+IUCKEVUJHt3jYm07/hp7PYlu3yvqYG3RiqWieCx8OjStDEk6I
	 ljisOqvUBuMxw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 03/12] mptcp: sysctl: map pm_type to path_manager
Date: Tue,  4 Mar 2025 19:40:30 +0800
Message-ID: <4edb40bf773e65c00d4447f4795cec26f9a047a3.1741088339.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741088339.git.tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/ctrl.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index d64e6b4f6d1d..d425fcbd036a 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -217,6 +217,32 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
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
@@ -261,7 +287,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
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

