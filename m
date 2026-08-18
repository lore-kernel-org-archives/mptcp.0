Received: from mta0.migadu.com (out-195.mta0.migadu.com [91.218.175.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105143F0B1
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046014; cv=none; b=CZx1vEBvbBWPcn15h1/ThxRFupuKwhwQ+tPf7lJExm9qtg4nNGAvGc+ADWRWU8C4NcEJL+W8dMDpfacQx/QdWgJo+Nz/gTY+QOSqldYInDd5O6T6GQNJ/yhvU/rmIez8hx5JRtOim2Ky0BWr70+Vt+JJVPg4p4uFV3Ryl0zvjW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046014; c=relaxed/simple;
	bh=6S9zW0R0Cv8IhcDyx51H5z/yRyjt/cM3azWG1GaLbm4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PMIiU+v9LjOg6Fl9bI7DFWKZUwyI4cyRUoh8w6B4tWQgecaiAUPY+u42zfNX9Ok3qrXOIN5lrP/7AK7WkkqjiibBEX8Z6Ir/s3susceH/NFuM5417fxoWnRr8FJ+9AgWCmzzm5D5I2jXOa1vFiiIheOsj/6oFo01XflpZQbgWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XBB0YkJI; arc=none smtp.client-ip=91.218.175.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XBB0YkJI"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=6S9zW0R0Cv8IhcDyx51H5z/yRyjt/cM3azWG1GaLbm4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787046010; v=1; x=1787650810;
 b=XBB0YkJIVbd3JcqXdw4pUQOgiTeMTzqCpWy3B2DGdLwvtnYNIuHnzTI1YEKfEBg6+yI16OkC
 bqdIH0oUYsKDCOHYMsRZG2XCkW5ps+9cV3TaI0M5Lk9SHBrk7wm0GOaePwm0vfEpLlUEXXaAaxu
 P2qf+oWP3XBOGKCF1csUUBJ0=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id b86daea308e44d23;
	Tue, 18 Aug 2026 09:40:09 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 0/5] mptcp: avoid data-races around the sysctls
Date: Tue, 18 Aug 2026 17:39:58 +0800
Message-ID: <20260818094003.47690-1-gang.yan@linux.dev>
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
v2:
  - Split the code around bpf to patch 4 and patch 5.
  - Put WRITE_ONCE(pernet->pm_type, pm_type) into patch 3 and add
    tag of Tao Cui.
v1:
  Link: https://patchwork.kernel.org/project/mptcp/cover/20260817012452.7519-1-gang.yan@linux.dev/


Gang Yan (4):
  mptcp: sched: change scheduler sysctl atomically
  mptcp: pm: change path_manager sysctl atomically
  Squash to "mptcp: pm: init and release mptcp_pm_ops"
  Squash to "bpf: Add mptcp packet scheduler struct_ops"

Matthieu Baerts (NGI0) (1):
  mptcp: use READ_ONCE() over sysctls

 net/mptcp/ctrl.c     | 116 ++++++++++++++++++++++++++++++-------------
 net/mptcp/pm.c       |   3 +-
 net/mptcp/protocol.c |   5 +-
 net/mptcp/protocol.h |   6 +--
 net/mptcp/sched.c    |   2 +-
 5 files changed, 91 insertions(+), 41 deletions(-)

-- 
2.43.0

