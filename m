Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20093264F9
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513616; cv=none; b=LLUOHbaTwJdkEcqwRjMNVtWXoOXMg1FKWuxurb6V9963wcT+7C2tda24/SUCuDPDMzWrkZFcuMpOLEMY4RGuLzSndH1cTHNhyjCU2f+2VLxCwxzq86EFTxmxby6TixiSaIVRkeT8y6aeRpz0rsyuC12OevfwbXhVDtlIRzcFlWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513616; c=relaxed/simple;
	bh=UgcEtHRVOEWDMfvilLxU5AYke0R4rocUQKHzqWRYVx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B2XkurwXbhEmTJyWq1NIu8iUiX/ooL86qTN8X9bICiBADc63dwlB8HTf3scqn8YWv+X4M38+2s71WVmFqJ4F/WrO+PU2FHYNkQ6MCyH5pSwLbfULsRGydLJ2DffTDuY9boJ1dq/KNvSXsbABUHIydHWqrwrwkQlpylAoVaxUw20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nr0ThdBC; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nr0ThdBC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786513612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MoNMaG7DckOAnBrweN6hRWALFxxNgmb+2Mru02m0xCI=;
	b=nr0ThdBCkWVFWIfAdk+CoZfZ9KblMpg2yx63YQCbkx7UWSnR3N9wUour0UenvWbpiD7bKe
	jFzDWTPWjiXuWOGG7j5vLJbn+nl2nGTnh378oIUEaqeiVO1lTH2gjKglq3EHTWYyAFoOo7
	JMy84a6/eXNEf278bEXuc7XDsl7/UFM=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH export v3 0/4] mptcp: fix TCP fallback on single-subflow MP_FAIL
Date: Wed, 12 Aug 2026 13:46:49 +0800
Message-Id: <20260812054653.43799-1-chenguang.zhao@linux.dev>
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

This series adds a dedicated MPFailFallback MIB, rejects joins after
fallback via mptcp_is_fully_established(), resets when the OoO queue
blocks infinite mapping, and falls back immediately after the MP_FAIL
response through mptcp_try_fallback().

Patch 1 adds the MPFailFallback MIB.
Patch 2 rejects joins once fallback has completed.
Patch 3 resets on MP_FAIL when the OoO queue is non-empty.
Patch 4 falls back to TCP after sending the MP_FAIL response.

v3:
- Address Matthieu Baerts' review

- Introduce the MIB first (Fixes: c65c2e3bae69) and reuse
  mptcp_try_fallback() in the functional fix

- Split mptcp_is_fully_established() and OoO handling into dedicated
  commits for easier backport

- Check FALLBACK_DONE via test_bit()

- Drop allow_subflows from mptcp_is_fully_established() (and the
  READ/WRITE_ONCE follow-up)

- On OoO failure, reset without sending MP_FAIL

- This patch series is based on the export branch, The git repository
  is: git://git.kernel.org/pub/scm/linux/kernel/git/mptcp/linux.git

Chenguang Zhao (4):
  mptcp: add MPFailFallback MIB
  mptcp: reject joins after fallback in mptcp_is_fully_established
  mptcp: reset subflow on MP_FAIL when OoO queue is non-empty
  mptcp: fallback to TCP on MP_FAIL with a single subflow

 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/pm.c       | 17 +++++++++++++++--
 net/mptcp/protocol.c |  4 +++-
 net/mptcp/protocol.h |  5 ++++-
 5 files changed, 24 insertions(+), 4 deletions(-)

---
v2:
 https://lore.kernel.org/all/20260715061830.1057851-1-chenguang.zhao@linux.dev/

v1:
 https://lore.kernel.org/all/20260713064134.914507-1-chenguang.zhao@linux.dev/
-- 
2.25.1

