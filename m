Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9730F803
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513622; cv=none; b=KgvecSc3txh7YIC64nRUV5n9BteRQplB9kkT0SavU2lfEjh7w9NsYSO+TEHR91lMf/apI0n3YEcAIRouaiLyfpNpDi1ff+Y53k2xSQ24qe5feq73/pIUYhbqfcvTis7yi6CPvEaMNSoQa9bLx4skDYwtWqXBpGCp+t3sXsb7L9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513622; c=relaxed/simple;
	bh=ny3cZ8TlxLQpxtGaAgCFg3bihGlhEXROx0R1iRCODtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZbkJpmUKAUn0AoEziJxRJ3Fs/oi8SKUlhbuE5cxhuMj8rnndtVUDi+RDqQ8X2D6r8U6dVmhkbngzwziWOXVRVU8qM/DOVDFj2X4Y069nPOUvuOu8UEoCiw1reDvtTMT5PF6j4Psi8Qb73Nkh0+Kbs9KzF0TNNBQl0wqBSjAbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ju21FnJq; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ju21FnJq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786513618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7ph7KvdAEdONiEXTCOn+oYhZc/rRMlUhbvZ9PQYdbs=;
	b=ju21FnJqROLnlQmLi0jS0hnEa832/hGlGg4/n1kepciuc9mRrTle+Ac3tb3W/090fa6wMu
	4xjO0DEnK3gMDTz8/FofgXplppiS3+RzzmN/8IvFCZUyt8jPHVh9lLgjCAZaq3+eS0uojn
	TLPV31yQfyFCbb0MvPkiQFChkZtIHpY=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH export v3 1/4] mptcp: add MPFailFallback MIB
Date: Wed, 12 Aug 2026 13:46:50 +0800
Message-Id: <20260812054653.43799-2-chenguang.zhao@linux.dev>
In-Reply-To: <20260812054653.43799-1-chenguang.zhao@linux.dev>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Add a dedicated MIB to track TCP fallbacks triggered by receiving
MP_FAIL. A follow-up change will use it from
mptcp_pm_mp_fail_received() via mptcp_try_fallback().

Fixes: c65c2e3bae69 ("mptcp: track fallbacks accurately via mibs")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/mptcp/mib.c | 1 +
 net/mptcp/mib.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 608cb568897c..3e1bb4ff07b7 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -90,6 +90,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
 	SNMP_MIB_ITEM("DssReset", MPTCP_MIB_DSSRESET),
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
+	SNMP_MIB_ITEM("MPFailFallback", MPTCP_MIB_MPFAILFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 1ebdb55e9534..89ebf7086cc6 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -93,6 +93,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
 	MPTCP_MIB_DSSRESET,		/* MP_RST: bad data mapping */
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
+	MPTCP_MIB_MPFAILFALLBACK,	/* Received MP_FAIL, fallback to TCP */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
-- 
2.25.1

