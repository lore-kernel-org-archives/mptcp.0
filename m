Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254177;
	b=0vcbCabKVFrb/bTTkk5UajvP3Kpl9x/9BiehRxlB1ph98OEWLU6Ilp4IWD7GQqz6/eeu
	 /mQjBCJqjQ0KTquGVx2H6W/BwSqBZ4GFU23GsAfegA0Cwkyquu75BBpvFR7s+A8fgs4/L
	 gCa6r61dRcC+eHfvf3I5EHf9b9lzQALs/m6qSCxcsN1q/wkBVAk5dz8xjH3A2K2FnUHvL
	 9ZPraqE0zLRvnuaeLSHj8bO4g57ejdo+JbSPoxONCaPUR+33jTcE5Ezr0pFA9v9ZbvB/j
	 7TcpRVHl4sVHwsrw7OdF4SH7YUV7Cw6GNky2DlPB0UQevHtZ0+mTPzhcqx9cjVJaQcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254177;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JGna/U+3lUN2A873tE+UyJObLaKT7mtIxa9mi776ucs=;
	b=f7GZw6JnxntEi21T/jXoQY/8GHkYM5UL3z/gxGW8netDaYlz6QFMIKBYvbQAtWM6ZLnC
	 wkWm7eyPi7dB4hLDJfxMG1pK3G1/KUafh6wD40THaFxPFRXE8eK8GW5EAVG9QetF3SRfz
	 hBvgyXmHxdhGWqEO+JYNGU7WmtGhdY0n3PvJfWBw6EfV0e08IDQ2oxfKAooEYshd3co/H
	 14ACnIcnaGqMIfBfcHeR8k1j/WXs8r7xKP+doTgFQOgXku/0cGMEjtfNF+e45r/GmLa8h
	 F/Aer3ICMxVfd3zwAAq84JvtnUpmm9p6El/WToGQ6xoJe9Ju0anIjBwnjeNJephMe/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbIinB9D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FBC606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbIinB9D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5EE1F000C6;
	Sat, 21 Nov 2026 09:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254176;
	bh=JGna/U+3lUN2A873tE+UyJObLaKT7mtIxa9mi776ucs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cbIinB9Duiz5QO4qARHgBW65Y2Cw0sYMzsYCgZqO5X8RTUMvOBLSdIBSLNz1O+LQ2
	 jewD/Ot48pNS+FSTGHFgzP9LMCxjwJ0ZEHGwcGBOQrXyAbG/G2+BFRWQFD16cJvNlc
	 SsQQu1rZTkYxGXShNL/W//G8PBQpeYSc5R+8NyRMGr8kufMDHsr9dUUr5bgKenEXGe
	 D7WamyLzlXzNY0Pakup8X1Kd1ILj2DvJIJca+UZadzFHc3tRTzR/XRsLVp/oGlLZeC
	 GyeYQIMAlyjQluIRRZwWI/Ki4jOiFU+mj+ujetUKGdJN8Sc6Wif4pu1e+j6vM9hiUy
	 Ex7ugqFXvRF3A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:41 +0100
Subject: [PATCH mptcp-net v2 43/62] mptcp: pm: kernel: don't count
 signal+subflow ID 0 endp
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-mptcp-cmason-fixes-v2-43-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5aj4X1VngcnbQopcabjUhJtSELjGQkg8VtpA8/I8OX4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0zNmL5+vU/rIeOpHf701x/5JMCxzORIpftHiYWNvw
 LpHB/ZVdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEykcQUjw0ftZ8JxXzpe+e/l
 /FezOjZPsNQgbsPjZdET3vztb7qcosrw38sxyVDnjcrGVQpyHK6XZst9l80+uZj1/DtGcZ6tv2a
 H8QIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Josef Bacik <josef@toxicpanda.com>

local_addr_used must not be incremented for the endpoint of the initial
subflow, because __mark_subflow_endp_available() does not decrement it
for ID 0. mptcp_pm_create_subflow_or_signal_addr() tells that endpoint
by local.addr.id == msk->mpc_endpoint_id, in the loop that creates the
subflows and after it.

For an endpoint with both the signal and the subflow flag that
comparison comes too late: the part that announces the address has
replaced local.addr.id by 0 already. So the counter goes up each time
such an endpoint is removed and added again while a connection that
started from its address is alive, and never comes down. When it has
reached the number of subflow endpoints, the connection does not use any
new endpoint: after four rounds local_addr_used was 5 instead of 1, and
an endpoint added then got no subflow.

ID 0 can't be the ID of any other endpoint: look at that, after the
replacement.

This issue has been found with the help of an LLM. It has been
reproduced with the modified "delete and re-add" subtest of
mptcp_join.sh, from the next commit: without this patch, the subflow of
the ID 0 endpoint was not created again at the third round,
local_addr_used being above local_addr_max:

  # 002 delete and re-add
  [...]
  #       after re-add id 0 (3)               [FAIL] got 2:2 subflows expected 3
  [...]
  [...] subflows:2 [...] local_addr_used:4 local_addr_max:3 [...]

The check after the loop comes from commit 579a752464a6 ("mptcp: pm:
in-kernel: always mark signal+subflow endp as used"), which is in all
the stable versions having the commit below.

Fixes: 9366922adc6a ("mptcp: pm: fix ID 0 endp usage after multiple re-creations")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ Keep the original one-line comment. Commit message: 'behind it' ->
  'after it' + how the issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 73261685ae4c..47c6ccb0a29e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -411,7 +411,9 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		/* Special case for ID0: set the correct ID */
 		if (local.addr.id == msk->mpc_endpoint_id)
 			local.addr.id = 0;
-		else /* local_addr_used is not decr for ID 0 */
+
+		/* local_addr_used is not decr for ID 0 */
+		if (local.addr.id)
 			msk->pm.local_addr_used++;
 
 		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh,
@@ -432,7 +434,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	 * case. This avoids issues later when removing the endpoint and calling
 	 * __mark_subflow_endp_available(), which expects the increment here.
 	 */
-	if (signal_and_subflow && local.addr.id != msk->mpc_endpoint_id)
+	if (signal_and_subflow && local.addr.id)
 		msk->pm.local_addr_used++;
 
 	mptcp_pm_nl_check_work_pending(msk);

-- 
2.55.0

