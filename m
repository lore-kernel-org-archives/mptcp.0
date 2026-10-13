Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C45A52ED4B;
	Tue, 13 Oct 2026 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914221; cv=none; b=ZUMvhX2jQryxD5jZS84iQ2ftdyke2hFVCPiZpA0qCjUqMjuqZLErMUAcHXe0xC6Z0pOFli1i8v+edaputi1d+T2tozaRf/5/x18pHlMpRR72Ba9mTY5BqU3KjJHsXpte9dFt+qQ/wh2+aLf7MmQjaWKLCHIKCzwGkrsLQTXggfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914221; c=relaxed/simple;
	bh=DiHQ+EWWKklHPdVqsQyelET/NENiIqy3TpBtMbM26z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xr2LR0CyUYVBZg5mxE/xLXjyCdxDBu0pjzi7KJKm3uluXq6zKB0pc/hMRQw52fZEZjuc/MMzHbRoKMKJDYsgd3zGK905pXbDRBU6Ffll8QLeWKJ919D/yiaXYlmIL4sqJHcZWLCz6ZIkmVmRR5hAzssfHMwnq2SIHpnk3cZVHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKse0huj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKse0huj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F059C1F00893;
	Tue, 13 Oct 2026 17:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791914219;
	bh=9B7pt7nyxfILBvMjbly9lwcrsCo1KpVnZ3MB3VsWDgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OKse0hujKKMLpRzT+CXJCRN/VF9JXU5pkHSTz/hGacKUBdw8FUqiqqZnIWVNVG2WJ
	 Bh0OQa49uOO7jLlp9ApEgMEDBWbtoneVtDYOyMIyF1RdVvKtFWs/Q/DBJUX9DFk8Q4
	 HRKghbM8lFXuqLtCzpGqKW645xn4yG1jNf6OT08VgwRmcA3rfaZjzEyt3kDD+TitEq
	 fS5TGRO/UpoklRbPT1EFtov/bvNFsmhlTWycHICcRp7CBmkBAGN8mdQLZ5JAGNy5yV
	 F/kfuhsoy3R5ujznzNexnrUsidHgSXHicBaorC1azUwDM0W0OzQLMjdQQeeUHSOyc4
	 mj3UpClaYx1Ng==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Oct 2026 19:56:38 +0200
Subject: [PATCH net-next 1/4] mptcp: options: mpc: avoid printing uninit
 data
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-1-1181e5d2fda4@kernel.org>
References: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-0-1181e5d2fda4@kernel.org>
In-Reply-To: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-0-1181e5d2fda4@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DiHQ+EWWKklHPdVqsQyelET/NENiIqy3TpBtMbM26z0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLOFTx5Ol1Xr17YizUofm13yOn6U1nzlyWfevJss0D2l
 jzbB1eMO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYy6R7DH85Fb1IX9pZdyVp2
 1Fadz9fz5KQb7RwHF9vcFBS8xJB63Jfhn8rdxJdH857znbc1F87efcy5xlNy2URdu/WKqcwuMc5
 X2AE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When parsing the MP_CAPABLE suboption, this pr_debug() might read and
print uninitialised values.

That's mostly harmless, but that's also confusing. Fixing that also
avoids some tools to complain about accessing uninit data.

So read these fields only if they have been set.

Note: this was initially reported by Clashiko as an existing issue. The
code has been analysed by a human and confirmed. This is a non-urgent
fix.

Fixes: cc7972ea1932 ("mptcp: parse and emit MP_CAPABLE option according to v1 spec")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c2f4d7bd080c..3b4a22846055 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -126,8 +126,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 2;
 		}
 		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u\n",
-			 version, flags, opsize, mp_opt->sndr_key,
-			 mp_opt->rcvr_key, mp_opt->data_len, mp_opt->csum);
+			 version, flags, opsize,
+			 opsize >= TCPOLEN_MPTCP_MPC_SYNACK ? mp_opt->sndr_key : 0,
+			 opsize >= TCPOLEN_MPTCP_MPC_ACK ? mp_opt->rcvr_key : 0,
+			 opsize >= TCPOLEN_MPTCP_MPC_ACK_DATA ? mp_opt->data_len : 0,
+			 opsize == TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM ? mp_opt->csum : 0);
 		break;
 
 	case MPTCPOPT_MP_JOIN:

-- 
2.55.0

