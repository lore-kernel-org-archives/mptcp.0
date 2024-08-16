Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8A2A1CF
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806131; cv=none; b=pMHXp6EJtdPA0x8VsvXKNIk2AS8QFKQWj0oOGdTaedzeN2v+nu5dvR3v85XTyF9UP96fOkiTasiBgklCwJOfGONkMIf15pa1oNSmVKeNkCAqgxwVa7hOsXZ9aIG0EiPor3DxIkgMETswRaHl15y978uvVNUKv2vctqUtDa/yMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806131; c=relaxed/simple;
	bh=38yqVkpfYH9uEwxRwherj3Y/AO8wIe7M+kcX2QqNBI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cctuHfUJfoJqRrKSXuvXtspzvhIqeNhzugBnU9onhvjkN7BKZIVKrW+2GRuaDZt+lyn9KPuZxF/tLv8PIFpCA0IVcWt9ZiXOuffNnW3TaIyS4As72StWTbnL1HzTKoKLnog87crDpWq74kRI7ZApUwZhCNvafAQKs4DV6UjQiQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/6BcY6y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/6BcY6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FAFC4AF0D;
	Fri, 16 Aug 2024 11:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806131;
	bh=38yqVkpfYH9uEwxRwherj3Y/AO8wIe7M+kcX2QqNBI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X/6BcY6yCP62g/RwRM9G3SfxkhSBhHo5hmxjym2q0lmjcBezktJ2piWR6ZoBFUzzJ
	 5wPRe8ovVPGJ8Yda0KH86B8n7WohcFTXXdmlpTDHwGa2bCVgIxNSRzgVLUHcXZcl1J
	 p8l3CBbJndAaq3ODhtzGf0CK40QSIRXPxvyqDIgyvIbJ/Jbnn/0juDA+HXybaOEQCF
	 KO6uX1qlRRaqVgrrGcOsfbg5nRXcHjYS2A34tRZSnWABzfBfmtUt9+G/JO1B5ydQcC
	 i3QceOiZJNiyx7EzwziApV6JlQe1eN4RWJ3qs+7/O0Vvqnlmrn2z+YwStDeXweFMci
	 RCKR4gealpF3g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 13:01:57 +0200
Subject: [PATCH mptcp-net v2 03/12] Squash to "mptcp: pm: only mark
 'subflow' endp as available"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-mptcp-dup-close-evt-v2-3-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=38yqVkpfYH9uEwxRwherj3Y/AO8wIe7M+kcX2QqNBI8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvzGuWU0xhxmToPKHL0mkc1nUpNV0+TKlq35tu
 qGGBHKRAqGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr8xrgAKCRD2t4JPQmmg
 c4cBEACDe4jjws0Ok2oxQe9Lca3bqAO6c+4v10pA9P/vV9Tg2A6yL2fRdR8G1JMNfknPxx61h0z
 JRBl9nBdrwlSIR1K9Bjum2UpIVSnxP5afP8ac1x3nBD+HHYf2otuMpMW8Uu/6T2AGXEsXyvvXKT
 ULS7MFWLxTyqAICgovAC+ZaOrbD2XzKq7NSpdEJjbTzr6Nyqh8HgSP+RP8HV3XShQIg/JT22RZ9
 T6934X/W0HQCf0T4e1s11ks4KM6PE4GOJiIQSRaqwdbm13hf75lICf+PRnFxBMcR7+pkINikGzL
 savThRw6PLipbRP8b/xKvyfX/86INUkljbSIR/H8KQW8jfgoJWMBGtDmlysLV15AkmJl+5u3j42
 ZTnGJxiMq6CnGmG5ip6GJjBQj/RPr4teihmJsv9DdUTKRwrrq+AWCOpg5r7jRjQOXCt7shCOQLO
 5nPcBpuS2MakMjY9NuoG+quGbl+ybDslC947GD2nyFmdBc1OQwU55Z1rU7vzMdRVyJ/m6cyqtCB
 OOSANKgZZBFkUw1dLuZE0km2jqmeoX53jH34uVRjpuzTdhFlaQCNFP4VymDVrFFk6O1vDSeKuAL
 CCbIyZ7AhF6qvxeov8sZC6xCKFZqRRJwkeWiEPcu1Rk+Sn5bhhLL3T54Qp3Efh1bz5ipdoxtgor
 /Hml5KiEmeRpXIA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

__mark_subflow_endp_available takes the ID of the subflow, which can be
0, not the one of the entry. If it is 0, the 'local_addr_used' is not
decremented as expected.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0881983f505d..3784eb5e2044 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1510,7 +1510,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 			spin_lock_bh(&msk->pm.lock);
-			__mark_subflow_endp_available(msk, entry->addr.id);
+			__mark_subflow_endp_available(msk, list.ids[0]);
 			spin_unlock_bh(&msk->pm.lock);
 		}
 
@@ -1954,7 +1954,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);
-	__mark_subflow_endp_available(msk, addr->id);
+	__mark_subflow_endp_available(msk, list.ids[0]);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 	spin_unlock_bh(&msk->pm.lock);
 }

-- 
2.45.2

