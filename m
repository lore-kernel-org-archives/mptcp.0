Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C5B41324B;
	Fri,  8 May 2026 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262033; cv=none; b=BnDRLO6A4czDn7DaK46vqvOF+dyW0k0NhtF3JFuebLNhFO6e3yrFRIKMYi6aIxBMb+cODQ3hvfq/U8UxqBxRgVLfBEvpjdZgtIwDRUneB4svb7hri3tVoEnWxa2kgp9jXjFZ9nQB9Xs6tYL7xE+BW7rAyP7LmyzY9qqQiWbENlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262033; c=relaxed/simple;
	bh=TypKKwe40llOLQhS8qZvR7uyooyh9jj+EVlTImjcMfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDtcLdFiqeOjd5UVmS+waI14jCYk8tnt9gFcN6jPMIj5q19ADTd0xypxG6f/aljSoKuDYeNwFXJXRhEZ+xsw33W/dOW60wBhZBQG0eGZUjH4wfiVX2SH6dlr0RqN1mk+UPVtE4y20WcqEe0mX0F0bilLCnqvCpCIHYtMDkvD2Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxeyra2q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxeyra2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB03C2BCC7;
	Fri,  8 May 2026 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262031;
	bh=TypKKwe40llOLQhS8qZvR7uyooyh9jj+EVlTImjcMfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mxeyra2qDyv+fBJx9YAgTnq6n2YhJy87pUXNbYTqyO23ZxyL8CUkkzYozCVV+eYTv
	 zRIUxpEgxkOpSh4D3aG1Hj23nIew1gnsFIF3dIRAU0nUeMMUEDxUjk1iF01m9MVzL1
	 W2MND7IGgeT47Xb7gQQ2sf+VUhQSIP9qQ26b7BJwoq6Ceh5ki1FpUFRkLyzfZWM44g
	 WbUHFYV8zCWR7loLp2bO0cDVtfqvqYT1j2Qv9c9sM4pzDmWW3YHHro0aF6l/UrAjBJ
	 WxYTfkobeLCcqNw5PKqgMbAA/dazjn+oZJUMFzJQQY+1GLAy9CPGHSWR8vTogezT+4
	 IfmEmTPZK9Kwg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 May 2026 17:40:48 +0200
Subject: [PATCH net-next 3/8] mptcp: pm: kernel: allow flushing more than 8
 endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-net-next-mptcp-pm-inc-limits-v1-3-c84e3fdf9b6a@kernel.org>
References: <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
In-Reply-To: <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3253; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TypKKwe40llOLQhS8qZvR7uyooyh9jj+EVlTImjcMfA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL/KTBdebagRHzfWSO2d5Ov8q/uS5g/9ZyVN8OzQwx7/
 nY/enFQv6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAi+vIMf7gaC/9Kbvris2T+
 iaCLd06detf8qLZMLufy69KonI6Flz8x/LMLvR+71v/GUa1Wnzv+OvNWaj57c8c3eeKrfSfWxtx
 am8gNAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The mptcp_rm_list structure contains an array of IDs of 8 entries: to be
able to send a RM_ADDR with 8 IDs. This limitation was OK so far because
there could maximum 8 endpoints.

But this is going to change in the next commit. To cope with that, if
one of the arrays is full, the iteration stops, the lists are processed,
then the iteration continues where it previously stopped.

Note that if there are many endpoints to remove, and multiple RM_ADDR to
send, it might be more likely that some of these RM_ADDRs are dropped or
lost. This is a known limitation: RM_ADDR are not retransmitted in
MPTCPv1.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index aabd73d15c15..ea3a7ea82013 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1223,19 +1223,30 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 }
 
 static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
-					      struct list_head *rm_list)
+					      struct list_head *rm_list,
+					      struct mptcp_pm_addr_entry *entry)
 {
-	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
-	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_rm_list alist, slist;
+	bool more;
 
-	list_for_each_entry(entry, rm_list, list) {
-		if (slist.nr < MPTCP_RM_IDS_MAX &&
-		    mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+again:
+	alist.nr = 0;
+	slist.nr = 0;
+	more = false;
+
+	entry = list_prepare_entry(entry, rm_list, list);
+	list_for_each_entry_continue(entry, rm_list, list) {
+		if (mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
 			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
-		if (alist.nr < MPTCP_RM_IDS_MAX &&
-		    mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+		if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
 			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
+
+		if (slist.nr == MPTCP_RM_IDS_MAX ||
+		    alist.nr == MPTCP_RM_IDS_MAX) {
+			more = !list_is_last(&entry->list, rm_list);
+			break;
+		}
 	}
 
 	spin_lock_bh(&msk->pm.lock);
@@ -1246,9 +1257,14 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 	if (slist.nr)
 		mptcp_pm_rm_subflow(msk, &slist);
 	/* Reset counters: maybe some subflows have been removed before */
-	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-	msk->pm.local_addr_used = 0;
+	if (!more) {
+		bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+		msk->pm.local_addr_used = 0;
+	}
 	spin_unlock_bh(&msk->pm.lock);
+
+	if (more)
+		goto again;
 }
 
 static void mptcp_nl_flush_addrs_list(struct net *net,
@@ -1265,7 +1281,7 @@ static void mptcp_nl_flush_addrs_list(struct net *net,
 
 		if (!mptcp_pm_is_userspace(msk)) {
 			lock_sock(sk);
-			mptcp_pm_flush_addrs_and_subflows(msk, rm_list);
+			mptcp_pm_flush_addrs_and_subflows(msk, rm_list, NULL);
 			release_sock(sk);
 		}
 

-- 
2.53.0

