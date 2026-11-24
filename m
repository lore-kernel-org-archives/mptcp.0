Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557680;
	b=KrVEPbMsfysvrJvjG7Fkq3tfr5Jh89qSwi0eMCw9hcLWNn+GEvIuymx9GUWRjFlcZ21H
	 vxlQR0QeATPTmld/oaEn5yqAOEHpZwTAqex2dxNfHz6rPsPvbSry2aPazhWeQVPGZf27+
	 9yKkT3eysaKnXfJ/XQ5k9kvPUMV0f3V7kbgCY3WdbKLllYJ/O66JcSmPXsgjqoW+3zh6h
	 tfGisnEiZ3YJoy2sEbF6U+BmJoAZrqVtAm4iGT9strluq8emsqhVvhdtz1Wq0+ODKJxDi
	 MUcGWiyKvZUz0CKMT1ie2B4P5LRQawBEAsmL2WNArCk30cdAhtYJXJn8aSEmYvE6tmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557680;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zBGah4EmGUH3pDG2nlvhXDiNZ2Gmxwj0IOr8CwyevVw=;
	b=Q/rQHkQJ9R5nN0pYRXgdkVhHSju6ACSptSWx/kRBSnJhJZbC+pXkQJI1ymt7b7+7Cjiz
	 sLaW1caODpKaOtybFE4wwc6Fk5PcjgrAr67UnzKpt/G2u779wnbeViFgNIGT3P5B9clUd
	 traB5Hoz03B9BRpbs2ICGFW6I71nXleYktsG89Vg1uuS4Jh1KaSsdUIMKl8btqkFCdfbo
	 faRGjHwGRqpixqvkiACZcSmfMy32jg6/uTefz4QxzO9QQPHWuCqS3ZeusrYNEXGSaa8Q2
	 cN9PY0eE1Z7+QqGSjsx2Q47iAiMcLZh0xUGbJm8luFP0JkhA2JghJt0UpaD1XwMBgsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b4lzEhVD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D6B606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b4lzEhVD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147C21F000C0;
	Tue, 24 Nov 2026 22:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557679;
	bh=zBGah4EmGUH3pDG2nlvhXDiNZ2Gmxwj0IOr8CwyevVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b4lzEhVDQ/oTk+oiRe0S0JLZvHicHtsZlTiqkbgzHveH+57hRBCQojX3CFhLHLa0W
	 0FwXL0cQ/15+NfeOa6QeecsOrXROeJlAoxGOSsxq+VUU3xeC7E5GVyyztnV2QU5Ycu
	 EwIAy4lzK7LN3k7cUfYrkgRuMIf0X1nEOF4esr/w53d74LFvMRyasfvuiLHygSlgmY
	 ZJYCanqmaarCadkMJdBEI5PgFOhqlq4mi/FAy/eeTUf2UsHa6dN+KJTLUwc+GDG71s
	 wmkGn7G5rGXWyixipXeb5QXqetqRmCgPMbicSo5y4+c5yj7nNhuQ/zcH97l9vCv3Co
	 sKqrBqy4Unqwg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:35 +0100
Subject: [PATCH mptcp-net v3 18/50] mptcp: no fastclose reset from SYN_SENT
 subflows
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-18-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2185; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DRtfIxZFihaTl/+OPHDFWHSAXRjs2KpkNXgrn/k5jyk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOJlWlnfeVq3TdnvhmbbnkaNsYe6ddrn3iqpuxstrW
 X7pX/nZUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJHbxxgZjqYuiGgIWBW2UfPZ
 549b8iQ1ElnrBR6ysgulVXP/v3+mieF/reGBXUf6buzZu5k/8ddW9el8qzdIWfTzmejt3rPJx1S
 dDwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_do_fastclose() sends a reset with an MP_FASTCLOSE on each subflow
not in LISTEN or CLOSE, also on the ones in SYN_SENT, while TCP sends no
reset in this state, see tcp_need_reset() used by tcp_disconnect(). On a
disconnect in SYN_SENT, e.g. with connect(AF_UNSPEC), an MPTCP client
then sends a reset with an MP_FASTCLOSE carrying an unknown key, 0. With
TCP_FASTOPEN_CONNECT, this reset is even sent before any SYN.

Before the commit below, these resets were sent by tcp_disconnect(), so
not in SYN_SENT. Skip them again in this state, as TCP does, but move
the subflow to TCP_CLOSE at once, as tcp_disconnect() does: a SYN-ACK
received before the end of the close cannot complete the connection, and
a later one gets a reset from the stack.

This issue has been found by an AI code review agent, while reviewing
"mptcp: clear DEFER_CONNECT on disconnect", and confirmed with a new
Packetdrill test: a disconnect in SYN_SENT, then the SYN-ACK. Without
this patch, a reset with MPTCP options was sent at the disconnect,
before the one replying to the SYN-ACK:

  disconnect_in_syn_sent.pkt:16: error handling packet: live packet field ipv4_total_length: expected: 40 (0x28) vs actual: 56 (0x38)

Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
v3: move the subflow to TCP_CLOSE at once, not to complete the
    connection with a SYN-ACK received in between (Clashiko)
---
 net/mptcp/protocol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 87f6da0f6cab..6c712f677220 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3321,6 +3321,12 @@ static void mptcp_do_fastclose(struct sock *sk)
 
 		subflow->send_fastclose = 1;
 
+		/* no reset in SYN_SENT, but a close at once, as TCP does */
+		if (ssk->sk_state == TCP_SYN_SENT) {
+			tcp_set_state(ssk, TCP_CLOSE);
+			goto unlock;
+		}
+
 		/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
 		 * issue in __tcp_select_window(), see tcp_disconnect().
 		 */

-- 
2.55.0

