Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599687;
	b=IBCmtJlLSEetIYYtmmLkrcMSKkfTCDgGxbC9H9up/Ovp2oOY83EcxjkgZuP31N2bncpc
	 jDv2KmVUmISXCclXr9cO+Bp+2mCKPHsXAhUGQvMsYXWYSM33nhWbn4jJ9xWmm4b8QyDdP
	 S83WqI1C8kwRYaFMqo3CXWc8kjR5r4thgJXs/CgBh0lFFfewxS56HZnPUIrrFuwxUa9bq
	 ch3XFt9wk5x9Y9MvA+syRa9VYXvp5MG1FtLumVTt0GsGqjwp7wUtAkQ9zVQpd78j6QjmK
	 bAaXAJVnjs0m4THAf1ND8O/4gzse2TJC7Etvda5b00j3wo1dyHx5H5Ppdm+Bf+OIU1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599687;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LtykvKAuB/k2zHXEydM4TKa/vTDWgr+HDiamPibVH1Y=;
	b=cUV01gWdOmfTdpiUk49p0vU0V16ytj53IXz/E2iaRJKjw0vfLqF6+tCTc4/J0rojVBaL
	 t5vaSRAcCT7WpokLhMbGyqDi79s4M6iiX3YyE/7h4t35U73hm1CDqocINep/7ipvqsPAM
	 K5egvfr5V3Rs/EqpGq77gE/p/CjPBilbRGWJbdFvYTb8V/Eu6msTkgSvKPmrgyVmZ11N8
	 xZsT/oNBVSIgXbBH6r6JNAjm9h4QDwuvcKgNzwKXerOFYzlEKFHKHQmTVKLC0fUhKg3gG
	 De7MrbOTwdh9cYlTzH9iuosWf6i3iXEkEaEx46ILwB+eVLew1EqPARgkVmhwLSMVRxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJaQlfmt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE7606D0C2
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJaQlfmt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB501F000C8;
	Fri, 13 Nov 2026 19:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599687;
	bh=LtykvKAuB/k2zHXEydM4TKa/vTDWgr+HDiamPibVH1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YJaQlfmtm7SVVmD7knMrnw44vvyJT8o57wATdanHV2cfzufy4XZBf/2UIWgao86rr
	 laqF7lCHyz5k6YL/+HJZle9lvozYKVKI/mGoPm24ZBpQAbLqwE29VVpUP3/A0cKQt3
	 l59Km3F1FrLu+6Lvh2gXrprYGtNdlhELqYk5bYEnyH1m6HoKxsNNmn/W5MsvekMaCt
	 7eh5zWkZJ6iTl0qbL7Ojpy/FQmh9dSlGwlJJCDXxVBjo2xcaaOakIxWsgYmxsXZorz
	 1h+VuuTBfRqUQsMdlNVXjj0zmyg9xj4UbtkUS08218c0u8ggdjNG51Dj7/fAn72RKO
	 sPnUiwba0s4Ng==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:59 +0100
Subject: [PATCH mptcp-net 21/34] mptcp: pm: kernel: don't count
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-21-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2991; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8X/pgFm5oMi6uqXYBW1J615qsTAMQvVMjuctgZ1KHek=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Zz3YYLStq9JK9XbQ43mWR07dWXB326fJBtcfzlrF1
 LpIb1PAm45SFgYxLgZZMUUW6bbI/JnPq3hLvPwsYOawMoEMYeDiFICJWG1l+J/xa/u9Ium9iqla
 qW+2bD23JP7uqaRZndy985ynpRkEB61nZOh45Py9eqauyp737nFvhOoVV29qvT837/7ylleau1W
 kGlkB
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

Fixes: 9366922adc6a ("mptcp: pm: fix ID 0 endp usage after multiple re-creations")
Fixes: 579a752464a6 ("mptcp: pm: in-kernel: always mark signal+subflow endp as used")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ Keep the original one-line comment. Commit message: 'behind it' ->
  'after it' + how the issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 4955c928ea32..976d72565bda 100644
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

