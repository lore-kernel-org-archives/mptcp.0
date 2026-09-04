Received: from mta0.migadu.com (out-253.mta0.migadu.com [91.218.175.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D240F75A
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 05:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498731; cv=none; b=cGtyowwDzVGlHTBnPDxNGEnYoTeZocBOSpTMI4c0+S4791yjrqodgZIJs0HJ0A3kC1sj0P4I7Z3T0NEQN8oNc5rGVqSgvbtMEdRQaYAfhJnAgyieA8snwRtKIhLexAa+vG1LjpAfgsFE8ZhZkFX0L6k8TohUfvpaERkG6MWSATY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498731; c=relaxed/simple;
	bh=vlz1b+Csbnkwq1bxemxyXf7jitsTYAMetSCARlCcwyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0AMT6wqDhnI9lYPci/LiLQJ3qFQuOXyqjtPuHhDihsZQymaF4ATNnf3MbxMR2AkV0jMYWrerEEjjIzRkJdqqQFPrNp59fUI3o1Pq7T6IVcsPQ76ug+luTl1FXw80k/NQGp4mrORS0C6OcECuUwPe5pYevNfFu3FE38Lj7KEE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g/+RuDyl; arc=none smtp.client-ip=91.218.175.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g/+RuDyl"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=vlz1b+Csbnkwq1bxemxyXf7jitsTYAMetSCARlCcwyc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788498727; v=1; x=1789103527;
 b=g/+RuDylHRxqn6fCiEyk+R1S91o1AxW3rFDOF1X41G7YCw4Zg6gYHYkxAuaThfmRY2guOSZT
 tRolH40jRGhZW92IzhFST4D+ryVstR904e/uxGDt3Yly3JFNZd3frpiBJHW33ndGuJJmdZfaoRG
 l/r7LNO1BIZ1rpcSk4Y0+vxo=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 9a802a4186d0bdfc;
	Fri, 04 Sep 2026 05:12:07 +0000
X-Mizu-Trace-ID: 9a802a4186d0bdfc
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	quanyeyang@proton.me
Cc: geliang@kernel.org,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH mptcp-next v3 1/3] mptcp: pm: bound extra_subflows admission on userspace PM
Date: Fri,  4 Sep 2026 13:11:48 +0800
Message-ID: <20260904051150.1196427-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904051150.1196427-1-cui.tao@linux.dev>
References: <20260904051150.1196427-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

mptcp_pm_allow_new_subflow() increments the u8 extra_subflows counter
for every accepted MP_JOIN on sockets using the userspace PM, without
any limit. A peer establishing more than 255 live subflows wraps the
counter back to 0, which then makes the underflow guards warn on the
next subflow close, and permanently corrupts mptcpi_subflows_total
reported to userspace.

Refuse new MP_JOINs once the counter has reached U8_MAX, so that it
cannot wrap anymore.

Fixes: e99c1ca89071 ("mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/629
Co-developed-by: Quanye Yang <quanyeyang@proton.me>
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/mptcp/pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8b68868255c5..07cdcdb54b15 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -563,9 +563,11 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	if (mptcp_pm_is_userspace(msk)) {
 		if (mptcp_userspace_pm_active(msk)) {
 			spin_lock_bh(&pm->lock);
-			pm->extra_subflows++;
+			ret = pm->extra_subflows < U8_MAX;
+			if (ret)
+				pm->extra_subflows++;
 			spin_unlock_bh(&pm->lock);
-			return true;
+			return ret;
 		}
 		return false;
 	}
-- 
2.43.0

