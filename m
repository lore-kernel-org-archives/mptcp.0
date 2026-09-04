Received: from mta0.migadu.com (out-54.mta0.migadu.com [91.218.175.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4E3B9601
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507209; cv=none; b=Eosujm1ulAR8O/eNE6HLUvQWuShIcseV8QB9Qiw5XN+hUl6w+tmi58UNWjWCdMH30ZcTpCnt0kfakxfcZw5E9Q83oDBqzqHtWJrZgEx3DJlGlecLIY9Bc6pyvIt5bC5J3Ccw+Itz1xLCE/bRhVRiZDU1vP8zlOpgygPSqEp7BKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507209; c=relaxed/simple;
	bh=CWKe4hYQjWPPfUP9s4lLcHtGS6xpP5jhoDy+CWf91Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WiX+Td2sh3aENBPCOWeVzIpFVZZST9SwHvVIxMtcj8bNuzzvGoN+8EGdUowU3UEsupfQ/i01MjXz6FKj3w85ffT9lFf6xEPAOI+0NqHKARozxOGQvwAV+GnSu6yj2uwtBG85Qz98oNIPG29rDfBQhwTHhR1bZwUXr5x2Dg+EAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w8RxyCc8; arc=none smtp.client-ip=91.218.175.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w8RxyCc8"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=CWKe4hYQjWPPfUP9s4lLcHtGS6xpP5jhoDy+CWf91Nk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788507204; v=1; x=1789112004;
 b=w8RxyCc8silPYy87qnQXfCIRul19n1ho1Dx+aG/BkVegT5CN8mwekVZzHwyrvv30hfeUfBXt
 gYEhBsOMJGTOCcvpy32eg7oSvW09NMdYqKgUG8ZdaLbOGhNOMA+YM65aJc1hVkrz8lBCtP5ms+4
 Z3So49Vvzs5vdMtMUosWVRTk=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 5b485ecec2f8b5bd;
	Fri, 04 Sep 2026 07:33:24 +0000
X-Mizu-Trace-ID: 5b485ecec2f8b5bd
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH mptcp-next 0/2] mptcp: fix disconnect races around the PM and cb flags
Date: Fri,  4 Sep 2026 15:33:09 +0800
Message-ID: <20260904073311.1285024-1-cui.tao@linux.dev>
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

This is the follow-up series promised in reply to the Sashiko
review of the extra_subflows fixes [1]: two pre-existing issues in
the disconnect path that were reported there but left out of that
series on purpose.

Patch 1 fixes a subflow socket leak: mptcp_disconnect() clears
msk->cb_flags with a plain write and can drop a pending
MPTCP_FLUSH_JOIN_LIST, so a subflow queued in the join list while
the socket is being disconnected is never flushed by
mptcp_release_cb(), and mptcp_destroy_common() only iterates
conn_list. The flush flag is now preserved across the disconnect,
and the masking is done under the data lock like the flag setter.

Patch 2 closes a data race reported on the same socket state:
mptcp_pm_data_reset() clears the PM data with a plain memset while
the RX path accesses the same fields under pm->lock. The reset now
takes pm->lock, with no lock inversion, as the callers hold the
socket lock at most.

Both are independent of the extra_subflows series [2], which only
made the accounting robust against the counter imbalance these
races can leave behind. Paolo's recent "mptcp: prevent race
between disconnect() and rtx" fixes a third race in the same
window.

Validated with the virtme CI (mptcp selftests).

[1] https://lore.kernel.org/all/739848e0-1d35-4ed7-afd7-4b0609ddb8d0@linux.dev/
[2] https://lore.kernel.org/all/20260903131416.1112393-1-cui.tao@linux.dev/

Tao Cui (2):
  mptcp: keep pending join list flush across disconnect
  mptcp: pm: take pm->lock in mptcp_pm_data_reset()

 net/mptcp/pm.c       | 5 +++++
 net/mptcp/protocol.c | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.43.0

