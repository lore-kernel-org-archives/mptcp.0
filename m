Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599670;
	b=O6gL5kp+CdOWTsh9CXN0S8YVTT6+WNe6pXeq9Ae6qWWnG3ggpSKiumesGpur5tq7x1W3
	 zogWeVrv8S4gbKIXLOuo3O1JogoXe9z9pTFMbP0+gxqA3r69ZBrFeCLgLSUgFwvDj+b2p
	 Da9soE7rsW9tSSEPJDwo50QFYtrYpy88uFI4Yt1/LveDdX57CQi3zuFQ4RKLfWuc/J+Qg
	 Pw6a5UsdmuNANdRMXGmJ7I7hLhvD1VBrCtD3L8/++B09kKeCX8qrQfhEZTkM1OK8UaTGy
	 4Jqz2puu/aQZpJ5j3U9gpVgt8kTXErv9M3jxebth/0yZUBfU2OetfimtfltCGDDbNyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599670;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=FUvnrfoIrWP4sWFanNSiwxm5cYNY7XEqtjgBEaMWZs0=;
	b=Z3z2BWg8zWjOkbKJoFGmtABGCoMZtm1ZlR73qTwgFF7OZ7M5vdnrzFfhcfHzkv1z3G0l
	 XixgkbfV3PqrQkc34woA4iusw4QLmWa6Xr9uL+l8Y3wmzcry8JiwnX6uO7myjskTydYBR
	 3hmgEVSjdLCKw6ECObT1xT6UJNKBVUscYo47BHHFgXaru1emYpAdks9eQyLvRFuNFO1K1
	 5itb2s8cmh3EqAINvQGZ9zk01yjlOrdeWvypuNUf+U+7YcPpWJPm07BhcwGwQQ6/LdIFc
	 gVo7KgF/NmBErFfm15DIXP8DxwAbvD9cA5SUqaWOzcELb0TN3gdDxBLTdpsLhLsu0Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYnBfjmr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70B606F340
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYnBfjmr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4F61F000C4;
	Fri, 13 Nov 2026 19:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599669;
	bh=FUvnrfoIrWP4sWFanNSiwxm5cYNY7XEqtjgBEaMWZs0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iYnBfjmroCHaA+tSYKncqbP1peJ2C4R+mQ3v01rWQcVqbMFE/8H7PTW5JT39y0fwZ
	 82XwD6DtdPpB8/Zm8vMEecQhYulBCOmkkmvq+cFJqVgvrL5fwZu7dDh4t31ZaYOdW3
	 A6vWGdsiAP/7at0JHQJYuZAx6kZzh+wIDkmJdVVEtMv9dnVEPdAjLjyUxVjoRi6FZd
	 jk6jLzFzLBfZw9JpRMZXwf2rB+eocrDNViZc398m25kFi2BaTitX+nU4WzmTnSZEb6
	 UJihGsVz6BwANWiCtKyjaXyIxd8MiCufc5FPmZ1Ogs32wAGRSoDJzp2pOTsGWwqV99
	 sd1CKw1+Kc+YQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:44 +0100
Subject: [PATCH mptcp-net 06/34] mptcp: pm: don't drop an RM_ADDR because
 of an ADD_ADDR
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-6-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=do3Obgl9vpdsCRt/XgX/sgciaoCCsctSSJRHUxkkuHA=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGr3atWiQN4+wi3ktEgWa6EJqCiTXxvM90szw3kPiey0h+DNW
 oh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmr3atUACgkQfCLwwvNHCpeojwD+JDLi
 FkVtT+BKK7dBuo40kihyA78mlESztZ4MvMkxGvIBAMTt97mVTYSdB9hcPPfZcM5QC8hLtcoJToe
 LsPPyyoYL
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Josef Bacik <josef@toxicpanda.com>

mptcp_pm_remove_addr() gives up, and counts RmAddrTxDrop, if any bit of
pm.addr_signal is set. That dates from the time when the byte was
cleared as a whole after a signal had been sent. Since
commit 119c022096f5 ("mptcp: fix ADD_ADDR and RM_ADDR maybe flush
addr_signal each other") an ADD_ADDR, an echo and an RM_ADDR each clear
their own bit, and they have storage of their own: pm.local, pm.remote
and pm.rm_list_tx. mptcp_pm_announce_addr() looks at its own bit only.

The callers have updated their state by then and ignore the result: the
endpoint is gone, the announcement is forgotten, and the peer never
learns that the address is not valid any more.

When the bit of an echo is set at the arrival of the peer's ADD_ADDR,
it stays set until the PM worker has sent the ACK. An endpoint that is
removed in between loses its RM_ADDR.

Only a pending RM_ADDR stands in the way, as rm_list_tx would be
overwritten. The ACK that is sent at once carries the ADD_ADDR or the
echo then, and the RM_ADDR goes with the next packet, e.g. the ACK that
the PM worker sends for the pending echo.

This issue has been found with the help of an LLM. It has not been
reproduced: the endpoint has to be removed before the PM worker sends
the pending ADD_ADDR or echo, a window that a Packetdrill script cannot
target. This fix is based on code inspection only, which is acceptable
here: the issue is clear from the code, and the fix is a one-liner.

Fixes: 119c022096f5 ("mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ Use mptcp_pm_should_rm_signal() instead of a comment. Fixes tag:
  119c022096f5 instead of 42842a425ad6. Commit message: remove the
  number of attempts, say which packet carries the RM_ADDR then, and
  when the echo bit is set + how the issue was found, and why it is fine
  without a reproducer. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 32885e80486e..5f844b9a32d8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -529,7 +529,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 
 	pr_debug("msk=%p, rm_list_nr=%d\n", msk, rm_list->nr);
 
-	if (rm_addr) {
+	if (mptcp_pm_should_rm_signal(msk)) {
 		MPTCP_ADD_STATS(sock_net((struct sock *)msk),
 				MPTCP_MIB_RMADDRTXDROP, rm_list->nr);
 		return -EINVAL;

-- 
2.55.0

