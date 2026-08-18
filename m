Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F463921EC
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045958; cv=none; b=F0dHXCV9pS2w9WqX4WDwgip6CAeRr9iMKvlCieyM+zk4HiNOkEqQLXE7oDB1sB+9CwSmZwTSkurf2l+gEt5OdvcLlrC5IkF0NGz0kI9EhF6rqDWV1MOIJDACyUBBj2Js6agcPlpAp4uK/Gs64CdiHeqc5DiLkxNVhMMC5TxTIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045958; c=relaxed/simple;
	bh=6S9zW0R0Cv8IhcDyx51H5z/yRyjt/cM3azWG1GaLbm4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AJGS6bnii/g75d/uD0w8PTcMne2aqxKMbA+rfen7p0813do9P5LvMYAjI0yIij8pTPDYR7LldiJqF9J5dhUbTTd5fxq5648Ys+r06oSX1ph/kmdio8L5U6T/gnzlkdWu54jdAkVo2Llme1Qlpx+eBwrdpYQinYCq4Y+KWstrFEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mXG1lBXW; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mXG1lBXW"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=6S9zW0R0Cv8IhcDyx51H5z/yRyjt/cM3azWG1GaLbm4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787045953; v=1; x=1787650753;
 b=mXG1lBXWfpRRcwaDJ8LMiqX5GZ126ajXCAVFFYinCQhfl87n0nlqjGrmHfnkDGiXq3lA4u7F
 kxT2jRzc2Nj02pUc9oVkO0HUXWDpWXLY0P6nzoAfwdNSFfpYmKIhVZsjIb45cnMd92iKrskUDa9
 pm/TGQBz5P0wvn4wqeXo67RQ=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 7494e2cd5443981f;
	Tue, 18 Aug 2026 09:39:13 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 0/5] mptcp: avoid data-races around the sysctls
Date: Tue, 18 Aug 2026 17:39:05 +0800
Message-ID: <20260818093910.47559-1-gang.yan@linux.dev>
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

