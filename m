Received: from mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B447B45D5C2
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514537; cv=none; b=AqcTCCMKweRyLBA8k1edXcfC3MtCvXN6cydZ7lQKsB/ixQSjjJ5WT6/7M81Pbg8GRt+LXdqWMy4ptu95NDo2cPS0Dj93/75xsZT84uhke6mwkmHEVVMbGTP7UdaCEDZNBWGVdomSGQcwLTyWid9ptw6AxFmm/6WbJYTk1bS2p6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514537; c=relaxed/simple;
	bh=7wDdyf9b6/Zmu7PjZCPn74jcpmehQLqcKHkTSGX4Ck0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dD5uOn/uw1UqwDa5RFCaCJ5Vpi9HUZ/pC95kCyC7rsPaHEv8VLiGQxuiykJR3WVFjmoKDmb51U7acRi/tNFoLdxaC7LaYuoGSDWNh45LtZ56vMPXEV32ni6R2EOqQ3ULoz3XvY8H2F4m7Q+PnlKIyr3WFtTgkcohMxwRj/Daq8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nLP2ha7e; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nLP2ha7e"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=7wDdyf9b6/Zmu7PjZCPn74jcpmehQLqcKHkTSGX4Ck0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788514533; v=1; x=1789119333;
 b=nLP2ha7e8lH/1ab/scBCjPM9UqEJYgTZGxvub5FGkC/MqUJnynRZMIg5EXj3S9SXcJ0MStg4
 PMH6LSwlGLSyWuQoGy7Q4Er1UlCQmSFDT5tJXrUsz7zbT/ByVZOf7GmB+/UEI0ufxgbmydD1rNb
 pc51+fWZJaykjYtnlhexgEDw=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 4b441a90e95df4b2;
	Fri, 04 Sep 2026 09:35:33 +0000
X-Mizu-Trace-ID: 4b441a90e95df4b2
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v6 0/6] mptcp: avoid data-races around the sysctls
Date: Fri,  4 Sep 2026 17:35:25 +0800
Message-ID: <20260904093531.20023-1-gang.yan@linux.dev>
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
v6:
 - Patch 6 adds old->release when the path manager changed to address
   sashiko's comments in [1].

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

[1] https://sashiko.dev/#/patchset/20260828060643.14397-1-gang.yan@linux.dev?part=6

Gang Yan (5):
  mptcp: sched: change scheduler sysctl atomically
  mptcp: pm: change path_manager sysctl atomically
  mptcp: pm: use WRITE_ONCE() for the pm_type sysctl
  Squash-to "mptcp: pm: init and release mptcp_pm_ops"
  Squash to previous one

Matthieu Baerts (NGI0) (1):
  mptcp: use READ_ONCE() over sysctls

 net/mptcp/ctrl.c     | 141 ++++++++++++++++++++++++++++++++-----------
 net/mptcp/pm.c       |  68 +++++++++++++++------
 net/mptcp/protocol.c |   7 ++-
 net/mptcp/protocol.h |   9 +--
 net/mptcp/sched.c    |   2 +-
 net/mptcp/subflow.c  |   9 ++-
 6 files changed, 175 insertions(+), 61 deletions(-)

-- 
2.43.0

