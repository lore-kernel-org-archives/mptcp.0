Received: from mta0.migadu.com (out-7.mta0.migadu.com [91.218.175.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442F4A5C5C
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441305; cv=none; b=PhbL7IQD95Ju7iMv+iBf+lt06mVC29cdPymn3BLogw+1XmBEAkaj6nR5vqxYXdsJ7tInMX29ooIasJoqBs0GhJkxA9gcDPeQoRWwW8SJmTgsjA7Z658Ak+tMf1b51uyu/Z8JA/06EXC+upITEzIKeratK9ZQ+ajnp1Nx4EYIgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441305; c=relaxed/simple;
	bh=dQC+vnNQC+XmcfKQspZclbWnmxlFV57/2KbkmRdIpiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hz59O4/0ySLRBLzQ/6ecauPIaFFlE5kmEdDXeDgWDwK6F5wZMTY58pTrbKYt3bFiwb8EzJPLYqUWeWpxwnZkTqjHt4yKhTx9b4uMt5KPzlpBLVNTFTSeKk8mDJhyhZSsWv7kumcWMN2MvdEZIn2QIk15ut1I+x4c8vAJhRp8jEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X1qXMeXw; arc=none smtp.client-ip=91.218.175.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X1qXMeXw"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=dQC+vnNQC+XmcfKQspZclbWnmxlFV57/2KbkmRdIpiI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788441277; v=1; x=1789046077;
 b=X1qXMeXwwycQOMac/DCgojhGcId721bB+VuEwne47I6UpNPvTLE0X4XhhC6C0kXnVmsXkaan
 KK1h7J5bw/3j7CZnSdKJH5GYMT7j2SW+/tKQP+fkG+X4zgIf4/NeIHEELHGEmQevrYLqNbCNw/7
 knWHyd8a6l92DQjSzXH4YY0M=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 4766c63bffb36d6c;
	Thu, 03 Sep 2026 13:14:37 +0000
X-Mizu-Trace-ID: 4766c63bffb36d6c
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	quanyeyang@proton.me
Cc: geliang@kernel.org,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH mptcp-next v2 3/3] mptcp: pm: userspace: cap extra_subflows on Netlink subflow creation
Date: Thu,  3 Sep 2026 21:14:16 +0800
Message-ID: <20260903131416.1112393-4-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903131416.1112393-1-cui.tao@linux.dev>
References: <20260903131416.1112393-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quanye Yang <quanyeyang@proton.me>

mptcp_pm_nl_subflow_create_doit() also increments the u8 extra_subflows
counter without any limit: a client with CAP_NET_ADMIN can create more
than 255 extra subflows via Netlink and wrap the counter back to 0,
with the same effects as the MP_JOIN path now bounded separately:
the underflow guards warn on the next subflow close, and
mptcpi_subflows_total reported to userspace is corrupted.

Refuse the subflow creation with -ENOSPC once the counter has reached
U8_MAX, and clean up the local address entry in that case as well.

Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
Link: https://lore.kernel.org/all/20260902-mptcp-pm-extra-subflows-v1-1-68540a866e5a@proton.me/
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/629

Signed-off-by: Quanye Yang <quanyeyang@proton.me>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b94fbb483bf9..3371e17d01b9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -417,6 +417,12 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	local.ifindex = entry.ifindex;
 
 	spin_lock_bh(&msk->pm.lock);
+	if (msk->pm.extra_subflows == U8_MAX) {
+		spin_unlock_bh(&msk->pm.lock);
+		GENL_SET_ERR_MSG(info, "too many extra subflows");
+		err = -ENOSPC;
+		goto delete_addr;
+	}
 	msk->pm.extra_subflows++;
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -424,9 +430,11 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
-	if (err) {
+	if (err)
 		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
 
+delete_addr:
+	if (err) {
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_userspace_pm_delete_local_addr(msk, &entry);
 		spin_unlock_bh(&msk->pm.lock);
-- 
2.43.0

