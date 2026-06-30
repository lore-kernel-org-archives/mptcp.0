Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBB39D6FA
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805377; cv=none; b=GHsdWm1ofislyQNnIRr13dXX9Q7czU2EMdN+bbyDck/efZFe5JGLqRULp4qnHCrw6SY1BQAetoccQJkKOpBFFDZ8cVO8wtPx88/k4JmPekVTV0P/gZ5s4aUkbVPjjjB6L8xvQCLJsrRbMjm11tr/1mn0ZD/H/8uEwAbiK9yBywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805377; c=relaxed/simple;
	bh=ScQQyHRvcuf2aB8+68qfGlYMq3fr8knt8/dwIXL846w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rapcaKYgNJtiNGFIidYsC/v77IZRpklVCRA8848ymfwVN4iY4e7riieGMdDi1hjzGcveH4aeev1CCGsD8g5jyiN8zuzSWqJiJrrktE9hBf14HFxoFMSOcDlEuxDLeJlcG6sp2Lw/8yU86l+cuWxTIE83HD9tGg0hLLPir9xWl0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hSnXmBbe; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hSnXmBbe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782805372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2FUU0f2DajN9sieHVybx8HhBETvwJJyO+g8NeLRjH1E=;
	b=hSnXmBbeTbsHLXUmX7bIuZaqPkyxzk628Sl9OGxYhkf7MGPMAmVwDZiuArOxoptA9AUyrk
	/dHJwSCO4v+2vemwDokH6kfL6BB+OLd/o0t7ieUqOmyeKFFfQYcyIKjQFnSBtPSpDFbx3s
	6775X3aBweo7uoKHM0m5bd2aecNAGyA=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	geliang@kernel.org,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net] mptcp: pm: fix potential NULL deref in mptcp_pm_ops_init
Date: Tue, 30 Jun 2026 15:42:37 +0800
Message-ID: <20260630074237.166076-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

mptcp_pm_find will return NULL when the PM is not registered. In that
case, mptcp_pm_ops_init will make it fallback to kernel_pm, and the
pr_warn_once will dereferences pm_ops->name.

This patch uses 'UNKNOWN' in pr_war_once to avoid this issue when the
pm_ops is NULL.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---

Notes:
    Hi Matt, Geliang
    
    This patch fixes a potential issue that might be encountered by the
    future eBPF path manager. However, as far as I know, this issue should
    not be triggered in the current codebase.
    
    That said, it could potentially be triggered in the future when the BPF
    Path Manager is in use. For example, in our current self-test
    environment, within a network namespace, we use a BPF-type path manager
    (specified via sysctl). If the path manager is unregistered and a new
    msk is created in that namespace, the code path would hit this and
    trigger a NULL pointer dereference.
    
    Therefore, I would suggest adding a simple check/handling here to make
    it more robust. WDYT?
    
    Thanks
    Gang

 net/mptcp/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9dc7b41fb562..0ba6dd25ba49 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1142,7 +1142,7 @@ static void mptcp_pm_ops_init(struct mptcp_sock *msk,
 {
 	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
 		pr_warn_once("pm %s fails, fallback to default pm",
-			     pm_ops->name);
+			     pm_ops ? pm_ops->name : "UNKNOWN");
 		pm_ops = &mptcp_pm_kernel;
 	}
 
-- 
2.43.0

