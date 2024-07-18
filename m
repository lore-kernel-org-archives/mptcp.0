Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946784D8B7
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318048; cv=none; b=J+uzhFVCVzTNAya2Uycp2vxsydw5A5kAQ4Yxo+acpXNFddCPKaiuS4XpWlFqq8/1/nQKz8owvdHZY/NhmWjLJEA0+pqE2bOsFZ0a8wOsXQSYx6LFPdoihNmm/+qDPQJhY2vVC6lG52tDllkcs4za2On8IeNH9FZdU9ZCKeR+P3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318048; c=relaxed/simple;
	bh=3DozdXhaVIzx/Ieb6dDuffZMch1nXiGqG38mwTcBDMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VqqnHcb9ZQRA/6eBeHCEMM3cvIsY/FS/AfOTjKRcDE6pEmilqQqyLeK6GOf9fOOgVVoDUdRu5FREsg+Jqi+bRknDNTr8tAbSaWKbAlS1FvEh+GETWq1kaDN6w68UU/XzBhhQ8MV8GKXGiM1C3dMxZtdD4mceiaOANoExumyHL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL0gpwXp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL0gpwXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F055C4AF0C;
	Thu, 18 Jul 2024 15:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721318048;
	bh=3DozdXhaVIzx/Ieb6dDuffZMch1nXiGqG38mwTcBDMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cL0gpwXpE2jteZ3C0Lyap/5GTylZgSSj+K3WSv9S7Q6Kvv4KqbUEbC1om6QCpm+vX
	 kNrMg4lzIAvHxvF+JVuMGfvgEQ6rnF3zk/VITrxNOI9S7MJoBAvbBjIJ6ogDCzGBwz
	 b+0C2EUKOm7LyfGzeARMoR0GYAaSulLxdKpsyrib+7HJugWKUOIYWi2VYyOcDMGuXK
	 JYR2ghu2qEZ+byqK3eHA92JfEGIwrZW5t5t0hhDkk0h6JXzdNpcJEjpSZ8OmQGebKF
	 OAwumPsHKowZAd51TsiHyQz03oRnb/RGtXVo6zJFv33MkNvVesjE3ydtBz6IkQzJ2I
	 69XfryZvYMuEw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jul 2024 17:54:01 +0200
Subject: [PATCH mptcp-net v3 4/9] mptcp: mib: count MPJ with backup flag
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-mptcp-backup-mpj-v3-4-1f6cd9b89ee4@kernel.org>
References: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
In-Reply-To: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3094; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3DozdXhaVIzx/Ieb6dDuffZMch1nXiGqG38mwTcBDMQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmTqbJsWv7GKDjC0mY0lCIbvekU6AqrGGhKM9t
 aVmKX/Pn/mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpk6mwAKCRD2t4JPQmmg
 c0AJD/9vyN3hZqg8CbJ0lC2lUgTUr9lMxHSRkftaaSEYgp7CLGgDUGZ7WK1X4UPF77sqnVg8DuD
 DpRjl+/rM+KJfAAEl/bawniGTujxqR4LZT4leCQ96XZErno95K1xSCOsFKTLGjZ8Sql3vZ3dOhx
 8cVIQopLx9g6yK4YoXc05z1wtPlzF3qAahKKiy4Y8wjeBqD2797LztoCrNjzRdVPCRBqvzvQ+Sw
 1Mpz7GDJlJW6ovTotupoPCVp8JM3JkxDPKemIjJnIFjVSOtJM9iqHjuRJBIhbj/ou3Xnrjn3t6I
 idntWLc0pl9J8f1E/KmqZP3SjhVvVHKymbK4+B2eGtDesBwPNAtCgbE03m5GX5igu73riKBV0Ss
 sAqvry7p1y4bX1qMcmJgt3O5zhXQAKbqOW4vwzw46fCys+Q7bnRvUg6PCQ3B2wIJiVOoor7BHfO
 BiVw28ABZVZ9vsiEWNqtCAABe+5lfcVmt4RsnD0ytK/i55/iDF7rTQQtiaJBhPppiSWt8ZiOLn+
 PCEKj3fOKlLfOysfPIBglotrhUWs2ogtFMtLMYjkY4oYXj2kXsATuQrvJqb6EH57pFJzLb0qF4Z
 2PJ3hPFRmKpwozbRAMyfdM916pkEe8dVlkK67PhacxhuxzxP0sbZG36Ycnkj0WY/ML9Z/HXMr05
 jLjeNK7EeKnc99A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Without such counters, it is difficult to easily debug issues with MPJ
not having the backup flags on production servers.

This is not strictly a fix, but it eases to validate the following patch
without requiring to take packet traces, to query ongoing connections
with Netlink with admin permissions, or to guess by looking at the
behaviour of the scheduler.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/subflow.c | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index c30405e76833..7884217f33eb 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -19,7 +19,9 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
 	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
+	SNMP_MIB_ITEM("MPJoinSynBackupRx", MPTCP_MIB_JOINSYNBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckRx", MPTCP_MIB_JOINSYNACKRX),
+	SNMP_MIB_ITEM("MPJoinSynAckBackupRx", MPTCP_MIB_JOINSYNACKBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 2704afd0dfe4..66aa67f49d03 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -14,7 +14,9 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
 	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNBACKUPRX,	/* Received a SYN + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKRX,		/* Received a SYN/ACK + MP_JOIN */
+	MPTCP_MIB_JOINSYNACKBACKUPRX,	/* Received a SYN/ACK + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a3778aee4e77..be406197b1c4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -168,6 +168,9 @@ static int subflow_check_req(struct request_sock *req,
 			return 0;
 	} else if (opt_mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
+
+		if (mp_opt.backup)
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNBACKUPRX);
 	}
 
 	if (opt_mp_capable && listener->request_mptcp) {
@@ -577,6 +580,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->mp_join = 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
 
+		if (subflow->backup)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKBACKUPRX);
+
 		if (subflow_use_different_dport(msk, sk)) {
 			pr_debug("synack inet_dport=%d %d",
 				 ntohs(inet_sk(sk)->inet_dport),

-- 
2.45.2

