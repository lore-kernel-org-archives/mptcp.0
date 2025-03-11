Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4E3360
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675606; cv=none; b=scKmof6Y1ChSrjof7MY37plQpcsBgpWqdHj2iUMqykVJTeY5JnlqfPFuNUQoyIbf/bggOg9tVWZa1YcRKyXaqL5fubkCQW4FRZe5wIpyG/NOePfRmenXH7tjBXfa6AtoPc6tmfslV5vAWgbrXMEI1JANvw3R73lnwp0uqUDRWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675606; c=relaxed/simple;
	bh=+nH88dP7Lw4AMHof9Ds35NJJ1HWFILVKR2SC2Nd4XYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5x9sWvU9y9MOhgKdj+YugEIDP4SOmOhoc61UEHRqbYs9PiqBgjqgjtOqgVUrRKNAn1ut+CLLDJoAnhbmzQkramwdpQ6Z85I2nl4L0I0dje1hcY/YYuVA9TRyBLnq7fdH06JMDVg9kk3QnVwrxVtXAUgowzY2joEwr0SIBGwGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSg6BLRi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSg6BLRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7BEC4CEEA;
	Tue, 11 Mar 2025 06:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741675605;
	bh=+nH88dP7Lw4AMHof9Ds35NJJ1HWFILVKR2SC2Nd4XYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WSg6BLRiKEwjX3H4XbGcnuE0pwuj8Rqe4S6et2XnJiEFpWArlW1uhkqScAkyfqDS3
	 4qgejiBb/nuP0KvHl1mKWGtmPQO7UR8CouexMhD8yqBrzqzLDMK+Y99s+ojTCEKZ5V
	 XwbMzSu9w5/Hfa+aKn8DMmwVS3SkPnroqg6C84RiDP+hDaJL/y/xwGZpHV1ZbXmbHa
	 MqJfc1u8bbT49KDhkdiEPk99W9wq5ZRfUU+9PM5QHc/XNXOoNrhgAJ9h1NAV1+6sz2
	 QYWUbpoEe2atIF5m5TfKkS1Eiuv+n/ADFfu36mTq521GgIh8zw5+SQ9JaAVzX3zvfY
	 ub1H8g/ZRmruA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH RESEND mptcp-next v11 07/10] mptcp: sysctl: map path_manager to pm_type
Date: Tue, 11 Mar 2025 14:46:24 +0800
Message-ID: <3bed5ce4e4cfffaa7e41a449e80827faa70141f6.1741674285.git.tanggeliang@kylinos.cn>
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
Message-ID: <20250311064624.qXWMrv-9k5mQVc8dcPnowtuEjfhlOXSAK_t70A24tek@z>

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch maps the newly added path manager sysctl "path_manager"
to the old one "pm_type".

	path_manager   pm_type

	"kernel"    -> MPTCP_PM_TYPE_KERNEL
	"userspace" -> MPTCP_PM_TYPE_USERSPACE
	others      -> __MPTCP_PM_TYPE_NR

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/ctrl.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 4209dc7f9704..cb0811e636ff 100644
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
 	char pm_name[MPTCP_PM_NAME_MAX];
 	const struct ctl_table tbl = {
@@ -211,8 +214,18 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	strscpy(pm_name, *path_manager, MPTCP_PM_NAME_MAX);
 
 	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
-	if (write && ret == 0)
+	if (write && ret == 0) {
 		ret = mptcp_set_path_manager(*path_manager, pm_name);
+		if (ret == 0) {
+			u8 pm_type = __MPTCP_PM_TYPE_NR;
+
+			if (strncmp(pm_name, "kernel", MPTCP_PM_NAME_MAX) == 0)
+				pm_type = MPTCP_PM_TYPE_KERNEL;
+			else if (strncmp(pm_name, "userspace", MPTCP_PM_NAME_MAX) == 0)
+				pm_type = MPTCP_PM_TYPE_USERSPACE;
+			pernet->pm_type = pm_type;
+		}
+	}
 
 	return ret;
 }
-- 
2.43.0

