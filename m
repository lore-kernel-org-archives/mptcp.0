Received: from mta1.migadu.com (out-147.mta1.migadu.com [95.215.58.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A866221767D
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144212; cv=none; b=c7xrWyjYknNICMavRDVv+Vd2SQxx9JMS9vKYEIWzWppqWwoTmx+8ywbfaqxxXOF0FD5Q/1hEU8pqQQHnMV4N/fLJeG4MxFIPFhFutUilRNOvE3rfRoKOb/6X6CWMAJ3UiNEPumnu2xzOiWXd3dWIHjX5yHbxbck8tGN9d9xxbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144212; c=relaxed/simple;
	bh=rtw1YyrIvzIHYWYdRXpdAafdWLiYM50DLewJZDMU6SY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtpN+QZdYFb4gtFGQDFtxjXT0TzT+LkHccG2vAupikA2ev1yrOBA7/hprVk6BlsHXvJTLzZqMrs0bP0DdbbZZvONLcUdU2PKoc7mkjNOvZGwXBGYusquxd2HpNw/LKi5IjYn9I7upHtjavhsz5qPznlhjfrtZ2jztqttXMHbHiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/0QD/fV; arc=none smtp.client-ip=95.215.58.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/0QD/fV"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=rtw1YyrIvzIHYWYdRXpdAafdWLiYM50DLewJZDMU6SY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787144207; v=1; x=1787749007;
 b=E/0QD/fVeq8/NprMDSXUjH4SL/hZX2TpcJ2vx+6OltMsj/o8pRZPnDb/auivj56pjJVNg2ur
 znsuNg+snguwTDg1e5j9ZFPaATCmW6Lg2EOQg7N6y8JNlTdahyidShJfIcLE/Xjm5ITn/o7pSfx
 NDeEQYIyDdQ18CQ2vs/wep7I=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.160.239)
	by smtp.migadu.com with ESMTPS id 1bd71ac4e5c7521a;
	Wed, 19 Aug 2026 12:56:47 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 4/5] mptcp: pm: use WRITE_ONCE() for the pm_type sysctl
Date: Wed, 19 Aug 2026 20:56:28 +0800
Message-ID: <20260819125629.49823-5-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819125629.49823-1-gang.yan@linux.dev>
References: <20260819125629.49823-1-gang.yan@linux.dev>
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

