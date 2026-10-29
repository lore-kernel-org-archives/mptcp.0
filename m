Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309528;
	b=YLikJVj2DJY6aXCSdf9JE+5uFgLBeAvHobKkDz6S7JULgYpPQ6o0FI+UTET3P9psBwfD
	 I4fUmOE/frpi9R2EsQXAqmjqegomlRnKbGQstZdSdmaztNyQFQOfTopEz3wPlkNNULSu8
	 nNX0jyNwTVyBn80oAokxsc5rul2p8+WaZ7Te67sVETf6r2tigdliu0j51LRWA+qj8Ee7B
	 tJV1iTVDZAGWwyYSzgZ3PhoDaEnkr5fBzK/2h8BDx+sFM4M/3usxNicBQtV3JnOsEjCAj
	 Zcnhh1ZhoIXlqwO/68+18uviJi1eUvUWQcQ1MWw832dQScSPhZlKBuyIJ69pLPr9mhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309528;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Od2tPKuv1TQzeyQyL8AQjofU0DeelE7sF28PcMdR2PE=;
	b=FE52o2DcfD+v4xOkwhhtFcn3b0hjth3N4jqacr0tLqMRS9v2VOrc76AtpfjMvNqN1CLs
	 FUCa41CCptsVBqIBBTo/HF6jOKfNjxAypZPu+c4de4xtHd8C11C56mDtWTi+OlJbsFfMi
	 WkH9cJ/f8YArFeRUSnvDZklA6P/0USD1O1YZklcrv1KdC9rnUnW9QvHG6WyfI5YSkQF6B
	 oWbOAitBtoO5xT4fHxttGTNjCqFBmIYVUauZ0Hu/ieNemRipadMBe3Ql5McSfOaatCPG5
	 b5h4Olq61Owk+jfd3N0Of0LiZc+I4nSTAMkaE32k+ELXHUE+tCXiegTJFourcL5tuGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JT42+eyY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DFD606A323
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JT42+eyY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A971F031E2;
	Thu, 29 Oct 2026 21:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309528;
	bh=Od2tPKuv1TQzeyQyL8AQjofU0DeelE7sF28PcMdR2PE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JT42+eyYkdnZ1HM+kY4LYoVJFKltoAvQfYt2oQSCBqhWoxYqArhsAbBMZwOlUMTN3
	 yNgI+TjlSxdJc+VacYBiUNkQoV7/CuJ9N3ZgSll9K5hgxgVWE9e4/Fpg1kTyM4CK6A
	 30he/886FXOgDCNnHz4b6w2BihVoxNfM7mYB7kmVhltQ8/tPCS3JAJraJwEQ59z/XE
	 ridydKvG3SU6mORdpISrHpbqfpDxg/C7upLF2uJQB6fNk0kMnY4wfvziCoW4YX/rKO
	 xUKadPSS9+wnSXlVV8NgH+09z+PNbqprb0FtlhBjGrEoRqMxUzxKnBoen9HP+XWt5X
	 WshfqAgDJse7w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Oct 2026 22:31:50 +0100
Subject: [PATCH mptcp-net v4 5/8] mptcp: pm: userspace: no ID0 exception
 for RM_ADDR
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
Message-Id: <20261029-mptcp-pm-userspace-id0-case-v4-5-555066fa4292@kernel.org>
References: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
In-Reply-To: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=El5xT2TsNQOMhZRToG0KbPg5mFoN9Q7bDbD2OLNSAY8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIe7w5Q+dT7UDdH9ljNmrqoygdFUafOLauJSr9+nbf7w
 64rFa9ndpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExkvTrDH75zR4LnTH2Xltw6
 R95lYcDrK7JKBRHOT1aVbTKc3f0/w4mR4f2eevGKvrhq61IHjrSTnXaSeod3/fD/kL+/7Oafree
 bOQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After the first patch of this series, the initial ID0 address is present
in the local addr list when the connection has been created.

Then, no need to have an exception to delete ID0, this can be done like
with other IDs.

Fixes: 84c531f54ad9 ("mptcp: userspace pm send RM_ADDR for ID 0")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
sashiko: check the next patches before pointing at existing issues.
---
 net/mptcp/pm_userspace.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 66dbf67fd6d8..0f6400bc3bf8 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -270,37 +270,6 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
-{
-	struct mptcp_rm_list list = { .nr = 0 };
-	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
-	bool has_id_0 = false;
-	int err = -EINVAL;
-
-	lock_sock(sk);
-	mptcp_for_each_subflow(msk, subflow) {
-		if (READ_ONCE(subflow->local_id) == 0) {
-			has_id_0 = true;
-			break;
-		}
-	}
-	if (!has_id_0)
-		goto remove_err;
-
-	list.ids[list.nr++] = 0;
-
-	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_remove_addr(msk, &list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	err = 0;
-
-remove_err:
-	release_sock(sk);
-	return err;
-}
-
 static void
 mptcp_userspace_pm_remove_addr_entry(struct mptcp_sock *msk,
 				     struct mptcp_pm_addr_entry *entry)
@@ -343,11 +312,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	if (id_val == 0) {
-		err = mptcp_userspace_pm_remove_id_zero_address(msk);
-		goto out;
-	}
-
 	lock_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);

-- 
2.55.0

