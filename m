Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254191;
	b=UaJY3oTs8yi0f7GnggMnqmg4bPiINYOduj4KcWMvaHhv/qTjnK12jxyLFAyLww6DhVa0
	 KaUXc+3G+HJ3GXtOhe2LJMzuAHPu6tfujqJL8IBWuWcjZhfGCtrA/F3d7ueKbxclXdKLX
	 Dj0Dxa5c+4KJDLrCy2RmJdb2vNEq3eDzJZiqN+AuTurs/TuXyywJ4HrLcI51Ee2BwwdVK
	 ejnhLgpw4eEiB1WHjCcNhBK6/xZz60x98wv2mQITBd971vTSXfyopZXbVwSwbJYuceQ7q
	 F2GHcQs6zDLmACXVrWj05a/rJZVWcg3UEv16vD3BcqcfE+nfi8KH6xDqhoBNIUVacPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254191;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0DC+n+GdtOSa1Qfyp6uLmRibzbOuzYFIF0cIJvkRu+Y=;
	b=5KdgxTB6CYZkNmP/N3bPtiD/8NLt6EdezWkQ12W5R6OJhDKAYvrgvupcTtyk2zs5AdfF
	 EkR4P3+gMsA1zzQ04AlblCZ3yLZABvdPg0eGvRcKwRro8+a9eRuYJnyibjBDpsyL6jOSP
	 MWodk660ViMgaZu7z8v25Yjou7+X7sPUf8jNw6D6e/S4B0Ju18EEyYnkHXbp2NoSDF16o
	 C3+o9Cdd128t9/mYIrdjLWYzsJwjIi6LoIJSFMtdogxbI/2YC35KbU8viNusLhldCEj3n
	 tUMCotcMVBXAbLoaRgETv/bD0aQvfMp/HaGAHo/AbJiuDvIfYYgbhu1ZPTfTL0hj+fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4cxm477;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B666606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4cxm477
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024951F000C0;
	Sat, 21 Nov 2026 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254191;
	bh=0DC+n+GdtOSa1Qfyp6uLmRibzbOuzYFIF0cIJvkRu+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W4cxm477NDmBlH5EmNFgs9uhrJeqvOmzR1N1rm3PopUzWONdVyQ71zoyxcXf/5tcJ
	 uW0QyZ74LHG2MMfA/+XcRcHIsxpncyjC9MpyYAbCzt1uLchpcXj4i/wCBl48Tq5scp
	 q0G9GkBAAYm4TJRGOELdaj1TaijExjHNKNt2AT59gehF4wwcuKc9e5U5rwCHiyulSB
	 LeZpdqOB571D99XDcEvswu8iI1cxkdJW8QlXgTflnZJrOmDqIjyeed79QRJwpCmumM
	 kZIiDWh6AQjRgjRLH+Bc3MXIZzrgJsLDwp4acJKJopRVOSknwxL9cWinMzjo4VBf1l
	 g90+Z7a3hQW8w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:58 +0100
Subject: [PATCH mptcp-next mptcp-net v2 60/62] mptcp: push pending data
 after a fallback on reception
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-60-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fYsv+l0BDzFIvw20XUtVD6+gO/USyK2gCweGSGlkER4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ08sSd3aelmXZLDut7OBZI0lhW9UpJ+/Fuc94xHhl5
 el9D3p+dJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExkbRHDb9YQOz6pq2nhM1Id
 Vj93vFD4QFZacNOu41MXi6pzKZhO6mZk2M6yXqrB0779dtd1+6hVhpo7Whfl3m/b3rIu38OmTTG
 EDwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When received data without DSS makes the MPTCP socket fall back to TCP,
the data not sent yet is not pushed: on fallback, this is done by
mptcp_incoming_options(), which already processed this packet before
the fallback. This data, and the FIN of an earlier shutdown, then wait
for the next packet from the peer, or for the MPTCP retransmission
timer armed before the fallback: up to one RTO.

Push it from mptcp_data_ready(), which follows these fallbacks, also
the ones after a DSS corruption. For the next packets, this push comes
after the one from mptcp_incoming_options(), which already sent what it
could.

This issue has been found by Clashiko, while reviewing "mptcp: don't
send a FIN before the pending data on fallback", and confirmed with a
new Packetdrill test: after a shutdown, with data still in the MPTCP
socket, the peer sends data without MPTCP options. Without this patch,
with an RTO of one second, the data is sent about one second later:

  dss_fallback_push_pending_server.pkt:27: error handling packet: timing error: expected outbound packet at 0.312538 sec but happened at 1.274089 sec; tolerance 0.100000 sec

With this patch, the data and the FIN are sent right after the fallback.

Note for the backports: the fallback after receiving data without DSS
comes from commit 119d51e225fe ("mptcp: fallback when MPTCP opts are
dropped after 1st data"), also in v6.12, and backported down to v5.15.

Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for mptcp-next, for an issue spotted by Clashiko in a fix
    pending in net
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 09514166c98b..1088caa788f6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1083,6 +1083,10 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	} else {
 		__mptcp_move_skbs_from_subflow(msk, ssk, false);
 	}
+
+	/* mptcp_incoming_options() can't push if this data caused a fallback */
+	if (__mptcp_check_fallback(msk) && sk_stream_memory_free(ssk))
+		__mptcp_check_push(sk, ssk);
 	mptcp_data_unlock(sk);
 }
 

-- 
2.55.0

