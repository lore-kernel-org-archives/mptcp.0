Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91820AF77
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258928; cv=none; b=HEXnKddPGegvVjozn/1vFGN73T84MaK7xt2dbXoEW1bqCep8a0v4OtS4sPs95MXjsTAXgJoV4YHMILMBOX6i5Fqqsd6c1Ss8Elo0pXo0kxuDfCbcsoFZ0m99Un0lKtPCuI+jHX2o3xXfwys2m7vcN6jb/x8bz45u3lZr/7+RfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258928; c=relaxed/simple;
	bh=97xTs12ZbUzEOHSOJpfpvHRzydUPy50SHjQXmO5DWr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Da1/iHwIo8APZpn6bCMV1ZvBepGeCmdF4WEsaMjs3UiZfC4i7DaCuGj1DBr+5GLOIZZcxtuTRBJoSzSbtyUsUbffBhu/jzYh3O3eZqayiCnnKbYeU8+CSSzRkzAW4dpUv672aLjLUKlBNkh7/uLH53zzkhc0huIcMf7W58mGR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s65E02fN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s65E02fN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D107DC4CEE0;
	Thu,  6 Mar 2025 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258927;
	bh=97xTs12ZbUzEOHSOJpfpvHRzydUPy50SHjQXmO5DWr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s65E02fNns0drj3Rga38lC1MhRFYkjGXK1aEys1iRiXCaYOGCb4KhJpLhjtXKv0Q3
	 1l8MEVqG51TNqOt48TjC/w16mazeTcirbULfnFWrycuSgXNF9isb+gjGehvBwBVEVZ
	 W4og7mN6jQP1Gx6YyJXgtfBn91qEiEewh98XmNar0UXCTlrDT5/qvCwS8E7CvqgdM3
	 +/HAtasTe0Yuno27WbMN4HUiOTIF74F3aCrqheIaH8Y7nxe+VJqGtXtDgE1Cje8xf7
	 qEatGuBPCKX+5S2zIljeIp967ELpUhKYunIpG92DB8w5cVC6yvuQ+6GL5Yifv9/tzj
	 M8u14LEcjs32Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 09/12] mptcp: sysctl: map path_manager to pm_type
Date: Thu,  6 Mar 2025 19:01:44 +0800
Message-ID: <a38a4f3b6cc2ac7082401a22bc33eb0d844f0b37.1741258415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741258415.git.tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
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
	others      -> __MPTCP_PM_TYPE_NR

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/ctrl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 1f405be6bc00..6a35e6bb0a63 100644
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
@@ -211,8 +214,16 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	strscpy(pm_name, *path_manager, MPTCP_PM_NAME_MAX);
 
 	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
-	if (write && ret == 0)
+	if (write && ret == 0) {
+		u8 pm_type = __MPTCP_PM_TYPE_NR;
+
+		if (strncmp(pm_name, "kernel", MPTCP_PM_NAME_MAX) == 0)
+			pm_type = MPTCP_PM_TYPE_KERNEL;
+		else if (strncmp(pm_name, "userspace", MPTCP_PM_NAME_MAX) == 0)
+			pm_type = MPTCP_PM_TYPE_USERSPACE;
+		pernet->pm_type = pm_type;
 		ret = mptcp_set_path_manager(*path_manager, pm_name);
+	}
 
 	return ret;
 }
-- 
2.43.0

