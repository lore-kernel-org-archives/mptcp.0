Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE9426EA0
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613241; cv=none; b=YdwaR6uvNH2cmeRfoc9ByAvjV+3rREubSAFYJd5GKAdY1Ej32Hlu5cC3dr8934DeN7lAj8ruToi9mlzO4wI8uzUA0E00ARFytPbMa+zRPdtj8ui/dUsec5IqdI8hl/W+W3Z4ax/+s0Bu7+zST2LQ90KhmbpsifZajspwe4gL714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613241; c=relaxed/simple;
	bh=BVUJlpvvmDJOujGyrHtGzu0mkqGHEkbfifPmgmytbQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tLZfVJTUSTrvuVDBeEpubBlUl+yuTBk+/PmcqcQ4YDoOiGA5FqX5ROeeOYax56MspRDX/R1SdI0qNlkaR8n7EcyTEjRKZk5FqBkFt3UobouLW2r1XEb0rzMoZkGcV0HKIC5naqiDQS66neI98hQV0kdX7dMb2hVQ+u0/gvoUAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEpfigDc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEpfigDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5551F000E9;
	Thu,  9 Jul 2026 16:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783613239;
	bh=tPXGBPKFIoQPym4XvzGinXLvLPE3deAyTa0+qjjse0s=;
	h=From:Date:Subject:To:Cc;
	b=GEpfigDcswOBKcQileEi+Jk3oZSl+kKgFfKuCFk9V5aLxyPMytib41eZZCi11sRyR
	 lEUJvNx+VS21akxSzPDkKzFDDnJoK00qg4dVDthwH5PiUPZ61UrhfhubfPbSEXm4IZ
	 cPw2RMFbGeFNQeB6KzNqeMSeRjK/Zfhfaq6GX/ZMjfe1GE8ECfszf1C09mh+Bg1HGq
	 Xr+kosI5/gCleUCi8+EAD+b2FN3+DQnlXbJ/Zgmsida06PjqfCFVunw8Sy3cJGfXLH
	 STgYTDia+hyY8Vmy60dSJQTsLijpZ8aO0M+LKuVeB+Ri2jC4g5XhumMGGp/GOLxL6r
	 I0IZwiQ3rdKaw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Jul 2026 18:07:07 +0200
Subject: [PATCH mptcp-net] mptcp: avoid combining some incoming suboptions
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mptcp-harden-combine-opt-v1-1-378b0a47c1b5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBAAv1L27EISWot+RTykm9Wu0E1Iogilf
 ze2x2GYWaFwFi5w7VbI/JEiURvYUwc0e30ySmgMzrizGc0Fl1Qp4exzYEWKyyTKGFPF4K2x3NP
 g+hFanjI/5Luvb3BUyhXuhyrv6cVU/2vYth8CcuJUhwAAAA==
X-Change-ID: 20260709-mptcp-harden-combine-opt-da101e4c5247
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6059; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BVUJlpvvmDJOujGyrHtGzu0mkqGHEkbfifPmgmytbQk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLL8j5u9fdDyzX/r7olftzS3rp5QmMAm5B726r6UEGPmv
 Vc37z1T6yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiI7glGhpXqEuw9MtKHi9SL
 836EfAk/Ne+26aR6qRl/Pnvwcr3J8GX4w3fQQ2n7/SnbjWUNW2c8uhbynP2doU6z7nF2jpTNChf
 suQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some MPTCP suboptions are mutually exclusive according to the RFC8684,
but also because in different places, the code doesn't expect some
combinations to be present. That's specially true for suboptions that
would be present twice, but with different attributes.

The new restrictions are the same as the ones applied on the output
side, with mptcp_write_options. The same rules can be reused:

  Which options can be used together?

  X: mutually exclusive
  O: often used together
  C: can be used together in some cases
  P: could be used together but we prefer not to (optimisations)

  | Opt: | MPC  | MPJ  | DSS  | ADD  |  RM  | PRIO | FAIL |  FC  |
  |------|------|------|------|------|------|------|------|------|
  | MPC  |------|------|------|------|------|------|------|------|
  | MPJ  |  X   |------|------|------|------|------|------|------|
  | DSS  |  X   |  X   |------|------|------|------|------|------|
  | ADD  |  X   |  X   |  P   |------|------|------|------|------|
  | RM   |  C   |  C   |  C   |  P   |------|------|------|------|
  | PRIO |  X   |  C   |  C   |  C   |  C   |------|------|------|
  | FAIL |  X   |  X   |  C   |  X   |  X   |  X   |------|------|
  | FC   |  X   |  X   |  X   |  X   |  X   |  X   |  X   |------|
  | RST  |  X   |  X   |  X   |  X   |  X   |  X   |  O   |  O   |
  |------|------|------|------|------|------|------|------|------|

The only difference is with the 'P': another stack could send and
ADD_ADDR with other suboptions (DSS, RM_ADDR), and this should be
allowed.

A point of attention is with the MP_CAPABLE: it could be used with a
RM_ADDR, but there is no reason to add it with a SYN. Note that even
with a 4th ACK, it doesn't seem to be useful, except when IDs are known
in advance via another channel. Better not to break that.

Fixes: eda7acddf808 ("mptcp: Handle MPTCP TCP options")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0ca60314d667..3fc368eb96d0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -50,6 +50,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			}
 		}
 
+		/* Only the MPC + ACK can be used with a RM_ADDR */
+		if (subopt == OPTION_MPTCP_MPC_ACK) {
+			if ((mp_opt->suboptions & ~OPTION_MPTCP_RM_ADDR) != 0)
+				break;
+		} else if (mp_opt->suboptions != 0) {
+			break;
+		}
+
 		/* Cfr RFC 8684 Section 3.3.0:
 		 * If a checksum is present but its use had
 		 * not been negotiated in the MP_CAPABLE handshake, the receiver MUST
@@ -122,6 +130,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_JOIN:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_RM_ADDR |
+					    OPTION_MPTCP_PRIO)) != 0)
+			break;
+
 		if (opsize == TCPOLEN_MPTCP_MPJ_SYN) {
 			mp_opt->suboptions |= OPTION_MPTCP_MPJ_SYN;
 			mp_opt->backup = *ptr++ & MPTCPOPT_BACKUP;
@@ -153,6 +166,13 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_DSS:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_ADD_ADDR |
+					    OPTION_MPTCP_RM_ADDR |
+					    OPTION_MPTCP_PRIO |
+					    OPTION_MPTCP_FAIL)) != 0)
+			break;
+
 		pr_debug("DSS\n");
 		ptr++;
 
@@ -234,6 +254,12 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_ADD_ADDR:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
+					    OPTION_MPTCP_RM_ADDR |
+					    OPTION_MPTCP_PRIO)) != 0)
+			break;
+
 		mp_opt->echo = (*ptr++) & MPTCP_ADDR_ECHO;
 		if (!mp_opt->echo) {
 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR ||
@@ -293,6 +319,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_RM_ADDR:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_MPC_ACK |
+					    OPTIONS_MPTCP_MPJ |
+					    OPTION_MPTCP_DSS |
+					    OPTION_MPTCP_ADD_ADDR |
+					    OPTION_MPTCP_PRIO)) != 0)
+			break;
+
 		if (opsize < TCPOLEN_MPTCP_RM_ADDR_BASE + 1 ||
 		    opsize > TCPOLEN_MPTCP_RM_ADDR_BASE + MPTCP_RM_IDS_MAX)
 			break;
@@ -307,6 +341,13 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_PRIO:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_MPJ |
+					    OPTION_MPTCP_DSS |
+					    OPTION_MPTCP_ADD_ADDR |
+					    OPTION_MPTCP_RM_ADDR)) != 0)
+			break;
+
 		if (opsize != TCPOLEN_MPTCP_PRIO)
 			break;
 
@@ -316,6 +357,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_FASTCLOSE:
+		/* Can be used only with RST */
+		if ((mp_opt->suboptions & ~OPTION_MPTCP_RST) != 0)
+			break;
+
 		if (opsize != TCPOLEN_MPTCP_FASTCLOSE)
 			break;
 
@@ -327,6 +372,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_RST:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_FAIL |
+					    OPTION_MPTCP_FASTCLOSE)) != 0)
+			break;
+
 		if (opsize != TCPOLEN_MPTCP_RST)
 			break;
 
@@ -342,6 +392,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_FAIL:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
+					    OPTION_MPTCP_RST)) != 0)
+			break;
+
 		if (opsize != TCPOLEN_MPTCP_FAIL)
 			break;
 

---
base-commit: 32300613e740604f4f64881581f74c508d4e412b
change-id: 20260709-mptcp-harden-combine-opt-da101e4c5247

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

