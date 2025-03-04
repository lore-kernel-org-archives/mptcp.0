Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B8F1FCD00
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088453; cv=none; b=uP5NShZIbvCV2+qJrlsP//rt87qSM0l3fYCM7ot9DbogwbHouDR9XUVyjmLyoZ4DAqPq2cGKmBfEdyGGuxkw6chLDySdXReyv9L3KdtW/S0UWgzyDWGAWgvmsVIXQJtHtjhpHr+qqXoT1fKDvckXvyDQ34MxI84Lcd5tQtAQfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088453; c=relaxed/simple;
	bh=IwS3BFgFmFv43uUVZdWzQ1w6iSYB3L/icJKvrdhmUYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANdO8jgnDnofnN62Cxjq4HMqsDIOIW/0jALQ87sJIK3c8wH6foyVUJyBMw8FtigtWLnku1Z9rbtxipWHOrNk4ukect31pFsgHkTRwGNkwodpoiJhMOuKJYMCWRH68L6MjVWjwXbkR2U9vg9D1iWkvkzaxfzAX2ylNpGrSM+yvf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY4f+wID; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY4f+wID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028C9C4CEE5;
	Tue,  4 Mar 2025 11:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088453;
	bh=IwS3BFgFmFv43uUVZdWzQ1w6iSYB3L/icJKvrdhmUYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NY4f+wIDJsbZYRh3kxnIXkWg5I/ywt3JM+MMJ1K5e5WNHyYl/c5p4r+/wxMf6G992
	 46g1PbV8qiTqw60mSwqMWJS7J04uoAvLS/Vn2nMsTr8QbnNq977pe+KsdOEuY15+Ru
	 f7LMNQCYUPV5a/RCm1LyxhfdmuH37ZA9eSBe8fyw1x6r6blgv6i6yqxbXuu9r+IdkY
	 Mf1PsFSjYyD7DPiACVorhHKdsl+AZgC0AEJJSCZyogHqCKraOU042aM/b2LFfEPIUc
	 eg7kv/fNFR8Nslw0KRrlmlJxfjpDEEUX/eDojl6sr1IdqasW73R3P++wVnKgo5wW33
	 ud9pfCUT30S4g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 04/12] mptcp: sysctl: map path_manager to pm_type
Date: Tue,  4 Mar 2025 19:40:31 +0800
Message-ID: <c83ba5bf407386ae9160ce1e570a93d3eb74e3b1.1741088339.git.tanggeliang@kylinos.cn>
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

This patch maps the newly added path manager sysctl "path_manager"
to the old one "pm_type".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/ctrl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index d425fcbd036a..a158a337cdb5 100644
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

