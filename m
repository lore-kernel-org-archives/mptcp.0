Received: from mta1.migadu.com (out-15.mta1.migadu.com [95.215.58.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25491F0E34
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786929902; cv=none; b=BXqUfNjoXSCfgrwycw1U/tvZYqt+NLAiutEPXmV/lhsRszZIEhEUPMD5oLH/lpyGUy8PHsmqK8zkh7p9uMFNfi3Dyji8RNQZN86WEEY3QSEYQlfZQkWeDQWdMLdfXfAP7sjIZ5TBEjlj/9PCAlHx6ArCIKeB4PYIZrHGfyLf4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786929902; c=relaxed/simple;
	bh=boot3dyDY56+IhbQ/UMO/jEDxsAdWnX+2l4cGuQflo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=quI3w75YianqjlBxgWGvrrURx3H7zVhiQi4xjSlfxbpjGX3kFygVv19zWBMO0LA0/TLVApni2LgnuIhSSsxvv3wCRb1Njte3WpPZ7dxiGMI8bkuAp9NdpwGE3l66WI88pPlENYsd3r9xhSDwEE8Lon2W5LRHvRidbZ4cjEEh3Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Arm8EEsl; arc=none smtp.client-ip=95.215.58.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Arm8EEsl"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=boot3dyDY56+IhbQ/UMO/jEDxsAdWnX+2l4cGuQflo8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786929897; v=1; x=1787534697;
 b=Arm8EEslNpY1kxEb1voWXhfy4jvgs/gFbsMoMmDgZyiN2K37R1xpu5qAjQawv11V6Xz+Cfri
 D/O6G5yvlVrjh0jJBloJQPmdxX6L17NcJp5uDWsrZGEbfGHzHeCXldjkjx3+cIhSdM0PN1m6ljQ
 zvlNW7sr8fXzTf41zWaurYCs=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 568be7600cadde52;
	Mon, 17 Aug 2026 01:24:57 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] mptcp: avoid data-races around the sysctls
Date: Mon, 17 Aug 2026 09:24:49 +0800
Message-ID: <20260817012452.7519-1-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

Hi,

As decribed in [1], this series is for addressing the KCSAN issues in
sysctls.

Following the tcp_congestion_control() model, patch 1 and 2 now store
pointers to the immutable ops and swap them atomically via xchg().

Patch 3 (from Matthieu) covers the remaining scalar sysctls with READ_ONCE().

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/626

Gang Yan (2):
  mptcp: sched: change scheduler sysctl atomically
  mptcp: pm: change path_manager sysctl atomically

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

