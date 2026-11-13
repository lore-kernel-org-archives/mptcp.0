Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599669;
	b=UK9JI7hIfpSWPZ3dsBfHsfujUTGuQRXPpRMabW+LTBXRiPOFLQ49SzymiWNezDJRh05U
	 8dBN1/gPvZm3FRyjAhUATgO1mVsFdlDlUtWE12MQc5JP5vWWFnOk38axg1fGLclGJqYZU
	 052kFJ9yxSAF0nbmEyF3jECYlhTD2k5OTBYB5RCwNYucy47nW251dUS8aCEV+HxyID3fK
	 b2Qqz16Nr3YBaiqyjBWztXy51WQkAjJZLk+NiXtaoIbMMczxabcHWNZOD7/8elPJcv/QQ
	 Bh9W0kLIwYZlr1ojLL+UCQ+h5y+7+hMT5lTFnupON3ZFYnZVt6RK4gkKuSlE2B4mEnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599669;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pIJMHnRdCwVKIYsgFZ5T+kBxkxkkR38tgRiZu8o6Opg=;
	b=35Wd5lo74P+AkEr60lr7jhJXGEcU8QnHeR6yK9+OM2nryZYmUXum/xPeZ8XGAWPfb5Fh
	 aUhsskbJQR0u2NYkZ+UUmnF2WRlZ7fu96gbd9uKyoNXvf69j0MuPv466TKwZUVVoEhkO7
	 pZJ5V0skBgDcXNBqKvl9hjSpGq3VJPPmymayWo5NWmZ2wOqTlpoToxWUJqRaqbDz2q0g6
	 9mI+sZPMZ0pKWKi7xaPSdLr2JzdVINDaPXIYfZLeiOgAdIiaNQDzWfblWo4QI3mCEYbY5
	 cIW5xnSDih4PcUJZ9YoLihTIps47uJZLHPQWkok6fzB8L9LuJV1/cxTPr6abpULhDCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENqb+V9G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6B060A6F7C
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENqb+V9G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB951F000C7;
	Fri, 13 Nov 2026 19:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599668;
	bh=pIJMHnRdCwVKIYsgFZ5T+kBxkxkkR38tgRiZu8o6Opg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ENqb+V9G2/lGhvHxdGZN3n7vnqfIS5HyE2+IloAeA/DHN77MCRhet4Q3788Gs8pxP
	 eZSE/9JSBZ+dDwlKry4/OyZl/rRIfyZoXXkm+2TlxUzeZRLECZQ8oEtPvoteIs/q2A
	 tWXVh+F/eyCQgxjzgxKapVTyquCj3T/cD9R/wVT9kjOZb/LqDMze9eL/y/k3kYkMMA
	 TLfWQWLxgrL91bUcDYg8k/vitc5tzo5n6h+rHr75GMX62nchiknh9L3WhYY/VHAFD/
	 cPcnJCmKfR43+EFZdsu975pjqPGKKuGSGhdaQeKSwJEdM/a43Vm9IYFasvUzKnjlft
	 fXwQ4QSwd08Ng==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:43 +0100
Subject: [PATCH mptcp-net 05/34] mptcp: pm: don't drop an RM_ADDR behind a
 pending one
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-5-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2440; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=C1VQzHk8uVoIp8Rzb5GCSvVci1o7UytyuySN6PWyaSU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z129WXHr2WTZz0dZ/gptqfbds/rAb4HZnLr8D5zun
 nn9XmxBRkcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEToQwMrzln+JpVn7mxX77
 td3GRnLTJDm2PLukumyj6mOJ4z9nf/7A8M8q+KGueebsDfz2SzL3Flic7nm9ZJfB5FaeQ5P9N79
 dMJMDAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Josef Bacik <josef@toxicpanda.com>

There is room for one received list of address ids.  An RM_ADDR that
arrives before the worker has taken the previous one is counted as
RmAddrDrop and forgotten, although the netlink events for its ids have
been sent already.  Two options follow each other at once if, for
instance, a path manager in user space removes two addresses of the
peer.  The subflows to the second address stay.

Add the new ids to the pending list.  Only the ids that do not fit in
the list of MPTCP_RM_IDS_MAX ids are dropped, and the RM_ADDR is then
counted as RmAddrDrop.

This issue has been found with the help of an LLM. It has not been
reproduced: the second RM_ADDR has to be processed before the PM worker
gets to the first one, a window that a Packetdrill script cannot
target. This fix is based on code inspection only, which is acceptable
here: the issue is clear from the code, and the fix is simple.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ Commit message: only the ids that do not fit are dropped + how the
  issue was found, and why it is fine without a reproducer. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index cdc8bab0eaf8..32885e80486e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -843,6 +843,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
+	bool drop = false;
 	u8 i;
 
 	pr_debug("msk=%p remote_ids_nr=%d\n", msk, rm_list->nr);
@@ -852,8 +853,20 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 	if (mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED))
-		pm->rm_list_rx = *rm_list;
-	else
+		pm->rm_list_rx.nr = 0;
+
+	/* the worker may not have got to the previous RM_ADDR yet */
+	for (i = 0; i < rm_list->nr; i++) {
+		if (memchr(pm->rm_list_rx.ids, rm_list->ids[i],
+			   pm->rm_list_rx.nr))
+			continue;
+		if (pm->rm_list_rx.nr == MPTCP_RM_IDS_MAX) {
+			drop = true;
+			break;
+		}
+		pm->rm_list_rx.ids[pm->rm_list_rx.nr++] = rm_list->ids[i];
+	}
+	if (drop)
 		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_RMADDRDROP);
 	spin_unlock_bh(&pm->lock);
 }

-- 
2.55.0

