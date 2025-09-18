Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2C26E6F4
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217371; cv=none; b=hAbGv4Hhtk5QLIUKnNiB+BFF2k376oh9dWjXBdr1vn7bk/vLigWeGQLCoQVaFiQBNsCmeAUp/NXh81W26WXFXCmIOO+tZHT6ER6CuS9j1sNdv3/LVSrcvEXzWhTzLopopTJS6lgg3vHBtSxogFEfz/jvz3SjiuY5JdmE+YYWOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217371; c=relaxed/simple;
	bh=uNDnyYt+fKdOhHhST42KX8J1tSFV4irpTlJRLdgXVl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ip0TcgAfOd0vZtm63zlczZvBiliujXN8jlrAdVMNwEpE4Gpmkjhd/ioFm4v2W93XPCm6SxXg+p8ApC/mlyh+XjDpEwy6Q2RxG2JOZoCx1rZUdMBC/+fKR8tTxhCPHaWzKJtFrw4SQr/hR9nU7ov4WthVYQGrhfZEj+NcI6+7qF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWBSJ6gX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWBSJ6gX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19243C4CEE7;
	Thu, 18 Sep 2025 17:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758217371;
	bh=uNDnyYt+fKdOhHhST42KX8J1tSFV4irpTlJRLdgXVl0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gWBSJ6gXpUxN32TW0Jj7FVO1u+oggSN8R4tt7T6dXaCozVp23xhub+VqWF/JvSSZu
	 y6qJaalyt+v1XVx7uVsWZb0frzXWD8AoiatymEmw8jWdKDU+De89eAyd0QmxLhth4Y
	 3OMaQIAXyhTRcYKM6yEoBaDkMH41a2ksajwDk0r8+S9HIf/t08VZvBJVezFWQfcHdt
	 tQ+Zdh0Q7MIA1Pnujfv8ZPyPCVG52+jAE/QYR9J+3AGX+0JxRpUZFQZIv8adjkgNY7
	 0yjOzHPb0C2OYpsS5H55SO4Qnrq0IusEllO7kLKENa1x5fNcEXAEzbGnsTAidtEgaF
	 Rk7R9KaYWm0YQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Sep 2025 19:42:26 +0200
Subject: [PATCH mptcp-next 10/10] mptcp: pm: in-kernel: rename 'addrs' to
 'endpoints'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-pm-kern-endp-add_addr-v1-10-e12e58770a11@kernel.org>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
In-Reply-To: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2454; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uNDnyYt+fKdOhHhST42KX8J1tSFV4irpTlJRLdgXVl0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuEwsdPOewNqk9bcuOT+rQLVwx+vNwY0HH4b41r7rO
 s7Ht7u5o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJyGxj+O7u39i5g5Fk298HS
 ctlFcvOiYx66zZ05vfT3keZXJaKX7Rn+x4pceeg+UbJ8l/3s8l2CB5ozg5eEHzJ8UCe98e/ns5v
 iOQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few variables linked to the in-kernel Path-Manager are confusing, and
it would help current and future developers, to clarify them.

One of them is 'addrs', which in fact represents the number of declared
endpoints, and not only the 'signal' endpoints.

No functional changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index eee931f1466afc166ad34658e8071e9b30cf9906..1f214e4c7078ad7518b2a501efa86633ad9e96ba 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -18,7 +18,7 @@ struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
 	struct list_head	endp_list;
-	unsigned int		addrs;
+	unsigned int		endpoints;
 	unsigned int		stale_loss_cnt;
 	unsigned int		endp_signal_max;
 	unsigned int		endp_subflow_max;
@@ -620,7 +620,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	 */
 	if (pernet->next_id == MPTCP_PM_MAX_ADDR_ID)
 		pernet->next_id = 1;
-	if (pernet->addrs >= MPTCP_PM_ADDR_MAX) {
+	if (pernet->endpoints >= MPTCP_PM_ADDR_MAX) {
 		ret = -ERANGE;
 		goto out;
 	}
@@ -659,7 +659,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 				goto out;
 			}
 
-			pernet->addrs--;
+			pernet->endpoints--;
 			entry->addr.id = cur->addr.id;
 			list_del_rcu(&cur->list);
 			del_entry = cur;
@@ -694,7 +694,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		WRITE_ONCE(pernet->endp_subflow_max, addr_max + 1);
 	}
 
-	pernet->addrs++;
+	pernet->endpoints++;
 	if (!entry->addr.port)
 		list_add_tail_rcu(&entry->list, &pernet->endp_list);
 	else
@@ -1094,7 +1094,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		WRITE_ONCE(pernet->endp_subflow_max, addr_max - 1);
 	}
 
-	pernet->addrs--;
+	pernet->endpoints--;
 	list_del_rcu(&entry->list);
 	__clear_bit(entry->addr.id, pernet->id_bitmap);
 	spin_unlock_bh(&pernet->lock);
@@ -1175,7 +1175,7 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 {
 	WRITE_ONCE(pernet->endp_signal_max, 0);
 	WRITE_ONCE(pernet->endp_subflow_max, 0);
-	pernet->addrs = 0;
+	pernet->endpoints = 0;
 }
 
 int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)

-- 
2.51.0

