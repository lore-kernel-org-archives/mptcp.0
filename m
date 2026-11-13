Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599691;
	b=NS3QZ49t3BBvuRt52mhl3HCTO8NU395x5tMwKrbYCucJMcOCv2bcZy2o3seWw9XnKege
	 bwOZQ+Ij8m4fvjCHpKyl9fN6lVfJ9nmSz/vMAmRP8BlMtTgAQk3PH+tRcD2EKfWXGClFL
	 Jqb7Y466wWhAk6iS1ilh/PjNeOf8xxayb5SkXVxnCOBb3seP8zc3180AhavoAJ2RJ23Fr
	 qO/DWoivkajPe36q2j37LMezDJxMICd4UAhHwCa3OqaAD4S+V9K/LHYZHz5t7gqLAwUDK
	 K4nnx6J07Fpo2yqbfUeXbl5/BqqG1Fo8JJj33y42g/1TG0pHDBxWsG7roHvx85IRveQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599691;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=73Q50ZJbtUofhkqDeqIdFCD+8VHDOnYJeBukBl20hxU=;
	b=KTTBLeygmIFUIGTAiVNnpckKeAKWQOImHyW3pbl1xj4H5Y4x3OJPJCBOMGoyHFWmp8Xn
	 9f+zLeJTqtUl1ncM+z9lDsF8Zi5oqhdq5VVaHgFdAfa1FfRD+VK0MKMySG6dLF/gOj46Z
	 Qfugf6m3CT+m1FNugJgZCt1NdGTfeNmuEPhkPtGVEG3+qITAg8eNX9XJUhYaELd1uCMdu
	 UFqBoF6C4AyDrQ7Ny3JawiOb6kqmUjNy5GTAlevWz+JMmyK+CTPRxOOv89s7pcH0QTT8I
	 zs2RDnPqV+ssfYwbVUkyR8k16NLtnQJjfG2B/DsoxGayDfExR+8Lda7VmOEem/2/0aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEkCA4gf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20850606D0EF
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEkCA4gf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D351F000C8;
	Fri, 13 Nov 2026 19:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599690;
	bh=73Q50ZJbtUofhkqDeqIdFCD+8VHDOnYJeBukBl20hxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XEkCA4gfvrm26jbGlGTJZwxKtlx5NPa2IfRwkQIlUlbfEo3UCc/F6/JBUTYvXv3oN
	 3CvsoNz3mrHKb18mjahpz5nugrcBkpZLA4/lWiuUZU5uMmme/wROQre6F4o00sKL5Y
	 eD6RicgYb6wy5xSfWuH+n/38XK/W8v+uEJQoCvl9pxSEcjRZsosiL9lMvGHhlQk8Nq
	 ki5q4C0IxncdEzT7CiR9UjJDoYI+7aWlGPlya5Zm1/HSO2264VCq3kfL2a628sOMUE
	 kwzB8nhNOS92iThNk0hXcy4Ki6Fp2H7IQfGqA38YfNeEt1mXEnF2I02/nkoPUXTmdL
	 oATIW4dSdAT6A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:54:02 +0100
Subject: [PATCH mptcp-net 24/34] mptcp: push queued data on passive TFO
 subflows becoming established
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-24-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Petar Sakic <petar.sakic@ink.fish>, 
 T S Rameshkumar <rameshkumar.t@phytecembedded.in>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3433; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qsjLEJPZNLiVtwGz2tvC9VdE7rExvTlSWx/F6iR+vRA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Zz3+rngt4ebO65wBN16klX99wHHB5YH9h6A+/75eu
 f+xs0x4O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbS/pqR4bTZ05sck9dGJ26/
 OKV52kczk0+LqvN/qD8/eWehWuLCzcoM/0v+vmEU+83KfC4w5EHmsSuTp3+w/ZW3xb5KzyY71/5
 6ER8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With TCP Fast Open (TFO), the data written by an MPTCP server before the
third ACK is not sent when this ACK arrives, but only when another event
triggers a push, e.g. new data from the peer. With a request/response
protocol, the client waits for the reply, which can then stay stuck.

A SYN with a valid TFO cookie creates a child socket right away, which
can be accepted while its subflow is still in the SYN_RECV state. The
MPTCP socket is already in the ESTABLISHED state: send() puts the data
in its write queue, but this data cannot be pushed to the subflow before
it is established, see __mptcp_subflow_active(). When the third ACK,
with the MP_CAPABLE option, arrives, check_fully_established() marks
the subflow as fully established, but nothing pushes the pending data:
this ACK has no DSS option, so ack_update_msk() is not called.

The fix used here is to push the pending data when a passive TFO subflow
becomes fully established. Checking subflow->is_mptfo is not enough:
since commit e00b63056fb4 ("mptcp: fastopen: only mark MPTFO subflows
with SYN data"), it is not set when the SYN has no data, while a child
is also created in this case. syn_fastopen_child is then used instead.

This issue has been reported by a user of proxies over MPTCP: the
clients put their requests in the SYN, and the replies from the targets
close to the server were stuck. It has been reproduced with new
Packetdrill tests, where the server writes data before the third ACK,
after a SYN with and without data. Without this patch, and before the
earlier commit "mptcp: arm the rtx timer if a push leaves data behind",
this data was not sent:

  server-tfo-write-before-3rd-ack.pkt:24: error handling packet: Timed out waiting for packet

Since this earlier commit, this data is sent, but only when the MPTCP
retransmission timer fires, here after one second, as the tests increase
its interval:

  server-tfo-write-before-3rd-ack.pkt:24: error handling packet: timing error: expected outbound packet at 0.237174 sec but happened at 1.181857 sec; tolerance 0.100000 sec

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Suggested-by: Petar Sakic <petar.sakic@ink.fish>
Suggested-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Reported-by: Petar Sakic <petar.sakic@ink.fish>
Closes: https://lore.kernel.org/mptcp/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: T S Rameshkumar sent earlier versions of this patch [1], but
stopped. In the end, we are back at the version suggested by Petar, with
syn_fastopen_child instead of is_mptfo. This issue is affecting users,
we can no longer wait: that's why I'm taking over, after having sent a
few reminders.

[1] https://lore.kernel.org/20261012111001.542847-1-rameshkumar.t@phytecembedded.in
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a74520f6b069..3477a7ec5a05 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1048,6 +1048,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	mptcp_data_lock(sk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	if (tcp_sk(ssk)->syn_fastopen_child)
+		__mptcp_check_push(sk, ssk);
 	mptcp_data_unlock(sk);
 
 check_notify:

-- 
2.55.0

