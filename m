Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307948;
	b=iS+z4RPVo1xFs+dzbk4xr617UGlEYln5gKh9HcywluB5DrRxMt9BmEWf4l6fMcsIu05P
	 3RmCc1gP0WPlCXlLssoLDIis1cmldiQEUuY50H8NMdH93yFva1/8o9ug5Y1fxPlNcAjIG
	 ARS8vBX4qiTp0b/MSYaNcRPWRk0TaPFqDKrXLx4nYpyDpU0RbUExbyQWDtH3afem2+ox/
	 tjaE+9nXRJa/yPJFi9J75qruiBmOcpKC9C1cjhOxw8fiMTj0CANbjkWBnRArVPo8BYotm
	 tgbjqwIrti7JwSza8UV6wiyonHk5wYhJCCxp3oYHVVvtG8tnonYSBes02XyvsbOZSnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307948;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=r6asDAUO1ZgOqeLABDcbvAtU3LZeI5YEwYy5cfxQ7nA=;
	b=MOh/cogcF0msucj/6fjL63SNc6S7yyqD1aDdo+WcvOIeOWfcW3gSJAbcvINnl5Fgx92Q
	 qax9NfAvkvC2ECI187ZlGmZMzOzn3DZiDiwbzF/M5zhtnb7mYvPAQYfCd0JnUL4FAGITo
	 l5sAVy87N39tVSFs7ajA8iBftlnzcyy0rQdjkcO34emli8iEoT2sXpbFix7HYLf7NKgWR
	 GidZi+xwu4guohdrTvoPrmyermdicKjsu0ytdgyzctxfHH4koTwGOSRUTHEupjwbD0hF7
	 Py8/GiKS6PzolDiedhPgas4J7H8KVWgfwh+KJJhsF6vmnQXE7xJyGZyX9SiNemtMVZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwvcVEgB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2905A606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwvcVEgB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659D51F01826;
	Thu, 29 Oct 2026 21:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307947;
	bh=r6asDAUO1ZgOqeLABDcbvAtU3LZeI5YEwYy5cfxQ7nA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gwvcVEgB0aupWeetcDPImQ1gDWVDYQOtbdh9OoGpEFU0N90sZRyik6Kdawf4SwFMU
	 I7mmnipPYXEHZgJR3brW6IdtF0P/rrw2j8ZTXmoNU70rgemOCdCjd/XZtXDyTHe/z1
	 blZF7VoIiXFVSxVaN19ika6arze3kLE4RiWHQfuv1BjqLAqi7NGpRotV6DXL1/iWaj
	 dVRzTNbeI4MmHuEQO6RpKpCJKapoNFEggv7xl/8xHqO5WYsUf/rUPKpQpmI0ik7v1R
	 +tfHRiaNa6itWOweq/uFPd6NlLjzJqFzZDotufZcce15YlWYtN8d351lNp50lIg2nE
	 gKlnBr300e9gw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Oct 2026 22:05:33 +0100
Subject: [PATCH mptcp-next v3 3/3] mptcp: options: reset parsing in case of
 invalidity
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
Message-Id: <20261029-mptcp-mib-inval-opt-v3-3-428f42a35674@kernel.org>
References: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
In-Reply-To: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2722; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WCeVedKM2Ge5u2uI8ZfXLfAnrlbXW8ka4EohFd6L5+A=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIeb9VIWVVZfP+f25bF1efTXOwD9zatlVzwSrbqU92xQ
 wfmmz937ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjI+ukM/7QOPL1WbtKrHLVr
 +vdFR9bNvWH1YWa1z7cjf5hvnmh6bjqNkeHPspppHYGttjz6177zH7r86MCTPXpxV492GC47p6l
 w6S87AA==
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
index 10a150e2ad69..b068f4f1861e 100644
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
@@ -214,14 +214,8 @@ static void mptcp_parse_option(const struct sock *sk, const struct sk_buff *skb,
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
@@ -424,10 +418,11 @@ static void mptcp_parse_option(const struct sock *sk, const struct sk_buff *skb,
 		break;
 	}
 
-	return;
+	return true;
 
 invalid:
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OPTINVALID);
+	return false;
 }
 
 void mptcp_get_options(const struct sock *sk, const struct sk_buff *skb,
@@ -464,9 +459,12 @@ void mptcp_get_options(const struct sock *sk, const struct sk_buff *skb,
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

