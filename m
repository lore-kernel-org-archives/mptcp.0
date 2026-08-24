Received: from mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCFF396B8C
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556994; cv=none; b=THRKMCLrQl+4ixDQtXzmOWaKTc4SnjZSlos35tghDwCsaZ9tEH8KtVXQ64yXUJthV4c3/Cahv4dAlqddWFBMjOOfGLtZmPdlQoTAoJobUQ41Iw2trjtG30x0TbKQH6q/Oaz89hsm8vBPTou2CMMqZ4heDOGBw61oCd1fSbss4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556994; c=relaxed/simple;
	bh=YbuCnCKQVk35+um1Lmfjg/Wafw6glJPxZ1nx+27EyUw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kt8YDx0SZ1qJSMdEQ6jkUj0/nsAB7liKpSMQDIu+c6LXtx1+NZzd/bDAp8RMkOJE1f9Ol+cfYDwjGId/dz/72SSQ/izAeDzqriZzbA99w9vqt53nABg2hriCukWfT/RXk9rHprCIfcB8DrcdiJsne7/riekTMiWYAQi/SgQHuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AP6yxIq2; arc=none smtp.client-ip=91.218.175.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AP6yxIq2"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=YbuCnCKQVk35+um1Lmfjg/Wafw6glJPxZ1nx+27EyUw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787556989; v=1; x=1788161789;
 b=AP6yxIq2DEOFAmB3WoutidH3zmB2y7cgrYcuPzw05LIVL8Accd9Ys5jK8SNHVZsQrQ/lUvbP
 edG6tJNYkm8lB8rZM4CyLztEyYSWxwHNSzlVSBgwXk4pp/MsQL5HwQxqgTecsW7S0LNCyoFfYPj
 xYeS33835kUDZaRBtNQt9WNI=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 7275e63edcd591cf;
	Mon, 24 Aug 2026 07:36:29 +0000
X-Mizu-Trace-ID: 7275e63edcd591cf
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 0/6] mptcp: avoid data-races around the sysctls
Date: Mon, 24 Aug 2026 15:36:19 +0800
Message-ID: <20260824073625.57471-1-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

Changelog:
v4:
 - Patch 6 is new to this series, for addressing the sashiko's comments
   in [1] using rcu. Please note it should also be squashed to "mptcp:
   pm: init and release mptcp_pm_ops", but spilting it may ease the
   review.

v3:
 Link: https://patchwork.kernel.org/project/mptcp/cover/20260819125629.49823-1-gang.yan@linux.dev/

v2:
 Link: https://patchwork.kernel.org/project/mptcp/cover/20260818094825.48446-1-gang.yan@linux.dev/

v2:
 Link: https://patchwork.kernel.org/project/mptcp/cover/20260817012452.7519-1-gang.yan@linux.dev/

[1] https://sashiko.dev/#/patchset/20260819125629.49823-1-gang.yan@linux.dev?part=5
Gang Yan (5):
  mptcp: sched: change scheduler sysctl atomically
  mptcp: pm: change path_manager sysctl atomically
  mptcp: pm: use WRITE_ONCE() for the pm_type sysctl
  Squash-to "mptcp: pm: init and release mptcp_pm_ops"
  Squash to previous one

Matthieu Baerts (NGI0) (1):
  mptcp: use READ_ONCE() over sysctls

 net/mptcp/ctrl.c     | 141 ++++++++++++++++++++++++++++++++-----------
 net/mptcp/pm.c       |  61 ++++++++++++++-----
 net/mptcp/protocol.c |   7 ++-
 net/mptcp/protocol.h |   9 +--
 net/mptcp/sched.c    |   2 +-
 net/mptcp/subflow.c  |   9 ++-
 6 files changed, 170 insertions(+), 59 deletions(-)

-- 
2.43.0

