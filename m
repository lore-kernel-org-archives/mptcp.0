Received: from mta0.migadu.com (out-77.mta0.migadu.com [91.218.175.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC232381AE4
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138471; cv=none; b=oZu2pFmaCjIuyqLxEJ0j6seMoi7qv4EwVccHbd0SEKTIdwLsPIPwz6yAua0oGIMbjEZwUW9jR03DoBPs3h5NrEUD8hZlxePuogTlJq4hUV9zZy+tAyvEKTE/iupu6XdR/7nK2uSLp4zSyCxRZMjKamgn1baVSjdHSsJHvaGXu2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138471; c=relaxed/simple;
	bh=t1Sq3c7qLYZ819/+DuoQs5UCwgaZIvwkDQPGOcNtTV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8IRk2HJgojp811UJT+1Vbv2j4SlO4ePUfztid0Wz+hhdp1Ap3hDUuQEa6PKjrQhsh43mdF/A2HRByWMT8Gbvcre7d5pMgctrX9dnUk3KZXo/f24rSYoke5BWU6WRa+4qbOhKgKbuQPBzdpb4as967jH62ggTYDlx4i4gAwap4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OqvFNLiL; arc=none smtp.client-ip=91.218.175.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OqvFNLiL"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=t1Sq3c7qLYZ819/+DuoQs5UCwgaZIvwkDQPGOcNtTV8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787138467; v=1; x=1787743267;
 b=OqvFNLiL8uRA/09CNz5P4SYxI4soLuC8oAP6cH3/0u5FY6Wmj9rNNI1qFxr1bCcglziGejT/
 zRZnNHvelPIzXq5g1uqpbhgbgNdEo0PcczTvb4jymeTdYPSqnzQjbSjiuTxTEAK/wXYVqW5wsnm
 36uVHTmGKIZWzkUj3wZIodbs=
X-Envelope-To: mptcp@lists.linux.dev
Received: from localhost.localdomain (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 87614ac4fac36c1a;
	Wed, 19 Aug 2026 11:21:07 +0000
X-Migadu-Flow: FLOW_OUT
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH mptcp-next RFC v5 1/3] mptcp: add MPFailFallback MIB counter
Date: Wed, 19 Aug 2026 19:21:10 +0800
Message-Id: <20260819112112.1985121-2-chenguang.zhao@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819112112.1985121-1-chenguang.zhao@linux.dev>
References: <20260819112112.1985121-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Track fallback triggered by MP_FAIL reception.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/mptcp/mib.c | 1 +
 net/mptcp/mib.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 608cb568897c..e1211ad621c9 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -91,6 +91,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("DssReset", MPTCP_MIB_DSSRESET),
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
+	SNMP_MIB_ITEM("MPFailFallback", MPTCP_MIB_MPFAILFALLBACK),
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 1ebdb55e9534..b006fc8cc848 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -94,6 +94,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_DSSRESET,		/* MP_RST: bad data mapping */
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
+	MPTCP_MIB_MPFAILFALLBACK,	/* Fallback after MP_FAIL received */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
-- 
2.25.1

