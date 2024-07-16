Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2A6BFC0
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163207; cv=none; b=K47rex63eUxs7+XJBm2phY8K0LuayrE+vS8jOiC3HBw8jCDdqK3tLFynplv9FfkI1uiZmvop6ZL8v6R9yKD2LXmvmiCHBQiGOq4NnWHz3yhYxYNLUHkUzeOn8dg1+nvpYaLVs32TQ06gBMap04mgfnI27ZRZXMPOxy4IHCvGbBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163207; c=relaxed/simple;
	bh=3DozdXhaVIzx/Ieb6dDuffZMch1nXiGqG38mwTcBDMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQPC4A+I+HFiuB0avmW74lnczO+wnd8m7Ii4vRhIkh8NdC/VRAU2jd+oh3Fioxka8aKTuSRxHSUIclErl4UDjTvYlim3f6HY9Zt0p09YCSmn3/VNFEqKI4CugBypeqeja08YwZDuEASeM1oWRcG+F8lbIRd5xUtQ62oKXaeCtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx5VaC8t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx5VaC8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A963BC4AF0C;
	Tue, 16 Jul 2024 20:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721163207;
	bh=3DozdXhaVIzx/Ieb6dDuffZMch1nXiGqG38mwTcBDMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fx5VaC8tI2r0FkKOth6H5Uo8LpdvO94S+1ZGc/qQH9zu5wBHEV2157A46DxXqjckD
	 CIMwc7KqgNYBhved95sZrUTyGtBN3tM0qwg83ShrRWmJIjprItms02BD/MVq9zq/qr
	 aPPtTbYW/J3Wf5aRYJN8eCOOojCYpTIVVgEiVtChM0KEJ9o4cDZbkMrTAUvcJTGefu
	 NA+ah27gb+IpbaCLIsyvjDX8qoNEeiuCFL57sj51B8j4DJmV5TIzEMwBbG6o7mhMc3
	 k0vUzC9TFpwev1UezZHz7IkM2+WsjpbFPiXK5V+8jVO6oMaEoZ8Pi7OvHteZ7hJ44A
	 tAIkoqGG0eL0Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 16 Jul 2024 22:53:16 +0200
Subject: [PATCH mptcp-net v2 4/9] mptcp: mib: count MPJ with backup flag
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-mptcp-backup-mpj-v2-4-4d50247405fb@kernel.org>
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
In-Reply-To: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3094; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3DozdXhaVIzx/Ieb6dDuffZMch1nXiGqG38mwTcBDMQ=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGaW3cGi14XigsHAhRV1/10vTWbVX8FbdjZKhJqstsA+GPfdT
 IkCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJmlt3BAAoJEPa3gk9CaaBzJJQP/jFM
 heYIf26rf/ZG+cevOozmJ4r24+7H5+sY0WYs04WIKuq+HFA+ksZqIRDH8v5JNkaD0qqu1VhHw1x
 eUn6UCnEuMQLqknTzU7gNR498e8ZC/Ie4o12GKChwq11v9sEv+1ejb64hSEe4dnN0CYK/odJmyn
 BlYvStBV0UVOaG1TtvIiuZxWA1gI8lzikPtraWmdR1BFc75HUtyR4VhHukiM7OQ8IlcOWVLohbk
 /noJDXZYS43l53t+lG8c6z1WYCQDnpy3ksQqXbG29+NH+hH64SH1V6Ax97s3QArm3zU9WOkz4bY
 my0S2qky/xhL6dwCAqmQyZvvA1J4riWd1QQ7GdTLgm6VkDnW+h3Y4KR1Gs7cs0lvvayY3ah/o7p
 XRxPU/apjW1mqoVEYnZqbs8nm3ycdcucSB7pR7yoaIZrObS86c7/5qjwaTqAfBDkrXyOuL9K6VS
 +obo+V7t2tegOBnLr/G1BmhOO2hcuOGo7JQhyF78PmN+XrD0yndqFNfp7YzsKEjnkcE/Tmlyoxo
 TRU66xD0txL4UNkHkSFXfX8qFJKf/GLQZ/9Qz2GySdY9BQ7edNdP6KbU6+9CGneDs8Znv2RQbOo
 2Zg8HrXKfLRS/9mqYmqxQiwWuWKWwXj6PUuxGaynq2pGtmJiFXxGn9+q50eo55RoxjA+bXXE140
 Fe+sG
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

