Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3DB45349A
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109170; cv=none; b=vBnWQUgK4UgILSu+KncggtDmK18kIEyDvekeROrK1SnMh8H9g9ue6ZoIJLBsIlixPaTq4XrOSRalWYgIm1cBw7pMIVE8NmhrhTvWaoebKA+jO57lH5NTTZCulb292PtBdVCy3yFappIMr3DXqtagh6rSyL1p9waATEuMZmfdnVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109170; c=relaxed/simple;
	bh=GQQnEGHiR2G5W85vjFnmPZ8lxi/uhPksmlmXAmDyTQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZd4NiW931zU0+0wskPKlUEOsv8BLWZUaeop+xcgWfMAVdntYrTVFyVPimppikf+PX9/hu6vuSL+A0QvVIAyYXCZQwjhXMVgoTfdrKZurBW4JXI7Q6G0cYwZ6u0OgwKBP+t0xNIblvXCB34EAJ5JZ5wtw64ZdoroAGJEjYBN4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDioGUnn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDioGUnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1E3C2BCC6;
	Mon, 18 May 2026 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109169;
	bh=GQQnEGHiR2G5W85vjFnmPZ8lxi/uhPksmlmXAmDyTQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oDioGUnnnFy993lWZwqbrx7/4qloC+PaS0+2eb1YtwqAB3sSGXS/vJw0SDHB7M/Pa
	 Wd7Ii9+5IIqnt7TT04DW1ZU3jhSlg10EdhbRBIMKYrvi7OksmXkZYHqAN5nkBZd35f
	 kCgTUcm3Q+tBE43QW4CgRex61Jo3kj6SMaNp+R+brXU6+G4pW6HrTnrNK77wWrAPFD
	 OF2cjf8Ej7p/MHF3l7d/NPu8+KWAz6ABZNSbBFDwmdFXTUB96Ch/NfT51G+sbHT5Zt
	 MBEKimql6086FQvFeE/arPwWhUM2s9xFWS0ADEX0O/+iSm/E91ng6DPk3tb4bK6ql/
	 p2kUsbMwC2VIA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 May 2026 22:59:14 +1000
Subject: [PATCH mptcp-next 10/12] mptcp: pm: make
 mptcp_pm_add_addr_send_ack static
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mptcp-add-addr6-port-ts-v1-10-f1ca26977fcd@kernel.org>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
In-Reply-To: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GQQnEGHiR2G5W85vjFnmPZ8lxi/uhPksmlmXAmDyTQE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqCw0hUixmFw7gUZb4woM7/+D8RxRwhRcf/J5gr
 vTnruxiBZiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagsNIQAKCRD2t4JPQmmg
 czQXEADKmXdRkLgRMJYK/Xo8qY7PFteXwgZnKepsIouIWB7CHPFV3u6OMpoIqtDHEqG2HC7V/tu
 C//CCpDqJx+o/wcCBSrG153pR55utdOm1h8cjE8YMAOAI1YvH0dvAHnwoU/HCaLgo9FiIn5pbL1
 YAfdvdnJufTIwazgYApvXyRidcYOxV+V2CB6FjDHrXSbcLLxWp/gwV2hl1TGe0p0unsZSNGgzKW
 JunpKpUALx/hJWCGecfU04cpWd006NtxdNcvUd0sYP5thMfU9lm7yGtfXSzPtLaV5vxCMZczOKG
 s+/hhawtPcUxb1Jfn1IcTkcoDCLbzl1t7Z3+ldEopkJZL3B5rCelfEQqYiyfVIC7+cihbH/OsrD
 cFlLu6W/e5jsh17P0f1GIqb9y4pucsZwnjDhXSjB5wSIC2chyGCI8O0yyBWP5mjGsXII3VmEG4C
 ChY2oKwwVng9pNICr/ZEfYMwaNEPFQW7mOejH5XjvP/L5Lm6+DFn1dwtgAxc0AdV3jSJYZAyQbl
 814ouE698aFWnNwdon3YYj1K0lNmq5PlLDoBZYMFG8+mepNbUkVXHOaC/ywA4llvOwvnf5jPzy9
 3d66hB4R3z27e23IpHTWh18WzTkJeABi/yw5fQs9vNGIIhhmcVlQ9lqkIjm/wEiF8drLlagcX2I
 OPOvp3XeiyILpOg==
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
index bbf89074a31d..ac9342f6e7b4 100644
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
index 885c5722d79c..448ba565611a 100644
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

