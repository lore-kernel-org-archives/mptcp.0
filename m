Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15034D90BD;
	Fri,  5 Jun 2026 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651363; cv=none; b=jvwujPgP0rwIcpKqRYAFZfgOuZQzEjhq9lPbJBXILL9nDNv9myk5hLwnPLhpXHlgeDWbKNM7Y5X41wXM/otw2r6QbTM1PYG7W+HLSv8r/pmwrNQFJYSp28D3tp2O8yynaHFf+SoCLxsJj9LcNW0cW+x2vvKxMsVL2mKPM/hIBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651363; c=relaxed/simple;
	bh=kx3wUfZ1EVlw2HMCMBGuzHZU7pdK3GTyZy2MTBgYjdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mDKtFwZsB87iO7nAzHyfWPFlnd5sYyHqaj82WFrF2McZMcEng4yAiD/MKLXf9ll8sVsroOmHCIYBwTEBl9pX3z962DXiUW+rSY5cVZ7QhKpYQsm6oZ71ARmevWH7rQ6N/4asyJx5+P8uZ42vv6PbPp/+/DEFG+gRf21Ip+wQh/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaAf7UnQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaAf7UnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7266B1F00898;
	Fri,  5 Jun 2026 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651362;
	bh=ZkavaiGTbAkAorfMrFmYUuRfa+RbAT4lLyumGqeRxSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PaAf7UnQPYiGezcBfFZ2s8cD2eHlXAvRwswEmoPwei/E77uWV3yjX2+ppl2PMF9qW
	 iZpxmpUuy7s262XbE6tE6AG3B9PHOTfLZt873x34OsRLvgBdgoOFP0f6VrHjNARuUG
	 dP31mS1A782QN167tB7u2z6/9p1o+c24716TW4YO5REnATnmvmB4eYLnaRhqVf4Y0l
	 eGpn4iBWl9fldL0YhnW2WpLSuaFGVDacWiVd9c10nPyL5yS6yIyYVDbIa+4rO4NuhY
	 Exk19zmQYqgIhKlLXbBx2lMagShf7JoN/x7cI6aWVTpZFXpu0Zbgw9tClB+9qPanSp
	 r4hPR5iXhMhnw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Jun 2026 19:21:56 +1000
Subject: [PATCH net-next v2 12/15] mptcp: pm: remove add_ prefix from timer
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-12-758e7ca73f4d@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2753; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kx3wUfZ1EVlw2HMCMBGuzHZU7pdK3GTyZy2MTBgYjdY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUx4W5YN9IxM+xvEs2JJrmBCmAbttGmGlu7E
 opQ5zTKCA2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMQAKCRD2t4JPQmmg
 c4KJD/0eqFvSAGjYMjxXWb0Sm1uYSn+sX1KcyfDCkVpVssJDsk4hNzfP3U5oTbGzWw1nlYUwXLi
 XOSK5E/wBNUKskflyk9EhSWxqxuhfbEi0sfloi0Bn1NPpv14XgsExkQmNXQPTUlmdTsZBrFhSMp
 ICsQGMhgfsvUqq4g3crN+2ZdS2g9qC2ygGPH/ot1PsSm+oFsP4ZYOLSi5I7deENZo7HSrVQk3ix
 0eUKlQVf9bUA4upGOZM9UbFR1J01nKrsHJt6i7sNwbKVJbI9+qKF75KTd0niP/olMvDgTIugQoW
 pXArbnnESnLmR+rgCPVin6hbWER2+9sfs9vYw/kLEAZxbVfB8xc3guw2S031pyBEuxvCD+Vfd4p
 PVoY6u8fU6spzErHDfNkDMcFlaPxhJO8ykF8dr83E9uXfugbnA73vw8id5d0zYVoMkJn1g+dlG6
 1YzgShqCEHZLn+fa516caukjPJcdOdKBqDj9Cmotjd/S2OuC779JZj4pVJMo0TdbmPpJWWWksmO
 bZqj/XXFqLE2HLkCFwMPdl8RezGc5H50YSyZFG5iRLCPGZ5KQgX8QUgzOHN7QMOqLfLJ0sPXwPs
 MIfXrfUK++gKv7tOXdynqsBksqg0U348kTgaUWsjh11n3UDttTZgEFeOzeTgN+k7w/RmhtD24d+
 PfcQaN/wKXre6Tg==
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
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 197eaef62015..684ae8650c19 100644
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

