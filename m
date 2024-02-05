Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445ABE48
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707113273; cv=none; b=s6Drrd8mpzPK2/+ETwgJE2HhpkBy1Ox8WBNkH+znPBs/OO0yGTudigLOpnqoJZI27Kb5E1H+Ek0AR/EEF45s1+2Fi1JFfG6qrE5zdt3iKcBxV3vs/OQIahiTD0q33fxCwU0GT9G7VTrJssRyftxlollkNLmIPP0iO+Hl+IvwxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707113273; c=relaxed/simple;
	bh=tEzbpo2rmWW84a2rbyBR/kj0GFy/b+vnCPilneiTF5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QMJcfl/QqmxgN3y17UIbxBLgV7wN2Fb6s2v05IRxgRbZehMehoeOwTTyoBHBVBZR71Xe3KjxfmH7/zALExKfKxmBGpSIyi5KygI47pyIlCVgZw67w3FjwYH6hYxHkeKxH/n8nGudk6vbtPDIKrSfo0bbIJn1OugrlZP8eipbwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJz7zrli; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJz7zrli"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B13C433C7;
	Mon,  5 Feb 2024 06:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707113272;
	bh=tEzbpo2rmWW84a2rbyBR/kj0GFy/b+vnCPilneiTF5M=;
	h=From:To:Cc:Subject:Date:From;
	b=jJz7zrliSxzCjTDqrUWFnSBwC0iy4ubBC9uFQTpmXJsVwbly8ZAr9kZ5kpbBRZjb2
	 G8GSPjX6lXTfDosvd7057aUQRuvOyiYNTtXALa97NYmLiXRpkG/urX7s3h4d6tQ7T3
	 ZLP79o/fUA46lGN5LUGY6VL73xQCmNFlo02U9oRAwv+eAp4UVb5UynhtdmTBvnGN4/
	 TFTuV0TJ4JdCXH2XSDN9I35RUzDfEAZq3D6NVASkQDAt9z/e0ihMHTTP0b9fELCXMn
	 ltfHlEhSrT/4tdJb1sDSZ9qMgbYmdrnV3W0Wd0PNl8meSB657KTvR8WAu3uSUpkVju
	 a/e5homyUWnFw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next] mptcp: add a sk_is_tcp check for sk_is_mptcp
Date: Mon,  5 Feb 2024 14:07:45 +0800
Message-Id: <e97e306f73ff10b437eef979b7d5d82b822e2f52.1707113244.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

sk_is_mptcp() looks like it can be called using any struct sock *, but
it only gives valid results with struct tcp_sock *. This patch adds a
sk_is_tcp() check for it.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/453
Suggested-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 63972d712a1d..30754bebd5fb 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -124,7 +124,7 @@ void mptcp_init(void);
 
 static inline bool sk_is_mptcp(const struct sock *sk)
 {
-	return tcp_sk(sk)->is_mptcp;
+	return sk_is_tcp(sk) ? tcp_sk(sk)->is_mptcp : false;
 }
 
 static inline bool rsk_is_mptcp(const struct request_sock *req)
-- 
2.40.1

