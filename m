Received: from mta1.migadu.com (out-247.mta1.migadu.com [95.215.58.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107833DDDD2
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168743; cv=none; b=KHEgn0hCRlfSY58KTqzPlBsuKyHYo6DLGUXYOeJu6jpn+6NnDca1vmT3W/fVKZaqdtb26UpzRBrzuGuckXbuvOxTfq+twsDxSfNr4i3BpGMhoyc4FNFXverudcMoG4QsDtLrnRtFOLsUdQ9UHG1SezcxNdG+xJ8pZlL/eU8LkVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168743; c=relaxed/simple;
	bh=ICY4BMIkDxsCuEL0gloNr05smtGdLWcLHarKBk0rUGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZmbezKaTmWwVKR7XgQ9UdUaA013zrhJLZs8owgniBv8nHoNAxBqOvJ9WOniWFz/ujIpCswGwcYIUjWDiAEvvcxY1w4uKY5ddMab3Bdh6OkZDurRv+jgmHbDCC1XSKX8eqJgNdLYpCd5HeMsDLnNFiyt6+LgkPY5EYBkJNsSMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u7k2SJoB; arc=none smtp.client-ip=95.215.58.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u7k2SJoB"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ICY4BMIkDxsCuEL0gloNr05smtGdLWcLHarKBk0rUGo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788168738; v=1; x=1788773538;
 b=u7k2SJoB8FRMV8MppaqsCufxQNeKlrlH8FSxJrVGC8YflNQhlfc+uXWwIUxDMEoRpnVNPNPz
 9nM2IFIyUmhUzdwbeZlYS8enIZfLgop4Cw2fqXC12fSnDV7SXaBkfpDKZM/7M7l4I3ytAqQdXKr
 iutdd+miU0XHRdmerNL9Id3I=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 44a1aac1ce13ac7d;
	Mon, 31 Aug 2026 09:32:18 +0000
X-Mizu-Trace-ID: 44a1aac1ce13ac7d
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	geliang@kernel.org,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH mptcp-next 0/2] mptcp: pm: fix reachable extra_subflows guards
Date: Mon, 31 Aug 2026 17:32:04 +0800
Message-ID: <20260831093206.689827-1-cui.tao@linux.dev>
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

Following up on issue #629, here is a fix series for the two paths
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

Both patches carry a Link: to the issue with the detailed analysis.

Validated with the virtme CI (mptcp selftests), and with a stress
repro comparing the base kernel and the patched one: on the base
kernel the server accepts 256 MP_JOINs and the counter wraps to 0,
with the patches admission stops at 255 and the leftover imbalance
only shows up as a rate-limited warning.

Tao Cui (2):
  mptcp: pm: bound extra_subflows admission on userspace PM
  mptcp: pm: skip extra_subflows accounting on disconnected msk

 net/mptcp/pm.c       | 22 +++++++++++++++++++---
 net/mptcp/protocol.h | 14 ++++++++++++--
 2 files changed, 31 insertions(+), 5 deletions(-)

--
2.43.0
