Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309526;
	b=dGVEEQpPTmKim6UpTXf+m4lvn5Ogt5UkvwTRlRrOtkbqHoqqtV2+YV4OubrWrhxoc19G
	 nInKViL9vARQuPM32plCeEJbPqU4yLqJv41lhnqokooqSnITg+SVYwkyV8EgzK6syGap5
	 UKZ3DLTSYa2x/Xdisx9tBPPsQ5wg9GgoCdEUfVGIivjpLNxIS+srh0mNCN0P/f3KPfROU
	 iPmGN5+7UZa0sfTPyba0OHqUnsHVEsAcSU5JY7EnPIpjjv5ZAJNKLYoV0DltH98GpYTE4
	 QAqxgUUBszOBiVlXrp8eK8gm4iaJYxg0QjNAQF8zIEOXTZdYXDxZPpy2pTBLY3SOdeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309526;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ZZmuKTW7XKXUQS+6KITY8s4On/f8/H/VjPkQtBEwcf4=;
	b=PcmnjaE2FVQD1vTuedoPwaVdBsEqaQjvqN33V2mukSuySfANulJont/JxvJDlgaGrTwz
	 Z/PGR/Xnbnwzf5NIWs6NVCKu3ws1ENvj+n8IAwGM5Dy6YeHb9RUG35sMjJgvS03gQOH8M
	 ziqAWqw9GPHCR6gWinoNDSgOZ4T6cGBkMs/gZx8LztGsv41zPdgQUDihjGB/rR7tRb/8N
	 huKf5zmtJjgBwhzCISJCKQvAn2xcPXJHyNGLL8/quFOImks9Me2pIm/bVZYmvAC+dycJO
	 suyo/qRNMH/xKqDy+i0e+DV//b5CTBtsgIwfSSb4DCl0QTcsfIc/CpuwB3Yg0XCtXSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgTrFd8c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF74606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgTrFd8c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B82A1F01829;
	Thu, 29 Oct 2026 21:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309525;
	bh=ZZmuKTW7XKXUQS+6KITY8s4On/f8/H/VjPkQtBEwcf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dgTrFd8c/85taKwmGZ5Fk/vvLVNdbFdNOdiUgaTW1NsnMkovD9MYVFLwe+htMvVlW
	 givOGvTbr0TNV6WcYPrWOYrNC5hYgwXPeizvnDt3SoQIfrskIOGCirnbcaDrFXDQGi
	 jUpploNnsRjApDuCzur33Mw1f3cACDNZ4QhzB1wQh51bwurQX3YwTcUR5y5e62pUwH
	 PUfjz6MZoyHW5GaRqn9/cTr68jTkzHBItvPBJEPtKBl7LwN4vTyAz5dev4aMy1aCi7
	 6IXFcRZBSGXxMAB8AlrxMEN3uVenLtEq81qzaD868ioNULKgGyD7O7qBIZK3DTHPnO
	 P+jhrhYhBSGzA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Oct 2026 22:31:47 +0100
Subject: [PATCH mptcp-net v4 2/8] mptcp: pm: userspace: lookup: match port
 in priority
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-mptcp-pm-userspace-id0-case-v4-2-555066fa4292@kernel.org>
References: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
In-Reply-To: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bZTk4zIjYz5FTkERHuVw9fjxQCzWhYHnS6D1nDyKyPM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIe7/a76D85zfSqd37uJcvEu9nfFM9Nm/17mZ0vp+jZD
 Q9KjuZM6ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIkwAjQ9OsmnP+glOcuma3
 nDUy4torErzzVucOuT1GYpt+fJcoY2D4pyS2ZM/5M2pan1N3723VnRKq6BAk5SRz+lmg2Z/YJ3s
 ecQIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In the local address list, there can be entries with the port set to 0
-- corresponding to the source port used by the initial subflow -- and
others with a specific port.

When performing a lookup, it is important to compare the ports to pick
the right entry: when a specific port is given, then try to match it
first. If no match is found, try to find entries with the port set to 0.

We need to handle the case where a subflow got created without forcing
the source port: we used the same ID as another entry, and we still need
to match it, even if here the source port is likely not the same as the
msk one (or a subflow attached to the same ID), but that's OK.

Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
sashiko: check the next patches before pointing at existing issues.
- v3: new (Sashiko)
- v4: avoid 2 loops (Geliang)
---
 net/mptcp/pm_userspace.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 45faee894ac3..68a02b15a4c5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -31,13 +31,19 @@ static struct mptcp_pm_addr_entry *
 mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
 			       const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_pm_addr_entry *entry, *wildcard = NULL;
 
 	mptcp_for_each_userspace_pm_addr(msk, entry) {
-		if (mptcp_addresses_equal(&entry->addr, addr, false))
-			return entry;
+		if (mptcp_addresses_equal(&entry->addr, addr, false)) {
+			if (addr->port == entry->addr.port)
+				return entry;
+
+			if (!wildcard && (!addr->port || !entry->addr.port))
+				wildcard = entry;
+		}
 	}
-	return NULL;
+
+	return wildcard;
 }
 
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,

-- 
2.55.0

