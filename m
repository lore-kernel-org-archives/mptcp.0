Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDCA27467F
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832012; cv=pass; b=u/3q5km/rnN457yReENEun0lo6DMglHmnbXy8h+5cC872U66gd/GD56vLFATHRoGKhWQdpksH6tmqWpGlkqwxgyuqBCoOMjFdtrG8WXtEbf4oVLfx5vQB59YQ1tAVGkqGa42C1k7D7BjmMqy9S7TRkCkPM9V7Crfajr6vdTxQds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832012; c=relaxed/simple;
	bh=LuQsXWOaHc3AD29DR4VoNKnhk0aOqW/TmHbvyEPhy0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rt9bKtjkHecjm8aB4RX0k9cPalyYzKXCniAFYEm6ulQL5k+9o2cXcKhRbTCPMLKtuTmvzwCfpe3/PEH0k9F1Lz3XsRQEvQV7qAaw2PK4S+NjIO0HTksalg31wBXWeaxlzSgHAw73MJP0v6znCRONEzMCywptHAOtjwSafgux4Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=RJmQqzYD reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="RJmQqzYD"
ARC-Seal: i=1; a=rsa-sha256; t=1782832005; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WzTpLJg1A7sdomk1+m0+mhrZj0i2P57sf0f9/5O9OckVIs06LDLR3eCpMtaJWTqvKgrNLwOBq7ri6IbuANbG/1EazxaDxyPNzmJHf4KknSjikBG+QJskFtGEb/PPBX4FRA2pSWZngkJuKPt0eGP+5z/1mRyiB8wHMU7h/EM11JM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782832005; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v1UzxH2RDDXkfunkJ6g6hBrPh0ECpc5If4DcGph+44A=; 
	b=fP7p5cNGAGu/1pLZpM3z1NipCA/cvJaAznBdzZ5W/WNnNwc0MTcNHoD3drDDr6n+gHl6a+SuMCQ2kUNkh96TLWozAmRguiYjWewIlynrmvNCYv9tgKjkwaRLiTe+lFa2u89wDNZEJ9j2pioIFHbg21i5cDMAcFoAyoLKWQgNEDo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782832005;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=v1UzxH2RDDXkfunkJ6g6hBrPh0ECpc5If4DcGph+44A=;
	b=RJmQqzYDBkuFqCBWlln0L9mNUnUoh55EIvjazJ4HA/subHnYbWbBxzmOxjXrd7hj
	AU6woUPnFnZ+CjIuwLLRU+gj7Y2tshgHvLHATPQSwAjqYp2kpa7j8oSynqDmU3W58si
	YQuLOED6DWxCw4Ayvvf3fZwHx1/6lr+grRnOK8VE=
Received: by mx.zohomail.com with SMTPS id 1782832002725417.1013901033183;
	Tue, 30 Jun 2026 08:06:42 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	akshit@mpiricsoftware.com
Subject: [PATCH net v5 0/2] mptcp: pm: fix stale ADD_ADDR anno_list entry on id 0 removal
Date: Tue, 30 Jun 2026 20:36:30 +0530
Message-ID: <20260630150632.899750-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The in-kernel MPTCP path manager can leave a stale ADD_ADDR announcement
entry alive when removing the id 0 endpoint, causing WARN_ON_ONCE() to fire
on subsequent PM reselection (issue #620).

**The Problem:**
When the in-kernel PM removes a signal endpoint, it must cancel any pending
ADD_ADDR announcement: stop the retransmit timer and unlink the anno_list
entry. For non-zero id endpoints, this is done correctly via
mptcp_nl_remove_subflow_and_signal_addr() -> mptcp_pm_remove_anno_addr() ->
mptcp_pm_announced_remove().

However, the id 0 removal path (mptcp_nl_remove_id_zero_address()) skips
this cleanup, only queuing an RM_ADDR and marking the id available. If an
ADD_ADDR for that address was previously announced but the echo hasn't
arrived yet, the anno_list entry survives.

When the kernel PM later reselects id 0 (after adding another signal
endpoint to satisfy the PM's endpoint limits), it finds this stale entry
and hits the WARN_ON_ONCE(mptcp_pm_is_kernel()) assertion in
mptcp_pm_alloc_anno_list().

**How It Was Found:**
syzkaller detected this via an MPTCP protocol-flow harness. Three crashes
were reported between 2026/05/19 and 2026/05/22 on kernels including commit
cca95436be15 ("mptcp: remove id 0 address"). The root cause was confirmed
through code inspection:
asymmetry between the id 0 and non-zero id removal paths.

**The Fix:**
Patch 1 makes mptcp_nl_remove_id_zero_address() symmetric with the
non-zero id path by calling mptcp_pm_announced_remove() before queuing
RM_ADDR, and decrementing add_addr_signaled if the address had been
announced. The fix is minimal (8 lines) and mirrors existing correct code.

A subtle detail: signal endpoints are stored in anno_list with port 0, but
msk_local carries the connection's actual local port. The lookup in
mptcp_pm_announced_remove() uses use_port=true, so the port must be
cleared before the call to match the stored entry key.

Patch 2 adds a regression test integrated into mptcp_join.sh (per
maintainer feedback, avoiding new test files). The test verifies no WARNING
appears when removing id 0 from a fully-established MPTCP connection.

**Verification:**
- syzkaller: 3 crashes, issue #620 reproducible
- Docker CI: 23/24 tests pass, no new failures introduced
- Code review: Fix is minimal, correct, and mirrors existing patterns
- Suggested-by: Tao Cui <cuitao@kylinos.cn> identified the port mismatch
  (v4 -> v5 fix)

Kalpan Jani (2):
  mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint
  selftests: mptcp: add id 0 stale ADD_ADDR regression test

 net/mptcp/pm_kernel.c                    |  8 ++++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
 2 files changed, 19 insertions(+)

---
base-commit: net/main
change-id: 20260630-mptcp-id0-stale-anno-fix-kalpanj
