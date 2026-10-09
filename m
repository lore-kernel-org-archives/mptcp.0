Received: from mta0.migadu.com (out-21.mta0.migadu.com [91.218.175.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B83472558
	for <mptcp@lists.linux.dev>; Fri,  9 Oct 2026 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791530834; cv=none; b=OhJ4MOJRHt3MjTJ7+dRsaNBmF8wXCFQnup7hAZnf+CyAhSn1OCEu42tR+heXitUoW3vSbmdy0ibm6PZ6HnDgNW+2ftR5sDN9SkUDrxguAm1A+1uBnmdhfqXcAoecqhrNvNG3EAGOcbfNJ+3/4ZVWSYLjGhLFAF2SwM7aAv/DjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791530834; c=relaxed/simple;
	bh=3HcmHVwYfjjZE/oIR0ErPyMhX1KKb6AnAZAglUVjOT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ge8E2qccF4ZmG3MJBmTrTL67f1hSAZlPpH4H1CJC7D9wIJFriMWfPNziYHusbb6kPgRUF98OnOs+KwgRB1VT0BJqMhg7dunmWwV2zcIaB9a3qRoAQYGxuQ2487xM5Nvg3BcArXJHx2nxUj2IC1gnii35jxTHM0RPkoqi8XaM5Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PHodY9OW; arc=none smtp.client-ip=91.218.175.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PHodY9OW"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=3HcmHVwYfjjZE/oIR0ErPyMhX1KKb6AnAZAglUVjOT0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791530828; v=1; x=1792135628;
 b=PHodY9OWthRG+Z7iCOKcCjFrcfo9aOVoBfHJwKHjvax62blz225aBz2uglsSeDXsi2Nab9er
 D8T/WRvgRG9ANA49SzTL6AyN7LPAfVACpDjSdcc5k5JKCwscVhySPmNLbsg4j6A5pj27I/2NUTe
 YWnM5iD0NLQyGpUvgWe/RL1I=
X-Envelope-To: mptcp@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id 720cb582d82d40af;
	Fri, 09 Oct 2026 07:27:08 +0000
X-Mizu-Trace-ID: 720cb582d82d40af
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Fri, 09 Oct 2026 15:26:57 +0800
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: convert iptables
 to nftables for mptcp_join.sh"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-mptcp_remove_addr-v1-1-4471d460e026@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7TtAIpb4SIaFr7SGTNUKQ/p50H
 JiZChmZMMPcVWB8KNMVG6i+A3dscUdBvjEMctBKykmc6XbJMp7Xg3bznoU2xoSg5KichtYlxkD
 lfy7w6yJiuWF93w9XZdqQbwAAAA==
X-Change-ID: 20261009-mptcp_remove_addr-6777ff1041c6
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

After squash, the new commit description could be:

During conversion, we retain the same table and chain names used by the
original iptables/ip6tables setup, so rule output is identical to the
former iptables/ip6tables output. Add new function init_nftables so we
only do nft table setup when test need set nft rules.

Unlike iptables, nftables cannot match rules based on their full
specification. Since endpoint_tests is the only test that delete rules,
which inserts and deletes rules one by one. Flushing the table
directly is safe and easier than using nft_handle.

The cBPF bytecode matching MPTCP add‑addr is replaced with native nft
matching using "tcp option mptcp subtype add-addr". But the RM_ADDR
suboption is added after the MPTCP DSS option, and nft is unable to
handle this because it stops parsing further TCP options once it matches
the first one. We therefore use hard-coded offsets to match the RM_ADDR
suboption.

The config file adds CONFIG_NFT_NUMGEN (replaces iptables statistic nth),
CONFIG_NFT_REJECT and CONFIG_NFT_REJECT_INET for reject‑related rules.
Remove other unneeded configs.

Remove the iptables/ip6tables check in mptcp_lib.sh since no script use
it now.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Tested with this nft rule and I can see it captures the rm-addr pkts

chain OUTPUT {
        type filter hook output priority filter; policy accept;
        ip saddr 10.0.2.2 tcp doff 12 @th,256,16 0x1e0c @th,352,8 0x1e @th,368,8 & 0xf0 == 0x40 counter packets 3 bytes 204 accept
        ip saddr 10.0.1.2 tcp doff 12 @th,256,16 0x1e0c @th,352,8 0x1e @th,368,8 & 0xf0 == 0x40 drop
}
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b16e24418e73..cf079c18af12 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -97,6 +97,20 @@ unset add_addr_tx_nr
 unset add_addr_echo_tx_nr
 unset add_addr_drop_tx_nr
 
+# A tcpdump capture of the RM_ADDR message looks like:
+#
+#   [TCP header: 20 bytes] [nop] [nop] [timestamp: 10 bytes] \
+#         [MPTCP DSS: 12 bytes] [MPTCP RM_ADDR: 4 bytes]
+#
+# nft cannot process the RM_ADDR option because it stops parsing after
+# matching the first DSS option. Use hard-coded byte offsets to match
+# RM_ADDR messages. We verify:
+#
+# TCP Data Offset (12 x 4 = 48 bytes), DSS (TCP[32] x 8) kind (MPTCP 0x1e)
+# and length (0x0c). RM_ADDR (TCP[44] x 8) kind (MPTCP 0x1e) and subtype (4)
+
+RM_ADDR_OFFSETS="tcp doff 12 @th,256,16 == 0x1e0c @th,352,8 == 0x1e @th,368,4 == 4"
+
 init_partial()
 {
 	capout=$(mktemp)
@@ -4375,7 +4389,7 @@ endpoint_tests()
 		local nft=1
 		ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
 			ip saddr 10.0.1.2 meta l4proto tcp \
-			tcp option mptcp subtype remove-addr drop || nft=0
+			"${RM_ADDR_OFFSETS}" drop || nft=0
 		local i
 		for i in $(seq 3); do
 			pm_nl_del_endpoint $ns2 1 10.0.1.2
@@ -4454,7 +4468,7 @@ endpoint_tests()
 		local nft=1
 		ip netns exec "${ns1}" nft insert rule ip filter OUTPUT \
 			ip saddr 10.0.1.1 meta l4proto tcp \
-			tcp option mptcp subtype remove-addr drop || nft=0
+			"${RM_ADDR_OFFSETS}" drop || nft=0
 		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after delete ID 0" 2

---
base-commit: 5ac58fb7c561392ec051c390479ca746c42ca989
change-id: 20261009-mptcp_remove_addr-6777ff1041c6

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

