Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557675;
	b=r5L7VWI0GJ1/6+JM+6Y+UMAzRzvjguFVo+H/P/3e9OWhHk5GFFd9C5X1k0HagK6aTtNy
	 jwqPPadIW/ea2IGji1wzOAHiQpYbZQTjAA+mnhHVde1rAjVtbVwFmrfLXiiRA8by3qKOt
	 d4erJjzFSrsV2MeMzA4OW2F4eyOXpGANyItjhNWCOe45Qnn88eD58hZPrDFoavP0GpfF1
	 AXpVNRekfuYnBMlOZ5oQ3kWncJVzgKdRXa80wQTorHhIG7zNsVVMEw8/MzQbkILZUWO4l
	 IzQFXQ/o1zL6P7c5Dw0wrrOF27+P/3JNX70u5mEWV7jsg3HpTgc6lCG1EXaxBg1ag8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557675;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CHg6cLp9gikE6OWNrdw5FOnL2uaA/b4N6CHoNbIqYUw=;
	b=Ge9slqfdrOdQ1e4DFKt/snMU8zCE9l1KXuMWKG5dUtvAf7pWqaYRFpPEug/hDyQjSK2a
	 xH9E5NffBzjTAPwNeNGn6Z+u22wTfoi45f3HFCWckRx6iHyBVD0EOIFpqlrtkVxVVExg8
	 TQO15uw5XUAcHmfRcMyat/WSrVKXHB7o4yvG2YiHODgmuUjkKSxXGSVKtnRyY4ZeJJMCl
	 mkQZ4VB8cPOj0Nn/7txNE261V56Kbe5UmDPMLldM3f3RktHISHo1RSm+fVloj43aQD+zz
	 rCAUXK00zTDnxZeC5KTE3JyGM9xj27B4S1QROy42WiC2LRWaaQEhnf9sCiPPPF9fArw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KukCRA2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB5606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KukCRA2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7991F000C4;
	Tue, 24 Nov 2026 22:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557674;
	bh=CHg6cLp9gikE6OWNrdw5FOnL2uaA/b4N6CHoNbIqYUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KukCRA2/0WW+Z8qInkywQmR3FrnZ4HlJMsdZF1n536W6pYxX4nFAebz5990UYyEEw
	 mKQvEEtq2+cGMyaHlVWVNc7gUsV5McaO0KeA0psN7n1t+2ceghLdZDGd6cjb15R0s5
	 MRxIY9hvOZZ0nG5lylu6W7QCQlInCwXbyaCuBOrIdKbTUfEEu69kv0db1XD/hnx57f
	 uUzgAropFKCPnelNb8w1YjiGDD69n2TqrVJGlvraKr15Yg5woRDkXvkjaPLjP9AKZH
	 dEKcSlfYwVv5QnwznIK0apYd9J5dU92KPvd0w9lKsbsCqEVCc12XtZAZGgqRvO6yev
	 jwPIesEO0DM0Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:31 +0100
Subject: [PATCH mptcp-net v3 14/50] mptcp: report errors received before
 accept()
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-14-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=upYA94QCv2rfxVoknOZtjnkazkiF2LkfrOCX4cuvMaI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOP6f11BdcNLkTpCqsxnrYaODl2elXP3maCgxU0lLO
 /QR18bXHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNJM2L4Kz95W+GH+8kSK9Yw
 tbOp/04/d4V5kYTH5LL8FxWRMzevz2f4p3lk8kb+tT2fs3ReLQ8992nJjKwCtt0VC0+evX+/I8X
 JmB0A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After a fallback to TCP, when the subflow of a new MPTCP socket has been
reset before accept(), and the worker processed it before accept() too,
the error was lost: read() returned EOF after the data, instead of
ECONNRESET, and after a FIN followed by a reset, SO_ERROR was not set to
EPIPE, as TCP does.

subflow_error_report() skips the MPTCP sockets in the accept queue,
without a socket attached. Before v6.19, the error was then reported
when accept() closed the subflow again. Since the commit below,
mptcp_close_ssk() is used there, which skips this subflow, already
disconnected, since commit 280d654324e3 ("mptcp: avoid dup SUB_CLOSED
events after disconnect").

At accept() time, when the subflow has already been closed, report its
error, after having processed the pending close events.

This issue has been found by an AI code review agent (Clashiko), while
reviewing the previous commit, and confirmed with a new Packetdrill
test: after a fallback, data and a reset are received before accept().
Without this patch, the second read() returned EOF:

  v1_bind_tcpfallback_reset_before_accept.pkt:21: runtime error in read call: Expected result -1 but got 0 with errno 22 (Invalid argument)

Fixes: 48a395605e08 ("mptcp: do not miss early first subflow close event notification")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: new, for an issue spotted by Clashiko
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8edff68ec650..ff1dcf306723 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4705,6 +4705,8 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		if (unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
 			if (unlikely(list_is_singular(&msk->conn_list))) {
 				mptcp_check_rcv_close(newsk);
+				/* not reported in the accept queue */
+				__mptcp_error_report(newsk);
 				mptcp_set_state(newsk, TCP_CLOSE);
 			}
 			mptcp_close_ssk(newsk, msk->first,

-- 
2.55.0

