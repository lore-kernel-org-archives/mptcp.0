Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F21624CF
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423673; cv=none; b=sPkYfWnqOIb6tHZw0FxI+dBM9HTcts9VzXgBfbGMzgS7aoQJ8sOvEiO0cbgLqrYtESuIorqcGCLY4Zl9WXDD8x4ewT0h8pbC1Zn3HK3jwiA+46XrvlBKmaJPoWeAjnvRyJh+N30TZAFKnRzAmMCI/OU6L8AqWdgX/ezBd/9rtbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423673; c=relaxed/simple;
	bh=+KHlFdGlck6VeTz7Thh8FGnSmQig/RMPwQ7Sp1+3H+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i8LSVaO/dWwnIhpcHL1t3emDxtzINKR3AjjlWNEpEi1iuCK4WZ0seOpafiDpnd1zZMRmrhZ/VmZTS4y+9aw4Dp7ogkNIqrVECjNUFcnKNEsqcCd2kL2i4eQG9vYkV37ITgtbvH8voa6UFTY7dXIDCoz5TI6qyXYFmvfNs8GA99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaO41K8n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaO41K8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADD9C4CEDD;
	Mon, 24 Feb 2025 19:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423673;
	bh=+KHlFdGlck6VeTz7Thh8FGnSmQig/RMPwQ7Sp1+3H+I=;
	h=From:Date:Subject:To:Cc:From;
	b=VaO41K8n/1Y0Ie1YWYzqF5+FQm1xxpmMUJz+2duqQ9+iDKm6GEgptB5j3bzf75RYf
	 eWdAXnpQZKBD3yMWEWiBajFUkXiShDP8jkFgmtZWaZCdgAxCZtThLzCgHz3uJvueQY
	 QTZiD8ID4F33RXzds2w2b1KbwNKPUr8mflfVcVxUOFfwn65GeSXhNgWzz8qRZYK8Ad
	 jv0ZzMqETmI0G/17CkEPaWqjqXAUXXW1uZAihfYf/F1RbQbau+g0ELsWeBe0UTNcnL
	 vXZVFoL6gw1yL1zP/iSk6jwUSEub3RJJc3a+jX1PdfjIeX5/VcUDFDKsiHQtaD1eFV
	 d5rAs3bJjMuGg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Feb 2025 20:01:03 +0100
Subject: [PATCH mptcp-next] mptcp: pm: userspace: avoid scheduling
 in-kernel PM worker
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-mptcp-userspace-avoid-worker-v1-1-127325d3e9a4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAO7BvGcC/yXMywqDMBBG4VeRWXfAJtViX6W4CPHXDqVJmHgD8
 d0b2uVZfOegDBVkelQHKVbJEkOJ66Ui/3JhAstQmkxtmtqYG3/S7BMvheXkPNitUQbeor6h3Nn
 RtnfYzruWyiIpRtl/+yf9ZcA+U3+eXy2yJgx6AAAA
X-Change-ID: 20250224-mptcp-userspace-avoid-worker-93f367e39ca6
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2619; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+KHlFdGlck6VeTz7Thh8FGnSmQig/RMPwQ7Sp1+3H+I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnvMH4Xs2HHwvFK2U6erlxS/ZNQZ9LjgWFdd9EP
 YVPX8p8viqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7zB+AAKCRD2t4JPQmmg
 c24cEADSzmnoa1ZVp8x31q035rA+EtAHZ+Q8AtmFeY1//OpTgjkCcgwKPq67q8lVo31XujOk8HT
 Abdl36s8BikJD7Z/F3IutkP3hy5dRqx0Z1vNOuSINsA/pO6B4jtgfL5T8E09l8mOU4tDCMCFPSj
 eDx1kH/7MS01KXaIVMfREmPfLJo6FqB248a7rxC6DB8cGEoYvakCrd3EGXfPqm/iQvaLGtcLIog
 roDerVcUYByvjP9jdXbyqWD4E2tZ4UnIwV2zBD7533vAu3il3fsWWg0fjMxzwApIwATgBdQCBQI
 TvUcfVYZ5HWxvB6bOGAhVPT76dWppZG+nmpFiHjA8iEm+W7Vm1PuW90doKMydFW1avS3ePItbjC
 gSHBi8JkuaJtFhQXq0Bmnvgwcc5WoxUkiXScUa6axlvcr1Eot+ljnF+cut8meNZWg5IbZiAFqcE
 37RHBByR/e2zwP9vhsQf/42oPkMhHcYkVzY65BV7kSa3tMsTmPBFOpJOvZY2hT0UC1a/ca3Mld0
 UurspEuUJYHjDxG2vbvpqn5JaNwjoxN//p6oOwBkkuaEnFhAG2UmMLmsWGRFZG5CutkQ1TiT0+8
 tVZu64nKL8kuxyDxtydE9Jnb9sUWG+iJeIDropDCYGyXoOQ/UKmwz+D8A3zQx7H7iXasLscvcXj
 xSqnDASSf9pafUA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the userspace PM is used, there is no need to schedule the PM
worker for in-kernel specific tasks, e.g. creating new subflows, or
sending more ADD_ADDR.

Now, these tasks will be done only if the in-kernel PM is being used.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - I don't know if this should be seen as a fix. Maybe yes because it
   was not supposed to do that from the beginning, and it feels less
   risky not to schedule the worker when it is not needed. I'm open to
   suggestions here.
 - I'm mainly sharing this patch now because Geliang is going to modify
   these helpers to separate PM specific code.
   @Geliang: please rebase your series on top of this one (or include
   this patch if it is easier).
Cc: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 16cacce6c10fe86467aa7ef8e588f9f535b586fb..4eabb83328905676759768fb44c859f5682721e3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -138,7 +138,7 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 	 * racing paths - accept() and check_fully_established()
 	 * be sure to serve this event only once.
 	 */
-	if (READ_ONCE(pm->work_pending) &&
+	if (mptcp_pm_is_kernel(msk) && READ_ONCE(pm->work_pending) &&
 	    !(msk->pm.status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
 
@@ -166,7 +166,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	if (!mptcp_pm_is_kernel(msk) || !READ_ONCE(pm->work_pending))
 		return;
 
 	spin_lock_bh(&pm->lock);
@@ -251,6 +251,9 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	pr_debug("msk=%p\n", msk);
 
+	if (!mptcp_pm_is_kernel(msk) || !READ_ONCE(pm->work_pending))
+		return;
+
 	spin_lock_bh(&pm->lock);
 
 	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
@@ -278,6 +281,9 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 	for (i = 0; i < rm_list->nr; i++)
 		mptcp_event_addr_removed(msk, rm_list->ids[i]);
 
+	if (!mptcp_pm_is_kernel(msk))
+		return;
+
 	spin_lock_bh(&pm->lock);
 	if (mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED))
 		pm->rm_list_rx = *rm_list;

---
base-commit: 3716d837622ee1baf6fbe7e6a6a7a3df116e75fe
change-id: 20250224-mptcp-userspace-avoid-worker-93f367e39ca6

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

