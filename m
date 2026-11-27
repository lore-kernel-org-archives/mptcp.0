Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809735;
	b=Ke5Ls2nnPg13oJ6aBdvB/cbnJFANTbyYUWsv6vtXy00+k9+fSYJj6G+cCwy8BLfJpgPD
	 B6ky2sh/KdRVMMYflCIyJuJP6iP48B9OMNfBnhWWtA4mAq09c/Hr0nl9li/NPhkvNt/Pp
	 iCzbYof7LjobkxZpfAy1MH21vCWqqTR34O+gpaNB1GAgmKPpQu+7teJbYvropGvZL24k8
	 ndy3dGlenwPM0o4Mixl0C8dSihniPxJ6eDuh8Ut3QvPEezzRclx9c66QTpH3BQrCI9/YY
	 qZ/bDNFxLcIuGvWMDPAzEfVahbGGPCVnv2xWHoZmP+7/54b3thmFPDU0IcFuxW06ZPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809735;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DFQ1hpOaMm2rdt/a72yde8yXWAdIzaaPnZ9cXPEfTOU=;
	b=pvEhx4z109f2juYIsW48gUo3lFNN5kxojHGdVHwNVkYN2CeEnl92rwV7GvWeY3n3xQoF
	 1//buFqpWHf82vLxQUv6fGhxDwlVgWlW6plW0jK1V9mCYt2bbWIz0DqKjyNVNvB/f6I0O
	 0e4jst3Gz7dvAL+CnRT2IQ3eL9ZUJCRUKqeHHHwdYd2/PtdlkaPG+leHzPJIFLHRTZ+HD
	 P0+XVq9DSxc+0kEwRjMORvxs5gummxx9gN9vR8xQr+dSw+5IkgWsijAyQ/LK50JqUSkKI
	 P8gw7Xs1749erNZA9YdBE2tELFtp4Ksvp+99Xd6uEWM5uppLMvsE/MQYXqAta4oXBKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STbGPvy2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC2606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STbGPvy2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0171F000C1;
	Fri, 27 Nov 2026 20:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809734;
	bh=DFQ1hpOaMm2rdt/a72yde8yXWAdIzaaPnZ9cXPEfTOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=STbGPvy22gM2NAtpM8PWQXcu4sUbGD22n3nAqBdFXY23LUUxdGCcLeHtqWjBvZSmF
	 6PeC0OhK27a37zsjr3+mP1oncx64ETImttDIRDQ+9N+JHFul2VulMqRLlY0u0Fs1Od
	 0DALRaEexk3HMH4W1+SG7JN6OnsaVB9zPDYOqmj3azHOMxV4iMja2h6Hor4sjameOz
	 gtZMT9wNDOCPCelZwPDDGU/yCIxkygSlBlVYVvc0AFm6hlBg1gYRYHdmpiS55XNetH
	 WiMRkl7FXVJGxKRQalpWBdE6kD2pHO1cHgSHHPpoREAlm2+p00u1Fj8/wwWzEMJbdN
	 KaPCBs8DaeKfQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:35 +0100
Subject: [PATCH mptcp-net v4 11/20] mptcp: order write_seq and DATA_FIN
 flag for fallback
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
Message-Id: <20261127-mptcp-cmason-fixes-v4-11-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2732; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pl5V7Eylpb8n3lD35WYS29Wn0SsfQislqnlrSdn0FRM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H66/vdpfx3tDk7bYgo60Irb4N0dMW208c13td234e
 MHZ++mTjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImoCTD8M7h5oWDGd5UZtdts
 wv/4fjBvCWQvDAy2a5g5aUXk5nXblzP895/CcNXQpXHG+dCURpvn/KYJLtuWP7ux9fyb0pxT6WV
 KHAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_try_fallback() can run in BH, without the msk socket lock. Since
the commit mentioned below, it reads write_seq after
snd_data_fin_enable, not to send a FIN before new data. But it reads the
flag without ordering it with write_seq: on a weakly ordered CPU,
mptcp_try_fallback() could see the flag with the old write_seq, and send
a FIN before the last byte of data.

Read the flag with an acquire, pairing with the release used by
__mptcp_wr_shutdown() since the previous commit, to read the new
write_seq with the flag.

This issue has been found by Clashiko, while reviewing the commit
mentioned below. It is theoretical: it has not been reproduced, and it
needs a shutdown racing with a fallback, with exactly one byte not sent
yet. Still, it is fine to fix it like that, without real impact: the
release/acquire pair is cheap -- plain accesses on x86 -- with the
release done once at shutdown time, and the acquire only when falling
back.

Fixes: d0e88ecfae68 ("mptcp: don't send a FIN before the pending data on fallback")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue spotted by Clashiko
v3: only the acquire, the release being in the new previous commit,
    fixing an older issue
---
 net/mptcp/protocol.c | 4 +++-
 net/mptcp/protocol.h | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2e3b34597380..7cc1715f49f9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3688,7 +3688,9 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 
 	/* will be ignored by fallback sockets */
 	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
-	/* pairs with the acquire in mptcp_data_fin_enabled() */
+	/* pairs with the acquires in mptcp_data_fin_enabled() and
+	 * mptcp_try_fallback()
+	 */
 	smp_store_release(&msk->snd_data_fin_enable, 1);
 
 	mptcp_check_send_data_fin(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a9daa047203c..59ddf3dafeba 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1365,8 +1365,10 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
 	if (!__mptcp_try_fallback(msk, fb_mib))
 		return false;
 
-	/* no FIN before new data: see mptcp_check_send_data_fin() */
-	if (READ_ONCE(msk->snd_data_fin_enable) &&
+	/* no FIN before new data: see mptcp_check_send_data_fin(), and the
+	 * release in __mptcp_wr_shutdown()
+	 */
+	if (smp_load_acquire(&msk->snd_data_fin_enable) &&
 	    !before64(READ_ONCE(msk->snd_nxt) + 1, READ_ONCE(msk->write_seq)) &&
 	    !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
 		gfp_t saved_allocation = ssk->sk_allocation;

-- 
2.55.0

