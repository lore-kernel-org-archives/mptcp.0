Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809726;
	b=CuhX6SuNL61pTNwtgohkPTWrrzQFmAnvLPDSvctwPgQLdo9QIMIOZ9nBq6QKshyZTE6T
	 eKsk5IDYqVXLR4XdwsahBI/aR9cUROnWroYSnH9gtTU3v5bxGdh0kX6R8A2LWCc0hh5EJ
	 O3ZfdwluQgO7bYBgCJ8uGfH1Bb//Ao+0a5MnT0ouVONhhZHKJ/B7QsoMG5zTTCLxacy2N
	 Cx4P5jfElS8X0bMuH1b1a4N5H13S2Ou5Xx/QlePSyy3oMCw9f1IytfURV6lfPVMKbInZn
	 NDpn5HxO8zbkp+rMTrbgcKJzhap/bpxRO7fG1zyX44wRhtgtjNp6KaPoXanlTotsEyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809726;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bX3jVeD+Txzp5tC3cxFRY0of1S2d/ScRneQSb9FF1H0=;
	b=2UYKg3W+ALfMtf6DwWb9++UR5ednmbhYEJULz3XhzMow8JHsuJPZJ4tSYt0cQnvAUZGx
	 ohHzwcsqAUJ6eOfzpbt4EbDKZLJeuMiHqDeQT9F2cuxtOpd/lcz6v0/4/rVaHm57LpshT
	 uYTocrsXYT4lGJA188+COmlpv/pZi5Vqhkw54i3GOV0JXho5+rqzaooayXhekCsJVAEmp
	 9kQpe4gY/Xy6kclQDw/+3Zuj6m+/r+5rIK9t1X8DWoCzdpAeovi+z6HcSarGSmPIgNgof
	 KowpP5De1LHLg91KRUxNUQEIJ/hcIC/kMhfPkpbgh2fQViN3djfj0emoxCduGxeMSfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QymycsxG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBADF606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QymycsxG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DB91F00893;
	Fri, 27 Nov 2026 20:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809725;
	bh=bX3jVeD+Txzp5tC3cxFRY0of1S2d/ScRneQSb9FF1H0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QymycsxG688+Jw4HnAMzWU89P/o8d5GpzrD5RTL07rnDQ8SRH3d6Z+cBqRpM3qQIg
	 j+0z/MV8riZP4US6iYPQc3meryneYq+JE79G3aeomHxG2id2y+bXK5dwSqqm9MSBNj
	 VYIHhD87UHROKGO03FmchNR64q+L/yTWcHkbeFQMr3BR/kxrhPGqXHtakSXpiRvgNY
	 bIAcIxu4NojCWSgeEAA8Czrg+3/sdYikSGSHeEaiPBddVGP+CIgqFP5WoebwUNXPr0
	 HVfVQ2NQOXN/A53rE177R6uUZfD9DCOL5jbw17rKG7qpiTwVoZMN8q/m/CgJ4Oxy5C
	 FH60zPlx0HqqQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:27 +0100
Subject: [PATCH mptcp-net v4 03/20] mptcp: move to ESTABLISHED after a
 simult connect
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
Message-Id: <20261127-mptcp-cmason-fixes-v4-3-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2307; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=q6Br2jQ29DAPvcvsi9ljACZCog0LyW4qm/jD8K7Lxpk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H65wDH+2aLZjvlTOFtc1zwLP5VRvWKVwXG13e6nIv
 HNdM95bdpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwk3ZORof9HRe884/6J+w/X
 VSz3VJm4UHuZw+I9C2wmH/i5ek/XGWdGhotFFWyfEo5tvZJTEyZ0pOrJqRYzy+CHaSxenZVbDp5
 mYwIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After a simultaneous connect, the subflow moves from SYN_RECV to
ESTABLISHED when it receives the peer's SYN-ACK. Since the commit
mentioned below, the MPTCP socket only follows when
subflow_finish_connect() is called, on the next received packet. Until
then, it stays in SYN_SENT: POLLOUT is not reported, write() returns
EAGAIN, and a blocking connect() waits, until the peer sends something.

As it was done before this commit, propagate the state from
subflow_state_change() in this case. subflow_finish_connect() then
returns early: also check there if MPTCP is blocked, as it does.

This issue has been found by an AI code review agent, while checking a
review from Sashiko, and confirmed with a new Packetdrill test: after a
simultaneous connect, poll() is called. Without this patch, POLLOUT was
not reported:

  simult_connect_write.pkt:18: runtime error in poll call: Expected result 1 but got 0 with errno 115 (Operation now in progress)

Fixes: 71154bbe4942 ("mptcp: fallback earlier on simult connection")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent, after a Sashiko review
v3: also check if MPTCP is blocked, as subflow_finish_connect() did
    (Clashiko)
---
 net/mptcp/subflow.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d485326980ca..330971e817c4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1998,6 +1998,19 @@ static void subflow_state_change(struct sock *sk)
 		return;
 	}
 
+	/* simult connect: not finished by subflow_finish_connect() */
+	if (unlikely(!subflow->conn_finished &&
+		     sk->sk_state == TCP_ESTABLISHED &&
+		     inet_sk_state_load(parent) == TCP_SYN_SENT &&
+		     mptcp_check_fallback(sk))) {
+		subflow->rel_write_seq = 1;
+		subflow->conn_finished = 1;
+		/* It looks like MPTCP is blocked, while TCP is not */
+		if (subflow->mpc_drop)
+			mptcp_active_disable(parent);
+		mptcp_propagate_state(parent, sk, subflow, NULL);
+	}
+
 	/* Rx queue processing is unneeded, error reporting will take place at
 	 * __mptcp_close_ssk() time and subflow reset can't happen in case of
 	 * fallback: subflow_sched_work_if_closed() would be a no-op.

-- 
2.55.0

