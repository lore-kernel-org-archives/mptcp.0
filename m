Received: from mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7147D44D
	for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156971; cv=none; b=TaT527g8KsethzZD1zP7AluAYxgI7VPJZTf39+UNszkwvb1v22io5c1poUF6jWnirJ+lUQ3ljTp5c5GcHL0y3vzjLIuXYCfiTkamy9YOrpPhrNCUNB2HgbAvV7xQqQ5zsNugXowoL06SfRBrSIDF26lYCEcpENcB06bTQLtk51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156971; c=relaxed/simple;
	bh=e0jeKEQwxZeuW7UJdl2vYqf5nP8iGG+cODaFSSpGE0A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L7GnkJL6i/nMGy9J73nj6rz9F/oa9r0MGWm8PcuhPDqpNKbglKpGV2Fe2nPNc8tsg/ebhoPCfSIG7Eik9E/jZVyfg92BzVDiIrqoPdF561G1SjcizS+kh5uRnq1AJ4ztzwuvtQaQUE7Gmzppnd27qQeo/+9PNpkF+evPeKYDmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hZCV+cKL; arc=none smtp.client-ip=91.218.175.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hZCV+cKL"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=e0jeKEQwxZeuW7UJdl2vYqf5nP8iGG+cODaFSSpGE0A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790156965; v=1; x=1790761765;
 b=hZCV+cKLvExglonP20DGzCWuBOljIKssbhRBxnvNTJLWGeNqm/qQYx1hKwPAR8vgEHNtzhrr
 dC+BfwucWWFJ3RvqCk4zGL63w0rVGN7wO6ByiGkA3kgHWH0xtPNnJu96xzErKl39KEx6WhwdTq9
 JDveTsGqoDtnQBhznHazcH2k=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id be5265eb15a4e66f;
	Wed, 23 Sep 2026 09:49:25 +0000
X-Mizu-Trace-ID: be5265eb15a4e66f
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v7 0/6] mptcp: avoid data-races around the sysctls
Date: Wed, 23 Sep 2026 17:49:13 +0800
Message-ID: <cover.1790147728.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

Changlog:
v7:
Patch 5:
 - Rephrase the commit message accoding to sashiko's comments.[1]

Patch 6:
 - Fix the use-after-free reported by sashiko [2]: the module reference is
   now taken inside the same RCU read section as the pointer fetch in
   mptcp_pm_data_reset(), so the ops cannot be freed between the
   rcu_read_unlock() and the bpf_try_module_get() that previously
   lived in mptcp_pm_ops_init(). The fallback to mptcp_pm_kernel now
   takes a reference as well, fixing a pre-existing refcount
   underflow when MPTCP is built as a module.
 - Fix the reported use-after-free in [2]: take the module reference inside
   the same RCU read section as the pointer fetch.
 - The remaining of [2] are not actual issues, along with the
   "scheduling while atomic" one which does not apply: lock_sock()
   has mutex semantics, no spinlock is held across synchronize_rcu().
 - Clear the pm.ops inherited by cloned sockets before re-selecting
   it: the clone entered the swap logic with a reference it never
   took, and the grace period wait could run in RX softirq.
 - Wait for a grace period before releasing the retired ops in all
   cases (same-ops reuse and final destruction included).
v6:
 Link: https://patchwork.kernel.org/project/mptcp/cover/20260904093531.20023-1-gang.yan@linux.dev/
v5:
 Link: https://patchwork.kernel.org/project/mptcp/cover/20260828060643.14397-1-gang.yan@linux.dev/

v4:
 Link: https://patchwork.kernel.org/project/mptcp/cover/20260824073625.57471-1-gang.yan@linux.dev/

v3:
 Link: https://patchwork.kernel.org/project/mptcp/cover/20260819125629.49823-1-gang.yan@linux.dev/

v2:
 Link: https://patchwork.kernel.org/project/mptcp/cover/20260818094825.48446-1-gang.yan@linux.dev/

v2:
 Link: https://patchwork.kernel.org/project/mptcp/cover/20260817012452.7519-1-gang.yan@linux.dev/

[1] https://sashiko.dev/#/patchset/20260904093531.20023-1-gang.yan@linux.dev?part=5
[2] https://sashiko.dev/#/patchset/20260904093531.20023-1-gang.yan@linux.dev?part=6

Gang Yan (5):
  mptcp: sched: change scheduler sysctl atomically
  mptcp: pm: change path_manager sysctl atomically
  mptcp: pm: use WRITE_ONCE() for the pm_type sysctl
  Squash-to "mptcp: pm: init and release mptcp_pm_ops"
  Squash to previous one

Matthieu Baerts (NGI0) (1):
  mptcp: use READ_ONCE() over sysctls

 net/mptcp/ctrl.c     | 141 ++++++++++++++++++++++++++++++++-----------
 net/mptcp/pm.c       |  64 ++++++++++++++------
 net/mptcp/protocol.c |   7 ++-
 net/mptcp/protocol.h |   9 +--
 net/mptcp/sched.c    |   2 +-
 net/mptcp/subflow.c  |   9 ++-
 6 files changed, 171 insertions(+), 61 deletions(-)

-- 
2.43.0

