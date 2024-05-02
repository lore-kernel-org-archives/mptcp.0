Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306116FF2A
	for <mptcp@lists.linux.dev>; Thu,  2 May 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670599; cv=none; b=nAf1FOIh3UiUwF4OWI2ZsrczShuHedWcaGnFq1A6Qu1W8ddS30s0+LlFGfLj1lGyr4YioIFxG3Ek7x3/PC2pxViE4sKlAEmOS333EfLrl1WAbmDlwOaJtssl9KGU1jLJeNzBZtmSJ0f4ArYGcgM55I5HhSkRweQGMzNDi4dRA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670599; c=relaxed/simple;
	bh=bMiCs/gqGEJkKIh2cpuKospUiWHyYgh2mjYUnA4KrTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R0ylwHmBEGVOiDGXCVdljfxfGfP6kHzu8akGcDNFrkwiCMj/FwjtFw6QwcQWzf1b7ooge/+KjgNlYGyceQbQ4FWIsdQ5rPSGTd5lHZspfcKqnU7/xorUmsdNlE0fjLCo6AsfH98bFhl7TkKvXDdtHy47cTgTRaWD9HJd8qCsl+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh4Jnkdw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh4Jnkdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D55C4AF18;
	Thu,  2 May 2024 17:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670599;
	bh=bMiCs/gqGEJkKIh2cpuKospUiWHyYgh2mjYUnA4KrTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eh4JnkdwSwQ86g3GJdQ6V1W0mnTAGFnD/vkHhO+jeeVGAZ3sLKcP8I0Bv91KpXZvW
	 wKIZC0h0WXGTzrteRAM0mfMmHkm7TAVSxYBozhxq7VcFT9nauCOMaASVCTcOLdTH/p
	 lUyReFtUjqDdG9m+XGeNzS/q05w5coK2p7h0gH446jDjkZilw563o6yyO05FsVJovG
	 3tAzJFjiIGJd0zRtt1vc7DBNIAyF+Ik7N3pMCGzon4Ms2vWfXwoOKQgQPmkFE+xjlK
	 sJ+LpGP7BsuqaKYdZFtjF+gh/jqEfj+b7riCA3hXRKHJ0xWTUItDBnkSh6g01jGwkA
	 F6Kq5RUWRs/kw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 02 May 2024 19:23:04 +0200
Subject: [PATCH mptcp-next 1/4] mptcp: prefer strscpy over strcpy
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-mptcp-cleanup-clang-checkpatch-v1-1-a2b46c0a6bec@kernel.org>
References: <20240502-mptcp-cleanup-clang-checkpatch-v1-0-a2b46c0a6bec@kernel.org>
In-Reply-To: <20240502-mptcp-cleanup-clang-checkpatch-v1-0-a2b46c0a6bec@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2616; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bMiCs/gqGEJkKIh2cpuKospUiWHyYgh2mjYUnA4KrTw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmM8wE4GQ8rYki2F9gZq7f4t/gm5pDo8MG9m1b+
 Ax9MWYdBLWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjPMBAAKCRD2t4JPQmmg
 c0uUEACWCBLbeu2bwDW+fvwIvFFgscixhSnCk0cb+y3T2n6wDVHhr9lEjIZ0A/kARyEU6lyNfCJ
 swgJ7HPkUL30k1i76Dib2d6f4h6zlwqnOj8gWKV2jbi9pyJv5EISnjbUnQ0koKSesDe4AUyCS4d
 JxY6+aWEbzX3AoHSm9rjCpfqP7IeEJSQ96czGSYqxSouxjPzlQcHh7r/mJu2UAfa5Ajyyo7w6G+
 BHGlIRTsNIbCyWPv+E4vNGkVi1q13pIoWJewihv9d/qCvsP6k/T5lyaCWa4PcJriGngwCcXd05F
 vqQl8/d2tdEuuRVJiQjc9nqIs0lS/qpgvH3hk8evAqswbrUq2D2Hyx9hZVlgk38VbCZEUuRg8SB
 4bPz7Daa8Ie48SrY7yD7T8+0jcfp0So6p/pelfwYkhNX+ArjvVNgMIlRhQj2Z7TpIxJOEyrg8Ea
 U5SmV37F9Kc3kSbh9coOwuf0RzivmQVXC09fbHK1WkgMG4+tRAR/9f6rIA2t9WDi5jdK/HVCQJf
 MhUWLDZbW5QrtYWnqKWxX0aJDrPr6ABO4OQjsG9BekwtEPWa1eNB9KT+lGquvA71Zl8rwA1vR/X
 NjV2Rj2EkNJfaguNcB231kvtnJJmzGGf9GxGGr5FTXilq6vCmawPpmj1as2Q1p/7+4qxw1aYN9h
 nHcpDMh4RAFBt4w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy() [1].

This is in preparation of a possible future step where all strcpy() uses
will be removed in favour of strscpy() [2].

This fixes CheckPatch warnings:

  WARNING: Prefer strscpy over strcpy

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c     | 2 +-
 net/mptcp/protocol.c | 5 +++--
 net/mptcp/sockopt.c  | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 8d661156ab8c..3d9d26b29bcd 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -92,7 +92,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->allow_join_initial_addr_port = 1;
 	pernet->stale_loss_cnt = 4;
 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
-	strcpy(pernet->scheduler, "default");
+	strscpy(pernet->scheduler, "default", sizeof(pernet->scheduler));
 }
 
 #ifdef CONFIG_SYSCTL
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 62403f93c4d7..579031c60937 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2814,7 +2814,8 @@ static void mptcp_ca_reset(struct sock *sk)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	tcp_assign_congestion_control(sk);
-	strcpy(mptcp_sk(sk)->ca_name, icsk->icsk_ca_ops->name);
+	strscpy(mptcp_sk(sk)->ca_name, icsk->icsk_ca_ops->name,
+		sizeof(mptcp_sk(sk)->ca_name));
 
 	/* no need to keep a reference to the ops, the name will suffice */
 	tcp_cleanup_congestion_control(sk);
@@ -4169,7 +4170,7 @@ int __init mptcp_proto_v6_init(void)
 	int err;
 
 	mptcp_v6_prot = mptcp_prot;
-	strcpy(mptcp_v6_prot.name, "MPTCPv6");
+	strscpy(mptcp_v6_prot.name, "MPTCPv6", sizeof(mptcp_v6_prot.name));
 	mptcp_v6_prot.slab = NULL;
 	mptcp_v6_prot.obj_size = sizeof(struct mptcp6_sock);
 	mptcp_v6_prot.ipv6_pinfo_offset = offsetof(struct mptcp6_sock, np);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b0d1dc4df0c1..2edaf1a16005 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -618,7 +618,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	}
 
 	if (ret == 0)
-		strcpy(msk->ca_name, name);
+		strscpy(msk->ca_name, name, sizeof(msk->ca_name));
 
 	release_sock(sk);
 	return ret;

-- 
2.43.0

