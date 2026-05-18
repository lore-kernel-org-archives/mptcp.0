Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECA446AF3F
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109168; cv=none; b=E5nnzRfaI6D5s7rlwWIfMw+zcrkczmGSsFANro2zuET1S7Su7X53qrmZeUaEhd4ZpjOJa6Ess8OloU4SznBYSUfxVOtruxQ7Zm5OjjvbuYKQQysxOgYIfdLLHXwU1gEzwhs91mnDLWbCujf1ITfLRXp9ze+udNpJlf2FN/P+DEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109168; c=relaxed/simple;
	bh=4YXgrpJlYIcCyQsljFW37dRbOVK8UkcsPHnGFTZcjv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n+9HOtPVIz2oK4a5YvppW2Rlnc+K2WXs1yD1Xqa3PP4JAvvpXFaPcyg81nIgljz8OUY9GT2YzoynKFeSnEGgxMy7god+4OhUTQGiQhcwp8hWjelLSrdxQaAZWHF8HM19yGehnwd/STrUGdBZ4fZSW4XrqXCJU2HZvO62Rrw7tEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmVSEiEH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmVSEiEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D37DC2BCB7;
	Mon, 18 May 2026 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109168;
	bh=4YXgrpJlYIcCyQsljFW37dRbOVK8UkcsPHnGFTZcjv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XmVSEiEHLQFrM8XyxsSlUt9Iv0bJyVw8s8G3KRsIKwiQnOYWBZmhKGA2DuAIQ3SRl
	 VIM77ATUr8h/K3XH1qoLxcdC9A67V6T6njHKFq76wsoOE7WMgWfneA4z3OpFPPUEZd
	 nmacTHvUVDhOmwVCWQxOnxzrlE8Jer63YTDcvwqfAqovgzqsVpm63DV6MPR5UDCKag
	 IpXPPZoH5tNsu7ZrfWPQp37KZEMklnET5Dxun4cV6xALFmQ+A8EUleBB6Kkv63F9JO
	 qWZiwnKxpi9Ks+Dtdp6VPL2q9EJfr1Ac0jwI/MKexYJwSptVYBwJ7G22XVer5W/nFH
	 3LzeO0X3y3KFQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 May 2026 22:59:13 +1000
Subject: [PATCH mptcp-next 09/12] mptcp: pm: remove add_ prefix from timer
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mptcp-add-addr6-port-ts-v1-9-f1ca26977fcd@kernel.org>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
In-Reply-To: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2702; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4YXgrpJlYIcCyQsljFW37dRbOVK8UkcsPHnGFTZcjv0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqCw0hE95qsNyViHhzY7z9fG7vicPeaAb1KDb4w
 t69N/plcLCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagsNIQAKCRD2t4JPQmmg
 c2hkD/9ZAHU2gq4oTHksPiMP/XWtnJxJcjj+Gkol12M8Mne3LUWJPQklOoXo8TcjspKSbLQrZ6d
 Ois94L2jcZ+PGIxN/Zzk0e1lc02zzUTXYrmUTKf6+dYwzBgZe9s90CVZQOOai+X/nX9XKbnQrKv
 DTW8xegohUhQb79p8s41CO/GBas1xfX4OSl7McUgcJtA9nqvBM2ddOQ5aUQgXu2CqjVZfLfa33+
 td2gLHAz25rsnTUivDXr8wv9YrPeKO0Cz5Q9gdJ51GZxgU55pL759HDj28by2ESNIlG0Zo1xZgW
 JSFSbaMCNKMMqzZyXEpQ3Zsxfzv6QbIKZWGqJLkZc1s+bE+64GbwXD1KJped1riFDtu+FfLMfct
 Am7Yg8hy9kmR3035/twBQWs1Z97Sg+5NuAsLkj3smuy7lAD9NBP/yGfq1K8qXr0Q55d4G7JAAyB
 ydaRdphL6zCPiHjnTgvTxZ3uL9S0Sv2ltAFioWmNxcK26SqAacTTxj4cqKcoqs2NAmaySQxqr+D
 gY2e4XGeoVSpaw5nA+ScT+hFufLAfR63kFzvuWR4GQmsWY7gFAymmfPwupvdHkQG5BA1se7OOCl
 3z8j+QZdYgp28cezEycptExUYHQEgeAhA12njY5f6qJNguE7bpsTWLdj4z+oZ88ipjhCarhfsf1
 vY/NLOj0Nt8diyg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to the two previous commits, using the 'add' prefix is
confusing, also confirmed by [1].

Now that the structure has been renamed to include 'add_addr' in its
name, easier to know the timer is linked to the ADD_ADDR, no need to
add the confusing prefix, or an unneeded longer one.

While at it, also update the ADD_ADDR timer helper to clearly specify it
is linked to ADD_ADDR, and it is not there to add a new timer.

Link: https://lore.kernel.org/20251117100745.1913963-1-edumazet@google.com [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f36f63f8bc7f..bbf89074a31d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -17,7 +17,7 @@ struct mptcp_pm_add_addr {
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
 	bool			timer_done;
-	struct timer_list	add_timer;
+	struct timer_list	timer;
 	struct mptcp_sock	*sock;
 	struct rcu_head		rcu;
 };
@@ -338,10 +338,10 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	return rto;
 }
 
-static void mptcp_pm_add_timer(struct timer_list *timer)
+static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 {
 	struct mptcp_pm_add_addr *entry = timer_container_of(entry, timer,
-							     add_timer);
+							     timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
@@ -422,9 +422,9 @@ mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
 	 */
 	if (stop_timer) {
 		if (check_id)
-			sk_stop_timer(sk, &entry->add_timer);
+			sk_stop_timer(sk, &entry->timer);
 		else
-			sk_stop_timer_sync(sk, &entry->add_timer);
+			sk_stop_timer_sync(sk, &entry->timer);
 	}
 
 	rcu_read_unlock();
@@ -458,12 +458,12 @@ bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
-	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+	timer_setup(&add_entry->timer, mptcp_pm_add_addr_timer, 0);
 reset_timer:
 	add_entry->timer_done = false;
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)
-		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
+		sk_reset_timer(sk, &add_entry->timer, jiffies + timeout);
 
 	return true;
 }
@@ -482,7 +482,7 @@ static void mptcp_pm_free_announced_list(struct mptcp_sock *msk)
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		if (!entry->timer_done)
-			sk_stop_timer_sync(sk, &entry->add_timer);
+			sk_stop_timer_sync(sk, &entry->timer);
 		kfree_rcu(entry, rcu);
 	}
 }

-- 
2.53.0

