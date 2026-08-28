Received: from mta1.migadu.com (out-28.mta1.migadu.com [95.215.58.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2608119CD0A
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 06:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897231; cv=none; b=l0f9quhlXc/Jtg0PItSN1nttuYQ0fPvUcfazsGVA4QAh9kUoDkjho2c88FqWpTc4DbBTVoLiZOABNGAJBfWGflFijleFrtCdWi+py7gHwaMZ72bHilvd7rXBthN8wVVgN82b61GedxVRy9asY1rdxZsQHTyvkyeYXqmCvIurdRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897231; c=relaxed/simple;
	bh=rtw1YyrIvzIHYWYdRXpdAafdWLiYM50DLewJZDMU6SY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pqe+CMjOa22HEXbP9YHV+fKbudWZCbyMZfUW22ReK9eIsKfIgLTLSeDxTmLIuRZo0MBr3OlxbvBVt0ppplSgnfwsYiA40fnbTbSkjzJe3W7J0MmPtpmsznsWO6nPY/qQI8pExkBwMhjk8Xrpf+K5F78IbRLsw/YdgqmjCp+1hUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JmLPUK3J; arc=none smtp.client-ip=95.215.58.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JmLPUK3J"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=rtw1YyrIvzIHYWYdRXpdAafdWLiYM50DLewJZDMU6SY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787897228; v=1; x=1788502028;
 b=JmLPUK3JzClBjc1oH4UyABxZg8EWWDhFTOU+r+dI38zmwu9qYFLoTXffqgd+O/pwY28scskL
 mxxeGDYRF00+zXawfdKZSDU7c32qiKcIxHx1U24L6YFNv+TxOt2ndKvgRti26SRfsFLy+z9BkXl
 WwibS09H1XQO7vYX4bdKgXwI=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id d1387b2e91f384ba;
	Fri, 28 Aug 2026 06:07:08 +0000
X-Mizu-Trace-ID: d1387b2e91f384ba
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 4/6] mptcp: pm: use WRITE_ONCE() for the pm_type sysctl
Date: Fri, 28 Aug 2026 14:06:41 +0800
Message-ID: <20260828060643.14397-5-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828060643.14397-1-gang.yan@linux.dev>
References: <20260828060643.14397-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

Write pernet->pm_type with WRITE_ONCE() in proc_path_manager(), pairing
it with the READ_ONCE() readers introduced earlier in this series.

Note that updating net.mptcp.path_manager swaps the ops pointer first,
then writes the derived pm_type: a socket created in between may see
the new ops with the old pm_type. As the net.mptcp.pm_type knob is
deprecated since v6.15 and will be removed, the race is not fixed on
purpose; document it above the assignment so it does not get reported
again.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Assisted-by: Claude:GLM5.2
Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/ctrl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 5a75f9b76d15..87491b961bf2 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -265,7 +265,13 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 				pm_type = MPTCP_PM_TYPE_KERNEL;
 			else if (strncmp(pm_name, "userspace", MPTCP_PM_NAME_MAX) == 0)
 				pm_type = MPTCP_PM_TYPE_USERSPACE;
-			pernet->pm_type = pm_type;
+
+			/* Pre-existing race: two sequential writes, a socket
+			 * created in between may see the new ops with the old
+			 * pm_type. The knob is deprecated since v6.15 and will
+			 * be removed: not fixed on purpose.
+			 */
+			WRITE_ONCE(pernet->pm_type, pm_type);
 		}
 	}
 
-- 
2.43.0

