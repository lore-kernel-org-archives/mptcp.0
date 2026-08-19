Received: from mta0.migadu.com (out-231.mta0.migadu.com [91.218.175.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91FC3101D4
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144199; cv=none; b=glgCkUKzuvJA12aM0prMDQ/Kd5jEZmHPsep9pQaaG6XzqFzUGyWltFRTRSDR/72nvznx+bA6U1smFtcoNgUnAbCko/sutyS7Yr9qyyiFNyydVP34HOSaSmu2gSRE21XrPIgVTDHTWuhq6jsbbl+15gmU8yXuy3oo+/R+Kx7dJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144199; c=relaxed/simple;
	bh=c5WQ2fNdRmd8yYO4TOzGyI9JL9nGIgWc7Q1XQKpOpgw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JyhKtFM934SR5n0AyI4ibHVScR1zKj6snCrJ5Ef9aduILG059TX+XPpvoRmyA5q/MqvQX8YhTIImocIxPfFxPYq4sSYQ59CadZJDV0hk/EAi5g2KYMVY6JNUzddBUyBoKpbQKRE3SdnZR1AEG2JAZtmZh/VBDKWjcMKIdm90Dlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ai1eQK/G; arc=none smtp.client-ip=91.218.175.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ai1eQK/G"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=c5WQ2fNdRmd8yYO4TOzGyI9JL9nGIgWc7Q1XQKpOpgw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787144195; v=1; x=1787748995;
 b=Ai1eQK/GCqNmj28mJ93BLwluA6qFwDq1tpeYx7Lok15TY8avcLYFDtoB2nQQ9TMSo8SOsceE
 RSf7+Lo/JFjQUrtPoHdzyV6gA/pM8b4jYAI9X2Zet6BSbaePbWqktRgZFluULjcAQ+88qCz/IdA
 ukMVjVnYumnHP2SN5sZZY3u8=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.160.239)
	by smtp.migadu.com with ESMTPS id 198d029caa64f094;
	Wed, 19 Aug 2026 12:56:35 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 0/5] mptcp: avoid data-races around the sysctls
Date: Wed, 19 Aug 2026 20:56:24 +0800
Message-ID: <20260819125629.49823-1-gang.yan@linux.dev>
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
v3:
  Patch 1:
    - Carries the full module refcount handling that was previously
      deferred to a squash-to patch.
    - mptcp_get_scheduler now returns the ops pointer directly instead
      of copying the name, so mptcp_init_sock() no longer goes through a
      redundant mptcp_sched_find() list walk.
    - A new pernet-level helper 'mptcp_pernet_sched' is shared with
      proc_scheduler().
    - mptcp_net_init releases the default reference on the
      mptcp_pernet_new_table error path.
    - Simplify the commit message.

  Patch 2:
    - Introduce the pernet-level helper mptcp_pernet_pm, like sched
      does.
    - Commit message shows why no moudule reference is taken here for
      addressing sashiko's comments.

  Patch 3:
    - Remove the WRITE_ONCE() part and the tag of Tao Cui.

  Patch 4:
    - It is new in this seires. Followed by Matt's suggestions, add
      comments before pm_type was changes.

  Patch 5:
    - Release the PM reference on the mptcp_net_init errpr path as sched
      does.
    - mptcp_pm_ops_init() now takes the ops pointer directly instead of
      the name, and mptcp_get_path_manager() returns the ops pointer:
      the redundant mptcp_pm_find() list walk from the name is avoided,
      mirroring the scheduler side earlier in this series. 

v2:
  - Split the code around bpf to patch 4 and patch 5.
  - Put WRITE_ONCE(pernet->pm_type, pm_type) into patch 3 and add
    tag of Tao Cui.
  Link: https://patchwork.kernel.org/project/mptcp/cover/20260818094825.48446-1-gang.yan@linux.dev/
v1:
  Link: https://patchwork.kernel.org/project/mptcp/cover/20260817012452.7519-1-gang.yan@linux.dev/

Gang Yan (4):
  mptcp: sched: change scheduler sysctl atomically
  mptcp: pm: change path_manager sysctl atomically
  mptcp: pm: use WRITE_ONCE() for the pm_type sysctl
  Squash to "mptcp: pm: init and release mptcp_pm_ops"

Matthieu Baerts (NGI0) (1):
  mptcp: use READ_ONCE() over sysctls

 net/mptcp/ctrl.c     | 141 ++++++++++++++++++++++++++++++++-----------
 net/mptcp/pm.c       |  11 ++--
 net/mptcp/protocol.c |   3 +-
 net/mptcp/protocol.h |   6 +-
 net/mptcp/sched.c    |   2 +-
 5 files changed, 115 insertions(+), 48 deletions(-)

-- 
2.43.0

