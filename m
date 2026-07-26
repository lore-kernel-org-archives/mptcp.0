Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0991E4BE
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055437; cv=none; b=CzE60weOF28AeBKh0TMhFV0YNAdVkyqKVXf/EYQtfcSYXpR8MuU3PVzevNl5ohEtehgN7/00gT+EVxrVTCtB+zMcmqHeDbFRc8GL9D1q3DCSsLdnDgaayD9bg3kKJZCBj7E4L82PjeWFlalzZsnnCzlmnCICT4xyDhttzCt7aGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055437; c=relaxed/simple;
	bh=wEPbJ1rvLTzOoEZHIcjcsCqUKLOo79w7SmtrJCkvHfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3JpFaOFkTeiiDRqddsglLKoObHCp6dhYW76PNhz+yn8lZq3L0pqAcx4eioeaw5Acxn77DkShs/eTsFyjS1vHthq+I+VGwvpluuJOpFho+PzOfQfnsH1Q2IUWc4PavbLMJF++E5WaDa9QnMV5BNuaSe3E0qlTxK32sZepugW6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fio7X55o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fio7X55o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83961F000E9;
	Sun, 26 Jul 2026 08:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785055436;
	bh=x1GoMDFx7cKDQbT4K+hhOX1Zw2kvjYO3Zq8GNvw2qDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fio7X55oKP+la6dveHy1mQSB2/pELBf16oe7S6f3y69Rqb3qUL27MFHwXgQZvuPRr
	 L+9Q/0Tqo3qUgMpAdnf2CP74hMQidElTUbbYNuw6mcNcs01g6/BgtEWpJRhkDSK7iU
	 9qLSuNYNJCCjRv6uQkqw6TYkgsQAcn+wfu7WvVpYfpE2kV/UwZiVwFhBClStaxuqmt
	 5hRAzo6NA8CaRUmofu3iFWfdUSbETejsrnt7KDCQrnAieVt8y5OGxy9MMKOGMeNaWG
	 P2zls+v9w3rTN+qRPmjbicPQKxlWMBAKcDSgiti0JlM9OOoW5avwIQf1m0ZPyLrRf7
	 1zfFIBXFYJ5mQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/5] mptcp: copy the subflow's tos to the msk on accept
Date: Sun, 26 Jul 2026 16:43:40 +0800
Message-ID: <e07e2a150fbaf65b4bfc6c84c01bb7e348a4dc0a.1785054808.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785054808.git.tanggeliang@kylinos.cn>
References: <cover.1785054808.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_sk_clone_init() now copies both inet->tos and inet->rcv_tos
from the first subflow onto the accepted msk, mirroring plain TCP's
tcp_v4_syn_recv_sock() which sets both fields from ip_hdr(skb)->tos on
the accepted socket. Without this, MP_JOIN'd subflows would inherit
tos=0 from the msk and lose the peer's reflected value.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 954e20bb27de..1152f1d0c24f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3699,6 +3699,9 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 #endif
 		mptcp_copy_ip_options(nsk, sk);
 
+	inet_sk(nsk)->rcv_tos = inet_sk(ssk)->rcv_tos;
+	inet_sk(nsk)->tos = inet_sk(ssk)->tos;
+
 	msk = mptcp_sk(nsk);
 	WRITE_ONCE(msk->local_key, subflow_req->local_key);
 	WRITE_ONCE(msk->token, subflow_req->token);
-- 
2.53.0

