Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914902773C3
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013464; cv=none; b=NLLUPFyJfdUYnG/M6vgLUi21IGX/c7qVj/IhjXHZoj1cTMGtPR8DG9oD9WvXzPEyXoCD1UDnIcgcic1fwly41O19NjAzO5lpZXug/s+t/JLkK7oFXP4MoyKPzV4hzkgNP2UVLIwrKxeO8pcYpk12azZJFmbPAmDE/2pJkW5crMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013464; c=relaxed/simple;
	bh=ft1yUqcPLCPz/7rHu0SEqmQ+795ZwScbFmNBrhBUiJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EHR6GDul+drT52c4nlv8MdoCiBuZ1EFDmDhwWABMIHAAywtHW2XLAxJRqYx+mC79rYSz7oEoGjCpKyK/qkszPNgl/Zv5tmTxOL1fUNT7+MIyzNtZVPEAc61Vj3ijPIWzWmDDnt85PJip2PL38bXY78x5Noy8uqnyPWpQsbnitEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6pyGQf1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6pyGQf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9661BC4CEEB;
	Tue, 16 Sep 2025 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758013464;
	bh=ft1yUqcPLCPz/7rHu0SEqmQ+795ZwScbFmNBrhBUiJE=;
	h=From:Date:Subject:To:Cc:From;
	b=D6pyGQf1H+chhQ/yxr83aKETnTmK35h2XVfY6OxUQ4UyHLMMbgvg96pXXvzaGx9C8
	 E0t2qynkrtwMCrHZY/SirLsZPcivP1vIfup1yFWbj045PN2nQShDz9XoyCAJkhEJhc
	 ZlppIi+EFu5ecOiX5nfv1urN4SDdl56bKrMxD1s3oIofbrrCxy+2mJgMD9mjeOQAtt
	 nWzy8RbajinkRuL2HAkV60sjwmjblUCsh98ExXuOy7yBnbWjfMlWTo4ZN5wflK49h6
	 pkeaNOzbVUWKvZp+b0Uo7cxfrALDdP/1xfcGAGTl/O/7mqQUSnqEjkEaU0v8BvJ62H
	 PabDRfAGlmCDQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 16 Sep 2025 11:04:13 +0200
Subject: [PATCH mptcp-next] mptcp: use _BITUL() instead of (1 << x)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-mptcp-pm-addr-flag-bitul-v1-1-5805a6ddde27@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAwoyWgC/yXMQQqDMBBA0avIrDsQIxbaq0gX42RiBzSGJC2Ce
 HeDLv/i/R2yJJUM72aHJH/NuoYa7aMB/lKYBNXVBmtsb17tE5dYOGJckJxL6GeacNTym9FR17M
 17KljqDwm8bpd6wFuFWQr8DmOE6g/pbF2AAAA
X-Change-ID: 20250916-mptcp-pm-addr-flag-bitul-da35c20cfa3c
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ft1yUqcPLCPz/7rHu0SEqmQ+795ZwScbFmNBrhBUiJE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJOaohZPM49Pc3wbQhrY4ZN4cMtPJu3hZ/+kn9kws7jL
 6weXhHQ7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIOhZGhmfpVzJ0PJSerPeQ
 +nP7yO7Ee9IXTzwt0s/6k6d2d8JObgNGhvYvP/M+/uyV/2bPGCH2ez9XE0PEv7WvPC4Gx/o8XrV
 zAgsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Simply to use the proper way to declare bits, and to align with all
other flags declared in this file.

No functional changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 95d621f6d59810126cbc37b1d6baf896a40dd9bc..15eef878690b8556af21be8d959b6a2c9fe617d3 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -34,11 +34,11 @@
 #define MPTCP_PM_EV_FLAG_DENY_JOIN_ID0		_BITUL(0)
 #define MPTCP_PM_EV_FLAG_SERVER_SIDE		_BITUL(1)
 
-#define MPTCP_PM_ADDR_FLAG_SIGNAL                      (1 << 0)
-#define MPTCP_PM_ADDR_FLAG_SUBFLOW                     (1 << 1)
-#define MPTCP_PM_ADDR_FLAG_BACKUP                      (1 << 2)
-#define MPTCP_PM_ADDR_FLAG_FULLMESH                    (1 << 3)
-#define MPTCP_PM_ADDR_FLAG_IMPLICIT                    (1 << 4)
+#define MPTCP_PM_ADDR_FLAG_SIGNAL		_BITUL(0)
+#define MPTCP_PM_ADDR_FLAG_SUBFLOW		_BITUL(1)
+#define MPTCP_PM_ADDR_FLAG_BACKUP		_BITUL(2)
+#define MPTCP_PM_ADDR_FLAG_FULLMESH		_BITUL(3)
+#define MPTCP_PM_ADDR_FLAG_IMPLICIT		_BITUL(4)
 
 struct mptcp_info {
 	__u8	mptcpi_subflows;

---
base-commit: 7064ceb50d7f26c7190bfe6d2ff76a3b6afa27c1
change-id: 20250916-mptcp-pm-addr-flag-bitul-da35c20cfa3c

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

