Received: from mta0.migadu.com (out-160.mta0.migadu.com [91.218.175.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515F385D6E
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044454; cv=none; b=tmYscqUBMsBWuEAe94HFbwrVUOdhZhbsxPJ8yBWZMXKsfZBmVsQdOg61YfKdX933ht1cDayvJnO8VX7op1QT4KrJwjX8Ke0ZyWzTZ8/X6h35wPnqNF+rQ0gJzuQeWbcEI1kCBe9wUs6nH/1smuvesHKpHhBthZS+/2cYopz7zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044454; c=relaxed/simple;
	bh=cdIel/41jBffA38CiumFQd2Z1Q0V+nJxNt1aKYZNL40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=J3QyG3kCvPR4XdTznGRwhpQdNLn+jpOBX55LIzitc31RbXPbpYO/AcIj5ep7KkUS7bUSljKDOw+oFL7tzMbzpJFuKEMtFA3Y1h7m8HsinlPpX5Pfkhlu0bhD0g0w/1PIVMWf+COr+5hicsS38VvwZ4EojQgB3vW/eH26wCGMGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bS6hXj6P; arc=none smtp.client-ip=91.218.175.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bS6hXj6P"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=cdIel/41jBffA38CiumFQd2Z1Q0V+nJxNt1aKYZNL40=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787044449; v=1; x=1787649249;
 b=bS6hXj6PVB4snPB9wFRpObBB5vtxBlG+pqHkDDcGGbSv4rNwplfXyUiIxiIIT4RhT1icviPe
 mOr5+MYO4d9TvHUaM7GN+q3w0baRFC2O2xnN3X89THfwT0ndcfBOi8H3okh7DEAc5W1t0EKgy8P
 aMhv8lesLfY1BmdnW0UqgoFE=
X-Envelope-To: mptcp@lists.linux.dev
Received: from localhost.localdomain (240a:4281:fe00:1ace:7fcd:c486:d361:c952)
	by smtp.migadu.com with ESMTPS id affab7ccf8cd6aa6;
	Tue, 18 Aug 2026 09:14:09 +0000
X-Migadu-Flow: FLOW_OUT
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH mptcp-next RFC v4 0/2] mptcp: fallback to TCP on MP_FAIL with a single subflow
Date: Tue, 18 Aug 2026 17:14:15 +0800
Message-Id: <20260818091417.2200986-1-chenguang.zhao@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

As suggested by Paolo, on MP_FAIL reception bound the MP_FAIL
reply and the infinite mapping in the same ACK.

Patch1:
 Add MPFailFallback MIB.

Patch2:
 Makes a pure ACK able to carry an infinite mapping: when
 send_infinite_map is set, mptcp_established_options_dss() fills
 a DSS map with data_len=0 even without a data skb. After the ACK
 that carries both the MP_FAIL reply and that mapping is sent,
 mptcp_try_fallback() is called immediately so the connection leaves
 MPTCP mode without waiting for a later data transmit.

Chenguang Zhao (2):
  mptcp: add MPFailFallback MIB
  mptcp: send MP_FAIL and infinite mapping on the same ACK

 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/options.c  | 33 ++++++++++++++++++++++++++++++++-
 net/mptcp/pm.c       |  5 +++++
 net/mptcp/protocol.c |  8 +-------
 5 files changed, 40 insertions(+), 8 deletions(-)

--
v3:
 https://lore.kernel.org/all/20260812054653.43799-1-chenguang.zhao@linux.dev/

v2:
 https://lore.kernel.org/all/20260715061830.1057851-1-chenguang.zhao@linux.dev/

v1:
 https://lore.kernel.org/all/20260713064134.914507-1-chenguang.zhao@linux.dev/
-- 
2.25.1

