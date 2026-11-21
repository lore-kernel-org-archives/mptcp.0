Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254190;
	b=cri3WaKaMtD0M+DuCoT0/IWi+lp2WrbcnQX4nqI/jmP3K4Wqmi6/BZyZAyLbBDT4KuRv
	 rQMc67v9znPoimzpIIU3JjF+XKG6wlbjcU3VTuOOxpSKcO/QAYiLlPxb0Zfhe265qS/CJ
	 g4IT08C2smt8t5uvJxxxHkb8v3LWll2OMA/ssL2ivfJjD17gQyEqoaPh48h4T2Sv5Wfxv
	 yJc8qlFpevpVjyf9F/OkN723nOtEo57CGIfeXZuAya0xYccRsYCEZ6mWb9U6MXPkA2yHa
	 RZTNAqbq9f/WP48am9rfzoH61OdRW2jDlzkMyNqvJVGGOkZIV9m9QFOAItgU7goWpRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254190;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UXcc8JwYt8zYKqhNDrcXR1cy3Cf1frwlR2EKSmzVSdQ=;
	b=vCaxgAkTIAFI417tyOPDyfAwMpMOOI9locH2KfYkMMo6BE8Vdoq7h7cyRgdz5Wgw6vne
	 P2NdOKbhvby/KNV3WDZVw6pFk+pLCkIY2/deYpUE1oXpKLbqSX/ipv/bPGjTG5n0OqMAa
	 m/5BnmgvLHMjrVvwmqjhRCir1rK7ei5v90ZjFsQ3FlahVJGIR6MK4zjn4Pdd1lPReBw9o
	 GTegJdJkd8Dgu4WMmmKZt1nnXnK4sfRoJ7DEloMFbf818VJUF6S0mbUUBg1H1b6r59ZMG
	 1JduktU+SlEHR2crIxCxuAH3Oq2Q2hgGL47FSqi/3X5T4hKvzJECjagXTCqI9K5OO8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBXxVbSy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771B606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBXxVbSy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC2F1F000C0;
	Sat, 21 Nov 2026 09:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254189;
	bh=UXcc8JwYt8zYKqhNDrcXR1cy3Cf1frwlR2EKSmzVSdQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VBXxVbSy+ifEGDiDT0bAVlgpQSXdWLtqoEb5M7vfDKCjs+SgGJjGL8wUxiSKVjGPZ
	 CBffZ6pgIzlY0E0I2k2fbTydvdXWFeUk5IDCakW6z1mW6OxGyxZwoIsEKW3UHMKzLC
	 mrQ2yCLwT8jhDSllCrEtgawU4zoeDRXr9GFMGbXfLrCCtjl8a3MKMlPuTj10Q73LoK
	 flXnEgCDyEslhaqDNyq6pcQ5wA8jUEj7J1wxT3vtpZlogyH1ioQGTkcl2/KsCnTOG8
	 iWPMC15XIgtzfEe6HbRRnNYIgdR2EV8bBgROXbd69p7mCKgACv2PFGvXrZ93y3Xkr8
	 7NaLxcaR6Fpkg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:56 +0100
Subject: [PATCH mptcp-net v2 58/62] Squash to "bpf: Add mptcp packet
 scheduler struct_ops"
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-58-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=h6gnjSCNm1Sd9n9hCte5uKiRUbXll74ViMDdH1viP3o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ00u2+nw13HcjJuin+IItzUs/3G6TelIiqfSvatfJC
 5bBou+SOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZy5hcjw9S19rl1/TdjZ3UF
 y3B0Pq659uh38qNHLLkXFgavSsmy+MPIcPr4y7cC8kb18mdEOMQPsm/xb7x5hm+31f6ES/bH7C/
 PYgYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A BPF scheduler can return 0 from get_send() without picking any
subflow, e.g. the bkup one from the BPF selftests, when all the subflows
are backup on both sides. With data to send, a DATA_ACK received while
the msk is not owned by the user then makes the push loop of
__mptcp_subflow_push_pending() spin forever, in softirq:

  watchdog: BUG: soft lockup - CPU#2 stuck for 49s! [python3:182]
  (...)
  RIP: 0010:bpf_iter_mptcp_subflow_next+0xf/0x40
  (...)
  Call Trace:
   <IRQ>
   bpf_prog_bf2471f1d206d5cc_bpf_bkup_get_send+0x78/0xd7
   bpf__mptcp_sched_ops_get_send+0x4c/0xb0
   __mptcp_subflow_push_pending+0x148/0x390
   mptcp_incoming_options+0x836/0xba0
   tcp_data_queue+0x6da/0x10c0
   tcp_rcv_established+0x2d5/0xce0
   tcp_v4_do_rcv+0x13f/0x300
   tcp_v4_rcv+0xbff/0x1200
   (...)

Stop this loop when the current subflow is not picked: if another one
is, the loop already stops after delegating the push to it. The default
scheduler always picks a subflow when returning 0: not affected.

This issue has been found by an AI code review agent, while reviewing a
patch for the BPF schedulers, and confirmed with a reproducer: the bkup
scheduler on the client side, its only subflow marked as backup on both
sides, data queued by the client, then data sent by the server, carrying
the DATA_ACK causing the soft lockup above.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
---
 net/mptcp/protocol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 174ffd0d3e68..09514166c98b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1961,6 +1961,9 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				keep_pushing = false;
 			else
 				copied += ret;
+		} else {
+			/* a BPF scheduler might not pick any subflow */
+			keep_pushing = false;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {

-- 
2.55.0

