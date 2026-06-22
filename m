Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D0379C3C
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120580; cv=pass; b=r5eedO0qwnqmQHbu4cL5+R8iVtwFwLfzPFEy+MZd8ra7eyhbeBZqllsivObxrXIxAiA62+LZFwyOlUc/pluRkeu5li27wUURvmRR+SwbQONEm8Dfj6VW0ToSxEZskzimI4lKFp2rs3mz4sV+girJylrgWE4nEV9owRs7eXowrJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120580; c=relaxed/simple;
	bh=CPQHZxDz8GUvueU8BAzwfjLlUOySIYa1mC3+OjTfSSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7HgQqisWMBw6q7POzy+y39T7D8TDRkugMkvzVdr6lwx6WnUMvZ240dmgJSVhFXftDsPMuR9Lr/MFJsMwamBH3AyBny+l3go2MQiMSESPZkY2FumI9bf1Y3g7Z4kAPlGkPf73JAxW0DYB78AWsqDuPYLoMK7keL+biVQAit4nMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=c2olpeC+ reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="c2olpeC+"
ARC-Seal: i=1; a=rsa-sha256; t=1782120554; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UX/5jq55lZs6yldTBNoyWB8QtEHFgSRodXj+C63ApKFNCFujMjKBr0x/tCebSpy26UgH3bvD18Vdd1us25XUO5de/ZgfVfthHJ4KiKFsBBno+nKVUrEYl/tXC6f07iG3kjO/2SHDOxESf/Bj5Gt7ckAS6MPoE6gHMogGUtl/+mw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782120554; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mfPmAGUyzz7tSy7SZDBWhyvq6O63/8XXpvlJV+nMMYU=; 
	b=EOKfNWzav2c/2K64q5NizJ9BjwLzzXGHxoMwhPYuHOwhOhvFt386v4FQFy9C7BhEcwVUD7BaIdxfIKL5Kv2+3AZl+conBO+rzL4e2kqLY+4P8htWI7OnsUYys86ncSPLK3v5bdAS0CvFiDarvxZ43CcmONToeB1+4ClksLyjaqQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782120554;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mfPmAGUyzz7tSy7SZDBWhyvq6O63/8XXpvlJV+nMMYU=;
	b=c2olpeC+QsHMGYHJ97Y8tdV/x/ceMyc30zA3T/2TKnqdzxDOhlrIlmdUPVG/Grtm
	YS0dgGR2wvG0b2QaSjQKekBSs76n0b+J5xzqHj9QK3TI/95nINuDCCNqzc1CT/dewzZ
	oFrWuClJtuay0r3EWvkO6t1zqSfMGlDCe40FlJiI=
Received: by mx.zohomail.com with SMTPS id 1782120550782210.3781451029489;
	Mon, 22 Jun 2026 02:29:10 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	cuitao@kylinos.cn,
	syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	shardulsb08@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH net v4 2/2] selftests: mptcp: add regression test for stale ADD_ADDR on id 0 removal
Date: Mon, 22 Jun 2026 14:58:36 +0530
Message-ID: <20260622092838.1267134-3-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622092838.1267134-1-kalpan.jani@mpiricsoftware.com>
References: <20260622092838.1267134-1-kalpan.jani@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a kselftest that reproduces the bug fixed in the previous patch:
removing the id 0 endpoint while a pending ADD_ADDR echo is outstanding
left a stale anno_list entry alive, and a subsequent PM reselection
re-announced that address and tripped the WARN_ON_ONCE() in
mptcp_pm_alloc_anno_list().

The sequence is deterministic:
  1. Establish a fully-established MPTCP connection kept alive by a
     bidirectional /dev/zero stream.
  2. Signal 10.0.2.1 so the peer joins: the second subflow keeps the
     connection alive across the id 0 removal.
  3. Signal the MPC address 10.0.1.1: an anno_list entry is created.
  4. Delete id 0 (10.0.1.1): on an unfixed kernel the stale entry
     survives.
  5. Signal 10.0.3.1 to force a PM reselection: on an unfixed kernel
     this hits the stale entry and fires the WARN.

The test counts WARNING: net/mptcp/pm lines in dmesg before and after
the sequence and fails if new ones appear.

Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Tested-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 .../net/mptcp/mptcp_id0_stale_anno.sh         | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_id0_stale_anno.sh

diff --git a/tools/testing/selftests/net/mptcp/mptcp_id0_stale_anno.sh b/tools/testing/selftests/net/mptcp/mptcp_id0_stale_anno.sh
new file mode 100755
index 000000000000..96c0d2256064
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_id0_stale_anno.sh
@@ -0,0 +1,85 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Regression test for stale ADD_ADDR anno_list entry on id 0 removal
+
+. "$(dirname "${0}")/mptcp_lib.sh"
+
+ret=0
+ns1=""
+ns2=""
+err=$(mktemp)
+timeout_poll=30
+port=50000
+
+cleanup()
+{
+	rm -f "${err}"
+	mptcp_lib_ns_exit "${ns1}" "${ns2}"
+}
+
+mptcp_lib_check_mptcp
+mptcp_lib_check_tools ip
+
+trap cleanup EXIT
+
+mptcp_lib_ns_init ns1 ns2
+
+ip link add ns1eth1 netns "${ns1}" type veth peer name ns2eth1 netns "${ns2}"
+ip -net "${ns1}" link set lo up
+ip -net "${ns2}" link set lo up
+ip -net "${ns1}" link set ns1eth1 up
+ip -net "${ns2}" link set ns2eth1 up
+ip -net "${ns1}" addr add 10.0.1.1/24 dev ns1eth1
+ip -net "${ns1}" addr add 10.0.2.1/24 dev ns1eth1
+ip -net "${ns1}" addr add 10.0.3.1/24 dev ns1eth1
+ip -net "${ns2}" addr add 10.0.1.2/24 dev ns2eth1
+ip -net "${ns2}" addr add 10.0.2.2/24 dev ns2eth1
+ip -net "${ns2}" addr add 10.0.3.2/24 dev ns2eth1
+
+mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
+mptcp_lib_pm_nl_set_limits "${ns2}" 8 8
+
+ip netns exec "${ns1}" ./mptcp_connect -t "${timeout_poll}" -l -p "${port}" \
+	0.0.0.0 < /dev/zero > /dev/null 2>"${err}" &
+spid=$!
+mptcp_lib_wait_local_port_listen "${ns1}" "${port}"
+ip netns exec "${ns2}" ./mptcp_connect -t "${timeout_poll}" -p "${port}" \
+	10.0.1.1 < /dev/zero > /dev/null 2>"${err}" &
+cpid=$!
+
+sleep 2
+
+warn_before=$(dmesg | grep -c "WARNING: net/mptcp/pm")
+
+# 1. signal 10.0.2.1: peer joins, second subflow keeps connection alive
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.2.1 flags signal
+sleep 2
+
+# 2. signal MPC address 10.0.1.1: anno_list entry created for id 0
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.1 flags signal
+sleep 1
+
+# 3. remove id 0: stale entry survives on unfixed kernels
+mptcp_lib_pm_nl_del_endpoint "${ns1}" 0 10.0.1.1
+sleep 1
+
+# 4. force PM reselection: hits stale entry on unfixed kernels
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.3.1 flags signal
+sleep 2
+
+warn_after=$(dmesg | grep -c "WARNING: net/mptcp/pm")
+
+kill "${cpid}" "${spid}" 2>/dev/null
+wait "${cpid}" 2>/dev/null
+wait "${spid}" 2>/dev/null
+
+if [ "${warn_after}" -gt "${warn_before}" ]; then
+	mptcp_lib_result_fail "stale ADD_ADDR warning triggered on id 0 removal"
+	ret=1
+else
+	mptcp_lib_result_pass "no stale ADD_ADDR warning on id 0 removal"
+fi
+
+mptcp_lib_result_print_all_tap
+
+exit ${ret}
-- 
2.43.0

