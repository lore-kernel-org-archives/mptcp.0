Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3B3BED31
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546753; cv=none; b=UgpY+TCJaGXGnWZHx8OsYPbXfJRhs+X2BCgrlGymGK7xFmwVrki75UUpL6VTAeGz0SeXWN7yEGzslvDgTA6Ov7sXsv3dEDzlHaRDR0LochZel1yJCCD0H5uEK9ViX6CkB3UdXYvvQcS6TwbrUFXyQ4GX+aPDzgOYQ0rwwWoX0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546753; c=relaxed/simple;
	bh=BUrl+sq/MYVEPetBKM5yvGj3IbI2v9gVN+VVFTNySSc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AKG4Si6PDBmm77xiBf8Ncc82f5Uqf8225xtByoLPlAu34rkheaiILDGwjV/wRcxE2H0IFpbHc4i7+0FUFexhP+e2Gz1pa1uhkb7ZDXvBOI2TMMptRCJsqhgLyx41hYPTwyLeBwRJ9XTA0f+OrlhcwfSss/eGDbJb8MLwukl88Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ItRFZGg5; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ItRFZGg5"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=t0P3D1O2zjINK5/WI848wDLwQ6gEvx74gdoC5Ghziio=;
	b=ItRFZGg5jgse90ocPRFMpFKcBnCTu4A1l/pHwZr3vc2RWqxbL0sKgMl5vu3NN2SslcSGWjjW/
	pgWHnD/DoPEmKYXo2wbSrEBAMULPNDIcSDz0V+ITL+UJb7xFrXklsD8Lj/qdulQN5z4O+NpOGlz
	31VGfAcL+CG5S5OR819xfMI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4g5rbW72ZzzpStj
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 18:52:23 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id BCC364056D
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 18:59:02 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Apr
 2026 18:59:02 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: <mptcp@lists.linux.dev>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <xiasong.lee@gmail.com>
Subject: [PATCH mptcp-net v2 0/2] mptcp: pm: fix ADD_ADDR timer infinite retry on option space shortage
Date: Thu, 30 Apr 2026 19:20:24 +0800
Message-ID: <20260430112026.343691-1-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj500018.china.huawei.com (7.202.194.48)

This patch fixes a bug where the ADD_ADDR timer keeps rescheduling
indefinitely when TCP option space is insufficient, blocking subsequent
addresses in the endpoint list from being announced.

The issue occurs when sending ADD_ADDR with an IPv6 address and port
while tcp_timestamps is enabled. The first patch clears the signal in this
path, skips the matching ADD_ADDR retransmission entry, and preserves PM
state-machine progression semantics.

The second patch adds a selftest to cover this behavior and prevent
regressions.

Patch summary:
  - patch 1: mptcp: pm: fix ADD_ADDR timer infinite retry on option space
    insufficient
  - patch 2: selftests: mptcp: join: cover ADD_ADDR tx drop and list
    progress

Changes since v1:
  - add explicit MIB accounting for this drop path:
    - MPTCP_MIB_ADDADDRTXDROP for non-echo ADD_ADDR
    - MPTCP_MIB_ECHOADDTXDROP for echo ADD_ADDR
  - add explicit handling to stop the matching ADD_ADDR retransmission
    timer when skipping non-echo ADD_ADDR on pure-ACK option-space
    exhaustion
  - keep PM forward progress by advancing PM state after a successful
    skip of the matching ADD_ADDR entry
  - Added selftest to verify IPv6 ADD_ADDR with port tx-drop when
    tcp_timestamps is enabled
  - Link to v1: https://lore.kernel.org/netdev/20260418100018.2219500-1-lixiasong1@huawei.com/

Thanks to Matthieu Baerts for the detailed review and suggestions on
v1, especially around PM progression and retry/timer handling.

Li Xiasong (2):
  mptcp: pm: fix ADD_ADDR timer infinite retry on option space
    insufficient
  selftests: mptcp: join: cover ADD_ADDR tx drop and list progress

 net/mptcp/pm.c                                | 45 +++++++++++++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 47 +++++++++++++++++++
 2 files changed, 85 insertions(+), 7 deletions(-)

-- 
2.34.1

