Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1EC43BDB9
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776118; cv=none; b=pAmWvtRj32IKVHPU0cZ/dsaFkatxxBSIXfzbg1JuZS2U2eK+fUPmmtc2TfxhZvOWiMusJ5NQr11z6S7xgzPcUQJmipbOqNX+RKA0uRhWcmlgwTu6wAwFXsu1mb3S/RMV09/NmQY6CcdU3Aw/3XHvIEtYED0MH/rBvjXVYFnscmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776118; c=relaxed/simple;
	bh=fltR40xsO63hDr38RsKLkR5OCy59YuLQb6AMAdbTmWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7/BAHIicMDNXkz+pn6ztpsT2AlLbSznsdygKltATfaXNPp3Er8bNas8XxKnvwF/U8xze1a25FUJp/6JytxZaiEo3m5OUE3oowBoxkTTIe2eNfYPs7AgYdvs5n/v6vil02wTaQfZ1a/60TpXEaSNmM4Cd4Brpke6SGEpIlimYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpU6CxsV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpU6CxsV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E902EC2BCFF;
	Mon,  7 Sep 2026 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788776117;
	bh=fltR40xsO63hDr38RsKLkR5OCy59YuLQb6AMAdbTmWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fpU6CxsVJfqc7zRPD4lCSQd82Eac7PgMfJlf8en35+UUPkg1RTj7iydLSqdJZJxp3
	 WAkiHAKdNkIUxsBA2Tkzr1bnQGzzUiag2CqcREgI6OKmtn7BJ/oSNbIyXKkk9FQwtv
	 SY+MsAV4vRMUxwd9r/+VWZ2DvrhGaPgRYFAVhIAcKN/MhUrpVV8q+rwNmmSZPTHkuA
	 fO7whd6WfIrH1m0fqyVs/5yFdYX+vFF/Baeu1ichccLLxBfYj6ksTMNTk5NDvNWAyG
	 gGUP/JIYXxI7d0dkZn4sS6wGSxF/ppouU23Qg0b1wSuqedugsr6Q/oxnUhgio3Eqlg
	 U+K89800xfEQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03D1C79F9F;
	Mon,  7 Sep 2026 10:15:17 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Mon, 07 Sep 2026 18:15:14 +0800
Subject: [PATCH mptcp-net v3 2/3] mptcp: fix data-race in
 mptcp_subflow_get_send / tcp_ack
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-mptcp-snd-una-race-v3-2-65ba0d5f0221@proton.me>
References: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me>
In-Reply-To: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: geliang@kernel.org, matttbe@kernel.org, pabeni@redhat.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788776116; l=1235;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=06AW/3QX+jM9WoTzq8ffD3/zCT6sKnkg6/dgcHOi06Y=;
 b=c73TL15YQPFqkQA02+etGUUBQTHZZR42Wedvp3z7VeJXVC7uV8vY5lLZFFiuy0Illl/tm7mxU
 A4koShh/F+HCHoLg0Mh1y6dnSG62KndtTxQ53psg0BGuhbHdgB3mT9O
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

KCSAN reported a data race between the lockless read of
icsk->icsk_pending in mptcp_timeout_from_subflow() and the
smp_store_release() performed from tcp_ack() when clearing the
subflow retransmission timer.

The MPTCP socket lock held by the reader does not protect the TCP
subflow state. Use smp_load_acquire() to match the store-release
operations used by TCP and the other lockless readers of this field.

Fixes: 33d41c9cd74c ("mptcp: more accurate timeout")
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0b24e0afedfb..f4f63df9d787 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -606,7 +606,9 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
 {
 	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-	return inet_csk(ssk)->icsk_pending && !subflow->stale_count ?
+	/* Pair this lockless read with TCP's store-release updates. */
+	return smp_load_acquire(&inet_csk(ssk)->icsk_pending) &&
+	       !subflow->stale_count ?
 	       tcp_timeout_expires(ssk) - jiffies : 0;
 }
 

-- 
2.55.0


