Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F83B42F4
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489817; cv=none; b=QP+rwOb7olqb/gaejsCsMUYD50xT54Su+X5BcvoXxNMQtRgR1PGsEGACx7zVAk5eksflGvrsnTfX6aip0OCKsNEk2Ee+Q/SmL3O+6YPrceZoI42ZTlsztRBY+rSVJWWWcKPJjIs4/LpeIvBOCiPLVHRjDaSu1KLgx1As2RXsFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489817; c=relaxed/simple;
	bh=vHuEkp3XcwG+TU5aIx0BZsYFQTQd2Ht4e2kyU9nA8S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h+5KJqUtS80pTwrRastPomiIiYY0XQc6f2tSsqNQXz8f07HubWW7kR5ypkKU+eIG/V7v0dbP9J1CZAzGIcj+6TnNVZvfDIQ7vkFTtbcAbDP80E+BSZkT1wt1dsnKZoxCYz8LvWaCYmD6yYMnzhXofB/iobuu3YLAK71poMs8gq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqB2CAn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqB2CAn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8911F000E9;
	Fri, 31 Jul 2026 09:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785489816;
	bh=KSmVIbxsK9lg1LcvqJUDLSyantQ1A/HDYQ3wAY4kvdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KqB2CAn41CGwUpE/ZYpnYanmKCgZMpe3mE0HQmAK2sPAa4fDWT/UbZilUTOLd6Ue9
	 qK3Nz6zKbxaYiZRc4aHiVMNt7BslmbEAA3k5iyVl9EZRcOn8R2Q8hYdq1Jo0ygxLG1
	 XWB/kDfpeKyzXerWevyusDaNkFYgd4tV5rHjZ+qGwKaLr7BhBgx16LAqxwJqKe4icu
	 NkizCF0X+NB4urzEN7RW/rsO4gdMRmm58N3JHfTWWMEMA0B1sXV/Lxq7J+/usXVX+Z
	 kaHq87fLofti5bCQdiEK06Ii+5Tp2/dSzJd9Npw7LHIF5qCJnpMadCfCyvjwCnA4ae
	 jDYxsGkgtU/Ig==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 31 Jul 2026 11:23:17 +0200
Subject: [PATCH mptcp-next 2/2] Squash to "mptcp: implemented OoO queue
 pruning"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-mptcp-squash-ooo-pruning-v1-2-a5f5115e1e24@kernel.org>
References: <20260731-mptcp-squash-ooo-pruning-v1-0-a5f5115e1e24@kernel.org>
In-Reply-To: <20260731-mptcp-squash-ooo-pruning-v1-0-a5f5115e1e24@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vHuEkp3XcwG+TU5aIx0BZsYFQTQd2Ht4e2kyU9nA8S4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJyMqf21BVrb3hTqnY7/MmU079TrskpRC8Odd3NaDjRT
 v5Ug9KajlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInwsTEyvH5x9tChA0xpYRk8
 0V2mm1sLZ1z5xCnLuqzvXq/L/sUT6hn+WZ5YImq+5PKr5u+aRf25QVtNGl54nNdzePbkuSfvAuF
 ZrAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Uniform the new counter with the other OFO ones.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54%40kernel.org?part=5
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c      | 2 +-
 net/mptcp/mib.h      | 2 +-
 net/mptcp/protocol.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index d9bd4f4afcc0..2569385bab7c 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -87,7 +87,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
-	SNMP_MIB_ITEM("OfoPruned", MPTCP_MIB_OFO_PRUNED),
+	SNMP_MIB_ITEM("OFOPruned", MPTCP_MIB_OFOPRUNED),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 25f360724c57..3a3425e258a7 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -90,7 +90,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
-	MPTCP_MIB_OFO_PRUNED,		/* MPTCP-level OoO queue pruned */
+	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue pruned */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 90dc894cb976..f387f24904da 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -416,7 +416,7 @@ static bool mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
 	} while (node);
 
 	if (pruned)
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFO_PRUNED);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOPRUNED);
 
 out:
 	mem = (unsigned int)sk_rmem_alloc_get(sk);

-- 
2.53.0

