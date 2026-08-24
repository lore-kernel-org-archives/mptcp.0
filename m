Received: from mta0.migadu.com (out-37.mta0.migadu.com [91.218.175.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB2C396590
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556996; cv=none; b=SgXzsZ+XbVWri5eSMRehFATQKRDHjLqyyvfjhev8mYWvSTdGwavD5bsLiT7rWUGcW6f1tKNi20autkKcERHf4L0ngHE+dc3Vq3GIo18lycTDFLHREdrr+6rX7Zv4EIraR3ny9rXSdFyxRFWAH7XeAWAWa/9RIqNzF30lyNe5iQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556996; c=relaxed/simple;
	bh=rtw1YyrIvzIHYWYdRXpdAafdWLiYM50DLewJZDMU6SY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnyiQOAh8pW136INJnQNHyrdkjwkuon5HfsNIUeQp535XpbUTet4Jm4nQeYeKt9HGBuxqLK9amUkoZgl99AzL7ybmEX0bCtIIshJH6M/F+ECuc2VGFbIA7dBpCbtNy6l12QBQZyqn6KgaH+EEpBaRl+zkTONktO5t5D+JpsVSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R07L/hCJ; arc=none smtp.client-ip=91.218.175.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R07L/hCJ"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=rtw1YyrIvzIHYWYdRXpdAafdWLiYM50DLewJZDMU6SY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787556993; v=1; x=1788161793;
 b=R07L/hCJ8BpepxLFmE0A6/w5/o6c4ejIrcV/mbUpTabz1ZTgZ9msG6ts8eMAxBECkSFGE/x0
 YOnRRyd6BDC16FMRZPStZQsU9eNCQL5ZzfA//Pl/+0GjJL1HBwZAtA39odhbGcn/OQIrLBIHrgy
 3BH6mSNvdgoS1dnTWjRd0YCE=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id cdca49b78d83c1b3;
	Mon, 24 Aug 2026 07:36:33 +0000
X-Mizu-Trace-ID: cdca49b78d83c1b3
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 4/6] mptcp: pm: use WRITE_ONCE() for the pm_type sysctl
Date: Mon, 24 Aug 2026 15:36:23 +0800
Message-ID: <20260824073625.57471-5-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824073625.57471-1-gang.yan@linux.dev>
References: <20260824073625.57471-1-gang.yan@linux.dev>
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

