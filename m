Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51E347BD4
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 04:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263832; cv=none; b=nUPnlN4kKb/f/TIGHN2PQAjLYSWB4I83EcBCofb9iBMopRC83d8Usb8d9etNx4wfpY210N47mAAVJLiLCRvRvGlrQeD7gptylDa3acuxM836ExnaMrJkMhPeJ+1RtkBZa7dH4CxRcnae2ca3T6WrRMoCkU084tu1tXHkNQjut5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263832; c=relaxed/simple;
	bh=VO2lWM9yY6PIOaTJ4sd3MLKK0esuT4PcPjMrYkyKJfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNd/V/WTMTNNmS135B4XkxaqXKJIKs/jMzko8d+WeV53J69igcejUxClfe9rcn+20t/1O1+Q9gQvPct8btQUSSW1v+NZt9SetcCe39Wbk0pe7tBUp6FgoFFVlIrJPuWBx+qmzcJMp1ZCChoLk/RdD9tNj5fmmLbpqbMhUp0cpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/YcbnwL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/YcbnwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2561F000E9;
	Fri, 17 Jul 2026 04:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784263830;
	bh=hBTp4gJcdKx312WpXFgr4fskzyl+43n/D4lcsgFrgyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T/YcbnwLLxfH5Snc3JOUxyxmPUul785vuo5up4LDK9j6N97s+/YLB+KHmu6SZpviR
	 NhP74mZ3wiDqjHPJCw3GnFqw/q+qmB+RAjnBNghUT1/g9VoDmcYZacyR7ytJ02n/LD
	 /U+aMeZqfLR88+5WMo0m9R3nDZL5ZiFH+J6cc8ZL0M7D7GUmQKMSw4nQlXi+Kf4XqW
	 c9Ij1KN8QxomKM7PQ0qFUulQXM8QUdkZiigIz19u3D96BmEXWaCoT80nKb3qhcjGuF
	 KoPl6FTXNjPjSQnyv69Mnx9X6x0Iu7x0ytn+FiQH3TJmnL+3Rqtu6uQaVlh4tcoxk3
	 6UdnwJ9IBVLQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 4/9] mptcp: remove redundant orig_offset in carve_data_frag
Date: Fri, 17 Jul 2026 12:50:13 +0800
Message-ID: <dc09706b665ab2134c9e9b5cf73dcff22ab338ab.1784260668.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784260668.git.tanggeliang@kylinos.cn>
References: <cover.1784260668.git.tanggeliang@kylinos.cn>
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
index ca0c02f3bfd3..6a9daa187dad 100644
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

