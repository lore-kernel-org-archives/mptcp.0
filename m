Received: from mta0.migadu.com (out-230.mta0.migadu.com [91.218.175.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E1A41C6A
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897216; cv=none; b=J75CMIL04TubZ/5qbp6StNHjg7I0qZz5+otgDmbMAMUZSCNSUr4KqgTBuoIRhtT/NiCyL3EbvEvyd1MEHfx2wr3iCFo9KDj4l/SSvJQLThKyfH7kx2WyfXEQxvPT6e6FIjB4IYvuY15x5DcdoGmdFVAuT7yH5df/0wTKtbHGDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897216; c=relaxed/simple;
	bh=EJPvCWQa1NikN1iCE8usAF3kNFaJtL/nMU1F3Jgq4D4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gnRNTZQmpagbO73LKoVoOnYBbT2ieeXsaJip66XCX80rWetvXXDikC79mlU0FCBB+H7BxX8gReG/tlcNoI8a3T2mvfvuGBONFUewNX4WU9y0bV0km4lp+XozEwRLIatr+xqD5EQQWBqLoiTaNGrKh2oqPidOb8mo7VESEipnunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NL5gkNaX; arc=none smtp.client-ip=91.218.175.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NL5gkNaX"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=EJPvCWQa1NikN1iCE8usAF3kNFaJtL/nMU1F3Jgq4D4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787897210; v=1; x=1788502010;
 b=NL5gkNaXptwf8BBSy6Du2lDCprFMUKmQMVHTT2VEXw5RSTXFjq21dmpSqFP51sXEYy1vIyni
 pBlEyqSblvbkWOEn5/QFXbpGMgRXGehjWViDeT1HwCTyU6UKVQDCKc90vyDbQ9bT5x3PKX2vglL
 JebluRLt8Bn7ChqT5OZxfNYI=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 5722f5b636861b4c;
	Fri, 28 Aug 2026 06:06:50 +0000
X-Mizu-Trace-ID: 5722f5b636861b4c
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 0/6] mptcp: avoid data-races around the sysctls
Date: Fri, 28 Aug 2026 14:06:37 +0800
Message-ID: <20260828060643.14397-1-gang.yan@linux.dev>
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
v5:
 - Patch 6 fixes the use-after-free reported by sashiko in [1]:
   the module reference is now taken inside the same RCU read section as the
   pointer fetch in mptcp_pm_data_reset(), so the ops cannot be freed between
   rcu_read_unlock() and the bpf_try_module_get() that previously lived in
   mptcp_pm_ops_init(). The reference hand-over is seamless: RCU protects
   the fetch, the refcount protects the use. As a consequence,
   mptcp_pm_ops_init() now expects an already-pinned ops and no longer takes
   a reference itself; the fallback to the built-in mptcp_pm_kernel needs no
   reference.

v4:
 Link: https://patchwork.kernel.org/project/mptcp/cover/20260824073625.57471-1-gang.yan@linux.dev/

v3:
 Link: https://patchwork.kernel.org/project/mptcp/cover/20260819125629.49823-1-gang.yan@linux.dev/

v2:
 Link: https://patchwork.kernel.org/project/mptcp/cover/20260818094825.48446-1-gang.yan@linux.dev/

v2:
 Link: https://patchwork.kernel.org/project/mptcp/cover/20260817012452.7519-1-gang.yan@linux.dev/

[1] https://sashiko.dev/#/patchset/20260824073625.57471-1-gang.yan@linux.dev?part=6

Gang Yan (5):
  mptcp: sched: change scheduler sysctl atomically
  mptcp: pm: change path_manager sysctl atomically
  mptcp: pm: use WRITE_ONCE() for the pm_type sysctl
  Squash-to "mptcp: pm: init and release mptcp_pm_ops"
  Squash to previous one

Matthieu Baerts (NGI0) (1):
  mptcp: use READ_ONCE() over sysctls

 net/mptcp/ctrl.c     | 141 ++++++++++++++++++++++++++++++++-----------
 net/mptcp/pm.c       |  65 ++++++++++++++------
 net/mptcp/protocol.c |   7 ++-
 net/mptcp/protocol.h |   9 +--
 net/mptcp/sched.c    |   2 +-
 net/mptcp/subflow.c  |   9 ++-
 6 files changed, 172 insertions(+), 61 deletions(-)

-- 
2.43.0

