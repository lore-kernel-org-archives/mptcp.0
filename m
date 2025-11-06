Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100D2F998D
	for <mptcp@lists.linux.dev>; Thu,  6 Nov 2025 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415711; cv=none; b=YM+sTnHzWfk/zwBltJ+PqWTzoaYQE+I7Wyb5dQKyNoaeSptpZbW49YLEY16LSRrHWKlpDAVFi4FmoGVah7qBHhwduRbnMSoxHxInSx9m3dVrGIxqlU1jMzDSfV1zaGnSzKbzFz2sxW7mW3f+nPe0RJJSAt55DHsQtNeFp0FMm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415711; c=relaxed/simple;
	bh=py88LV1IEzc1nbkdcKPWavqm/K+KEV+5q+sek8Ssid4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmLvIJrd+HeDoOYyMpNyVpnqPgFeAhntUWYtTGW0/PhPuyIjXN0HYx1AQe5jXrG9UcTazwXJlbbNfs+f5t56maZWkaLOUcvXfBSEr0HCXrkjI1rlok0mspYIMqzGjfkf0YG1YDLoaEnb3kV4qQ614iT8CPIP31B2wt9eqI3DBCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K4/Gz4xo; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K4/Gz4xo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762415705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jXeDOohRraEsTAAw1lIy70dQ0uEYenl/eU9DJvD7qWM=;
	b=K4/Gz4xoUWhACod0bov/xWrd6/awiC0WREZcu8buyAOKLtVJ6JqsHKND1vwBm0RprTqbvY
	YeXnObygWZZ2Fr4gS+QjKd8l31ShpccI7vzwfLrOFGhA9Cvj/buXNfrqaa8YNxP6p8UP/O
	ZTCkF0x2+DIz/TXSe8KgiNB11St52SE=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH, mptcp-next] selftests: mptcp: Add a check for 'add_addr_accepted'
Date: Thu,  6 Nov 2025 15:54:57 +0800
Message-ID: <20251106075457.41025-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

The previous 'delete re-add signal' test did not validate the
'add_addr_signal' and 'add_addr_accepted' counters. These counters
are crucial for ensuring the MPTCP path manager correctly handles the
subflow creation via 'ADD_ADDR'.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4faf58fecc94..cca97a8ad0d6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4203,38 +4203,45 @@ endpoint_tests()
 			$ns1 10.0.2.1 id 1 flags signal
 		chk_subflow_nr "before delete" 2
 		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 1
 
 		pm_nl_del_endpoint $ns1 1 10.0.2.1
 		pm_nl_del_endpoint $ns1 2 224.0.0.1
 		sleep 0.5
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
+		chk_mptcp_info add_addr_signal 0 add_addr_accepted 0
 
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 3
 		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
+		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
 
 		pm_nl_del_endpoint $ns1 99 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after re-delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
+		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
 		mptcp_lib_kill_wait $tests_pid
 
 		kill_events_pids
-- 
2.43.0

