Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D03199FB2
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258929; cv=none; b=nTeFDAY08jGdEdSmtzpXa8+ndKl10l4J5zu+pPpXBA6CHjVC2mlPGPacIkMDYvQcQINqQSLHFiKpz5maJcTIL5zBXq4bZdRih++P/Yvyp6mmPyrMJ3QwwPqw1N2RjYZnsTxiAteLJB9brePNdYIGctO1zmaf3Wp5Og75kj7GvpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258929; c=relaxed/simple;
	bh=O3BqlVHdCPYXt2mjOT4Pd7KhPSnVulTQdujQqr43vag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk6xPmOthOxh1tjAp1jkS4/i9eEae7PwaQyIL59pPx6Bs3+lNvT22A1MPqVvCa8o3Wvf+BA08b9+kkaQyRuHCaVvHPN+clrqT5znjfeKRgUpwnVGqfaRMRUZIWn72qJ5jVI4vi0rGXUr5UB/JRAVD0Ebj7zh5zn76H8WxS8mX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTpdj+7L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTpdj+7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FCBC4CEE2;
	Thu,  6 Mar 2025 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258929;
	bh=O3BqlVHdCPYXt2mjOT4Pd7KhPSnVulTQdujQqr43vag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTpdj+7LRfCgAL97hdFkaQ8/DK/XPGicX1Zo3jYLgy0aQeOwAtNYE4vf6P4S6AQ/x
	 1Zi3KopXxBHprdEM5QZ3q1QMDQ4aOrFIvxF5ZIUrpihdkUhPUZMzNbcOdWVBo8JEb7
	 fazZSGirp4cXqTu4Me/RzDHTcFBFVnGlBFQuFTYaIC6FkuVu8rNt04CGLnOsvUKhBi
	 pchTgm+MibVQKVJbprkaFKGhIU6EZ58iD+eUDclZsPgafdMMLrMxgiW6iS6VmaTtyI
	 81iuWwcIEFrRHQK8WSr+PIb98mOWGJk1xGX2PUSTXtI980hg6hoyNKsY7MNDpLeXq/
	 ErU3IlrBb3H0Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 10/12] mptcp: sysctl: map pm_type to path_manager
Date: Thu,  6 Mar 2025 19:01:45 +0800
Message-ID: <f96a373f1deb84ab24623e546067bdf47c52bb57.1741258415.git.tanggeliang@kylinos.cn>
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
index 6a35e6bb0a63..357083977ba5 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -228,6 +228,29 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
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
+		char *pm_name = "unknown";
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
@@ -272,7 +295,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
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

