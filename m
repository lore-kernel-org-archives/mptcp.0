Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1137F20B35
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eh/yU4v3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702282715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95cUT96x+cSi+CvAuPYXaunhNbTq27irBepjddhW8js=;
	b=eh/yU4v3ykI8JiT0VFBQHxhBIt3E7QYQoSTk4vPmRC8FufcG3B6kYsjcJbRlLQHkNmLwhA
	7ANnQcoPho4qYlS2hnuHVy5C8or+wTJsaQ+KYCTv0mHpLEvoTnynqiBOHUEkzHVklca53H
	lyuQya+jPV/BjUojkEClPrhsGZ1wYS0=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v4 2/5] mptcp: add a current established counter
Date: Mon, 11 Dec 2023 16:19:14 +0800
Message-Id: <060be0ee5810b8a5e2d71aada83928ca704d8eb7.1702282650.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702282650.git.geliang.tang@linux.dev>
References: <cover.1702282650.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds a new MIB counter named MPTCP_MIB_CURRESTAB to count
current established MPTCP connections.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/mib.c | 1 +
 net/mptcp/mib.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index a0990c365a2e..c30405e76833 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -66,6 +66,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RcvWndShared", MPTCP_MIB_RCVWNDSHARED),
 	SNMP_MIB_ITEM("RcvWndConflictUpdate", MPTCP_MIB_RCVWNDCONFLICTUPDATE),
 	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
+	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 9b7c366675ec..dd7fd1f246b5 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -65,6 +65,7 @@ enum linux_mptcp_mib_field {
 					 * conflict with another subflow while updating msk rcv wnd
 					 */
 	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
+	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
 	__MPTCP_MIB_MAX
 };
 
-- 
2.35.3

