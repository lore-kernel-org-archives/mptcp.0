Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254146;
	b=1N+bX1lQTo05caeM8nGOleQWLeUNJjncyeGCECYQHG9m8TubKghsMug+7baRjDausuZm
	 23mOs5Om8vd5nskmlszXCSVfXPpkm8bsUentp6GZPJc7DXXkfyP0G1k9RyTAFgy++TyuF
	 20/INQJtkGVHGovR8fQjOMqxziWOYvmuCC3S40dXZddOwnvwoGvamOaLTOe/yi+hKmyVa
	 APSDeUuY3LEQi6tJv8kcGFohrwKMYX0Hk3YuifpIChGUkEsSQilTlA5qcJiOtj2Od3nR8
	 jyhbkQpgis7h7YQQJNRt3qpCKw4Ey5WCEcT10722WBR1MeUPkvy4QRezFBjCDzSlarw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254146;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qMJtYmCoS7IvqzxCfiYm3OmSMWe29KXo2X8yhoU27FM=;
	b=pjC+kAJa80T3I1FyAtcXiPudwgc6b/Jc/JACqOpOoz85cI3uf6gm96io+B4EAztfNWhq
	 d2p8hzbVT/cZeIM7/uPSUk+AMZlWbSuiNvtWSkfMowVT9hjnrQ87dVyGXbt8xZKxBA9Sn
	 4eCtWslZJ5AGjL062aEOkPHV5py/2x56tbt2cMRYqAnHjrSnGuR3sY0ZJ4qj7MTeFK6rC
	 1VY6DqnZ0iDPDN7IDFzjvGzx9rUK2f2NQISoYJEZVXHd00PYUZyMb8f7vZa6FIPIFRJRB
	 F3fWZ6ZNa8zqs1eHWjLc6zcUyUi+LqgMYnvzlYfqfkqCdM48nKeJQKdlTykEHvTZMBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEwm0G08;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C9606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEwm0G08
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA3C1F000C4;
	Sat, 21 Nov 2026 09:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254145;
	bh=qMJtYmCoS7IvqzxCfiYm3OmSMWe29KXo2X8yhoU27FM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eEwm0G08z8Yd6JM9G4dW+5gcx2P3oQhHaTYuHKsXFXKvk9KqzFoyK0w/MUv9EWnfx
	 F8zRYYHGO7xcLeSIrW7cA56N/ALwO3DsupeY3UOPYn+tvNFFqafj4Hz2Kn0c/ZtNoH
	 CUxycu7UQlgwKwEZcKDM8pYUFyiEZsap+LDArqVB2dDxX317Z2vxx8Tl8RhT1BF1XQ
	 v5gfm6+irfJW+fp38cXAeDikJ9oQ2VO7Fl5tsoQ0mGSvCmDbBczn7WklIygTBOeMWa
	 dYfomlHlCc0LZnfdHaBjFGQ0MoYZ2xmsHJWae39PS5k+BuYy/4GUE8VmRb08TwmoyK
	 zDgCsmWlzRSnA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:05 +0100
Subject: [PATCH mptcp-net v2 07/62] mptcp: pm: keep an RM_ADDR when
 computing the MSS
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-mptcp-cmason-fixes-v2-7-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4323; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bap6/1cQgE+Am2AhJ7tvVe6ZKpQpwlMHLQG0tkiHaj8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ031bsr1fisiUJKZf+Xc9Yl3+rZ6Z0+1NtipeCqkNc
 DzaxrG3o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLVLgz/fSc56ieWFifO+iOk
 E73+YEssf8FtjcdOHW+9pJZqTZR7wshwosE+o8o3prKnPlB8Zl3/EbHiw1tTag6JvXncm3JsxlN
 +AA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

tcp_current_mss() calls mptcp_established_options() without skb, to
know the size of the options. A pending RM_ADDR was then taken: its
signal bit was cleared, and RmAddrTx was incremented, but it was not
sent. The peer then never learnt that the address was not valid any
more. An ADD_ADDR is not affected: it is only sent with a pure ACK.

Without skb, only reserve the size of the RM_ADDR, and keep it pending
for the packet that will be sent.

This issue has been reported by Clashiko, while reviewing commit
"mptcp: pm: don't drop an RM_ADDR because of an ADD_ADDR", and
confirmed with a script on an earlier version of that commit, where the
RM_ADDR stayed pending longer: data was sent while it was pending.
RmAddrTx was then 1 on the sender, but RmAddr 0 on the receiver. With
that commit, the window is narrower: tcp_current_mss() has to be called
between the moment the RM_ADDR is pending, and the moment the ACK is
sent.

Fixes: 5cb104ae55e9 ("mptcp: add the outgoing RM_ADDR support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue spotted by Clashiko
---
 net/mptcp/options.c  | 12 +++++++++---
 net/mptcp/pm.c       |  8 ++++++--
 net/mptcp/protocol.h |  3 ++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6365e180d9a0..736e55532296 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -762,7 +762,8 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 	return true;
 }
 
-static bool mptcp_established_options_rm_addr(struct sock *sk, int *size,
+static bool mptcp_established_options_rm_addr(struct sock *sk,
+					      struct sk_buff *skb, int *size,
 					      unsigned int remaining,
 					      struct mptcp_out_options *opts)
 {
@@ -772,9 +773,13 @@ static bool mptcp_established_options_rm_addr(struct sock *sk, int *size,
 	int i;
 
 	if (!mptcp_pm_should_rm_signal(msk) ||
-	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list, size)))
+	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list, size, !skb)))
 		return false;
 
+	/* without skb, only the size is needed: keep it for the next packet */
+	if (!skb)
+		return true;
+
 	opts->suboptions |= OPTION_MPTCP_RM_ADDR;
 	opts->rm_list = rm_list;
 
@@ -933,7 +938,8 @@ int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 		total_size += opt_size;
 		remaining -= opt_size;
 		ret = true;
-	} else if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
+	} else if (mptcp_established_options_rm_addr(sk, skb, &opt_size,
+						     remaining, opts)) {
 		total_size += opt_size;
 		remaining -= opt_size;
 		ret = true;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index cdd62433e0a6..0fb38c257eea 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1026,7 +1026,8 @@ static int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 }
 
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			     struct mptcp_rm_list *rm_list, int *size)
+			     struct mptcp_rm_list *rm_list, int *size,
+			     bool size_only)
 {
 	int ret = false, len;
 	u8 rm_addr;
@@ -1047,9 +1048,12 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 		goto out_unlock;
 
 	*size = len;
+	ret = true;
+	if (size_only)
+		goto out_unlock;
+
 	*rm_list = msk->pm.rm_list_tx;
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	ret = true;
 
 out_unlock:
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9febcaf84762..2c9a442dacd6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1248,7 +1248,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *drop_ts);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			     struct mptcp_rm_list *rm_list, int *len);
+			     struct mptcp_rm_list *rm_list, int *len,
+			     bool size_only);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,

-- 
2.55.0

