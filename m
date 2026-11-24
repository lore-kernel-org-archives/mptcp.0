Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557705;
	b=D7S1r+ST/ewTpp7RhCVg1yraV7/klyGauB3VusTc4AMyy+mpCZZ+9b+dtK9v2My+jekD
	 As11wQSgfbnksSbHLURZhMEER5vIj/WfMrb+fyw56juj2JYwEcXs0Mo9v5jaquBin3yuB
	 MF6lQPFqMcw9VYBei13F4ZMgFSyY3WT1MA82MNhCb2LTCx7HFniL1P+V060dkR/8llTss
	 jNToRqU261pDuESJAVHFQo/laByeVEOXMe5BaJNn+2UmK1AWvlXg9BOg0xJD5Ch+RgaQD
	 1GSgDfB7gn39SzDakQrtnP2r6iKSN3WJTQH0iUnptK7OM1hS110YmY8g6Xyus0byDiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557705;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=TzDTzRvo+7IVefhsP1uRXe2C7YrGVfjeLPSV6bKvoXo=;
	b=lCkrgj2ErHmbx3bUU/981NBRSzv7MTiEJvEF4RrUrt0qjIczCCiHQwHO/HRZco+ZGX2q
	 S+zdj1xjk8prrgNAWnTh7ScIebc+NGWiayuFpAvDtWEoRIXrR8dYPx/VRrdio8AA4Y60Y
	 YlRpp4CVnWIvMoYmdrSsZeus7y0vRIdek9d/fa26ownSVys305Rrb2m4YrkkvkEcmCnMb
	 tS60DXI2HK+OwNtPhtGQg3tLzQJqIpu3vN6hQkmL0mOKIhOZgJ00Zz1gxgITAUixBlhqo
	 ZwB43/FnYCGztD33fdJp10DpyBCzrb6s/Vzgva3XmtOUQan2lnu8QsCcQblB7DI+6Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DukzyMgt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282B606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DukzyMgt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F111F000E0;
	Tue, 24 Nov 2026 22:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557705;
	bh=TzDTzRvo+7IVefhsP1uRXe2C7YrGVfjeLPSV6bKvoXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DukzyMgtJy35lEWRWHP1trkctA9YrDY63J1gYxZKYEmdTBNxWioecgDOSc0crY065
	 WUEnT1tnaaMJsyQIQ2moeseBUOdaGQo1u3TIE7oXw1i60OLQgDA9zNQa89EVeDDHbO
	 SWzglDuCJuGIy6bXz5/3LvA0VxC/YJVW8kEU57Tksta4r5ZFIkKSZSudzq2A5LY0Hs
	 IioSEOxDucx8ep8FC9mBNVmuJcFL4fpsfBpqK/1msszY72FknpzeV96XafJaYfFpjM
	 0DnBl6tims7TPdxWO388qUBhi4ltqSb2TRU51MIQdOQgLZke9vq0HjgILt6h3a896/
	 08EXvhOAlzOFw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:55 +0100
Subject: [PATCH mptcp-net v3 38/50] mptcp: move to ESTABLISHED after a
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-38-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2324; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=F35SWgZ2Re/nV1Q82WD/8Bh9Eu7zNtUmuFey2DOAdHY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOPnqjT50hj/dmiaw+wL7hcITJmfnrkyc9+bfLtnlB
 569Xz/JuaOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiPc4M/6yunDwf7Gmx40HW
 9tJuzTin+duFL1SsnX1w58pw+VcuDYYM/8zdvkyo5bj8KceNOSTixMmZ8xbp37qf/f5G4O1l0fl
 CMbwA
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
index 439a11d92281..190c75311ff6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1988,6 +1988,19 @@ static void subflow_state_change(struct sock *sk)
 
 	__subflow_state_change(sk);
 
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

