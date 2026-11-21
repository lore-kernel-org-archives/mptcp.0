Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254153;
	b=K1vJrpMEu/lDib/p95uHcVYJEoVv0T4+FFvg8Q0Zglz5+S9HYZUhgqyOK++hU/OboxMP
	 x4UrbfamVk2NXeBqghrE2YwrPtu8cHm7Xe0vvYA/iUcACnAnm1so8wORbOEseP+Sknl2/
	 HMNgo5fq00FZ18BWiNzlEENArLMntJbf8rdQ1MBczeg+N6Th0jJ+yIgdrCjJjMb01cxQi
	 AQfYHV+he+z6LsNmvQ/mZRjRrt7u5c9FUNA4Iwae71BAqJwtJ4VYUsWx2bWyfqGVo4POQ
	 6ffXkFCn/8NzFFzCHRtemE58R3phvt67ZXht/QNql+7s7EBaAR/cS0oAFTSEEuFihpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254153;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=g0TKJq6BW5yBDG2MyIB41N0o0cp95XArJtuOPCPLSps=;
	b=aiaB+6HV66cxgILD99vsYY9Z6jfm0aKY2Y1mxfyOJ8mFN6RZfB0m+rAC/tEkjckjeboZ
	 wkrPohbu+JL8QUJGxb5KArPPr2afzpGWeOLHBzAmojvv8fkPeovYAW8kTcVK4HmTaV7th
	 MZNG/s1OvzXbKoAqhx1cWneXitX9ftnTTPmb4yFBob/YJdw6BQmAzVR/DDxm7f24CZ/DG
	 iHkeMeuL7HN4uT7OSF/PEAEzXzYKwycU+soti5rO/UaYRZ15dnBjjsfzSGKq2wUQiG57p
	 GRtnsp4Cx+It+SNoHnmWIx8ZmVjSDy8mprVRS87Uos9lmi0o1T8UtMexW9FuhWc+vSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6i1mOsV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C36606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6i1mOsV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E01D1F000CA;
	Sat, 21 Nov 2026 09:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254153;
	bh=g0TKJq6BW5yBDG2MyIB41N0o0cp95XArJtuOPCPLSps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=J6i1mOsVyZSulgpCKSOUnhc+/9q9Hj2BDxFgkK22pDYAqv/i7c4+sU3lmQI2kBMES
	 vl/wRTW5+oLY4xRObMdrD6lSi3m5BTl13JU++sHrbVxlKjwjHzHMwH5AD9jmooEfkD
	 i3DV8sRdlQ/AgPALy1cUsn94ddW3BUL/Z66TBu7hkBdpPC/ePIyzkc7TtL4NpjVnOT
	 Bd4mE9DEdhE3mpXYqmeOGUqJfZ0E0O+z6XmGXFmyFy03/8j1SGxwkpeojIVV5sb4eh
	 kPHS5U+VtP7s93OhkEdrLscP6g2xp0yDy2oqyLHEfXVCo3T5+aJ+QoACJXgE9D/1sG
	 GnmfTSOCMJenQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:14 +0100
Subject: [PATCH mptcp-net v2 16/62] mptcp: let TCP send orphan data after
 fallback
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-16-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Zd3W32f/HsMaH3x20KWRZPNpAaYlazEDcUgjI6lBvFg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ00PyDgn61k701uQoNQsN+1f8ZAGTz6ZJnC8yeI8y7
 dlT//JeRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESYuBgZ3hrws9tcjJu/c59k
 KpfGJtcUpqvr3r9TztnbOf1HU4igISPDo5TFf/evT/J0qXthXNIaP/3QzA8rk89E7fcvYZrIsfs
 MJwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After a fallback to TCP, once an orphaned MPTCP socket has given all its
data and the FIN to the subflow, the rest of the transfer is in the
hands of TCP. But when the close timeout expired, the subflow was reset,
and the data it still had was lost, e.g. with a peer reading slowly,
while TCP sends it, within the limits set for its orphans.

Close the MPTCP socket without reset in this case: the subflow is then
closed as after a graceful close, and TCP sends the remaining data.
Unless data received after close() has not been read: as in
__mptcp_close(), a reset is then needed.

This issue has been found by an AI code review agent, while validating a
fix for a similar issue, and confirmed with the reproducer from the
linked GitHub issue, adapted to a fallback: the writer is an MPTCP
client connected to a TCP server. The server got ECONNRESET after its
pause, while it gets everything with a TCP client, and now with an MPTCP
one too.

Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/647
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for a similar issue found by a review agent
---
 net/mptcp/protocol.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 91639ae0c8a0..541bf23d1bda 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2940,6 +2940,18 @@ static bool mptcp_orphan_keep(struct sock *sk)
 	return false;
 }
 
+/* On fallback, TCP can send what an orphan gave to the subflow. As in
+ * __mptcp_close(), unread data requires a reset, also in the backlog.
+ */
+static bool mptcp_orphan_handover(const struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+
+	return sock_flag(sk, SOCK_DEAD) && __mptcp_check_fallback(msk) &&
+	       msk->snd_nxt == msk->write_seq && !mptcp_data_avail(msk) &&
+	       !READ_ONCE(msk->backlog_len);
+}
+
 static void mptcp_check_fastclose(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -3287,6 +3299,10 @@ static void mptcp_worker(struct work_struct *work)
 		__mptcp_push_pending(sk, 0);
 	}
 
+	/* TCP will close the subflow, as with its own orphans */
+	if (mptcp_close_tout_expired(sk) && mptcp_orphan_handover(sk))
+		mptcp_set_state(sk, TCP_CLOSE);
+
 	if (mptcp_close_tout_expired(sk)) {
 		struct mptcp_subflow_context *subflow, *tmp;
 

-- 
2.55.0

