Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102A186E42
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038205; cv=none; b=hU+o5dYClV8fvgCLQyuKKaalHdbr0VAzYmOcwsYbduObunIbC2oHrin48NlDlBME/7cfQp7J3eInMDkzpx5uWPe3V8szravDiDhN1CcbMaO23Bmr+56G0NcbiTDiO0etWXplj35MFhvr5MrrNt5/fzOges8Bey1r9JPAUXKRg1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038205; c=relaxed/simple;
	bh=1jgdfRM0rWxjkBHjcFTDjH0KOPr1H9+0NK7hSE/rOyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Muj9AzoniAlfjY1mXeLlCOBgMhz0AMi6+6LM/k3HraIivdArt/AzusKyvTj6poh+yX7R4HhHbbZhzRWDu+s0fhv42jU+QSu+3TVbh9gXRQX66rG/wQD48+SNQpPFFjfQo94VKkOiHC9d8T4EeyIZOfO0VcMve6GfzA8+b9dBPAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK9dvmMT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK9dvmMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6F5C4AF0F;
	Mon, 15 Jul 2024 10:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038205;
	bh=1jgdfRM0rWxjkBHjcFTDjH0KOPr1H9+0NK7hSE/rOyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PK9dvmMTZhPBS4/CDyRystUoEYrwelxFArpXADs5DDNv3HZFvuIfHUgD1+zDyvojJ
	 7vFDbGSIcLYHw/004JRgqrwh5ERkkrE8mPGEhigBSNgQnxzsz9o6G9PZtHkviGsbNV
	 lIXyYkgjpArekR4tHmLqRnXfROzDA9tWZBrSrQEOYz8An8sy3A3mVzBMtsEP7s1TLY
	 18M1RhXVJ4wxMkCJY+/ksy5pY763uU+nCXU+gK8x0EHVGicQyG8VZ0XyoVoDDZkCZ9
	 H8TNep7QBJ269cPODNpsLFOO/hmINHAYf3CJnnFLYlPlH8RZjOInRJzwkb+aSMjYdR
	 J8YId/R/1bwaw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:41 +0200
Subject: [PATCH mptcp-net v2 03/17] mptcp: pm: reduce indentation blocks
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-3-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1jgdfRM0rWxjkBHjcFTDjH0KOPr1H9+0NK7hSE/rOyY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV33veI1qy1+EaTmamhZ0PV6zWxNoQWkA67B
 hhOmEI5AvGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 c84nD/0XO6A/aHLYt5XUzYvJpHc1fXJNue+fuDCFY2E6ggvAmWBaGvZX+eM+KA/Rg3QOQ1nd9PK
 W81WTfLeMcA1pvoSSabCrJf6yHmpnOeb5sLCh+syGLpAH+UAN31QLuV6QkMnrzZbtuWGteG/9A3
 QoYL2wdMP3RB4lSBQmi0Ydz2gjflvuplru/6vLhzGIBa/GjOyeDrlfE1UhPS7qq/NUFgSWyGPCU
 apKyKVoLxPeKJZSP/HOiGkgnrjydnMfYhBFsDu324xYpQwU9gQ+SCP2maPWweME+F2DkVv+zQjQ
 XIQQ8VquNWlgBeHOgClQr45yY0BfzYuHQQZ+B7qAtGPgj3Dru8PvutmIr2XPLCDOMbFbRlCDLkC
 xvMJqvvQdrapMzPxO81alS0sLYq1gEn1+LmS1790JdiROj7ew/DHfAAIIDoAaNTDo6LlbEntr9d
 GJ5l4GJhHDSIQLOz4rWr0pwPMgFZCNJwEtiHNh1bI2Bq4ZoBMwL1nRVoyIx49hekHzmw6P36CGh
 PlpZ1R1/pBj7h6wnVjVqfoRxboxro0e9jnpDUFtMqGNJ57mNhyJqKbDyO/q6c8ZLFIoD66beE67
 A6MLT14kBIL51FAN4Y2uDwHJLX+GjC5mx6zqflL3eUm2sGhmtG1aeGr2s+XYAhpTy+wdZHHIjY4
 pg4+mTS01pJcI1g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

That will simplify the following commits.

No functional changes intended.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c44b0ae51cdf..adc0183b8d3f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -568,16 +568,19 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
-		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
-				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-				msk->pm.add_addr_signaled++;
-				mptcp_pm_announce_addr(msk, &local->addr, false);
-				mptcp_pm_nl_addr_send_ack(msk);
-			}
-		}
+		if (!local)
+			goto subflow;
+
+		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
+			goto subflow;
+
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		msk->pm.add_addr_signaled++;
+		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
 	}
 
+subflow:
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < local_addr_max &&
 	       msk->pm.subflows < subflows_max) {

-- 
2.45.2

