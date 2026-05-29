Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A236CE10
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024941; cv=none; b=G68rKxEOQnqUmE3ReE+AHCHKJPXR9miUP1/en52lw6T6GJBE/S7BrJFmw1jfaq8rvx8adbrv6DgeEVVxeeBdZw9JwenOpgdQNq3jWDojIntbegRmsOLg0n1cKgvFGnnTh2EVhr3nS3J0ERej3m7nPttNfY13GPtieP8l7tU0mmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024941; c=relaxed/simple;
	bh=QtvvOy39OgkjhOQ05E7sEUnlKwGOqcasSvumz6pK310=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2mOc1Jyk2CBTAha+6Vq0nO9Qper94SxU3TLA7fALYmku+un8KYfu8Gyh6SNq+OfwqmNiRHyBnULEzIHvV5N/LeslvYXfN02LCNaM2mfKoczWol+WH878Ai7D6dL6feP28xBzAm0oHWS5eWUAb+44nWxvDjdc/ay+1/ejlmgm2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipUqeeB9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipUqeeB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA571F000E9;
	Fri, 29 May 2026 03:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024940;
	bh=RIc4jdhURr53WQpzyLkumdAK//seYnVg7PqG2n83M7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ipUqeeB9cQNXvPqdGkyqD12nR9jyk6WjHAIfGCwUWKI1RIEGMZNIP4OHVuL+0wcn+
	 OXtOmBH/Y8MkVDe7ATRkOyPL7Cprvyjk3whckr6nSjo5RqafhpH/P7sQcs51vesGXC
	 H0AB5SiVNh8tPwbnCpc6hNibDrv3LBAZ5iuF/wYEDfFgKkUbSuJiEL55siIa5+Chlh
	 tyMYKMlxDN8coepF5GuehMDLR5DMYELOYZ0AC0NYScFPSr6FcCH0Hq+0bYBFB4iCGO
	 U8xiCcBiN51AC9QHn+mWff60J9TbKjikbMhNlV5Hz3mTZn9ORJvZf88NsFwX4cqoYc
	 FpKI+JFH1gqYg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:53 +1000
Subject: [PATCH mptcp-next v4 15/15] mptcp: pm: avoid using del_timer
 directly
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-15-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5293; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QtvvOy39OgkjhOQ05E7sEUnlKwGOqcasSvumz6pK310=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZXDXrpZI/Q3NMvLUPGUMuc97e+7YfQsAvIu
 BAbn+RCRuqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVwAKCRD2t4JPQmmg
 czmdD/95Q5XhKTezoesugSqSl5OLkESaJGcr+x1WuHBaBwbHLcTobm2L7x8GdpYTMqHr4M9H3tL
 2aKxicFhKLLQQQ9Sw2RPqSzhRVUm0pWFqcoR2l5kTNLUOa7yz2wyJ/dgZ80mtgw/xQXP2VnM+WE
 y76yUkziXpKGpBZZU+Wn6I0a+5UNNej1y9llbgzm8JxW7X3Ll0kIwQu8UJlqFi+tB+fK9wmj2rp
 gwECCbmzbspInJ9FaoKVZWPMcHSyyYNr8tZ6jwtb3DGuDxIWaFQk8oTcChrajPgvqamxuAapWg9
 ylZ7P5s/aSYJb5I05bMO6exn0XItif0ZMSbrePRmqW5PYj2ha3Br4JMT1NskanNccbg0CN5r1d2
 iDSwEkysLiUbluLyZ63mDYH8rsFpqS52kQYGwcp1t2c5nJZk49ftD7t0f8XVcnTAu0wUgXdgE7j
 LzPf6hzp7LH7Ynmuy4tEp2igjSVpCYIIyrRDDEKPf7d8D78DfqNfJHpRyejURs3l6DndYv71v+g
 jeGoesUtgyQC61Tka3qf16uI7mKLz+Pc1kEJai9TLz1dsmr87FSgI0r5caK4hHgW6cRt9El4lga
 X2HB5m1Tdyq12Jy5GhLLHWJTr4GblYQB4cbJtTra+v65pdc1vywTx5/LyzoUh6jl7CEeWsZkCiw
 C2wvPlH1UimKO2Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_pm_announced_del_timer() removes the matched ADD_ADDR entry (if
found) from the ADD_ADDR list only if check_id is false. That's
dangerous, and not clear, because it means the caller should be free the
entry only in some cases, and it easy to miss that.

Instead, make it static, and call it from mptcp_pm_add_addr_echoed,
which is the only other case where mptcp_pm_add_addr_del_timer should be
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
index 5d9bfd559310..b8ef59632638 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1218,7 +1218,6 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-				mptcp_pm_announced_del_timer(msk, &mp_opt.addr, true);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 			}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a781e21d74f3..452b17b9330c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -149,6 +149,40 @@ mptcp_pm_announced_lookup(const struct mptcp_sock *msk,
 	return NULL;
 }
 
+static struct mptcp_pm_add_addr *
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_add_addr *entry;
+	struct timer_list *timer = NULL;
+
+	rcu_read_lock();
+
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_pm_announced_lookup(msk, addr);
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
+		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		timer = &entry->timer;
+	}
+	if (!check_id && entry)
+		list_del(&entry->list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	/* Note: entry might have been removed by another thread.
+	 * We hold rcu_read_lock() to ensure it is not freed under us.
+	 */
+	if (timer && check_id)
+		sk_stop_timer(sk, timer);
+
+	rcu_read_unlock();
+
+	if (timer && !check_id)
+		sk_stop_timer_sync(sk, timer);
+
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
-	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_add_addr *entry;
-	struct timer_list *timer = NULL;
-
-	rcu_read_lock();
-
-	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_pm_announced_lookup(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id)) {
-		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		timer = &entry->timer;
-	}
-	if (!check_id && entry)
-		list_del(&entry->list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	/* Note: entry might have been removed by another thread.
-	 * We hold rcu_read_lock() to ensure it is not freed under us.
-	 */
-	if (timer && check_id)
-		sk_stop_timer(sk, timer);
-
-	rcu_read_unlock();
-
-	if (timer && !check_id)
-		sk_stop_timer_sync(sk, timer);
-
-	return entry;
-}
-
 bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
@@ -731,15 +731,18 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
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
index 71bb522483ef..b63571400c6a 100644
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

