Received: from mta1.migadu.com (out-46.mta1.migadu.com [95.215.58.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5346E1AA1F4
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 05:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498727; cv=none; b=TcU2aQHIEc/9jy2TrblCde/S97Az1e/U0LbD1NNI0s9NN/WE8t1+a2Qkg23suPA8STvli2vq90yThFn/EKOpvoIUgsl6MbpXZEcLxklq53RZliftJyRkhIkoa7UyKL6vBnM+CQC9UBsEU0gJxeYGc1BG8856jJsJVEDL38qiHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498727; c=relaxed/simple;
	bh=zA8fwKBupg/DDIhIF5wH9dmthVjFzNRotdeVCQgTBME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4rU49ZqCiB6nARv3GDGvwjXY6dysgDiTVjLQwdNGXBklny0zV5DZoZrx9Oeh8bYcHEJFFT+1cUP9Gj1qjIS+IznrDh7WDZYESHn5/aJM9B22GtXfUkr+DXlHaqvHnj5Vf4CIV5vNx/2Cq/T9CaDe5We0TBExQCYXyZm18nlMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XU3D6zjE; arc=none smtp.client-ip=95.215.58.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XU3D6zjE"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=zA8fwKBupg/DDIhIF5wH9dmthVjFzNRotdeVCQgTBME=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788498722; v=1; x=1789103522;
 b=XU3D6zjENtuVG3yTGtvzBG76JUG27QRYqWaVCQjzG0s6jhsCBe9AJVC7MeR9RchglZ6FFH2a
 qDETR670GsdVdm7YcCVSycstMDxXBGHgly+/rqzu3NsWlHVGc4lmcYzGQ5XosO2ZeNjRhcvjdFQ
 pWu8c8E8HGmialSECDi8v2/A=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 281f486779fb6a12;
	Fri, 04 Sep 2026 05:12:02 +0000
X-Mizu-Trace-ID: 281f486779fb6a12
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	quanyeyang@proton.me
Cc: geliang@kernel.org,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH mptcp-next v3 0/3] mptcp: pm: fix reachable extra_subflows guards
Date: Fri,  4 Sep 2026 13:11:47 +0800
Message-ID: <20260904051150.1196427-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Hi,

Following up on issue #629, here is a fix series for the issues
reported against e99c1ca871 ("mptcp: pm: add WARN_ON_ONCE guards
on extra_subflows underflow").

Patch 1 bounds the userspace PM admission at U8_MAX, so the u8 can
no longer be wrapped by a peer establishing more than 255 subflows.

Patch 2 addresses the disconnect() vs MP_JOIN race: as discussed,
the decrement sites now check the msk state first and skip the
accounting when the msk is already in TCP_CLOSE, as the state is set
before mptcp_pm_data_reset() clears the counters, and once the msk
is closed the accounting is not relevant anymore. No new lock is
involved. The guards themselves are downgraded to a clamp with a
rate-limited pr_warn(), as the warn was reachable and turned into a
remotely triggerable panic on panic_on_warn kernels.

Patch 3, from Quanye, applies the same bound to the Netlink subflow
creation path.

Changes since v2:

- Patch 3: label moved inside the if-statement, a note about the
  pre-existing unconditional local address deletion in the reused
  error path, and the spurious empty line before the SoBs dropped

Changes since v1 [1]:

- Patch 1: re-use "ret" instead of a new variable, drop the
  comment, Co-developed-by added for Quanye, who sent the same fix
  independently
- issue reference: Link: on patches 1 and 2, Closes: on the last one
- New patch 3 from Quanye for the Netlink path, per the discussion
  with Matt [2]

Validated with the virtme CI (mptcp selftests), and with a stress
repro comparing the base kernel and the patched one: on the base
kernel the server accepts 256 MP_JOINs and the counter wraps to 0,
with the patches admission stops at 255 and the leftover imbalance
only shows up as a rate-limited warning.

[1] https://lore.kernel.org/20260831093206.689827-1-cui.tao@linux.dev/
[2] https://lore.kernel.org/all/c8c4f667-5d25-4d94-8627-387d4091c8c4@kernel.org/

Quanye Yang (1):
  mptcp: pm: userspace: cap extra_subflows on Netlink subflow creation

Tao Cui (2):
  mptcp: pm: bound extra_subflows admission on userspace PM
  mptcp: pm: skip extra_subflows accounting on disconnected msk

 net/mptcp/pm.c           | 17 ++++++++++++++---
 net/mptcp/pm_userspace.c |  7 +++++++
 net/mptcp/protocol.h     | 14 ++++++++++++--
 3 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.43.0

