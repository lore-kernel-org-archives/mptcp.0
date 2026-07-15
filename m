Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC41FECCD
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096328; cv=none; b=IZ0gO5LPINz+Zdq6l4xa4qlD4UXS1+79SdCr1XGFSuEfEO+IfAtcu6KwRqpI62BDFGtnZVtj6/UHmOtW2NhVHCoaQrKk5b96ChVHB0i36JOsd1gR0496qrQc+syOv6Q1RK19oZXkQEyB+aPYSRFeWj8RwfS6UMDSwuQNTTdD+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096328; c=relaxed/simple;
	bh=9qQ/YfcOEBvzC+8KU3j1YkdhrQW/795HTxdtXVQA+vk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SuYWJVbcPOCh05YUNAmK/fQsysome5oeYvzSS9SIcBomar0rxW1Vk6Wvi08qUYY2ZbOhKA1wqY8iQzYGcsSj5UG/uzv3suXC696Equ3cFSSN7etmVnOaac6LDOKvixfWcqjJ7CJJbkJ7bJfTpn6FynCxvC+K3k1zjZNxgt47czw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fn5yrRpN; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fn5yrRpN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784096324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0uPUlDzfX+JwCwQegKGl3Bp4cm36a+VWLu8YU1Egstg=;
	b=Fn5yrRpNN2j7ZodErVbIm6rSQYPE3xDyYKNJ57J9mvHrDC1feGt1/LZ82nQ3vRGk+dxPTv
	z8IsSCW32U43FtEveIePoK/DgH1nIsTgUF9z4jBNM23h2u98L61pYtWhMtGQIG2hQ0WVR4
	OwMoJzDtX8ia6aKdBBal4vBabv7d1pk=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH mptcp-net v2 0/3] mptcp: fix TCP fallback on single-subflow MP_FAIL
Date: Wed, 15 Jul 2026 14:18:27 +0800
Message-Id: <20260715061830.1057851-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

When a valid MP_FAIL is received and infinite fallback is still allowed
(single contiguous subflow), RFC8684 section 3.7 requires leaving MPTCP
mode. Today the stack only clears allow_subflows and defers the real
fallback to the later infinite-map transmit path. If no data is sent in
between, the peer can still complete the 4th ACK as MPTCP and keep using
MPTCP options.

This series falls back immediately after the MP_FAIL response, rejects
later joins via mptcp_is_fully_established(), annotates allow_subflows
with READ/WRITE_ONCE, and adds an MPFailFallback MIB while switching to
mptcp_try_fallback().

Patch 1 fixes the fallback behaviour.
Patch 2 annotates allow_subflows accesses.
Patch 3 adds the dedicated MIB and uses the common fallback helper.

v1 -> v2:
- Split the previous single patch as suggested by Gang Yan
- Keep the MIB as a separate patch so the functional fix can be reviewed
  on its own

Chenguang Zhao (3):
  mptcp: fallback to TCP on MP_FAIL with a single subflow
  mptcp: use READ/WRITE_ONCE for allow_subflows
  mptcp: add MPFailFallback MIB for MP_FAIL TCP fallback

 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/pm.c       | 33 +++++++++++++++++++++++++++++++--
 net/mptcp/protocol.c | 19 ++++++++++++-------
 net/mptcp/protocol.h | 18 +++++++++++-------
 net/mptcp/subflow.c  |  2 +-
 6 files changed, 57 insertions(+), 17 deletions(-)

---
v1:
 https://lore.kernel.org/all/20260713064134.914507-1-chenguang.zhao@linux.dev/
-- 
2.25.1

