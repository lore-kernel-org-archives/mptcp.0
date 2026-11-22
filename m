Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318676;
	b=aGsxDuAzrxWhLXGlDIMRJ2vP6ttB02fojZwZLVyUJpJMUsfJ2ZveHdFaGhsPC63AJQ3C
	 oAU2h0YgxJ+/bCD4+FnjHCXcidvBZy1glLKr+eNZHEZ/H59zKKn1YR5AYaE8gWHYadcM3
	 ak5j4No/26+9URRiel+bgXwi4VzoWLHzX17ntIh0TmwmSUDIeHZ9HUqLI8GGM+voT2mgT
	 EUxu36sJV9l13NXghPaN+qnoExhFbq9GDRxAex58Zbq4jPN3qDa4FLIyzFHvcC4XRsBlM
	 Y3EV5xXjd9K6StTFrgJYsKLNkP7uf0SglWf1dapMd32OMvb2mXLFkn0Z4+Q/GOw5jpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318676;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xzgdi6tixpENAajuTDo2lKhr0psohkrbZKpP6EdA4a8=;
	b=Z9yNaYQ2zCHh089COIwGB2LYqccdIhBE0qm9stouPEDnQZJDFIoNIyuPVBpcHQ9YOmZP
	 PvGsRlZcC+vmIeUHe9mJzPNOzolIWyZx/kCNP34/PvSrYa0ccLjVtCifX3LNK+9IitfMg
	 JqjjPEHaKUxdN2z5E6czCeM0mPaiz2X5ylNHPlnvOYaOF11i2e7mm11JJj6RSatNmE/kR
	 ndpjgKn8qnMbA3Zn4N6u7Kjo6qcXt2k47pVxR+5/3IizDhzI74RLj4ViQo2/K08vRhD0K
	 3j73aWFeou7x4ueFQ65nSAi+KaaKwUc7FL3hOEmC+7K5uUt6tRV+qXawTU+37yYisWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dq5OJpql;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172B606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dq5OJpql
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09941F000C0
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 03:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318675;
	bh=Xzgdi6tixpENAajuTDo2lKhr0psohkrbZKpP6EdA4a8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=dq5OJpqllHfTnJXZ8XsrePHxJ1Vx0XzEpddno2Cd2tXdE9lz9WIlw+IReBkOgjco1
	 jL6xSgi6y3uKtpW5VTpj1VoNsONKOZ5XRVTCm+wjrNz6pCtUU3HXiRJiU/lcqNUhXQ
	 qCzIHdrOUR3Q9PGh6YacgARREhKWHGjyGq0cG9f32AC9RYVCr70Nalkez9YVnv9Vk9
	 qlq/g39Vsz7fp2/V78RtzbqTIErVDAFzKgCEkkwIkF/Hvd73phTR8GHqE4JqEaX8zt
	 hyLxJlB77Otgc4Zbp/ics0zlaCsd+HNcZHtRLqMJ4bAhsuWoUktmRNVFdDKTBt67XU
	 BObk89UWfUKIQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/4] mptcp: handle ack_seq advancing past rcv_data_fin_seq
Date: Sun, 22 Nov 2026 11:37:46 +0800
Message-ID: <84d2d4f05df024cd45c1936a3d53ea1d2797ae2a.1795318567.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795318567.git.tanggeliang@kylinos.cn>
References: <cover.1795318567.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Change mptcp_pending_data_fin() to check if ack_seq >= rcv_data_fin_seq
instead of ack_seq == rcv_data_fin_seq. This handles the case where
out-of-order segments in the OFO queue advance ack_seq past
rcv_data_fin_seq before mptcp_pending_data_fin() runs.

With the strict equality check, if ack_seq advances past rcv_data_fin_seq
due to OFO processing, the DATA_FIN would never be processed. In
ESTABLISHED state, this causes read() to never return EOF since
RCV_SHUTDOWN is not set. In FIN_WAIT1 or TCP_FIN_WAIT2, the connection
hangs until the close timer expires.

The new check using !before64(ack_seq, rcv_data_fin_seq) ensures DATA_FIN
is processed even when ack_seq has moved past it.

Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence number and add related helpers")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index be23768b6d05..5ade9c25d0fb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -569,7 +569,7 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
 		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
 
-		if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {
+		if (!before64(READ_ONCE(msk->ack_seq), rcv_data_fin_seq)) {
 			if (seq)
 				*seq = rcv_data_fin_seq;
 
-- 
2.55.0

