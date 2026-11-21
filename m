Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254157;
	b=irDkRlmfCE89JZD4EWhRW7YfrW6s+1tad707JpA5DMgQA8Wn+HB9KB0fwrN4dugW620W
	 r4R2enFjTSaXMRBxBclbPy+NnUT1dYzZYX6T6vqxt5I+y8SZjfC5OiofMqO+SE0mE4ntU
	 uajSXc8DlayBWWLU1rNyy9ESE9btAkwxc/GDXf6TfVWY2R9clSE3rKDFD7iZyra5Z8vpa
	 97kE41l6sBXEi7jcJPnRj5T8ID+mhde/dNZm7BjLitdx2AfpAcMH/+1xOVZADhaC4IgzZ
	 GBGmK4kZps5vUjvf+YsbG1D6GeH4TsH3zRsuYlyZ4SV6vEOOwiKwp9sB0zZrzSFJfbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254157;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=J/3NH3snZpwpk6xMe7VoPuHIzeltTQrlc3xlx9g68M8=;
	b=fA6i+kUtFWRcw2qKn5hR/ne1MfOfq3W0YtGU0kdTtkeFLNj2tNWWoeuwWB8GyamrKSAw
	 zG8LmjrQ1gBrrLGXrBObKosnofrsQPMLRNgzLRqwOgrMywuEEb1aMA5nIh39TbJvS312a
	 uvBeuuFTUsBMB+KyEd5790/hCQ44gdEpjUcGowDQP+EAnkZ+jlYVLNHyfCEGO+71TcYN7
	 qevlVtBgmWhtW3qmpHZ0QnPnrStN/KVZipUuJB5WJHwsWm67RC84uT2/WvYhGr41z2WLT
	 dJWDsY/s2IZQf/RQBpe++ESoiSnLOIy0xFedV/5Z3rO01PaMCpIQweb56k6s8zHrssg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaYw6xhs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E4606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaYw6xhs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A23C1F000C4;
	Sat, 21 Nov 2026 09:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254156;
	bh=J/3NH3snZpwpk6xMe7VoPuHIzeltTQrlc3xlx9g68M8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aaYw6xhsU2+Un9GZuR2kh62DkDa2pQklbL399uOuFuqa/7ykbG/jVXYaqkNG8kzH9
	 tpOV9S9BfMSF9RzqBklj2NGvLy0Qrl8PxbVAidHpLXiWQ/eDfXXJuo1BGu1QSUXAAC
	 Y5GcsqENFXZJRac35/oPevIwKv0QTmMMoU/dC+lKZ2M/m0bpNCVDMe/U01WJxdbBtf
	 IeIEAUewJ8amqhomtZU2WilXHm2tsjIrFNXzcg7dSotYUsi0MiKjsRQ1UPLL7ysUS/
	 I1y3yoB1KO5DPhPmEm04AZZAH129cQAy4kYYLu3CN47eU2YQct3tZOod+20lJcZuQR
	 9LxSBOj6hg2Aw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:18 +0100
Subject: [PATCH mptcp-net v2 20/62] mptcp: start close timeout on initial
 sf shutdown
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-20-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=H0N7IBphdSYQqEubQnXZHtnLBMZ0SLdiEKNyxI9Aiis=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ08N/a7j+K33guc/gPLe2c6eydKdz1PuiDmVNz8XCP
 /clJjp2lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATOTbP0aGBY+ENnS4iv3Rbf+m
 ntHdu3yOVpbHw0i55FUv9j39Y9THyfBXxE1QPZ33o/AmlUMCEflNYd/Fv60+4y/yLuz9QeWulzW
 MAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the initial subflow is closed while it is not in TCP_CLOSE, e.g.
after a FIN without DATA_FIN from the peer, it is only shut down, and
stays in the connection list. The check for an MPTCP socket without
subflows then missed it: it only looks for an initial subflow in
TCP_CLOSE, and when this subflow reaches this state later on,
mptcp_close_ssk() ignores it, as it has already been processed. A
socket still owned by the application then stayed without any usable
subflow, without close timeout nor error, and with blocked send() or
recv() calls, for good.

When only this shut down initial subflow remains, start the close
timeout, if it is not running yet.

This issue has been found by an AI code review agent, while reviewing a
similar fix, and also reported by Sashiko. It has been confirmed with a
new Packetdrill test: the peer closes the only subflow with a FIN,
without DATA_FIN. Without this patch, send() stayed blocked:

  subflow_fin_blocked_send.pkt:26: runtime error: exiting while a blocking system call is in progress

The check only looks at TCP_CLOSE since the commit below, and
mptcp_close_ssk() ignores this subflow in this state since commit
d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events"), which is in
all the stable versions having the commit below.

Fixes: 27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent, and Sashiko
---
 net/mptcp/protocol.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 835796fd4f77..d3a793e96c9c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2823,6 +2823,14 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		} else {
 			mptcp_start_tout_timer(sk);
 		}
+	} else if (list_is_singular(&msk->conn_list) && msk->first &&
+		   mptcp_subflow_ctx(msk->first)->closing &&
+		   !inet_csk(sk)->icsk_mtup.probe_timestamp &&
+		   sk->sk_state != TCP_CLOSE) {
+		/* The initial subflow has only been shut down, and its later
+		 * close will be ignored: start the close timeout now.
+		 */
+		mptcp_start_tout_timer(sk);
 	}
 }
 

-- 
2.55.0

