Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36412D978A
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169879; cv=none; b=uJsnJGSdiooZmcx/KZvkFc0Ku6orDCWHS0tDTu6BuHsxSDbB7gp5HlwCMC21E1iUT+qYhhvyVCd+8/fv7pviIEOv6iI2emodwJYnoK3sQ+dQCx2YAZm8I0QCNKv/zbwpWxM77FThXOuBUQlbThhT/1MEmNHfAZxQUwRIXKQuC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169879; c=relaxed/simple;
	bh=SPSbe6DhnL5SRcm7ZL1UbtbiCe0VWqK+AlzpNlRTqyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PqwAivhK4NODAH6e2dxhIS+4T7u7hBiXmhA7qWhSvfDU8i11YzA+y5UUWvzBkfMIpqWvryzUUGeb0VZ2PjKWbXu3sZPykwlbgoEwn3ZyYDL6vrWOdsTxBUVvkJ/W4a0ZaU26vj4p5q5E+LAW0U1xxGiqRkqFvsLfeNdBzwfwQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q62LNY7C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q62LNY7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C36C2BCB3;
	Tue, 19 May 2026 05:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169879;
	bh=SPSbe6DhnL5SRcm7ZL1UbtbiCe0VWqK+AlzpNlRTqyg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q62LNY7CCGSdQaEQBtQ9Deov/AnidJaY1v7oE1MPj4TDjWAma6bDfFPKzoxafarYF
	 Zd+ENUv2P+9KVr7pi4FLBeceY3aHy2lCUQBgSvWa4gj7vNXT6msK1APumWmWT5m7kw
	 sdbeyOGOL6XkCX8aMb86nhRCVJUuTV7VqdEIVr+QrgW4UztrM4aw7+7wn1Buay2iMz
	 2FFjVJ5Yi1cBCsKDYZNi+fWv2fEil5mt6TCqUiNzcINDoKIWO/4IIj/QrFvIQw8DQ9
	 NfKUNvRSmqvHGInganlkWZXQxTHdxfZTKNOLHDaTI1DDHvos8xpg6xR7mJTRRV2bdL
	 +n8sU+j8tOkhw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 May 2026 15:51:12 +1000
Subject: [PATCH mptcp-next v2 03/15] mptcp: pm: avoid computing rm_addr
 size twice
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-3-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
In-Reply-To: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3708; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SPSbe6DhnL5SRcm7ZL1UbtbiCe0VWqK+AlzpNlRTqyg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pS9QuybSrDuHeQkJ0Q/k7M9hwWYFpY9bZiH
 cxdNwnhzGCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 c8VBD/9SdPQ29/WNYtob3MXdbs91iWkWwWfczM8y/H6M5eTil3VtAjAF11lE8UDn+7CYIKngaGI
 m/TS1aWS65yWyCJ4AkYK7geg2BLROPbi1KZyoa0DupaSKVCs77SEvpJ4T/7FCdX1EUyHlIW5Gop
 JK9kcV5DcyxdY3tGpuBSJV3o2GVJ7P52EI/XNfBfOBI91PbI2dtkJ8I7h6Bp6yLIC439tOyNtEX
 rlWqphJLj5hkGjjNzpkAJfLTt/sRzDP6cuJ2b8hQHIV5Hlbh5cyWtt6HjHsuGz6vtXEGfHf5WiW
 HcCm7pW3zpb17m9t48OxyAI5NXHo6kKp0pmDpGOSZ3S+p+ZUWAzvBDLeOjRVkxnCd6pFOv3Pbop
 o5AIJM8nUlNZLlvQzpJU2PzUIh8ThCKq7I5P96mSmu3K4aLfuEgvg7ytHTea2+U/1u0IUCfzb5E
 U3i0VfrUbRdf9P9FRrAbVcpgPocekPGHnW2LvKEtBSXPYJvjq5JgyjFEGeCPMpz69DIx9+ivrdM
 Ql0HGmsemmo3JomjjUJ2M6JLsXuRnvfMjvZx9N871IsjzUBWfMh+ATW1Oz9+jZFGwI7KenUonlW
 DL1diss3McvNMaoKN60hCX9vq+6x9fqkVwMWq0KlBSsvkymyptCwEXIbWRalthAJh+pfYBnHjSH
 05kUrl40MKjbryg==
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
index ba58d057d040..c51e57effbdb 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -961,8 +961,16 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
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
@@ -982,6 +990,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
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

