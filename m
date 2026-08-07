Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B03DDDC1
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092124; cv=none; b=r+vGzjo7mNmpX1134gzqH4wP6x949efLXK5Zzy3iwWetIN4aKNN+y1l5BBk0oi8xZs/CDrmL4rM4j8G27FAJhF1Ix44zX2vKXcNXrR/sJWnvAxx0WD8kStYCODtfGRBWcHvvMSjejHHXerT41q8lwrMMuKYh/svM160nNacf2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092124; c=relaxed/simple;
	bh=AwLbiHudTi5LJ/tSjBIPC6inR6NWLPNk7kx5ujUb2Yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mL2u4rgKLPMkqRlRmbaWbZU6LScqZ2N99CaS572lJwxw71KPjU+nlKvYdOoDTp2x0InbzQGG1W29s18jIP1JRNWH+ggGpl1tPW2xPVNe5erSfOXOlq0pFQrjTLzCIHDDaNDGOZnf3SWv2p5KmSjD4YLrdK0mxOkVwelPRqAbIiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHuSXBoh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHuSXBoh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3931F00A3D;
	Fri,  7 Aug 2026 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092122;
	bh=0vzWfe8w0VbiaBY3HPEuUOeOEHXCj5FDBoujPFjT5ow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dHuSXBohqyeKxmg4B6vlQ8bQoKnarYxBLsjsbKUlMSfYdkf6+4IjM/bWv73UzRhqs
	 sGOuGUOjwwMEy4rZQYOEdp71JFkrd9YAcJUtB19l6JJVbz5q0GeOAaSTYgALfTI2WP
	 xe3YhH1wfYx3+h0B4bRBeoDpZ9pxJ+JtZ45OxpvtP1rD4h40We+Zjs+T4RAvXo3+9X
	 9Bb7reY541sLZPGYguD1gmLUTCXGe5W3IvasH4roIOunevGE8g0L+a5NlzsdTLpDep
	 ZrDASjoABobniQPD9dqwfhFPt+6ShuCG34nitk7OLciyQhxi9DHkP96lEB44giON+h
	 ravHTuP4Ff7/A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 10:41:49 +0200
Subject: [PATCH mptcp-net v3 2/8] mptcp: pm: userspace: lookup: match port
 in priority
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mptcp-pm-userspace-id0-case-v3-2-de9088549924@kernel.org>
References: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
In-Reply-To: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1501; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AwLbiHudTi5LJ/tSjBIPC6inR6NWLPNk7kx5ujUb2Yw=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGp1mlKjLOs8y89oZOKzDzdbHjKiAZO8Ku7h2ixl0M5D9/zcx
 4h1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmp1mlIACgkQfCLwwvNHCpf2RwD8Cl0H
 pNqd/kuhh/yjuQHxV3DeONiQHtgA3xy6VnaXDf8A/0eZGV7XIxWt68XtKp8da+mubXIo+xXhHqs
 gq1Id4EwJ
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In the local address list, there can be entries with the port set to 0
-- corresponding to the source port used by the initial subflow -- and
others with a specific port.

When performing a lookup, it is important to compare the ports to pick
the right entry: when a specific port is given, then try to match it
first. If no match is found, try to find entries with the port set to 0.

Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: new (Sashiko)
---
 net/mptcp/pm_userspace.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 663cbeb79548..3f1471ec3fc7 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -33,10 +33,22 @@ mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_addr_entry *entry;
 
+	/* Compare ports when set in addr */
 	mptcp_for_each_userspace_pm_addr(msk, entry) {
-		if (mptcp_addresses_equal(&entry->addr, addr, false))
+		if (mptcp_addresses_equal(&entry->addr, addr, addr->port != 0))
 			return entry;
 	}
+
+	if (addr->port == 0)
+		return NULL;
+
+	/* Check only wildcard ports if no exact match with the port */
+	mptcp_for_each_userspace_pm_addr(msk, entry) {
+		if (entry->addr.port == 0 &&
+		    mptcp_addresses_equal(&entry->addr, addr, false))
+			return entry;
+	}
+
 	return NULL;
 }
 

-- 
2.53.0

