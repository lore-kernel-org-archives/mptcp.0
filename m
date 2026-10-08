Received: from mta1.migadu.com (out-167.mta1.migadu.com [95.215.58.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F584908BC
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453988; cv=none; b=ZYD/oIvPdjyHAArzkFkknoTpg0mKS6xC4qVgxel5kKcEGtjkyChCMxYbPWE+Kj9sdqk8t1jb4lQthmHwRLKkClYme9mgLxu1cQ1EATHUlOKVLJmAIY/CRw1/csSJGKyqqk2YM7tiAbWIrkGxKKbyeZ1EThbWoxJ5LnPrhVU1BYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453988; c=relaxed/simple;
	bh=EvBugRWIF63Fqr6Yu0/t+ZC9qI26toW20Yi525B8yPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UOcww15tlJTDy9vgafLItQiY9L+2H8V6uCusyiwF2zs5phIYGWy+lNQgIB/thB6TbClERykEpVEiDKb82hhcTJogY3bOcIdEjZ3Wr2XxfS0EbxPKXH9pewBSW6TlXs+QlcqQ3emHnhWDRwHJWkw+kC4KR5FlzMaM0QhVb6no/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AVEpHshO; arc=none smtp.client-ip=95.215.58.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AVEpHshO"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=EvBugRWIF63Fqr6Yu0/t+ZC9qI26toW20Yi525B8yPQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791453980; v=1; x=1792058780;
 b=AVEpHshOnlQ4/nG0lGa8yIeVG/OrIvpyNhzs9jWAyV8/ukmL9+9gZQzoUwcBn8YRoJsZgwyB
 xEoIYm8Rj1spz1yfhjztpjYIvja2MsdYTkz94Gp0dqsdmt1/aY7gBaaDft253WW8rJD93jOEMw3
 EhMtQpP1OeA009voPZgOKyUs=
X-Envelope-To: mptcp@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id eb9047d9a6a63b5f;
	Thu, 08 Oct 2026 10:06:20 +0000
X-Mizu-Trace-ID: eb9047d9a6a63b5f
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 08 Oct 2026 18:06:07 +0800
Subject: [PATCH mptcp-next] selftests: mptcp: use offset to match RM_ADDR
 message
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261008-mptcp_rm_addr-v1-1-b4d35ac8afef@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5W6hV3L4iItWkmoO1pCKC+HeLx
 4GZeSCSMEXosweELo58+ARFnsGyWb+SYkwMRpu60LpVeziXMMk+WURRnbFz41yJXYWQmiDk+P5
 /A/yq8nSfML7vBzGrm9VrAAAA
X-Change-ID: 20261008-mptcp_rm_addr-92ab7ff3d94d
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>, Hangbin Liu <hangbin.liu@linux.dev>, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

nft cannot match RM_ADDR when it is the second MPTCP option,
so we rely on hard-coded offsets. A tcpdump capture of the RM_ADDR
message looks like:

  [TCP header: 20 bytes] [nop] [nop] [timestamp: 10 bytes] \
        [MPTCP DSS: 12 bytes] [MPTCP RM_ADDR: 4 bytes]

We verify: TCP Data Offset (TCP[12] × 8) equals 48 bytes (12 x 4),
DSS length (TCP[33] x 8) is 12 bytes, and RM_ADDR subtype (TCP[46] × 8)
is 4. This matches the old cBPF check, which calculated offsets starting
from the IP header:

(ip[32] & 0xf0) == 0xc0 && ip[53] == 0x0c && (ip[66] & 0xf0) == 0x40

Also add MPTCP kind (30) checks for the DSS (TCP[32] x 8) and RM_ADDR
(TCP[44] x 8) options.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b16e24418e73..194b80277ae2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4375,7 +4375,12 @@ endpoint_tests()
 		local nft=1
 		ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
 			ip saddr 10.0.1.2 meta l4proto tcp \
-			tcp option mptcp subtype remove-addr drop || nft=0
+			@th,96,4 == 12 \
+			@th,256,8 == 30 \
+			@th,264,8 == 12 \
+			@th,352,8 == 30 \
+			@th,368,4 == 4 \
+			drop || nft=0
 		local i
 		for i in $(seq 3); do
 			pm_nl_del_endpoint $ns2 1 10.0.1.2
@@ -4454,7 +4459,12 @@ endpoint_tests()
 		local nft=1
 		ip netns exec "${ns1}" nft insert rule ip filter OUTPUT \
 			ip saddr 10.0.1.1 meta l4proto tcp \
-			tcp option mptcp subtype remove-addr drop || nft=0
+			@th,96,4 == 12 \
+			@th,256,8 == 30 \
+			@th,264,8 == 12 \
+			@th,352,8 == 30 \
+			@th,368,4 == 4 \
+			drop || nft=0
 		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after delete ID 0" 2

---
base-commit: 9651c766735c19e7a6b90d731bab53ef7959def8
change-id: 20261008-mptcp_rm_addr-92ab7ff3d94d

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

