Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254145;
	b=zTUnjAZKSVgEw5Ig3l8e0n8G+r17Pwe4N6Z4SewBhMWQdmLUga1sBE1zNxeSC+O8Vndo
	 N6P7P4+D4mXBCkjEuotRy34u5o++LaHjqeWuQ39uK+CIbs8Pp5BEY1YS5tUxNP+ojt9qo
	 OTfwqVXBEeocOwKmt08GSfMSs+Im7b07pZLR6wIsdRfGS3jsZT91FuPBxOI7pQVx/v6pT
	 b8MvG1ax0gsBjLiIamFHzmyEKEHAR7qnQMVpsipIs/QtRTcI6SsmKu3WbilPHuwM36DmP
	 YHyQlJnTHpALrspx1UUGRbgZMVdoNrPpCO69PRwOt6PbiiP9S5Vo8N87lBneeRAfeZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254145;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NrHRiJJjs6LTRsR4S/VnHtaXqyEMNcfnoaoksDZJkCg=;
	b=cAiDDU5KddeyNFy6dk+32o1bzDQ0vUGxPlZUeWibtLpKL5nzsbvnuNfkB+22aEm0+5V2
	 h3UGSOhxhxBspRQrzjnwF0U1rbZVoN9LoGzgZtqHTDnCemHBISytg+mikxLy6hEag5agm
	 kaKlFFXaTNSjgYruLCzbulrSOmZNTdXbAifhIjiUzeWknGN6TvILYW7AYQPQkc5Db4jes
	 vyjNKtWjhF7smTgF7JIMFFfO8MiGgF/ubW4VMMrrZg0K5DUdvs4j5HdkNVtuNJ/KKbI9h
	 lohA03wJDsyECnljnqkelpjgsUUV+++MVaoBHXj3ZMXdufjut5Go/AHqTinJSCaTDZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdv8MGu2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E081606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdv8MGu2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737F41F000C4;
	Sat, 21 Nov 2026 09:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254145;
	bh=NrHRiJJjs6LTRsR4S/VnHtaXqyEMNcfnoaoksDZJkCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mdv8MGu2CyOn3FU/j27JGutw9X4asVtO9Y9siKFw8VWaw3CB0KG2sc7OhNf8D/0J3
	 /vahS+MAL50Vs3m0+t5NY0cHQnsnI5MPKfiMw9XNdjhUaQ3JHXRe1Ar9fVwPXp8Kwf
	 LyxOa2lIe1N+SK9zQGuqElCH0iYqaXvO9zKexxPVev9sUEcb8g+8fPbKGPAvnwRK01
	 S83hhuibz3kQ/i/vt2FEjLrs11fLqMUXQDLTfdNRBpzBVCivYQMap+npcWpz0r+z7e
	 IyzxN5TbGXqtcqchiCSJeNOQ/NjvfcODEumInkOavfg86f3uqMKhTDLtpP8/GjSWsW
	 o9MEirDVQsb7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:04 +0100
Subject: [PATCH mptcp-net v2 06/62] mptcp: pm: don't drop an RM_ADDR
 because of an ADD_ADDR
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-6-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3702; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RhpWiFJOubzzETB5WHE8QdEog8R7ekloOjGRrIx0VK8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ032+T6uZXZpSUVWnzKJ+ipWve7Fisa2x9bXWnDtzH
 nvlaKV2lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATOTLaYa/MpYld+dWxDvOf+W3
 /xp/+bmJnTonzjl4lk2fp/PISairheF/+CX3jrvP2J0nSG9gWvZl46I5E7iq/3Quq7t/yyb62ud
 UHgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Josef Bacik <josef@toxicpanda.com>

mptcp_pm_remove_addr() gives up, and counts RmAddrTxDrop, if any bit of
pm.addr_signal is set. That dates from the time when the byte was
cleared as a whole after a signal had been sent. Since
commit 119c022096f5 ("mptcp: fix ADD_ADDR and RM_ADDR maybe flush
addr_signal each other") an ADD_ADDR, an echo and an RM_ADDR each clear
their own bit, and they have storage of their own: pm.local, pm.remote
and pm.rm_list_tx. mptcp_pm_announce_addr() looks at its own bit only.

The callers have updated their state by then and ignore the result: the
endpoint is gone, the announcement is forgotten, and the peer never
learns that the address is not valid any more.

When the bit of an echo is set at the arrival of the peer's ADD_ADDR,
it stays set until the PM worker has sent the ACK. An endpoint that is
removed in between loses its RM_ADDR.

Only a pending RM_ADDR stands in the way, as rm_list_tx would be
overwritten. A pure ACK carries the pending ADD_ADDR or echo first: up
to three ACKs are then sent at once, preferably on a subflow that is not
being removed, until one carries the RM_ADDR, and as long as they carry
one of these signals. Otherwise, the RM_ADDR would go with the next
packet, which could be sent on a subflow being removed, or after an
ADD_ADDR re-announcing the same ID.

This issue has been found with the help of an LLM. It has not been
reproduced: the endpoint has to be removed before the PM worker sends
the pending ADD_ADDR or echo, a window that a Packetdrill script cannot
target. This fix is based on code inspection only, which is acceptable
here: the issue is clear from the code, and the fix is small.

Fixes: 119c022096f5 ("mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ Use mptcp_pm_should_rm_signal() instead of a comment. Fixes tag:
  119c022096f5 instead of 42842a425ad6. Commit message: remove the
  number of attempts, say which packet carries the RM_ADDR then, and
  when the echo bit is set + how the issue was found, and why it is fine
  without a reproducer. Send the RM_ADDR at once, with up to three ACKs,
  instead of with the next packet. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: send the RM_ADDR at once, not with the next packet (Clashiko)
---
 net/mptcp/pm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f1f4b13c5459..cdd62433e0a6 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -526,10 +526,11 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list)
 {
 	u8 rm_addr = READ_ONCE(msk->pm.addr_signal);
+	int i;
 
 	pr_debug("msk=%p, rm_list_nr=%d\n", msk, rm_list->nr);
 
-	if (rm_addr) {
+	if (mptcp_pm_should_rm_signal(msk)) {
 		MPTCP_ADD_STATS(sock_net((struct sock *)msk),
 				MPTCP_MIB_RMADDRTXDROP, rm_list->nr);
 		return -EINVAL;
@@ -538,7 +539,16 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx = *rm_list;
 	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	mptcp_pm_addr_send_ack_avoid_list(msk, rm_list);
+
+	/* pending ADD_ADDR and echo take the first ACKs: one more each */
+	for (i = 0; i < 3 && mptcp_pm_should_rm_signal(msk); i++) {
+		u8 signal = READ_ONCE(msk->pm.addr_signal);
+
+		mptcp_pm_addr_send_ack_avoid_list(msk, rm_list);
+		/* no signal sent, e.g. after a fallback: no more ACKs */
+		if (READ_ONCE(msk->pm.addr_signal) == signal)
+			break;
+	}
 	return 0;
 }
 

-- 
2.55.0

