Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21FD416857
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493147; cv=none; b=rJxyplVZ/7hQbI3RdnAotMxMORcCfsap3TuAd3akt75RNc0BLFVPHEkz+RBjDh6RpmnwTp4RoAl3hF8lTRLlNfyxjxrYVWUslM35a0pQT0D4cFzusE6jEll/d7etb9uOQWGZuaiyPdqLuitdHTrhCZJzkc0FD0z6kBNM6qwy4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493147; c=relaxed/simple;
	bh=vHuEkp3XcwG+TU5aIx0BZsYFQTQd2Ht4e2kyU9nA8S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RKpjdOp7JXv6SLio6SbKFi/drr7NPynMsm7d6eLM7+R56WCgRkN1f37dxZfdgaPAaYhxvG0CDIF2XgrO4rolar3CcyWTMVxesKWoZYxQbMnph3hKNKupHK9S/qXrVvaMNLKXif5YXSHwi1unnlS8epAALE+w6O1khpaTZ0XIcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6p5vYBW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6p5vYBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78EA1F00A3F;
	Fri, 31 Jul 2026 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785493132;
	bh=KSmVIbxsK9lg1LcvqJUDLSyantQ1A/HDYQ3wAY4kvdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=T6p5vYBWFuqU6aS/WPCla0CYjU6WIZ7ReiUsTrrrd9Dxm6gLiRp+0bI919Tcju4ce
	 67NvNwjI1yXdgIBWtOqCblsYmLUGhxLuM0D+C3o9bn9pg5bCYS4qv+pi/ctDxJv1u6
	 A7plEAA8TdydwQyXUsvFOtzNz+t2met41bG7pdkPIyeLd7k5x77sPdyYkC1rbSN0tf
	 /BeKY8IffloFhGXbMu7GZEKsbVEHbPSv6h/5k3S9HOmCIeodmM1mN+Ik2o/sAU5awx
	 Y8NvieW8ENjd9UppM3HeAjKRZRv6St3JzTdneSO1XWPTjdj7jhY9db2dMOPcL/0auk
	 jwgL0IkD2WZwA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 31 Jul 2026 12:18:44 +0200
Subject: [PATCH mptcp-next v2 2/2] Squash to "mptcp: implemented OoO queue
 pruning"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-mptcp-squash-ooo-pruning-v2-2-499a523bbce3@kernel.org>
References: <20260731-mptcp-squash-ooo-pruning-v2-0-499a523bbce3@kernel.org>
In-Reply-To: <20260731-mptcp-squash-ooo-pruning-v2-0-499a523bbce3@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vHuEkp3XcwG+TU5aIx0BZsYFQTQd2Ht4e2kyU9nA8S4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJyyjoDT3P8UCrnu2JwNX1Nx9buukO9OQmFASx/i4sru
 X+mfU3rKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmMivGkaGLaeyD2aqfM4yW7qB
 aVnF1NPWt2RveJc/kfscdOH/vvb71Qz/k61v30xTMb3mX3N191VbkyC7s8p1F9+Ud5ytfRf5XFq
 ZHQA=
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

