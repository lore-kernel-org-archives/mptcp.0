Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033AA3382CB
	for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188294; cv=none; b=f52/4b3FS5HCaqyNIq9E4ENJ92kX+1uqjzEGqqB3wj6X2rnahzT65yiHVKgziqkUa7T3rZ+uSJqdu81fk0m74SkEnWOSHmSj9a8Vwf/XVxFO/82s/oE5qIXewiDRAE6CYOaszSl82HMclk3lE/IHdbYqzD1XioXMgN7lAc0/SZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188294; c=relaxed/simple;
	bh=ulWILUpb3pw4luElom6jkwqXrUv025UseXHFuQyY6KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUWRNmljyvuH731kpF1jHY7arE8Tud/VVI58iW4QYW7/4p2HYIa5zzE+YdAdAysK5X6q6S83np4W0OjC91zJ1kSiGUeBgGrf+vFJGewBDvUeWavpYnkQQGFPjgtYssHx8anugL+AiIENk45hhCNBNKDmem9EIo9dvnisTf3pRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+ye6Ts0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+ye6Ts0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AA01F00A3A;
	Thu, 16 Jul 2026 07:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188292;
	bh=mFe+EhieCAIFPeIzQNDJVSmkrrIOqPnGJ4ZYpTKuG6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F+ye6Ts0FKRDZ6jga+ml1nj60pNo53C7HEaY0mizyEOhGPjsCZzfwhuz95Mm3VrFC
	 RenFZZceGYGCDtZTGNEYaA2Q3VTE1zOhfaH6TEMM3otX0xkAZygoM2Y39Nif0DuroV
	 CgC0kn7PzIc5aSGKWeHOZkoPmcDOu6kkiLr9S1Z1zaszFnVUKjCjRYoFFMfzoV1EvD
	 H1RT/0FMvYQFKMXkSPgDTYh/r4ccxbMr0ZxN0tEl140yf7wHVh7I5ihMm2SmVJANSn
	 OZNTjBJiE5odoGarXwOm5M/SAGYq17pAgrr+NU3Lt6pRc8CSZ4xabwmw1aaL6UNXCz
	 uFaLJs33nUTyA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 05/10] mptcp: remove redundant orig_offset in carve_data_frag
Date: Thu, 16 Jul 2026 15:50:44 +0800
Message-ID: <26a440ab536462e9618b4f10f86197657c712608.1784188064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784188064.git.tanggeliang@kylinos.cn>
References: <cover.1784188064.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
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
 net/mptcp/protocol.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ad3a4a09e3b..85bbcb16c87e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1234,12 +1234,13 @@ static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 }
 
 static struct mptcp_data_frag *
-mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
-		      int orig_offset)
+mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag)
 {
-	int offset = ALIGN(orig_offset, sizeof(u64));
+	int orig_offset = pfrag->offset;
 	struct mptcp_data_frag *dfrag;
+	int offset;
 
+	offset = ALIGN(orig_offset, sizeof(u64));
 	dfrag = (struct mptcp_data_frag *)(page_to_virt(pfrag->page) + offset);
 	dfrag->data_len = 0;
 	dfrag->data_seq = msk->write_seq;
@@ -2031,7 +2032,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			if (!mptcp_page_frag_refill(sk, pfrag))
 				goto wait_for_memory;
 
-			dfrag = mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
+			dfrag = mptcp_carve_data_frag(msk, pfrag);
 			frag_truesize = dfrag->overhead;
 		}
 
-- 
2.53.0

