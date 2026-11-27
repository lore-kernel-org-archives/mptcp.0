Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754192;
	b=IHnXmMZZSqkM8Qi5IbzyOEcuE0sZTFTo1HZP3jsYmAaJFsqUPePXDRCNBbFsbOrzBINz
	 CLMFAISfSIXlz8Y55rLtsM2gkO8bGxCjnBNBAYAF0VnibGacvygBmCg81rKvE+lvF7h2g
	 GSsUZmBv3y/08lr8mmGyoMgHclFks6GBm/GQOR72l/SPLrSLE6NokCM76smATLkgkVAL7
	 PAsIfIyCyuHP/jArK+SBbuKTTxktdDuIB2y3lSkOgrR4rzV+wBhOEVksZm0bD2/TgJFN5
	 PZ401rtADXbIGs3KjQbLYQNZenc/I2UgGvQJ5yA2WZLTA/eJj5hXDUpEm+Tg+EXNfng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754192;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uSe9WMIjgNivZz+mf4oQPcRc7qsTQtjfI7P1LdxS+k4=;
	b=RYPOQqEs/YNYPNh73VoNJbUslXABfaM8rZ9E1NTRK3Arv9XNdVAz3A0gsCBtHiGjPcuc
	 iabN8Z/dL9b21UwAN+xsZYUDRDttk8enOXc2eBvwtwfHUFC0XnoQKQwSaOPxMPczqrmdk
	 XKP3GUwmxwY9tEEs6+nNFblpjszQEnos08w5r7RhinksDarpf42bstRrEdrCZf5GN/zui
	 HscwX0SmDoSociV6mr95A8HIeKuprE62rdmbPwWONrJmG1ZDwZR3BeO8dzcUNwlis7DsY
	 S8JAOwW8Ah/TS0UYuyXvAzjgAuGB9L7B+Ox5CHKHD8HGTiFaNFULpPb/8TREbS51PAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FuEn1Upg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7507606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FuEn1Upg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AD51F0089C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 04:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754192;
	bh=uSe9WMIjgNivZz+mf4oQPcRc7qsTQtjfI7P1LdxS+k4=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=FuEn1UpgEF6vcDVRXU92K3t1oKHxWSbVgqEzVBwoMHxO8E45WQDxARJgnDFV94v5s
	 dSJFlz/rbakIscvv561VVbXGOwOixmj5NQXq1xoOTWiBHe1Tf7kIIifPGfj0zlEp41
	 cCLak6dGN4bZe3PkERJvWNUBN5U6goEEllAw7yG5vWpMbf7s6Ii4PvvNNDWiGEuEji
	 nZKQSz1UuqezyEoc3cbceAc7ZvgQScThspjPNDxdWRTcEB2WQB0Wp/tWN6uUSEYPQF
	 wC5nh3E47r2N2/2SNOvMMLlOH98q8jQvv5Kc63NwM/3LU2ezxQLRHtd77K7GUU2LmP
	 uFGD8xr5lxCkQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v10 2/7] mptcp: remove redundant orig_offset in carve_data_frag
Date: Fri, 27 Nov 2026 12:36:15 +0800
Message-ID: <90ddf1a1390104c4e793311dda36bb834e2453a4.1795753727.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795753727.git.tanggeliang@kylinos.cn>
References: <cover.1795753727.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_carve_data_frag() already receives struct page_frag via its 'pfrag'
parameter, making the separate 'orig_offset' parameter redundant since it
merely duplicates pfrag->offset.

Simplify the function signature by removing this unnecessary parameter
and directly accessing the offset from struct pfrag internally.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b9ae52caf47e..504d0b196d84 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1302,9 +1302,9 @@ static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 }
 
 static struct mptcp_data_frag *
-mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
-		      int orig_offset)
+mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag)
 {
+	int orig_offset = pfrag->offset;
 	int offset = ALIGN(orig_offset, sizeof(long));
 	struct mptcp_data_frag *dfrag;
 
@@ -2111,7 +2111,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			if (!mptcp_page_frag_refill(sk, pfrag))
 				goto wait_for_memory;
 
-			dfrag = mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
+			dfrag = mptcp_carve_data_frag(msk, pfrag);
 			frag_truesize = dfrag->overhead;
 		}
 
-- 
2.55.0

