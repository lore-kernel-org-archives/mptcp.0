Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679213C9D4
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975924; cv=none; b=rZUoh1kOU5hGD+L0TPMDY3RB1A5EkUgoN2nwfIBZZgvzzohzk/wXMtrulWvbAnQNZTdW8rWmjC8JTQ/695wMNXUbCmXtO03/VMRSyB0bQXgR3CGeAibj4qekzpedqCwY7bB+AT5piqR3PaBL3J++BMDQ0c70ulr890hg84ZY9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975924; c=relaxed/simple;
	bh=YtKENI08o18Gf4DbWHU3CEBLRmY39APexWCyAjvkW6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkFSaRktdg4DFaggaETPIS9QLPO6QA2o38EbSnP12JMv+y7paQV/clKQxcpN+fdmUBZlLrey1NWsBah/C7h4k46MiPrEW97WAM8sOACKZI4kVslboy4//+PvlSZFgc3cB0/arzHw+fz9wmv7Pgqh9uSnsQAcjJaCr86IP9niPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B69dCpfo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B69dCpfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6D1C4CEE4;
	Mon,  3 Mar 2025 04:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740975924;
	bh=YtKENI08o18Gf4DbWHU3CEBLRmY39APexWCyAjvkW6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B69dCpfoA+pud7n0HnYwXMo7mv9NoZ5wW25nwocUGGrlh4+C5Sn2OPCGok/T9QSWE
	 8DqMnJRRojzs8FnNJEBFX2uw8zd0b8zZQIgRJTI1KufNREfRS7vokjdsXtY4A/y886
	 3LJAFq/bFLJmAFQL1De9A3BEQYkGmMEoIf61tnaf7QP5GmZWjN7A/xPwlHe7hueKxH
	 Vn1oX9ewz2J+4lWbdoWVEqaGtIknkcHrZ5PcBBw2C+nifFjzWkBeHfYjZRDsSFuqzP
	 u1/1UW9S3DyZL0WKB20IcM2QUjmUEOWbO0FuSVOLwnnwJgDQvVeglD+zQ+ZMGJkJmt
	 cbxEGWMu1WlrA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 03/11] mptcp: sysctl: map pm_type to path_manager
Date: Mon,  3 Mar 2025 12:22:51 +0800
Message-ID: <8840912119ce5a1180550745d496087ac7e81fa0.1740975633.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740975633.git.tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
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
 net/mptcp/ctrl.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index d64e6b4f6d1d..32f13ab7db0a 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -217,6 +217,35 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static int proc_pm_type(const struct ctl_table *ctl, int write,
+			void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct mptcp_pernet *pernet = container_of(ctl->data,
+						   struct mptcp_pernet,
+						   pm_type);
+	unsigned int val = READ_ONCE(*(u8 *)ctl->data);
+	const struct ctl_table tbl = {
+		.maxlen = sizeof(val),
+		.data = &val,
+	};
+	int ret;
+
+	if (val > mptcp_pm_type_max)
+		return -ERANGE;
+
+	ret = proc_douintvec(&tbl, write, buffer, lenp, ppos);
+	if (write && ret == 0) {
+		char *path_manager = "kernel";
+
+		if (val == MPTCP_PM_TYPE_USERSPACE)
+			path_manager = "userspace";
+		mptcp_set_path_manager(pernet->path_manager, path_manager);
+		WRITE_ONCE(*(u8 *)ctl->data, val);
+	}
+
+	return ret;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -261,9 +290,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.procname = "pm_type",
 		.maxlen = sizeof(u8),
 		.mode = 0644,
-		.proc_handler = proc_dou8vec_minmax,
-		.extra1       = SYSCTL_ZERO,
-		.extra2       = &mptcp_pm_type_max
+		.proc_handler = proc_pm_type,
 	},
 	{
 		.procname = "scheduler",
-- 
2.43.0

