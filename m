Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAFE3BFE5A
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512935; cv=none; b=FHU3rKvngUpDjMEmpkYNsRN2U+XWGrrbNPb3qfSiAY+CevM1LWsAMUCQ2x0I6uqqBuQd/LCXwwZ56zMGQ5QBmnnEWBJUCVBEWMpl2xeGZYlvkgXoTKv38+mkLOw8nfPEmJfsB0SjhMsGnxKzVXigPl5a+zgP/fmqO8wBhmRv140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512935; c=relaxed/simple;
	bh=5I23Rx9vLwV5cBxljIK2mFCsZhMkTv3jlWrq9InIAWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=umL1vEbbOIsrJ/xl01xc60YhEm9NFAs/ACCST603ue692AsvySh+WUV/+92CG3NLVlAe2Jixep0c8Zdg5q9GZrnWyxMY+r9Fv8wsOvkTN3w7dtsNPdy2MMod5a1EDNvOQI1SNq37g/5NGDQTGNEWRQT4K5j+ZvdEnMSDB0iZbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRqTybS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRqTybS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423A61F00A3D;
	Fri,  4 Sep 2026 09:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788512933;
	bh=uhwsqGb8iUyUEH2641SBeIIcHovM6MsiMMTd+f2nI2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HRqTybS84sgP+G3Q2vmCMRb7C40zjZx5kq0XczLEv5yE3MrARiBsaX27zfClN++H4
	 2mSVZkoViLN6gk1ObvN2eEQ4gupp3ho6ytE6yqetfBFcpUL85bnwZwx1WakOX8X36v
	 FQv8bEQTX8YH7/Eb8ST2zgeXoyfEiOaET4U6DUKjhUlv6jyY0VvFopfowvmjpdWGEG
	 IhIFvqqu0NnHshXaEx4rnRKXB3MmBwNoyr/zy24svRYZPsheLi+SzlBezqzUYcDwwQ
	 pL5jwT8rUMCmv4I5TUELvfrz17O+wd3PtXIR+FMrvUHCzDi/DXPa/EcDn79lyLdenY
	 h7sqzTtN33+Dw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 04 Sep 2026 11:08:41 +0200
Subject: [PATCH mptcp-next v2 3/3] mptcp: options: reset parsing in case of
 invalidity
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-mptcp-mib-inval-opt-v2-3-a72003dc4425@kernel.org>
References: <20260904-mptcp-mib-inval-opt-v2-0-a72003dc4425@kernel.org>
In-Reply-To: <20260904-mptcp-mib-inval-opt-v2-0-a72003dc4425@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2722; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5I23Rx9vLwV5cBxljIK2mFCsZhMkTv3jlWrq9InIAWo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJmdS1atb3vduwThQ1aVre1l1Xrf/567/NjI84ddlyWF
 9+tfrqloKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiPc8Y/qfn999oEGTvKJlR
 8ff/qSMrZQNOPo2xy/qQHxRlpf5eyoXhn/HpGdn7LjId/btxRdItZn7rXP2zG/wz5tSEOmy4vnB
 yIQ8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an invalid option is detected -- any unexpected suboptions
combinations or use of invalid sizes -- the current behaviour is to
ignore the currently parsed option.

Receiving such invalid options is suspicious: either this is coming from
a buggy host, or an attacker. In these cases, it seems safer to drop any
previously parsed MPTCP option from such packets. This will likely lead
to a fallback to TCP or a subflow reject, which seems to be a good
reaction in these situations.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: break the while-loop, not the switch-case.
---
 net/mptcp/options.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index aaaabcab0f8f..6e0d625c848e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -20,7 +20,7 @@ static bool mptcp_cap_flag_sha256(u8 flags)
 	return (flags & MPTCP_CAP_FLAG_MASK) == MPTCP_CAP_HMAC_SHA256;
 }
 
-static void mptcp_parse_option(const struct sock *sk, const struct sk_buff *skb,
+static bool mptcp_parse_option(const struct sock *sk, const struct sk_buff *skb,
 			       const unsigned char *ptr, int opsize,
 			       struct mptcp_options_received *mp_opt)
 {
@@ -211,14 +211,8 @@ static void mptcp_parse_option(const struct sock *sk, const struct sk_buff *skb,
 		 * RFC 8684 Section 3.3.0 checks later in subflow_data_ready
 		 */
 		if (opsize != expected_opsize &&
-		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
-			mp_opt->dsn64 = 0;
-			mp_opt->use_map = 0;
-			mp_opt->ack64 = 0;
-			mp_opt->use_ack = 0;
-			mp_opt->data_fin = 0;
+		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
 			goto invalid;
-		}
 
 		mp_opt->suboptions |= OPTION_MPTCP_DSS;
 		if (mp_opt->use_ack) {
@@ -421,10 +415,11 @@ static void mptcp_parse_option(const struct sock *sk, const struct sk_buff *skb,
 		break;
 	}
 
-	return;
+	return true;
 
 invalid:
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OPTINVALID);
+	return false;
 }
 
 void mptcp_get_options(const struct sock *sk, const struct sk_buff *skb,
@@ -461,9 +456,12 @@ void mptcp_get_options(const struct sock *sk, const struct sk_buff *skb,
 				return;
 			if (opsize > length)
 				return;	/* don't parse partial options */
-			if (opcode == TCPOPT_MPTCP)
-				mptcp_parse_option(sk, skb, ptr, opsize,
-						   mp_opt);
+			if (opcode == TCPOPT_MPTCP &&
+			    !mptcp_parse_option(sk, skb, ptr, opsize, mp_opt)) {
+				/* invalid option, drop previously parsed opt */
+				*(u32 *)&mp_opt->status = 0;
+				return;
+			}
 			ptr += opsize - 2;
 			length -= opsize;
 		}

-- 
2.55.0

