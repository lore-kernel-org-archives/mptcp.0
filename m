Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D6B16C6AC
	for <mptcp@lists.linux.dev>; Thu, 11 Jul 2024 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712403; cv=none; b=F4QfgVeH5vyIyunMpm2dVxiNGLv4wk+0xn3ZUgJy0LuZVf9OIkr9t5n+IWd18rMKhUsV6OcVEUYTYxHIktqR/iZlandaWZG5ZBb9vwc+76vBWIp/4YmEPemdFDaZ3UAz7+VYn4W6KE8sILDf/q7LzhIgRfVWupiZksv0AXFEDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712403; c=relaxed/simple;
	bh=Fn73rImpeWC8EQqc9FknandKAe95OLv5q72DUryxtME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2DDUikOSdeG8mxmC3aF230hMlps2VUq67lKIIkHQylYAeGQA8HgV1TirnRYHAryhWV93qLNVv01TXKadYmdiZPA4JowCeikCCicW3x5PtUH3bY0FUKANuefE/jgcIZ4yrRjoI7sjoQI7ONLWVl5KFsDtz/CXM7OwUW019fVuHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8Sz308I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8Sz308I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB67EC116B1;
	Thu, 11 Jul 2024 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720712402;
	bh=Fn73rImpeWC8EQqc9FknandKAe95OLv5q72DUryxtME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d8Sz308IKfipO7JqZy7v8zyqzwVzGm06jQujQNDnjWd/3qxGk2id4qrSV7FhelZ4T
	 GoZE40X9QyasY9WTgBdmdBDT2c0Qbx6ijPjGz9KPm82FSpHd9xLN8odnv1LnTfu2I0
	 2MC0owJ5yd8ljlS9GfcOqnfdBqL1u4+GmCrkT8VQrwMmXD0oSxaKlASMOohEbF+pHU
	 YpYNAoz2u+cY8u/Z/72kc77dn6z3QzWqt80BJw8MEsqe1jqh5sJ8zmZQC0xKRMkI5N
	 D6m5/wrPN9wFKz749N8GW6iCwvh2GxzqTLqrDVReO+F/LAU8ih1Hr+7HuwTSb+aNkf
	 DHZTxxs/rpd5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 11 Jul 2024 17:39:03 +0200
Subject: [PATCH mptcp-net 6/6] Squash to "selftests/bpf: Add bpf_burst
 scheduler & test"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-mptcp-backup-mpj-v1-6-d45506182a9e@kernel.org>
References: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
In-Reply-To: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Fn73rImpeWC8EQqc9FknandKAe95OLv5q72DUryxtME=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmj/zJeDY1+Gf4rUjiz+HKVip2O9ViekbCk0j4L
 F5efaQwfh6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZo/8yQAKCRD2t4JPQmmg
 c9cbD/0RkDbfJY6vnbn9007yuN+uANxQlRuHl0MfcCUYaea+v8le7cYt9T24WuQtP2M2vLo/C9E
 O7MbKRFhSYuTCESpcuHAshCuxrgsl0xDwdefsxL+/kNx0UIeBFgzNSmSQ/2mGyTaBCrDA3j2f+S
 sC2HKurOV8217pB78FS/gMENO22aAVb8bvlHR/BUkcibpbXZAZzUvTTkyJ62jYSFngyBJatD9TA
 EPSLhTpPSJyctiuCNlbgeioGR8WUHFUftI7//jiDV1cCFa2Kk45z6ccObhP5ikEdzajrSUukrgS
 3in+LmVkSG2VWy7ZukXP1IMauWGH0R/qpCAnqax3oq18Gobsyux9iPkQh74VvVkOlq6u5trIcgX
 wy+g5ai1x1LE6VHtodAjxyc3oneXj5mpPd60ItiQRmiZMiYKr9tTZx8iq08b26A/iETlkceKbKu
 wwaaNl/xABNqi0oRyiL/URxqDNBbaldgI9FUw7nSlQQ99/dOhwg3lCAIDGnReeHmpNbL8CnJqt4
 y4mEkl8hlnQ+K4FWb4t02qOntPVpGFuxSNXM3zF5BdY9ibYsFTNHBRpMC6syRlhCnGRx+MDSZrr
 y5MIXmmTlpM9AvbS/io00Fr8Yue10vgUmE6IYHMCVNsOVDybY8kQZRsMBQpt/7+vWo6A6ZVv90k
 Utb6Ep9dNGLYd3g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to "mptcp: sched: check both directions for backup": it didn't
matter before because the two flags were very likely set by accident.
But that's no longer the case now.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 0026587a94df..3a673291b4dd 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -85,10 +85,14 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	}
 
 	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		bool backup;
+
 		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
 		if (!subflow)
 			break;
 
+		backup = subflow->backup || subflow->request_bkup;
+
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
@@ -103,9 +107,9 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 		}
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
-		if (linger_time < send_info[subflow->backup].linger_time) {
-			send_info[subflow->backup].subflow_id = i;
-			send_info[subflow->backup].linger_time = linger_time;
+		if (linger_time < send_info[backup].linger_time) {
+			send_info[backup].subflow_id = i;
+			send_info[backup].linger_time = linger_time;
 		}
 	}
 	mptcp_set_timeout(sk);
@@ -160,7 +164,7 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 			continue;
 		}
 
-		if (subflow->backup) {
+		if (subflow->backup || subflow->request_bkup) {
 			if (backup == MPTCP_SUBFLOWS_MAX)
 				backup = i;
 			continue;

-- 
2.45.2

