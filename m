Received: from mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54E3C9ED6
	for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156983; cv=none; b=X4+IbRrgunM+mJQTKkC1OWYpX6/eMIZ7Wh1t//XPLoQTB7swyFxQasFfbqGgh62vfD/+dcrPbQkilHi+iQxqFARVfDeBwv7Ng5NiOnA9WAO28MK4vlC31mNkEMsQHaaklzyPH1A7mdUVmaU7nA4fpUBlFTqAw9UcpvfDp5lmYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156983; c=relaxed/simple;
	bh=rtw1YyrIvzIHYWYdRXpdAafdWLiYM50DLewJZDMU6SY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kx1n6ZmJjzkG9D2/CRZA9RAENMrC1XPX3gM8P+oHYhsZHfpoFRxSt+1bKMjNFA3IwCsc+KGKxIkODeYG6wKdepY6HQVmIhlakLc6EMe0N6/MUKqP7BznK1cEeHTYdkzFo1FB3CVe8ym1jWUuYNLTSi1i4YdZXy4dFADAzlYDOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rQ6KHRut; arc=none smtp.client-ip=95.215.58.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rQ6KHRut"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=rtw1YyrIvzIHYWYdRXpdAafdWLiYM50DLewJZDMU6SY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790156979; v=1; x=1790761779;
 b=rQ6KHRut33ZzqQoZvq1GQpRGASw0UGFQZqpJSjgsLp7Xo2L9aoheimAM8vIRfwE/CtGmVly+
 +btiYgbV6F4w/Ltyltv+/MAhiAywwFnFWXuMoXcOQ+dH4/1nfj5L/3Z76ljfGA1y3Id/oQBS4HU
 UAXS6lo0ZCifI3at4yOWgRT8=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id fddd15738cf691a5;
	Wed, 23 Sep 2026 09:49:39 +0000
X-Mizu-Trace-ID: fddd15738cf691a5
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v7 4/6] mptcp: pm: use WRITE_ONCE() for the pm_type sysctl
Date: Wed, 23 Sep 2026 17:49:17 +0800
Message-ID: <dfda2d339d7a91927bdb3ab859003c88a93d6e7e.1790147728.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790147728.git.yangang@kylinos.cn>
References: <cover.1790147728.git.yangang@kylinos.cn>
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

