Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20008348896
	for <mptcp@lists.linux.dev>; Thu,  7 May 2026 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156805; cv=none; b=Svxh0oV4dV/9s3PENDG6/cFLqQGXQkZoui6MWe2QL+VaTkZQmB2YcH/zRw17bMR7snLYYPVMbgdjxj9F6RQDuTihjnocpUhJTynZzqVFRFbAVodaVnusr3znmxYLRRQHKntwXn/0sJ7Ii+uZJzEJwicagsKWJ9SqwQyhctfH/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156805; c=relaxed/simple;
	bh=/WrLpHFNEQr7M50txOkbWq+Mpzj+7YMsxf25UuFBkkg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F7wUWMKuVZ9jNNKptbagAI/kJmujRHGxcEBqfkqSIN/Q6CL7AWPUYOHdIEP4w9m/BdpjfRYiXSGaHbzJcOBeUF1SjjycGjXXZFbvk0FcWW3Y3Tl4ZmRVzm8OQsh83M/lJLxPO7he+eh6jOrjlSalum2bAm6L6ZCGH23nOXlpvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=T0Ptn9n3; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="T0Ptn9n3"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kUw1SrtdZtwcakZuJAQt8SVxc4ym0GeArJHGDsItgjQ=;
	b=T0Ptn9n3R+vtS+FAMFilBtIpLrHKAOzGCGN5NRQcYmSvCk4cWnkDtbILEA2M+r8JaaS9zIYFU
	iufl0QWYmfxlKPXweW3orQJxLIbxJX4tG7B0FFVw3iD0u1gzgaiTcJR5DlEmJ72dvgo1/XBYMi5
	MM9XvWJ3WSJCAcPw0Wf6eHo=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gBBBF4MQMz1T4Fx
	for <mptcp@lists.linux.dev>; Thu,  7 May 2026 20:19:01 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id A2B4B40537
	for <mptcp@lists.linux.dev>; Thu,  7 May 2026 20:26:34 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 May
 2026 20:26:34 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: <mptcp@lists.linux.dev>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>
Subject: [PATCH mptcp-net v3 0/2] mptcp: pm: fix ADD_ADDR timer infinite retry on option space shortage
Date: Thu, 7 May 2026 20:52:22 +0800
Message-ID: <20260507125224.3536507-1-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj500018.china.huawei.com (7.202.194.48)

This series fixes a bug where the ADD_ADDR timer can keep rescheduling
indefinitely when TCP option space is insufficient, blocking subsequent
addresses in the endpoint list from being announced.

The issue is reproducible when sending an IPv6 ADD_ADDR with port while
tcp_timestamps is enabled. In that case, option space may be exhausted on
pure ACKs, and ADD_ADDR retransmission can stall PM forward progress.

Patch 1 clears the signal in this path, skips the matching ADD_ADDR
retransmission entry, and preserves PM state-machine progression.

Note on concurrency: timer cancellation in this path is best-effort.
A concurrent add_timer callback that acquires pm.lock first may still
perform one final ADD_ADDR send attempt before cancel state is applied.
After cancel sets entry->retrans_times to ADD_ADDR_RETRANS_MAX, the
callback-side check prevents further ADD_ADDR retransmissions.

Patch 2 adds a selftest to cover this behavior and prevent regressions.

Patch summary:
  - patch 1: mptcp: pm: fix ADD_ADDR timer infinite retry on option space
    insufficient
  - patch 2: selftests: mptcp: join: cover ADD_ADDR tx drop and list
    progress

Changes since v2:
  - document the possible timer-cancel race window in the commit message
    and code comments
  - keep best-effort cancellation semantics (possible one extra send
    attempt under lock-order race), while preventing further retries via
    retrans_times gating
  - selftests: remove the redundant ADD_ADDR tx-drop subtest that
    duplicated existing coverage for list progression behavior
  - link to v2:
    https://lore.kernel.org/mptcp/20260430112026.343691-1-lixiasong1@huawei.com/

Changes since v1:
  - add explicit MIB accounting for this drop path:
    - MPTCP_MIB_ADDADDRTXDROP for non-echo ADD_ADDR
    - MPTCP_MIB_ECHOADDTXDROP for echo ADD_ADDR
  - add explicit handling to stop the matching ADD_ADDR retransmission
    timer when skipping non-echo ADD_ADDR on pure-ACK option-space
    exhaustion
  - keep PM forward progress by advancing PM state after a successful
    skip of the matching ADD_ADDR entry
  - add selftest to verify IPv6 ADD_ADDR with port tx-drop when
    tcp_timestamps is enabled
  - link to v1:
    https://lore.kernel.org/netdev/20260418100018.2219500-1-lixiasong1@huawei.com/

Thanks to Matthieu Baerts for the detailed review and suggestions.

Li Xiasong (2):
  mptcp: pm: fix ADD_ADDR timer infinite retry on option space
    insufficient
  selftests: mptcp: join: cover ADD_ADDR tx drop and list progress

 net/mptcp/pm.c                                | 56 +++++++++++++++----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 31 ++++++++++
 2 files changed, 77 insertions(+), 10 deletions(-)

-- 
2.34.1

