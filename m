Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3FB3E5EE8
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225944; cv=none; b=dBWxqA9z/KCMs+2Tk6ZFyQAHHK/bm9YQYhsbivzAz3kFTwg70E36pWx6w+bvsd+9N15ZjhOoYJiMCiQO+/d7ZWxXzf2kJCDEkRcbXwlgPYp8Mu0itBcoOLS/Z3ZUwzuL6ZwSRPay8iaaA04EdnD+LILfIRsXf9jQWsm6ZPUD3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225944; c=relaxed/simple;
	bh=N2cWfBo6wQKdWA1g/sCtdjmluldFfivRaOMnkgBQCw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CyQIyH099m6mynNkh1Bud8nNovNdsqrJpgfDgJ7VEaNumfuDeE24+/Mo9U4U90FeEyvcgrVCo5b4qL8NLZbeMiOR8FTAKKXgKExAEqPrDvr6kvjusZA2ecD1K+IE7PYa6oUaoFXM8YsfYqpWvjBzbNx19f8E4DBNSjgu4zVqFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkVDMJKm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkVDMJKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAAF1F000E9;
	Tue, 19 May 2026 21:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225942;
	bh=USqrqqY0HxyYwr4v8e74t541pjv1sInsrgG2puRj9fo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kkVDMJKm8bH/K5V+5CTIzWNUmj4+wCnue7fvI82sjQM9pa+0sdstknAx14k/vS49D
	 /kYaricHW8ws2WKaWiHampO+Jd6NzdgIVZT1cNEQdyII2TMCTOMX/1bq1vSyOP0c66
	 frtDYNTu4b+Vt8j4T0GE8swfzvS5DS2DuuhlO9DKDbAfa1CT5PBysCAWHrIoThhB02
	 aWhamFXp/RJTatokHbNTg59pxwDAOadFC1dkFZGLp6eMBgYm+4t9AGRuxpmPPCyPt6
	 R7M85b9zRPpg+oeSZ29frd9fL7wiNytuio5mkuX0v72Q/1zQEdUbt6GqNuroRI8hiq
	 F0+9vz/iEmePw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:25 +1000
Subject: [PATCH mptcp-next v3 14/16] mptcp: pm: make
 mptcp_pm_add_addr_send_ack static
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-14-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=N2cWfBo6wQKdWA1g/sCtdjmluldFfivRaOMnkgBQCw0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVB+SkM1az5T3gwnhKk+zF2CqDMLf3WWH/tE
 AEqgN97DJKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQQAKCRD2t4JPQmmg
 c9a1D/9kO2zch8qnazBZ6ZYv36TU+sr+kAFTJNEl//RPasCp6dy8JDeaN74aGq3VYhV3epWc87O
 rlabzp6SNq8EU+VUQLjC6XjZu/q+ttWHyaqsRiGIBCwVg1E1c3NFUlpqMMK8T/8m9/AVw4nyZMW
 7BoOmu5mxwnV5lo0san5BHme6dMmzvnCd3R4pCW1OjuOAbqFBYB3we1O6GbAs+QUAc8uZFvgct5
 GSVdPObR2wIp8b+EpimmoBxsYmA6FZ2d18iEyEVy9MpRg3o6NUSdVSdMyrxjMda4kJPrmxjy5lx
 McmWMIop4W2OeMN0YP1ogUPGWoPSVWUD47enrrE8IevqM+ULJSkOcFerympIwOzJzdBmsd9nFId
 hbe4jkh4gRhnpExWBrxHzpBIBRCljTHWtjgc6/PJ5DKT3HIlNaaZPaxEPjQUimx1M0aiTe2pldu
 E431zwaSzQcGg7JMmG4WIxzRNJEhr4IK7tCxQtb4Raiq3Avyjhvl4nUvFLmTGkJ+AlGt7wBZtSS
 zqxUPG9KuIns6QQeb8iRlguO+D/IqIgqutxLa1qZPt54YUsCL8T9ce1CGh5Ml8gZGDkHCXVbdWU
 dYR8BYDjd6he7GNk6ZicyBUqKjQ2CWAIJ+aZ6apCPSHsBlXoWahbrtAUKGIkpg4+seSgGTbNiSO
 DKO4LwfM87JmczA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Only used in pm.c.

Note that the signature is added above: it is easier than moving the
code around, because this helper depends on mptcp_pm_schedule_work which
is declared below.

While at it, explicitly mark it as to be called while pm->lock is held.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c       | 4 +++-
 net/mptcp/protocol.h | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d3469d3b95c0..7af4affa8ecf 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -226,6 +226,7 @@ static bool subflow_in_rm_list(const struct mptcp_subflow_context *subflow,
 	return false;
 }
 
+static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 static void
 mptcp_pm_addr_send_ack_avoid_list(struct mptcp_sock *msk,
 				  const struct mptcp_rm_list *rm_list)
@@ -743,7 +744,8 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
-void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
+/* To be called while pm->lock is held */
+static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 {
 	if (!mptcp_pm_should_add_signal(msk))
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d501cd625362..a0d2d72a5401 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1117,7 +1117,6 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_send_ack(struct mptcp_sock *msk,
 		       struct mptcp_subflow_context *subflow,
 		       bool prio, bool backup);

-- 
2.53.0

