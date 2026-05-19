Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5631AA9B
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225928; cv=none; b=WP1y7KvHZBCWSYswfQHe5qjFd6Q+yw2DLkU98JVkdrYwid9QubZy8XUQ9oYtXTMJEXpYwlRNLYsCDAyPGPqZXXDx7yesm6ikrYZDZ2ZRu5EWd5+UuqbeBB8wedD68UmnaCs1+KEGysKvenxVmgktzcKMI7eaicx2pzB4W2JETfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225928; c=relaxed/simple;
	bh=o+QRMk4/8Sn5CkbSCof+Mkfcf8eANTuQiTKu28jp2qA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYv8l7MS7W9kFiedrVoq1S966A5/MUfXfxiLfDrEnp8zwSlASYPKU4Lr2IjDtq91hOoasQDC9RLNGYqD0E3L2qSI734QZgeotoVaefEBHKWVVUuquRszlnnbLqeK1gcFu/DZNi3lIKQpIDVdU1hOMoSE7OOfmYqUjW8+IEOcNfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPXIRFRj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPXIRFRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D4C1F00893;
	Tue, 19 May 2026 21:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225927;
	bh=ZVSpbgYCztQJudy2SASrXJFkLjU30lYlel40XVRYaZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PPXIRFRjBOZjHkPGDkYjMsrJozDyfP88Bs7rEq0/z/dMJhZLeTV7p4mX0PJXuAmXP
	 +ayAzSMtuJH14YSmlne+B/RlB+qzUg9hDa97D5Hm3ZUHrdgvXDgu7QQj2GqaJMBbXf
	 lfbRGNguPZm6jnQjorsNfFHtLhnwOZYjG7xh//ydm4uEBI04R0783eqhRxV1fZLokK
	 h3axcYNTegoesNytOyFD+WDk/J3qiAOSqIEchQyvNpok33WlujVocks9/yQRteJ8m+
	 K9pIRv19RC+adp+dS00PO4mNpujk7rQVIspkdBqW/7KRyt417zYiCiDnhiJNCcbBNm
	 u0rGZrm7qYTFw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:14 +1000
Subject: [PATCH mptcp-next v3 03/16] mptcp: pm: avoid computing rm_addr
 size twice
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-3-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3708; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=o+QRMk4/8Sn5CkbSCof+Mkfcf8eANTuQiTKu28jp2qA=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGoM1UGghGnzqy0K0w+b3mFFT2xtp+PGgVgyGDmhuKBpQcYp4
 okCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJqDNVBAAoJEPa3gk9CaaBzvgQQAOeh
 ZBGES0hNfgVGHn5RO3jNrK4jc6uMwnQs+1jDTyRAGSFbgCiWHrMJkEuPhGlOFod6v8EVRCIWEQ9
 P/s7U03g33H3NNY4ic692/j7WHOyy1ZEB5u0KkBJE8Xo3sbS/yahCXuLhMUv8XL4Nygzl5jJpKJ
 PDtr8ycM3aCXheP/n5XUXVBrtl0PQ+qxdVfD5zMrEGh3fI41Zrd2QbyPiSlUyyA0aKDbOJXgjCn
 a4plq/CuGZkGdz0dmwQIXy/hxR/ds9bgdgE4cLHeKM081L3IoPnGeygQuaVnpH4huae/SRc6weD
 SSGZnr4vqTpTdhv9zTqKtE03jXLscBfYgKUQkp79aHgUl/ufaBSdqUtynTqmBzBRIfca11NDN2A
 37E4tHSkI35i3RzoUMoqDE7Va80LELg9IAe0EFXMQQIwsJ7WaSndeVJNE+YVpsmaJBsJmFIBPIX
 0gCQuKT4wEqyVLzpnE8DXhnRg0aLqLpSUtkn7j4Vdvc76W3HIEeftCJEX4A8OhhwGB/FJorF2Vg
 mEDH1GTlYjqSC7i9eAx177zC/WcpTDooEAi00ym7qejBdtMo5A8WAgzJbZ4Ak6wqWS4ceUfEvhL
 RwsYFMxzT8ZGX/E9Gj7Eb3N6vBafZhgF4AP+JYTod5PRIgOHkVbFCZGrleI83p1kEJvDQWSFL0i
 PBK6f
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_rm_addr_len helper was called twice: in mptcp_pm_rm_addr_signal,
then just after in mptcp_established_options_rm_addr. Both to check the
remaining space.

The second call is not needed: if there is not enough space,
mptcp_pm_rm_addr_signal will return false, and the caller,
mptcp_established_options_rm_addr, will do the same without re-checking
the size again. Instead, mptcp_pm_rm_addr_signal can directly set the
size.

While at it, move mptcp_rm_addr_len to pm.c, as it is now only used
there, once.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 11 ++---------
 net/mptcp/pm.c       | 11 ++++++++++-
 net/mptcp/protocol.h | 10 +---------
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 966f6a867287..231010aaf163 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -723,19 +723,12 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_rm_list rm_list;
-	int i, len;
+	int i;
 
 	if (!mptcp_pm_should_rm_signal(msk) ||
-	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
+	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list, size)))
 		return false;
 
-	len = mptcp_rm_addr_len(&rm_list);
-	if (len < 0)
-		return false;
-	if (remaining < len)
-		return false;
-
-	*size = len;
 	opts->suboptions |= OPTION_MPTCP_RM_ADDR;
 	opts->rm_list = rm_list;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4fc7d648b672..e78a248414fb 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -960,8 +960,16 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	return ret;
 }
 
+static int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
+{
+	if (rm_list->nr == 0 || rm_list->nr > MPTCP_RM_IDS_MAX)
+		return -EINVAL;
+
+	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
+}
+
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			     struct mptcp_rm_list *rm_list)
+			     struct mptcp_rm_list *rm_list, unsigned int *size)
 {
 	int ret = false, len;
 	u8 rm_addr;
@@ -981,6 +989,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 	if (remaining < len)
 		goto out_unlock;
 
+	*size = len;
 	*rm_list = msk->pm.rm_list_tx;
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	ret = true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 661600f8b573..6f3c73ad4284 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1224,20 +1224,12 @@ static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
 	return len;
 }
 
-static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
-{
-	if (rm_list->nr == 0 || rm_list->nr > MPTCP_RM_IDS_MAX)
-		return -EINVAL;
-
-	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
-}
-
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			     struct mptcp_rm_list *rm_list);
+			     struct mptcp_rm_list *rm_list, unsigned int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,

-- 
2.53.0

