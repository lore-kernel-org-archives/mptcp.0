Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591392;
	b=zzgIdJ+eZfMAJ4IPl6a+FDURolBSci8hDVXbzA9brp4fNgUTyfGLYk4dzf6yrGIpgIFO
	 9SznrQXHw4em8R7AOCbB5y8pBCVVNi633J+8MToHyUSjOGaQJDY9XYkAZmylfv5Y9qAQz
	 ntEbfqpL6oJHi8iGnKQIbKg5yWmn7P/e2clSy3Mdye2CcpjsnkcPHwmjWHv6En5FKLFgj
	 W78FOiznmz9pZIE0L0HHZglunOuuLOUU2g0LZnqbCHwFeNHPwofHZYootR/xPF52YDHOU
	 rP/jWgSRMmsElclZrWgYefEXejpEbdvcw/IA6JZJEruW01QTNgLICa3TrCf5q4Sh4Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591392;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uSe9WMIjgNivZz+mf4oQPcRc7qsTQtjfI7P1LdxS+k4=;
	b=ZLHuW+aMffq0Ybt//TdHTWh2Uv63woc89BHACwxq97CoNOEDGqvVwHvmL3vxcirTtYMv
	 sc+DwTxYUvXrRWnGp3GqTlSje1Cwd1G254TEqpJXdBQP345HEAqDvWKECwKqHcEawaxhP
	 uxwCTybqasxBE7n+S0tmFIsly0BP0B9D+ati3njBJMn779RhN45fL7ByGk40JQ85Ngx0g
	 VJEWU4GZHgoJngUrex2qNQfJKV4ANU2w7uXnN8jPfhLJp8X6rNx9pEeuSQtuBZsn1oTI6
	 qLYmNvSVzkABxZAJsoo9nS6O7X/+wIJnmDSGStWzzyfLjLi8Pbpt/4ZPgjFKnMvah8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8Nud7lt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8C606A323
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8Nud7lt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693401F000CA
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591392;
	bh=uSe9WMIjgNivZz+mf4oQPcRc7qsTQtjfI7P1LdxS+k4=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=T8Nud7ltc59ZmLwT44RERFo+KoFoTKIU/Sj2IzrK3Uh24CzbVUkBW6SXjUuiRaEkZ
	 3QemXJ1IRp5V1nYCfouyCiSq+SdICr0+wSIzLz9sYBXZnw8LOU3XVXYr8UuWoWfG+h
	 rsHARhDabSUdUNkfcThh/KVtO4eLrzK1LxhRDdi1M2ZQPI1e2mY8d5HLy7SpFN/FJq
	 s0iysOXNy86Imm210wvnHFp/oZxg80YOP4nV72AtfWf1GW+2t+q1dy9B0E0JyxetsM
	 WuZKtSTn21vHB/pfEMydPQmGy6CoI3HC2sywkbnGP1SmopV96fWnlfPNPKbfFH1Kcs
	 9zICvo976x6hQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 2/7] mptcp: remove redundant orig_offset in carve_data_frag
Date: Wed, 25 Nov 2026 15:23:00 +0800
Message-ID: <ba564038b16dc170e4605bd733a988808a86037c.1795591278.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795591278.git.tanggeliang@kylinos.cn>
References: <cover.1795591278.git.tanggeliang@kylinos.cn>
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

