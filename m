Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557695;
	b=JNN1AmbINKfd1KDex5lRlYCs/J2qN3+IqhR8W7BxPzt5JtoZVzC9iPq3KEDq7rk9iNFU
	 S3u81WevRRlyErnXLJHAD9SLxNO2pICW6fs4tuO0YgaalukSxwj1BHLtUyKWzFgd2JxcX
	 uqIAMkyrPyUmry39FJJK59sGUmafSNvpvq5vlyiwwryoDt/LNIQ7SOf1tJazv8/V0Ka92
	 hjAaoALv3NJVLhv9Uu74NfaoBzimHqvRWbVxek0qmont0Zx9+Jif4JLLK5rTrGcvg4zpm
	 Tant2dMVKKs5U4ARkdsgtwZQnlFY/b+bxKYqgz2eX6T7D8hi1y1RAA6xa4LXQjsbbsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557695;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JGna/U+3lUN2A873tE+UyJObLaKT7mtIxa9mi776ucs=;
	b=t7sewCxNaq6CsLQnZ3pWBIRvKY1IRbkt1KDIgSEdEFTvgmiSMynNuJTSFLyrMMjkspMV
	 ckX9PhLwSb0RJVR9hl1IApldm60wNnpr5068NKvOXzJ3OisGZbto4c5mZ5bGSRrGhOlHX
	 WFOp39wsoWbCckKOzu0UEvOyIrEG/opZhulHzweQVl9KIisF0+CMAHHTc0hjfush6KJEq
	 V7SP6RseAKyvOGn7EgrH/QK207VzIzajQZ6ieAf4CbP/QFqxwaCqNZP8HLDWlASO61WSs
	 yCHh0gs1EY0FXN57BrPug7g1KVqO2ZEhRQzYfQsQKoR/H3/HapMzZUfh//1S+hlcNFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CyCHbF+A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB2606A321
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CyCHbF+A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6319D1F000D1;
	Tue, 24 Nov 2026 22:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557695;
	bh=JGna/U+3lUN2A873tE+UyJObLaKT7mtIxa9mi776ucs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CyCHbF+ASGPQiqEJDC0hbCasv7bCkRV0xJnT52mQVYK+2oIxHxO9wlXVrUbd81wlD
	 n4DSGRHDuuERHT92v/gwAZepXEQfblEMVgNqks7STjM5Qc3OCeiYD06bD6Jd2fwA/w
	 XyLoXfKAZAmkxYr6dgTN6SxURxwdn0XsoP5qfko5F7g6obEs719+bDNhjNNHlfoDxu
	 4/nILyBF8CF3GrYyE+oIbRJXMofwmc/HjBplaQX/pUoR4n1UeU8IhgE3yV8CB1hQzZ
	 +VOPgidZ4Zi8OWqW6JPvRseMAA251Ogbqyz9SmQfWIipde7tVUdSjp4c1GmROXtTh8
	 ugEkaltxsfZkw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:47 +0100
Subject: [PATCH mptcp-net v3 30/50] mptcp: pm: kernel: don't count
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-30-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5aj4X1VngcnbQopcabjUhJtSELjGQkg8VtpA8/I8OX4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZODk1BV0jG7Vtluds2imXatdn5Poy79bSnk2zdliWG
 tZZdPN1lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATORzGcN/j6my759KS8X/XjLJ
 bvuEr6e63kmK2/71OdvVzK/H5DfhH8Mf3uIz2mx9M1ov3/Pds4K97uZrHuF/mXIn5s/gaupy2xX
 DCAA=
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

