Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818D14A91
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749503; cv=none; b=q2ze8BSLXCX0ZMVQBQ+RPtsfWmySWSEvsPZLIdOk9U4qvYfuL16zRQAXRt1aLtikRUaHiHWoRLabZRPP8X0onNcu9mWcjWZNSv/z2Bsqtr9iejhR2Bpbkz+YNusj/uqgYw8nOIoUVaGeqv657UYAHUWOz3l/H52p89jzusEw/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749503; c=relaxed/simple;
	bh=UILxa/TqfhzdXpuDLwwRz/IgNjXN8euvQyCOxLlbGPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nfeoaj9AiPfHj7roPpCR5SyT+gbVznYEuFNrfkDPfQHAw3S1zn/bzFUo7wPD2Lqk/gODTJflB6+jwtKS8E1nuJmG761adRMbQCimslAE9bnfjsds6GgaLa3Z0t203cEPB4KKZJtRrCfdwac2aENMla5ec1fr05lZiurC5Ef2OM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzRbUyq/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzRbUyq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EF8C4CEE7;
	Fri, 28 Feb 2025 13:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749503;
	bh=UILxa/TqfhzdXpuDLwwRz/IgNjXN8euvQyCOxLlbGPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CzRbUyq/3p3VbKoGXZ6h81CU1k/9slyam/PwFugQRaTDQc2TEq6TnsLlNy0hliBd7
	 v8f1TkHhk3ToPiMgjVS9jLz6sriU8OSQHMPuMAuqf7fOJTdGUU+j0ZtopFHS75Ukoy
	 EgmXxlCRpvPND1k0MwNeSa8F5iiTfB47fwe6lnLyojtoOGQggy3KK30QOnPjpRdPH2
	 pb62AoqV5ISqWKF31naiBCLBEhp5iZWKDkPo7J+/LAjP4aHjQqYVwfkpgcNXcB1IaP
	 j8CfAskPLBt5eNe/CTFsWXIoGU7cE4diehDKiPCXp2P3A0KP54nE5Y8a3FPEHquk8O
	 IA2ZvdCgunuXA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 14:31:22 +0100
Subject: [PATCH mptcp-next v2 02/14] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_mp_prio_send_ack
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-mptcp-pm-reorg-code-v2-2-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3369; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UILxa/TqfhzdXpuDLwwRz/IgNjXN8euvQyCOxLlbGPo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwbq5uZDe/dDfmX36hMQbN1qME3FY2qGpv6Lgu
 RoS6vw+M1yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8G6uQAKCRD2t4JPQmmg
 c9/mEACyAyA+mlBX9w9z9mpayCDPvQXdJE8wbIBo2Fb6GGSSya5U1YMYcckXXcTFUSb/4PK339N
 xGnueTlzP1zMNJlZcV4Ftw7RMASw8uwcD0sPTFCxGw1pzNOmg1QkaH7sLPiCcw0ofw+qZ7zQI3I
 lG4I5jT7eHME3XPEkSwK0IcsUDgAg7/Ns637LD8VBJOlwJjS5wUFXl+Bg2NrHz2kWfWM1b5Wcim
 XgjV+PnOpk2gUk6YxshzhESCGrxwJ3YEC8AsulGLdeShefqlXP2df+QjMcVNVHmNvpUjJB5/jcs
 gr9i+UTwoPP9c/DtoN31YiFrydqsmLisrw5SQMaO0mjTNk9n/e2acnwJImxsfKCfedI+BkZ9y2g
 HfKGKRj4H/e+fLFSSI89MLOU5swt5In9L7lZ29qYhqSi3RBhUBCca/XzDB0LYAnwirm0M9D6li4
 ez76HocQoX5rMdz+1DvSjcw8uJvyS95WRV73/1SE9jhampUkLAV1jr/O77HQeV8RL3r95ssuhh1
 HKU8nvwv53tynLtgCAvuYswebAWaLIH5jkxUOeQ3eybXow10HNShuhwhmbBB1kBDEN3CG85C1yB
 81t4ncfuQbJR0El1+hssW7QijTd8ai3kGjTvToItMkgjxyDZW8SrHLjtJYKInE0pyzDv9IVLumu
 4FCnuroqS1vHlFA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_mp_prio_send_ack()' is not
specific to this PM: it is used by both the in-kernel and userspace PMs.

To avoid confusions, the '_nl' bit has been removed from the name.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 10 +++++-----
 net/mptcp/pm_userspace.c |  4 ++--
 net/mptcp/protocol.h     |  8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a70a688eae845c562c03caa0f3e20169c5f5be11..5494b5b409dc478dc783844b9cfdef870688d17e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -808,10 +808,10 @@ void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
 		mptcp_pm_send_ack(msk, alt, false, false);
 }
 
-int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
-				 struct mptcp_addr_info *addr,
-				 struct mptcp_addr_info *rem,
-				 u8 bkup)
+int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
+			      struct mptcp_addr_info *addr,
+			      struct mptcp_addr_info *rem,
+			      u8 bkup)
 {
 	struct mptcp_subflow_context *subflow;
 
@@ -1936,7 +1936,7 @@ static void mptcp_nl_set_flags(struct net *net,
 
 		lock_sock(sk);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
-			mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, NULL, bkup);
+			mptcp_pm_mp_prio_send_ack(msk, &local->addr, NULL, bkup);
 		/* Subflows will only be recreated if the SUBFLOW flag is set */
 		if (is_subflow && (changed & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			mptcp_pm_nl_fullmesh(msk, &local->addr);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index fbb29a9eb19125ea29f557e97123488689bfb3ce..434f59b793ef9a581ab37667fc904927c1600199 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -606,10 +606,10 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, &rem, bkup);
+	ret = mptcp_pm_mp_prio_send_ack(msk, &local->addr, &rem, bkup);
 	release_sock(sk);
 
-	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
+	/* mptcp_pm_mp_prio_send_ack() only fails in one case */
 	if (ret < 0)
 		GENL_SET_ERR_MSG(info, "subflow not found");
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b8800fd208429df43869c40e5f67f110d9584332..500c147cd4d4b4bf274b65fc9a181417fa90bc1a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1018,10 +1018,10 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
-int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
-				 struct mptcp_addr_info *addr,
-				 struct mptcp_addr_info *rem,
-				 u8 bkup);
+int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
+			      struct mptcp_addr_info *addr,
+			      struct mptcp_addr_info *rem,
+			      u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);

-- 
2.47.1

