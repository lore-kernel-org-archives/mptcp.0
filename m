Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4B83CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391877; cv=none; b=tGFwhzVQlJDZ3w7LQXDnmiaeSzemvb4ZZmazF1L3tC3Wi5x1CocaVGay3DmyU/D+It7fw6xhZcsx5D4cceHPEGx8gp+i0A/E9puRRTcc4MKe3yHlPONOXVzLfbu1wUYhWrbgIkxibJY7nP8FTEpl4JcgEbzGeTkrRzg3FtotJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391877; c=relaxed/simple;
	bh=1jgdfRM0rWxjkBHjcFTDjH0KOPr1H9+0NK7hSE/rOyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IuN8llRHg/CvAI3krhuBqhkqRU6a6snX0LvX0Qto/kY82/dpqTZfQTheG7DO71B48cCgDpb0aj1FnLIe5BlgrtnzGu35drKehEIV/0NKMTgYAIdNpl9sPrsFLHorIqQ++uFaIqr85HLCoWO3SniHH3tmvzy1NViQUQ98YIwnkK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXYeGYEB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXYeGYEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81227C4AF0A;
	Fri, 19 Jul 2024 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391877;
	bh=1jgdfRM0rWxjkBHjcFTDjH0KOPr1H9+0NK7hSE/rOyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HXYeGYEBXYJp6wLm7PEbCh1sleAZm7FQmjDciKeeXhloJrXXTu8o/CHxSMEgKlE8n
	 M9lDCPkdOGqvBn7YmLDe0Fm3y6CciX9OgcTQuPtyGBDGEaaG3xKQRLxI+y84tYNBDK
	 MojfYAcpZmSiGmWYpKVoeJ0o2cfrVSWeGvSYOQegAMHKa7Sq4zwQaB1h5sF094Fjax
	 1RyEwEqKYdMoMHXGDVL+W5QgfeefBxpo/0wdfPfu1DYPZloRqHz1n4vSEcM2Ot2d0j
	 mbFnU27Txe3pypUxvcODUggeZ5Loe8wcCdqxqmVtgrLB1LeJYhyEfzWBt3aOx4fvMd
	 qWhSSg0R3ppPQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:14 +0200
Subject: [PATCH mptcp-net v3 03/20] mptcp: pm: reduce indentation blocks
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-3-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1jgdfRM0rWxjkBHjcFTDjH0KOPr1H9+0NK7hSE/rOyY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlr/xFatUMWs9pYtIA4YMkmEks0rW4Rj0ZOjQ
 R4YsUEdZP2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppa/wAKCRD2t4JPQmmg
 c8mHEACAq93RFrC3Zj9kZKSyKaRXfIPP5NhA10k8K/Uv2aQRtuVwJobZJNLI5d45ao0LnZGkUA2
 22b7seRKspVqjEYWymR7GlqB/OP9lBiDtWqRe6ltaJeojA9x4jm39qhkx7MeOKrUHriOLn8lt4s
 Z0XmRookiyOfnLAA4gGVVT2OfP+H+u5DtMZH4LG7BF6zXY87Gp5PDTvS7ftmbcJZ15KRXxtYvu+
 NHLIg9usfIatDAeKUqSgj9DflqBFQDCvjjpb8qdBPNpS7s5w4fY2pLwaemHT++Y5MnQw83uBtX+
 UwpmyRrPmU1K6C7+FLvd8UtfP4aHd7R3///pgK3krovXG9E8pS1UTnhXQdU363TJevHLKjXY9kP
 cPUp/M1rO/s1pgkwyePCYXEAjtw1W+C0Xo9TD2qi0SSIUwp00DE2fDYzCx/5HYNExERtniN2acN
 lFE2ySr02TVe5pASetTeDNM2BFNbfzQTLNzloyPW3O+dDDalMAivzoi/fqNS0iA3i42+SalHNkn
 DBdkuCp02QJPlL59hSyDKDzuGKPegdpD9zheRfD4haL142XSQ301cm0zvDMpOwTskkfpbnifpYs
 fUi0Spv5IvgbwQfK52N4zmrIEmRoFhYmre9ORV4Jey213k65Um95f1/uA9tdDiN1rg/wPJWUnRy
 4o3JtP8ozfBJ5fA==
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

