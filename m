Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53EE382385
	for <mptcp@lists.linux.dev>; Tue, 21 Jul 2026 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784674653; cv=none; b=dHW0kjjMclmOLEeT/L97GRY8vubNEbbYGmNzSMFziUFm5yaEZHCW13AXiuAI5GVH6BY/HAsRJJCCcY9irhihMYbANudDZW5JiUDsN6Ectfly58AsCE0kdG64nioYRuyCle1YUBiN55aD9vBvOq/PQ2IQro4fgepTzesTml6uO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784674653; c=relaxed/simple;
	bh=B9EQHb5MHb9Vu7rQy27yeP8211QMySKjthUiaE2C4EQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GHqQ33r+y964TAcc80kyiOwXho/Ewn6CjGXEG9oVunRV6HYdGgYkIvUL7ep7ZDOGrvHcwTeMQcVWiknUUMaVtEa5mAW4FXrUqZLsWJhMlF0Y95tZYB2rM6ckTMySt24AVQtnqKKtam7RHBopvJsAlx7Y2Uks/nmtnYVBGedIw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMtYQfsN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMtYQfsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2564B1F00A3A;
	Tue, 21 Jul 2026 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784674651;
	bh=h6T2g8967K2zakuNed8B3tn2vQi2xmqQoDIFBkgiO+E=;
	h=From:Date:Subject:To:Cc;
	b=CMtYQfsNtDxpOdcV/mMUWtHfSsQGFjzjCw5it7zhVFn6sGdvY8/9oE1mU8FZNaEvW
	 TNKORuu6un09wnJXt5Smvi7dleW6D7kFtbd1yc+05cJVZazJ9ZNywdge5qgvrpe9Kb
	 gyGfFh7q+tgdoC3hmhwzsTnraeX9NLF6bmFb4Ob+AfOCazPGoFFHiClT5iB4ROyXlS
	 MJv5bTYPfiYfdZr+07+vW4IZO3F6lrMk2x2snA7iJqr3uWIV8S4oLswrNpJIMdn2so
	 Buni+WYpbX+VxdRhuDOzJYtOVg25jZTjBDKSkppHHqsPzxsxX2pN/QVQv9QeiaTQya
	 81sfpcLQycnIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Jul 2026 00:57:26 +0200
Subject: [PATCH mptcp-net v2] mptcp: avoid combining some incoming
 suboptions
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-mptcp-harden-combine-opt-v2-1-2021e67703f3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOTQ7CIBSEr9K8tc8AtqKuvIfpAuizRS0QwEbT9
 O725wAuJzPfzIyQKFpKcClGiDTYZL2bhdgVYDrlWkLbzBoEE0cm2Rn7kE3ATsWGHBrfa+sIfcj
 YKM44laYSpYQZD5Hu9rNW32CjHGWoNyu99YNMXqqXcGdT9vG73hj4ivxfHDhyPMiTZqqUhuvq+
 qTo6LX3sYV6mqYfNFHZ7t4AAAA=
X-Change-ID: 20260709-mptcp-harden-combine-opt-da101e4c5247
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7008; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=B9EQHb5MHb9Vu7rQy27yeP8211QMySKjthUiaE2C4EQ=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGpf+Vqhg/TFLQyxUqBAE01lgGm1Agan0ZB9BDFzqVKrmhuUN
 Yh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmpf+VoACgkQfCLwwvNHCpenPwD/WT+b
 IBDd2f2KM90TjZCbCYaXyEz6oqlycs8sXWs01CABAPPWl5lA6DpqulRh/UTNig2IWG/1zpS5tPJ
 /6SZryrUK
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

Also, in mp_opt->suboptions, there is also a bit reserved to the
checksum, which can be used in an MP_CAPABLE and a DSS. Each time a DSS
option can be used in parallel with another option, the checksum can be
set, so the verification is combined into a new OPTIONS_MPTCP_DSS macro.

Fixes: eda7acddf808 ("mptcp: Handle MPTCP TCP options")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Take into account OPTION_MPTCP_CSUMREQD. (Sashiko)
- Link to v1: https://patch.msgid.link/20260709-mptcp-harden-combine-opt-v1-1-378b0a47c1b5@kernel.org
---
 net/mptcp/options.c  | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 2 files changed, 56 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d78f55df538a..d6b009319839 100644
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
+		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
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
+					    OPTIONS_MPTCP_DSS |
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
+					    OPTIONS_MPTCP_DSS |
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
+		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_RST)) != 0)
+			break;
+
 		if (opsize != TCPOLEN_MPTCP_FAIL)
 			break;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da40c6f3705f..c7ead31bade5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -37,6 +37,7 @@
 				 OPTION_MPTCP_MPC_ACK)
 #define OPTIONS_MPTCP_MPJ	(OPTION_MPTCP_MPJ_SYN | OPTION_MPTCP_MPJ_SYNACK | \
 				 OPTION_MPTCP_MPJ_ACK)
+#define OPTIONS_MPTCP_DSS	(OPTION_MPTCP_DSS | OPTION_MPTCP_CSUMREQD)
 
 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0

---
base-commit: f984839d1257b5a7d840038d8a92ef7b08301779
change-id: 20260709-mptcp-harden-combine-opt-da101e4c5247

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

