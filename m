Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992A3290A5
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109171; cv=none; b=T3GHVM+KfkVHECjVj8j2GMtk9LZorpJdg1ucIk2jcBjHiblV7OWZc7C7ZFWIZWiEHakIOSyZCbpkYq3HXnpEBYqv9MdU9gTvx0pJdmQ+mlUwZ41SHPu1EMqsKKj4edqKy6X2Uun1DezBVn9gsh0qqpiAJIUCk26C5GGHCSPq5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109171; c=relaxed/simple;
	bh=LP1ojt6bJlTdj3otDpNxbzTstWJmo46VDAB1gqRsFTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5HB3Mgc4t2vHMhszZqLNRqAF/tE1wqJe/8DbMxWmnhDYNJOelbJ9SjA1734/Yh79JlXF0pNc7cdaE8sSzHGyFlVLRtfjvZ2J+b4Lrp1L9fKjWev00QLZhS+hBaI7eezT84h3+PaVmWkvlg/FcMG2TN4bL+YuB1ykt3LXuymXNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIkvkDVb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIkvkDVb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA88C2BCB8;
	Mon, 18 May 2026 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109170;
	bh=LP1ojt6bJlTdj3otDpNxbzTstWJmo46VDAB1gqRsFTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XIkvkDVb8yTyag2AUhgoYYr9iRwoPx/86WAwXWi2zIIK7JEvwFH2O1QzQThB6KAS5
	 MQTpK184JD4uXoVNdEjF615W2e6t1HDMqEGJ/PwFfnkgkbsZFSgATSM0xKVpUdg2/5
	 wNNj8nTMJk5XHhxPQ6isMn2FZp0LxZprthl2hTF1LEWhGGM4580jI/IRohaL5Vm64h
	 /ZHz4ak0S3SqeXpjMvEPlvqniF/CoJKJd9T7FQBm9l46au/4HS9NrPJ1F80qeqkN8f
	 eY+SoAMp819yfwHTIu/z7yZG5j5956FyrNqgN28iQmSzA2rvJUX6B8PM9fuQNi25NM
	 Vshcxjs9orh5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 May 2026 22:59:15 +1000
Subject: [PATCH mptcp-next 11/12] mptcp: pm: avoid using del_timer directly
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mptcp-add-addr6-port-ts-v1-11-f1ca26977fcd@kernel.org>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
In-Reply-To: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5286; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LP1ojt6bJlTdj3otDpNxbzTstWJmo46VDAB1gqRsFTo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqCw0hXTAcW6pKODExQ2nflNxmqVgGWEShFZ0c+
 FZ/DE/FWDaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagsNIQAKCRD2t4JPQmmg
 cwJ9EADUCvaTBe8FbARUXms/TQlYORgG7vVLIyk0ZirHtQEq5CjQLBQ48lGS5cAH+ofvHbxx4xT
 iqZaE4W/sdpTx/Hmw0GPOUjNY6BRmfDUdRiG8ttGE9Bk359Mktpj03W86dHIEu3MEgF7L0C10Oz
 nLPFECEwXElupcpV2tVz6sRyctanA4mA/pEpXqzE9DpuZ8lG4VrVBETx3tmp9WKAqDCQyD7m9XP
 vpZyKBnXpis8vpkwFNP7Xd5wkJJL3Ud5UCqIwnR5IWrsPsIts/NADGFRbBGYo2HEqK1ptoeifkN
 u9grfOaCZTK5LjaatdFQfAsNhj1EBCvQuyw7/Hm5mzx4t+fHyNvtxWPAR83J501EpC5krzCj4M7
 4GNGhlPvnNcnc/jn7IN1/SlojN0c6wfTyOAtT2wdsv6oLT26TqquyHwLFTAa6EDvMpa3wzPUHI2
 p8C6HE7nfj4bub87OKsPBVLHmmfF8QsEeQ3CJLWtMTPiOXo+YJQD39QdCfGmS5tptaBbqwfqNpK
 elyDIRMJlVdc/R8/67jn7hDhlzOEdJiEK9gRDMv8K9OrDavX6s4LtaEm2GgLuba+qi7bZ4wT9Gw
 7fvP5nMvcwSwJQSlQdcsWklcZABvesE9YuKiS6KI1bwhwlSbVl96pBxQW39k7hjQasqohNoUaoZ
 ZSWVRzUVv3zhx7A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_pm_announced_del_timer() removes the matched ADD_ADDR entry (if
found) from the ADD_ADDR list only if check_id is true. That's
dangerous, and not clear, because it means the caller should be free the
entry only in some cases, and it easy to miss that.

Instead, make it static, and call it from mptcp_pm_add_addr_echoed,
which is the only case where mptcp_pm_add_addr_del_timer should be
called with check_id set to true. Bonus with that: a second call to
mptcp_pm_add_addr_lookup_by_addr() can be avoided.

Note that instead of adding the signature above to avoid a compilation
issue because this helper is called before the definition of the
function, the whole helper is moved above where it is first called. Its
content is untouched, except the addition of the 'static' keyboard.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  |  1 -
 net/mptcp/pm.c       | 75 +++++++++++++++++++++++++++-------------------------
 net/mptcp/protocol.h |  3 ---
 3 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6514776e9ce4..70ddde327511 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1201,7 +1201,6 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-				mptcp_pm_announced_del_timer(msk, &mp_opt.addr, true);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 			}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ac9342f6e7b4..cf0a7b44e3ed 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -149,6 +149,40 @@ mptcp_pm_announced_lookup(const struct mptcp_sock *msk,
 	return NULL;
 }
 
+static struct mptcp_pm_add_addr *
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id)
+{
+	struct mptcp_pm_add_addr *entry;
+	struct sock *sk = (struct sock *)msk;
+	bool stop_timer = false;
+
+	rcu_read_lock();
+
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_pm_announced_lookup(msk, addr);
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
+		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		stop_timer = true;
+	}
+	if (!check_id && entry)
+		list_del(&entry->list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	/* Note: entry might have been removed by another thread.
+	 * We hold rcu_read_lock() to ensure it is not freed under us.
+	 */
+	if (stop_timer) {
+		if (check_id)
+			sk_stop_timer(sk, &entry->timer);
+		else
+			sk_stop_timer_sync(sk, &entry->timer);
+	}
+
+	rcu_read_unlock();
+	return entry;
+}
+
 bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
 			       const struct mptcp_addr_info *addr)
 {
@@ -398,40 +432,6 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 	sock_put(sk);
 }
 
-struct mptcp_pm_add_addr *
-mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
-			     const struct mptcp_addr_info *addr, bool check_id)
-{
-	struct mptcp_pm_add_addr *entry;
-	struct sock *sk = (struct sock *)msk;
-	bool stop_timer = false;
-
-	rcu_read_lock();
-
-	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_pm_announced_lookup(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id)) {
-		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		stop_timer = true;
-	}
-	if (!check_id && entry)
-		list_del(&entry->list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	/* Note: entry might have been removed by another thread.
-	 * We hold rcu_read_lock() to ensure it is not freed under us.
-	 */
-	if (stop_timer) {
-		if (check_id)
-			sk_stop_timer(sk, &entry->timer);
-		else
-			sk_stop_timer_sync(sk, &entry->timer);
-	}
-
-	rcu_read_unlock();
-	return entry;
-}
-
 bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
@@ -730,15 +730,18 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
+	struct mptcp_pm_add_addr *entry;
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	entry = mptcp_pm_announced_del_timer(msk, addr, true);
+
+	if (!entry || !READ_ONCE(pm->work_pending))
 		return;
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_pm_announced_lookup(msk, addr) && READ_ONCE(pm->work_pending))
+	if (READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 448ba565611a..004f8b9c8fdd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1134,9 +1134,6 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			      u8 bkup);
 bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-struct mptcp_pm_add_addr *
-mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
-			     const struct mptcp_addr_info *addr, bool check_id);
 bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
 			       const struct mptcp_addr_info *addr);
 bool mptcp_pm_announced_has_ssk(struct mptcp_sock *msk, const struct sock *ssk);

-- 
2.53.0

