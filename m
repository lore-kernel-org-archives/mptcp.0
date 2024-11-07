Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFBF19CC36
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970600; cv=none; b=gtDEk18YfnFG0dOkEpZAXHnctS2WM+loNeLFvAQim+m98xNo9bKB17oSJ6egBmQIhDWDKdS9rhL3mq4CBXZ86ArAksm+9aBrBszS7F3kBwxwgGKYZ9xNEqW57KnAGQFhrYqRqGwQY3zJW1z0NtBbMERV8dPP+REh4HxpymHz6NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970600; c=relaxed/simple;
	bh=LR8paxrpA9rV64owzMgemXMb9bMluQXMg0iVcTNDwds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cinu7J9JrJI4QZlusFOIQyqsSJ6JMLhmY8me07Nk2bkigJTU4576oBSG9NZA9QcIYec8FYgI6is2gSLmm3qygCUPIbRW2NE1n2Ypkl7l+pwEX77gLDhW2poFgcEBP/lUqTJ01CLtiID96nhnK9H5f0/iNLL8bU9A2GYF8oyRHq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpK6S3jj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpK6S3jj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBE5C4CECC;
	Thu,  7 Nov 2024 09:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730970599;
	bh=LR8paxrpA9rV64owzMgemXMb9bMluQXMg0iVcTNDwds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NpK6S3jjqPfEyV23x8ibJa5iz7Chet6ws3l7LRfpzb2X7vlmbdLmhxU4hkVYUYPwK
	 3P5aKHW0SQxUBYzrOOR2QcxKdyvBdbdIDlZZK1LFXu3e5Amlub2VjXNJO45ME6GOX6
	 RbCBo0CBofsunNZXwbcb0yLNKcsJ4V0NjUudHC6kLDiGKimcb14hHosu7RJzVdKUbk
	 OIKeN0KDxKCV02nYMmqzJDNfn5DNYzWvEB5YKnBoKUOrKa4HPvxRie53JRhgtcp31F
	 FhU0w23+24SdO1QligREAL8PicPLAsMlhf553gFE6baETiLOIoR+92tdZNfb8UJFis
	 SZwKeFa7vTN2g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 07 Nov 2024 10:04:15 +0100
Subject: [PATCH mptcp-net v3 2/3] mptcp: pm: lockless list traversal to
 dump endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-mptcp-pm-lookup_addr_rcu-v3-2-3c458d025de4@kernel.org>
References: <20241107-mptcp-pm-lookup_addr_rcu-v3-0-3c458d025de4@kernel.org>
In-Reply-To: <20241107-mptcp-pm-lookup_addr_rcu-v3-0-3c458d025de4@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2798; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LR8paxrpA9rV64owzMgemXMb9bMluQXMg0iVcTNDwds=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnLIPjmQXhtUkcjXpNDY7FbBNOdRI4aN/2NxXh4
 Ir/xLHBAbmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZyyD4wAKCRD2t4JPQmmg
 cyXhD/9jIU0QtYQQFKthACNVGdJnCdtr+in6lkcJeNcPD2wPtClbRAKF4kol09KuKPlg7fZ1Wbw
 3PCagyUThQAg/ID7dReWP8DiaIf43gNM+9ygPra8gcsYaMgGg479NavhU8YtGQwMRWQ1FSOzF67
 1eOUhMLADyOcBYYUgS+pDExEVvl+0RxhPk320lSGamexNWyuwZdB4Dy6gRER7gMjYHCxnu6ETrM
 gmtawUF9iqp2RmQA3gGn8Ofs1FADN00bXJzkPy9kiUHO2zGhhvRagoytww41NVWNZaLe9RCMwet
 e/nWsK56CCo+CMcl/Gjqc3a+lINz+Ecyarg9BcYA2ETs3J+yFJUru6gWjE3Zqxl6yhag7aHB6R1
 6qRqClRPI/KZfpbDoijIYQQvXo4imPIMNFNT6KcxANMnw54M4oiUumd6LLId/ubEVvO5vAsozQt
 +sW1GLVmqbQ+OFczSuHUdM+aFBzUZn10u5epTX6lBVurg7fRo0kItYGOBrqMJkWO5uF4r/FShzl
 U0f5bNmIFkSWQbCryMDokWWwhsKfMIbCW46uFvqft/5B+25rwACK176D+I+TNzUlnNd/aPIgEQ1
 TuoJSp1UKCkq1mk9APr6+XnmtWBLdbum3g8KziUxN7KRHJbRENPBOtZNl5upnyDheeqv2ND6Vi8
 XkWkc88n0w3FJ+Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To return an endpoint to the userspace via Netlink, and to dump all of
them, the endpoint list was iterated while holding the pernet->lock, but
only to read the content of the list.

In these cases, the spin locks can be replaced by RCU read ones, and use
the _rcu variants to iterate over the entries list in a lockless way.

Note that the __lookup_addr_by_id() helper has been modified to use the
_rcu variants of list_for_each_entry(), but with an extra conditions, so
it can be called either while the RCU read lock is held, or when the
associated pernet->lock is held.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - This is not a fix, a small improvement for -next.
 - v3:
   - Use list_for_each_entry_rcu() with lockdep_is_held() instead of
     duplicating the helper. So no need to rename the helper with _rcu
     suffix.
   - No copy of the bitmap in dump_addr() (Mat)
   - No need to modify set flags. (Paolo)
---
 net/mptcp/pm_netlink.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 758a0dbfcf78e545d840c0b580c0b12bd042d7a4..2b005ddfd2d365b66abf42065289d74630e604f6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -512,7 +512,8 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+				lockdep_is_held(&pernet->lock)) {
 		if (entry->addr.id == id)
 			return entry;
 	}
@@ -1824,7 +1825,7 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 		goto fail;
 	}
 
-	spin_lock_bh(&pernet->lock);
+	rcu_read_lock();
 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "address not found");
@@ -1838,11 +1839,11 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 
 	genlmsg_end(msg, reply);
 	ret = genlmsg_reply(msg, info);
-	spin_unlock_bh(&pernet->lock);
+	rcu_read_unlock();
 	return ret;
 
 unlock_fail:
-	spin_unlock_bh(&pernet->lock);
+	rcu_read_unlock();
 
 fail:
 	nlmsg_free(msg);
@@ -1866,7 +1867,7 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 
 	pernet = pm_nl_get_pernet(net);
 
-	spin_lock_bh(&pernet->lock);
+	rcu_read_lock();
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, pernet->id_bitmap)) {
 			entry = __lookup_addr_by_id(pernet, i);
@@ -1891,7 +1892,7 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			genlmsg_end(msg, hdr);
 		}
 	}
-	spin_unlock_bh(&pernet->lock);
+	rcu_read_unlock();
 
 	cb->args[0] = id;
 	return msg->len;

-- 
2.45.2

