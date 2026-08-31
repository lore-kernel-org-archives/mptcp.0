Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D74237180
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168751; cv=none; b=MQvAcDmIwtBIRNX7T/K/yI+gi9zp7vcWY/uhJLZadvdTnaJLDd7XKCie60QKb5opVH+hM5yJBApJPQiT4Isz7C/9V+SjQpZ8eLMg5w3cZJtw3Vu8ow+yxKbROp1VKFVJeYLIxoaky93oqlQgTQ6oD7Baltq9BrT1OKLGV/k8Cug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168751; c=relaxed/simple;
	bh=LPIkZ2J4gV/tmtrZ+5bcpWy0oI+XLjiiSYMdOOTkF6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8DZMZfhpt6xxIk49DkoFZ2Ry3gzBWkR5IgvwUXsCPdL628BEwFVwxO7BFmQ/HPpjYCVKqOke//JayvX+R+omWaIfYralmnalx6GbLihmCaVvNJDaNNAZAaaIWlswWy0Vcobx5bAIxdFyd8oGkG7yN7UajWzXStsvy+A/POqjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JDmeUbb6; arc=none smtp.client-ip=95.215.58.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JDmeUbb6"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=LPIkZ2J4gV/tmtrZ+5bcpWy0oI+XLjiiSYMdOOTkF6Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788168748; v=1; x=1788773548;
 b=JDmeUbb69LLKdkaGRPQmKX4EGTY3n5FGsKFR8KqggphnmtcdOFMVddwnH+A0l56yTAid9i6O
 tdYGkR5AH1K3eVRbSgquPkbcuwdwW5sJYWRscetcDILfasZZyD7TCvl53lxVfUEhQl/UWqnD/Gq
 DDFzMfGuuUL8/J1LfMS69KQ8=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 93cc3431dbaf0d27;
	Mon, 31 Aug 2026 09:32:27 +0000
X-Mizu-Trace-ID: 93cc3431dbaf0d27
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	geliang@kernel.org,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH mptcp-next 1/2] mptcp: pm: bound extra_subflows admission on userspace PM
Date: Mon, 31 Aug 2026 17:32:05 +0800
Message-ID: <20260831093206.689827-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831093206.689827-1-cui.tao@linux.dev>
References: <20260831093206.689827-1-cui.tao@linux.dev>
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
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/mptcp/pm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8b68868255c5..3990f6775723 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -562,10 +562,17 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 
 	if (mptcp_pm_is_userspace(msk)) {
 		if (mptcp_userspace_pm_active(msk)) {
+			bool allow;
+
+			/* extra_subflows is a u8: don't let a peer wrap it
+			 * with more than U8_MAX accepted MP_JOINs
+			 */
 			spin_lock_bh(&pm->lock);
-			pm->extra_subflows++;
+			allow = pm->extra_subflows < U8_MAX;
+			if (allow)
+				pm->extra_subflows++;
 			spin_unlock_bh(&pm->lock);
-			return true;
+			return allow;
 		}
 		return false;
 	}
-- 
2.43.0

