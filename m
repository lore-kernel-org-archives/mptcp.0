Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67004D517
	for <mptcp@lists.linux.dev>; Sat, 18 May 2024 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716047580; cv=none; b=mZ3ExU+T9dU13dEgsqWK0ow1RPWMaMkjFAJgbma03i6SajLDYRHnjP5Xx0uivPG9hb7BP5Y38SUgMyYuEVQ7rZ/XWGE0joUGWV0AZE+9zyx7Hks1RBNla1eoOzen+S6BnOJ8Eh0veqQk6PRxrsDGEV61KzjmAWqPA/aooWsMy1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716047580; c=relaxed/simple;
	bh=l9P1LJpRFXGmNv34bk5f33fH/TJc9InrPPq2VO+kELI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B1KK0Ih6eH2xmz75oczdWpoLR2lSiuovKFOlCV4jZWHUnzxh8s/r1QMw8lEdFPu2tBxvqAtVoFTu4knh1SB5ZkTvgiQrP9tLMZFg0I+kvwhMAcpORT1+VRLlOwps8JtAS9IFHWHgjXRxKWPBuAHRZXhHedILmBfG/nuQriSGSLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auf9c0z9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auf9c0z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14C6C32789;
	Sat, 18 May 2024 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716047580;
	bh=l9P1LJpRFXGmNv34bk5f33fH/TJc9InrPPq2VO+kELI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=auf9c0z9iaAl2TxPYKttTF2XebIbyjcU9mDR5sPsGeKF2oVoutCi0yfbxCIo/keAm
	 QMsPzWcr+9f48g6kbGXFH9H0eaMx42cbYN6WEL6J6cXZWe3yxgWWL2NtZ0M3VMFaMW
	 /7jD0C28rpNWZ9iPR66QvcFzmryMQlvriWlQd6ahaSjP+tsVWCma8cVAotn9HyA9so
	 C7lUV9bFLGBvTban5fkTFcKvYEu0MKBCQMza8ZISBDBlxFV88KDyaxpUArxAXzQPez
	 ag8LayCzxt/JXHcj2egR8PI4dBjCz2duLRe8zSIw0dr4ubZGvoCWD2nyhtqVUqQOSy
	 mKC3neY4aWjvw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 18 May 2024 17:52:42 +0200
Subject: [PATCH mptcp-next v2 2/3] doc: mptcp: alphabetical order
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240518-mptcp-doc-v2-2-68304a17cd7d@kernel.org>
References: <20240518-mptcp-doc-v2-0-68304a17cd7d@kernel.org>
In-Reply-To: <20240518-mptcp-doc-v2-0-68304a17cd7d@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4118; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=l9P1LJpRFXGmNv34bk5f33fH/TJc9InrPPq2VO+kELI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmSM7TVo1Rgga9+q086aNb2SI+ZXrECCTiNrdvk
 w5P5v0QaoqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZkjO0wAKCRD2t4JPQmmg
 c4KKD/9kfkcKxbVmKXT8rnUcqrsOcEiI8aroT+UaHiASbe5757vGo/Ie/KKLeUSELVV06KeHjhc
 EoWOBSxP8BRriMmdNMt8Obid3TqXFW/8CGcv/PBG7PZRI9i0g81FvH3F+dJ/+waKZc0HdyiAgYR
 jpgeVVdMUb1zc70fhPQ2pqqmA6ppgpcZTNLvyMEsxwUsuLKPKUIqAl82yEeQ5w3k2rNSwE0gkHp
 9DirZa+Ror89W192wPSTRkjRX/Hjju6jCGXB6vZtfB/++2GVr+7smU8xj69VMf67ueI+4K5pEVQ
 jOWJNZoLBjbF3eGmf6C7+BdjSLeJiO9dcm2gGu4jh2J76WKeGlmy2AWQflMbUmonAgbC/63gsn/
 JTyerYn94GIif9BFlhFsjbjYHr/LnnIcBBIS84CGJ+22sEvajb3J+nvFxyNAmhZHUZOT9i1wGco
 i78cn8Eh+ePXmAquNI4yocq3hUmPbrz6cRpLNIiZOd+R06TtriSCNrDFwe6iLPaC1ZLyfKFGSoq
 l+lrFfqlReKUZktCMMuTGP/+L1Y61+rWVCbMQ3Oobw4UwgOl5Ncq2oPbJuzlpvQ6UjzIRKf8S0e
 WMb/xqBjJUQWmtmovzckWoMmjtZs7+B8cO0MRrQ4oyUBK8FAmdXWHyCSb5UY0SD9M8b4IO+CCnT
 Xo6airE1mDRJvKw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to what is done in other 'sysctl' pages: it looks clearer from a
readability perspective.

This might cause troubles in the short/mid-term with the backports, but
by not putting new entries at the end, this can help to reduce conflicts
in case of backports in the long term. We don't change the information
here too often, so it looks OK to do that.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 78 +++++++++++++++----------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 102a45e7bfa8..fd514bba8c43 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -7,14 +7,6 @@ MPTCP Sysfs variables
 /proc/sys/net/mptcp/* Variables
 ===============================
 
-enabled - BOOLEAN
-	Control whether MPTCP sockets can be created.
-
-	MPTCP sockets can be created if the value is 1. This is a
-	per-namespace sysctl.
-
-	Default: 1 (enabled)
-
 add_addr_timeout - INTEGER (seconds)
 	Set the timeout after which an ADD_ADDR control message will be
 	resent to an MPTCP peer that has not acknowledged a previous
@@ -25,25 +17,6 @@ add_addr_timeout - INTEGER (seconds)
 
 	Default: 120
 
-close_timeout - INTEGER (seconds)
-	Set the make-after-break timeout: in absence of any close or
-	shutdown syscall, MPTCP sockets will maintain the status
-	unchanged for such time, after the last subflow removal, before
-	moving to TCP_CLOSE.
-
-	The default value matches TCP_TIMEWAIT_LEN. This is a per-namespace
-	sysctl.
-
-	Default: 60
-
-checksum_enabled - BOOLEAN
-	Control whether DSS checksum can be enabled.
-
-	DSS checksum can be enabled if the value is nonzero. This is a
-	per-namespace sysctl.
-
-	Default: 0
-
 allow_join_initial_addr_port - BOOLEAN
 	Allow peers to send join requests to the IP address and port number used
 	by the initial subflow if the value is 1. This controls a flag that is
@@ -57,6 +30,37 @@ allow_join_initial_addr_port - BOOLEAN
 
 	Default: 1
 
+available_schedulers - STRING
+	Shows the available schedulers choices that are registered. More packet
+	schedulers may be available, but not loaded.
+
+checksum_enabled - BOOLEAN
+	Control whether DSS checksum can be enabled.
+
+	DSS checksum can be enabled if the value is nonzero. This is a
+	per-namespace sysctl.
+
+	Default: 0
+
+close_timeout - INTEGER (seconds)
+	Set the make-after-break timeout: in absence of any close or
+	shutdown syscall, MPTCP sockets will maintain the status
+	unchanged for such time, after the last subflow removal, before
+	moving to TCP_CLOSE.
+
+	The default value matches TCP_TIMEWAIT_LEN. This is a per-namespace
+	sysctl.
+
+	Default: 60
+
+enabled - BOOLEAN
+	Control whether MPTCP sockets can be created.
+
+	MPTCP sockets can be created if the value is 1. This is a
+	per-namespace sysctl.
+
+	Default: 1 (enabled)
+
 pm_type - INTEGER
 	Set the default path manager type to use for each new MPTCP
 	socket. In-kernel path management will control subflow
@@ -74,6 +78,14 @@ pm_type - INTEGER
 
 	Default: 0
 
+scheduler - STRING
+	Select the scheduler of your choice.
+
+	Support for selection of different schedulers. This is a per-namespace
+	sysctl.
+
+	Default: "default"
+
 stale_loss_cnt - INTEGER
 	The number of MPTCP-level retransmission intervals with no traffic and
 	pending outstanding data on a given subflow required to declare it stale.
@@ -85,15 +97,3 @@ stale_loss_cnt - INTEGER
 	This is a per-namespace sysctl.
 
 	Default: 4
-
-scheduler - STRING
-	Select the scheduler of your choice.
-
-	Support for selection of different schedulers. This is a per-namespace
-	sysctl.
-
-	Default: "default"
-
-available_schedulers - STRING
-	Shows the available schedulers choices that are registered. More packet
-	schedulers may be available, but not loaded.

-- 
2.43.0

