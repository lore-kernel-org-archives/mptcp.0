Received: from mta0.migadu.com (out-253.mta0.migadu.com [91.218.175.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9473C4AA587
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441305; cv=none; b=Bfw2XU1m3BI5eNI+mvpN/A5YbqaSCY7Qi8GpU4YA1Bdfs6/TFBgUrnyz6Zcue6XKjwLUfkwCTj71qo0l45vXZZCRZUqmj6INIkhTNtSc+OauHR/6vvF540hgiI21nBZXQeYFFKRbi8lp58Z/pxG4mafimBnOgJBkhhiE//kRe6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441305; c=relaxed/simple;
	bh=XNeW1s8WZHSK09uHazdO+Xpc77PTOKvVHf0VO+XRZqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQNeic/ukX64zJUTa898HCeCRccy4x0WI+f0NB2BgR/K9UnZszaUFxBx9MX684J6XZ0m8+mG0/x+7JRLhhR9NL3v382hyOQ6REhLstBHTm7WNf2fanu2yBFeR4WhXF11VZXvve/c0szICCflckSjVZe8inNMguG9KKk+M/FQgFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZiHpbNmL; arc=none smtp.client-ip=91.218.175.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZiHpbNmL"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=XNeW1s8WZHSK09uHazdO+Xpc77PTOKvVHf0VO+XRZqM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788441265; v=1; x=1789046065;
 b=ZiHpbNmL3jcgcHk8JH22hFWzIcuRzIJ62xpaU3iOdZgtTATutHv9GxPZNxRizaqrIXD3TwJU
 YPjqdC0Vbx3yd40tElVYQ9dmmS3apnM99lR1R9vb3vqOYG9hQxOwV5Z/prkzyAegdMwQljuIESF
 0BQxd7EdrzuVR1AUCCGhaIyo=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 30475ea85cfe1c8d;
	Thu, 03 Sep 2026 13:14:25 +0000
X-Mizu-Trace-ID: 30475ea85cfe1c8d
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	quanyeyang@proton.me
Cc: geliang@kernel.org,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH mptcp-next v2 0/3] mptcp: pm: fix reachable extra_subflows guards
Date: Thu,  3 Sep 2026 21:14:13 +0800
Message-ID: <20260903131416.1112393-1-cui.tao@linux.dev>
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
creation path, with a goto to the error cleanup as suggested during
the review.

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
 net/mptcp/pm_userspace.c | 10 +++++++++-
 net/mptcp/protocol.h     | 14 ++++++++++++--
 3 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.43.0

