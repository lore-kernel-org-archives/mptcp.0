Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599698;
	b=o34k3sx7Yt+VCxp91wZIt3DCv0+5J5CGhPq4vxJYiB+H//WkRkD7iJr0ueMzKZpR2SZI
	 KgylL1D4Ys66oeOuw7o8KCN4VEP0vgtte2U5gUziDUF3QiKOqDE/2uOHwEqJD8vlQdglk
	 zACSqstOm10SX+7A1UmPst3OkbU0fZ+TaThFBurMa3MOuBABzlKabnFOGiKcSiFwcPqR7
	 aK0ydty+YGa9bstOAP9DZyWii7fjtSdRRXo0N/LsXOuI+s80Jfxt1IaefRqOixNP34dim
	 dDPlR3f7DhG9M/AmrBSJ1w0gAyzJ6P+5WIOVtwo9PvmSPswkw+cPQERTdE4YygQMz0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599698;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UzQjT6pTdVhVgVD1x7jkIM/8s3GmfnVk1e/maolr/S4=;
	b=zcimel+20pN2S4u8DPbfy9AhgPjntW9VsMFciF9mN5NTmbCrvpgO7dmb2UV/OMGthl4F
	 eFmJKZvh77z/UbVHoKpK0d9bzGV2mGZEDHsORrjv1jcMc13wktuXgstNFCYglDRHGKs7o
	 +GoSryflHMC+dXnRbjAHi9eh+vTRr8yO2kEtjGI8ZeD8NPvwWUf6HzL9cRkR3vLC1AU8B
	 Lzg/jRKU6lCYN3MD8sIibbw+STgTa5cNJJxXcFhfzghOAAa2kzMWic10Oeo0mJALln9uh
	 yhlzs5J7pxprI0RShjS4mLnvaGxqejB7Pt0XeN2jj6+0i+I9Fk+s80m02KCwquDqIDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZzk5hIr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B5606BCD6
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZzk5hIr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047531F000C6;
	Fri, 13 Nov 2026 19:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599698;
	bh=UzQjT6pTdVhVgVD1x7jkIM/8s3GmfnVk1e/maolr/S4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LZzk5hIrwwmlJIKmFjmCUP7QcMAHykoLBloNEiJdUh+9QANOZrNX/OkIYPmjSowhm
	 /KFCMbwSgK8YfxX+5dcjHzJcEhhHbPsNdFzK/tmrR9WpU5oM7ea1wOL3WRbh+C3zga
	 XpgUROEnwiHXnbEOS6smISitXTk3HmD8e06v3iIoV5Hk8esYIu5VMp3crJ2Wbr0y6+
	 /sYDbptl+jkRDMIcTCnuWK5qvW735hXnFc7RzF5W1/1GxjRHHJJXXpkI0LI9bJ2G5E
	 Q2du4mkk2LcerLvdie6+r9XP5kXHs7xVUjgqN+RDj6v1P6TUn6T3nxL3jotninabJK
	 gZOCPZ652HF0w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:54:09 +0100
Subject: [PATCH mptcp-net 31/34] mptcp: don't charge a subflow twice when
 it joins during accept()
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-31-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2598; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Me5+bq9iyzEOYaa3xqyQ24369zFmx5spOsiCZTXyQ5k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z704dnOGwJ4Vu1JzFDztXvQ+7vA4rM15+GB46hQ+u
 49/95yw7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhI1ARGhjsTL+3KbZ/iFPLm
 4Lt3B24WB5zclcFfwNe64KGUnGqmQzIjw3I70/sT+poM7omeftzBtkpF4faSH0o/uxP29ogkzuy
 I5gcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A subflow that joins an MPTCP connection while accept() runs can be
charged twice to the memory cgroup of the server, for the memory that
it already holds when accept() charges it. Nothing removes this extra
charge.

At accept(), __inet_accept() gives the MPTCP socket (msk) the memory
cgroup of the caller, then sets its sk_socket. From then on,
mptcp_finish_join() gives this memory cgroup to a joining subflow, via
mptcp_sock_check_graft(), and each page that the subflow reserves is
charged. Because accept() owns the msk, such a subflow is added to the
join list, which mptcp_graft_subflows() moves to the subflow list
before charging each subflow for the memory that it holds. A subflow
that joined in between is then charged a second time for this memory,
which will be uncharged only once.

The window is short: from the end of __inet_accept() to the start of
mptcp_graft_subflows(). And the extra charge is not zero only if data
was received on the new subflow before mptcp_graft_subflows() gets to
it, while a peer must not send data on it before the fourth ACK
(RFC 8684, section 3.2).

The fix used here is to skip, in mptcp_graft_subflows(), the subflows
that already have a memory cgroup: they got it when they joined, and
their memory has been charged since then.

This issue has been found by an AI code review agent, while reviewing
the code of the commit "mptcp: don't charge a shared page twice at
accept()". It cannot be triggered on demand: the window is too narrow.
It has been reproduced with a 500 ms sleep added after __inet_accept(),
to widen it, and a Packetdrill script sending 1000 bytes on a subflow
joining during accept(). Without this patch, a page stayed charged to
the memory cgroup once all the sockets were freed, and none with it:

  memcg sock: 4096 bytes

Fixes: 6228efe0cc01 ("mptcp: leverage the backlog for RX packet processing")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2a47107001fc..afc122e476cd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4503,7 +4503,8 @@ static void mptcp_graft_subflows(struct sock *sk)
 		if (!ssk->sk_socket)
 			mptcp_sock_graft(ssk, sk->sk_socket);
 
-		if (!mem_cgroup_sk_enabled(sk))
+		/* Got the memcg when joining: its memory is already charged */
+		if (!mem_cgroup_sk_enabled(sk) || mem_cgroup_from_sk(ssk))
 			goto unlock;
 
 		__mptcp_inherit_cgrp_data(sk, ssk);

-- 
2.55.0

