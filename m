Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57799429CDC
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505013; cv=none; b=XJ6EX72vF20lt6NQG8yp6rUJVtXT+SCHPTUsu21QYHcmO/sQTiapfseBA2pVzypliQmOaaytxNoob649T0K4o1D7FR769gsS0Aawra4IiuvdQaEEJHydVGp/KpY3frtwMUAWqX3dZwqOFC4P55nZd4wc00ahHxKGCJNrLen9QUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505013; c=relaxed/simple;
	bh=3d61TPLDedwu55k65Rj+GmTJA7yfGLv/8fURSSZB+uI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTbcPZOx05X7FXK7D7HpuqpmRjIbSHb/gT8twPlVPeqBh7rd7M5UpCS/fEPcBpL7YTUZau+/LQYwQ00W2S9LoovcA5lrXg5mvAs9p5H2RoewdDMhVZ+og4c7tFV39cPMtqBrHfQ98FTGt1LtKO0GM7eWAT/DCjTA7c3Hu6dNeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW09j/5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW09j/5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710AD1F00A3A;
	Fri, 31 Jul 2026 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505008;
	bh=HtroDACWq0gaAnsjTD2gAENEKJNiDGnQStiDyEN4k0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LW09j/5j965BhbXDcy6m+Px9CFJzzeSnHNa3GFPZ3JqACR1s9Kv7oio2wAureLg/e
	 lQRAukMFRmnCLEqxYC8DSHXhNOG0oV3j1jNbA5F9ebEg2r+NW36rCi4hfcfb+RHZXI
	 wgi9o/i7VtEn1lGfKTBDIFgrVW6Xoua0sfrxIU7Y1T//5YNSBCPDb4rwvCYF/MhXJ1
	 lLm95T8ygAZOGItALzOWkhgjPy9PgvFA0I2szHNnZAPs3uE4ll0jiknsnmUpl5Wdxu
	 dyA+B+0zppGBsHEhIzKoUz7q9sl3DKdTcxfOzBBmTOgbmhFhrb5A8aWBImGTNhkqDQ
	 U2tdWrm2eOjFA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 31 Jul 2026 15:35:35 +0200
Subject: [PATCH mptcp-net 1/4] Squash to "mptcp: avoid combining some
 incoming suboptions"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-mptcp-squash-fix-7-2rc6-v1-1-cfe460beb666@kernel.org>
References: <20260731-mptcp-squash-fix-7-2rc6-v1-0-cfe460beb666@kernel.org>
In-Reply-To: <20260731-mptcp-squash-fix-7-2rc6-v1-0-cfe460beb666@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2329; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3d61TPLDedwu55k65Rj+GmTJA7yfGLv/8fURSSZB+uI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJylrzROKDSPW/lrJMHZK2DHmxNmGwkqdzRZiDH/Y5L8
 NaJ+4fKOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbSIMDw3+f7Ro5T394t42fb
 PMXnQknKe6U+9vY3z7oX9D7qcAyM/s3IcF333BrBif9aEoxCmL4eeHntcmpjikWY43JGs8WHl/L
 6MQEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Another stack could send a FASTCLOSE on a plain ACK, with a DSS. That's
when they follow the "Option A" [1], while here, the "Option B" is
implemented on the sent side.

So we need to allow that, and this seems to be handled by the stack in
mptcp_incoming_options().

Note: this note should be added in the commit message:

  Note that now, combining both an MP_CAPABLE and an MP_JOIN will no
  longer result to a reject of the two options, but only the second one.
  That seems OK to do that for this unexpected error. At least now all
  inconsistent combinations are handled the same way. This could change
  later.

Link: https://www.rfc-editor.org/rfc/rfc8684.html#section-3.5-5.1
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d6b009319839..5611de38f4d9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -170,6 +170,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_ADD_ADDR |
 					    OPTION_MPTCP_RM_ADDR |
 					    OPTION_MPTCP_PRIO |
+					    OPTION_MPTCP_FASTCLOSE |
 					    OPTION_MPTCP_FAIL)) != 0)
 			break;
 
@@ -357,8 +358,9 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_FASTCLOSE:
-		/* Can be used only with RST */
-		if ((mp_opt->suboptions & ~OPTION_MPTCP_RST) != 0)
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_RST)) != 0)
 			break;
 
 		if (opsize != TCPOLEN_MPTCP_FASTCLOSE)
@@ -1478,7 +1480,7 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 	 *  RM   |  C   |  C   |  C   |  P   |------|------|------|------|
 	 *  PRIO |  X   |  C   |  C   |  C   |  C   |------|------|------|
 	 *  FAIL |  X   |  X   |  C   |  X   |  X   |  X   |------|------|
-	 *  FC   |  X   |  X   |  X   |  X   |  X   |  X   |  X   |------|
+	 *  FC   |  X   |  X   |  P   |  X   |  X   |  X   |  X   |------|
 	 *  RST  |  X   |  X   |  X   |  X   |  X   |  X   |  O   |  O   |
 	 * ------|------|------|------|------|------|------|------|------|
 	 *

-- 
2.53.0

