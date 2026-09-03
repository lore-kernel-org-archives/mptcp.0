Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A545A28E
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434724; cv=none; b=ulY3Sif7V5cXE84tumvgLIYC7I9tiaAV8q8p0qq7Fhl9r4pS5U8ic8hU5Xl+QW+ZqNE44PLM4ejQS2hn9qGdwVdmh8yNnP3+qA+GWvvfWcU1U0iybj/9+BcUY8uJiUkqpb0BTkk3WuWGFikNhLSOfGzmrUGV/nwYuWDB6vre0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434724; c=relaxed/simple;
	bh=mQSnv+WGutmf8prHrR1ljHZNqnlEDoBVtvwI2MF69w8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OfZSf/lT0eCXWVOAx0Z4jsFo+fkNveRJ/ZnvGr5JZ5lsDfDADevA5maL07CPolYpZGhdfhNnzW+5SxJ+rqesz6DRr71FFjTlG1/tW57eMpPDG9yqdhpQ52XR/v4PaTT6xm2SpaNnz4yMS2D7QJXLBy1DVZR/3ocLH0Wtw1cQ9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm4IQelI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm4IQelI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FDB1F00A3A;
	Thu,  3 Sep 2026 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788434716;
	bh=Y6XLctRiRwRS4VEjVvThSJrp2Z1FKbkwRHPugJMFbDE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Lm4IQelIPqtG5wcrfYgYqym/yiXaQYmA5dvsqHeFnYfbhYlPU30Ra651wpZigHUNN
	 6aQ6jkkOigKNT7wVgs9q0zu6eQBSj6fHalsUfT0wVAh3kV6vBohjWlNHN3mgLOLplP
	 tZjKTqdQfbPzYxxoECJ/6EDbLccQk7Irqezx7Oa8iW4VH6iXfvJ4gxOLmurlDCl5lg
	 gGVS0R7PI4LCXkzqhJb+fKN5G2MAwHMbYnxrG6nJ4bE6QBRQKGfqBIMPNKK0+1nxIZ
	 +RtlYohzmnwJymR4tjayaxAA5i7QVnF//5cfuIcHhEGvQqB6jBfFI1RTwLhC7sl00i
	 wAlaA+FZdTY2Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 03 Sep 2026 13:24:56 +0200
Subject: [PATCH mptcp-next 3/3] mptcp: options: reset parsing in case of
 invalidity
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-mptcp-mib-inval-opt-v1-3-84a553c552b6@kernel.org>
References: <20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org>
In-Reply-To: <20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2668; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mQSnv+WGutmf8prHrR1ljHZNqnlEDoBVtvwI2MF69w8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJmRkpYrHQXC9WceGw5x9QY9Q2tP+MXXkleWxGirhH/L
 cXPjremo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLz9jIyLM5evOLwmpULBNIe
 z9VfeFzrzfmwT7YpSxoFps0yOPRbTZ/hf/qO3tvcgo06CZYXGysSKzXdqvR+VDzk0tlrd8rRVf0
 qDwA=
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
 net/mptcp/options.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index aaaabcab0f8f..b6d2e39f8464 100644
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
+				break;
+			}
 			ptr += opsize - 2;
 			length -= opsize;
 		}

-- 
2.55.0

