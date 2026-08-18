Received: from mta0.migadu.com (out-167.mta0.migadu.com [91.218.175.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE62E41B354
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044469; cv=none; b=bxptDoVca4CKXuMWaG/E+UMNpW7c70rvWPnfbLp8iMJFKCIeN8MBGPyCTslWtrTurQlTDcx6CEWMAQtfVziuFML2lwy66WGdDOnpDB/HSEiTo6GtNBABBhApByLFlJN2Yy+O1CrS+bmCLut3QwkqhqTz1MJSGWV+WbFCxLeIOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044469; c=relaxed/simple;
	bh=gQ/r96649+HxdrOBIVmVKoPWGJNkZ30qmqEWGiQfM+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TziLUwxfcZg9f+YU3rXD9HSHWruJ/vhfcBqQHZB62JpWH0fI/qBkvAzzowfabZcWR8UbkxMEvllJaNmTDxLHIeTCZI1rF/rWDKI4rgAJ13Vnbrw8vJzm5hMLZmok9qHIxp86MgewwrngYAJlglc5LGOnhYXKinJ7fdb5FdP1j+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ao7UnHh2; arc=none smtp.client-ip=91.218.175.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ao7UnHh2"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=gQ/r96649+HxdrOBIVmVKoPWGJNkZ30qmqEWGiQfM+M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787044462; v=1; x=1787649262;
 b=Ao7UnHh2VpNLTMt9GNpYVzgbakSwB7WgF0lE98uvxQmxoA9NFNmEL5s7T2g7KV1vZCLHxHdh
 ZDJbII8aUaehcwhmyP3kVANGvovuKZD7bdwmHNfaUDEJN2wyr1AsMMGxXY/DgYjfmqUoz++7s70
 1vsUzdUPNrhEMiao/AEzFEAI=
X-Envelope-To: mptcp@lists.linux.dev
Received: from localhost.localdomain (240a:4281:fe00:1ace:7fcd:c486:d361:c952)
	by smtp.migadu.com with ESMTPS id bfad146502604034;
	Tue, 18 Aug 2026 09:14:22 +0000
X-Migadu-Flow: FLOW_OUT
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH mptcp-next RFC v4 1/2] mptcp: add MPFailFallback MIB
Date: Tue, 18 Aug 2026 17:14:16 +0800
Message-Id: <20260818091417.2200986-2-chenguang.zhao@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260818091417.2200986-1-chenguang.zhao@linux.dev>
References: <20260818091417.2200986-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Add a counter for TCP fallback after accepting MP_FAIL.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/mptcp/mib.c | 1 +
 net/mptcp/mib.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 608cb568897c..648d4dbca764 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -88,6 +88,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MD5SigFallback", MPTCP_MIB_MD5SIGFALLBACK),
 	SNMP_MIB_ITEM("MD5SigReset", MPTCP_MIB_MD5SIGRESET),
 	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
+	SNMP_MIB_ITEM("MPFailFallback", MPTCP_MIB_MPFAILFALLBACK),
 	SNMP_MIB_ITEM("DssReset", MPTCP_MIB_DSSRESET),
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 1ebdb55e9534..075e21e20a80 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -91,6 +91,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MD5SIGFALLBACK,	/* Conflicting TCP option enabled */
 	MPTCP_MIB_MD5SIGRESET,		/* MP_RST: MD5SIG enabled on listener */
 	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
+	MPTCP_MIB_MPFAILFALLBACK,	/* Received MP_FAIL, fallback */
 	MPTCP_MIB_DSSRESET,		/* MP_RST: bad data mapping */
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
-- 
2.25.1

