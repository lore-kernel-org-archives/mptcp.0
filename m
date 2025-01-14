Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7901C1F0C
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736876275; cv=none; b=L6/nTvwT7tv8wfF/6jfA3qVyo14KUQpONh6dCO0R5Alm4hQURI2vUrebZ7dpn+dW4HD4SopUs8qKhfTNtNVDJ1k8eIWhnNrKNj0yt2EGU06B6fkJvAxP4QqosQRK346pE7Ewe3QvF2Oop5CDOHJbRzv+UXdQU/Ej+VSrAYotIW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736876275; c=relaxed/simple;
	bh=ETylZ3YEIc3Hm3eh/nLzjNeczaR4uQGObKYnIfCS+BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LiE8MIvpUX+choQ+KExVbsJcmqVnkaOZmBdHwe8PnOCzGdvwsfhBA6L1gU6/L41jBYkqlCtE3CtwrtCKgLcP2+Sw8na9TM0MV3r/p7nhZaVLJ/ip+6FSCYBtTRkJjwsAk/rNXqbwTK1k68mqYZJz46Q37ahSkcBYOm2UKrbkGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfCucUYi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfCucUYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0454AC4CEDD;
	Tue, 14 Jan 2025 17:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736876274;
	bh=ETylZ3YEIc3Hm3eh/nLzjNeczaR4uQGObKYnIfCS+BE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lfCucUYiW5upRm3T6LboHn1EByGxITYb48IK79Rao7FM8m20lu19WdXLNdJroq8R4
	 HuUgpZjqrEMhtdA67I6qk5u99d0uT1q+V5N9DDNoV4knDHyTkSl8cOwLGGPXefmUUG
	 xXRMLVltoMngFB/XyS0Jnf5bzOLwmHA+cmuSdhKJ83zFFc/HsEm4/lxbpIjC1uB0XQ
	 o45qkEMFpfurEpaRsSaw0mpkBQfV64aweF4/7Pis+ZKrfsLnNO5Dp+ySrizliOwRTB
	 74rAE9N9RSKjA19u6IlEqEufByDN6Uc1gu679yhyw3e0WSQdRfLc1COuukWz7ZipHF
	 Tnvn4CBh1pZJg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Jan 2025 18:37:47 +0100
Subject: [PATCH mptcp-next 1/3] doc: mptcp: sysctl: blackhole_timeout is
 per-netns
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-mpc-no-blackhole-v1-1-994bd2a357fb@kernel.org>
References: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org>
In-Reply-To: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ETylZ3YEIc3Hm3eh/nLzjNeczaR4uQGObKYnIfCS+BE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhqDwQKEQpTupu7rW80q3TXKiZ/7FH6ekYC51N
 lZdo26f+oWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4ag8AAKCRD2t4JPQmmg
 c4noD/9Tzt6gH0ATlzHqxmtswYZNhoKeknZm4iFwq8q/yGXFy0jxVQF5ao3IiE6mLLplfzwNAro
 sCTuUQRJwAU0avJ4F189cjLLqLq+v7eMHIQRCF4Wgw543gt7DoyMVmm6l4fNqWlMM4YID3jr5Kn
 SS97fpTT+1YuEXgp14pLpWefjeewaNbWrxJvzv0/J8abM74glUpRm3NJLemZvdghZi+UAkzONLg
 aaR53Mf/28UwOW0kiiEE2ji4/z3mFiwdUJDnGnyXJLk1O+59Osm9j/ZUwI9UscQXnb+tn4OyoZL
 GAsAHdxGhs+q9nLEzctvqKkEYNZ3f8pl8yUu+dt18E6Sil4zvrHTIMDOvNwTAs8Y/SYcvF6WzA8
 +CBYztHw0pQ2QdepOy+pl+2x8neYAQFTNJ3W9kf4a3k2+mHUOY8rbxiBc3dVrdWAL6k9KpCAxGo
 nfqrXVdB0HgsxsnIHflgg15Uf5ozXD5LTVnHP7hdzxjTRZbuXdO092Zoy4B82haA4iAovYxtPpf
 hH3sN46qQGK+ZghjGaXKWjns8h4d7orzVymxg3202rPrVaBES6Skg+vf7BcBBq6GILBXOQScbWs
 OmyFOhUmVdiXGGlci+S8IibhsW2ubBZhW4dfRBhpzRtXPqryZan3jHzDPoLjI3z6CZi6W6beGKE
 O2yxRar4KQjsMEA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

All other sysctl entries mention it, and it is a per-namespace sysctl.

So mention it as well.

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 95598c21fc8e8782533bbc6a36de63bb465c297c..4ce31a2ac85be2daeb84c5447f06f69aabd18ef7 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -41,7 +41,7 @@ blackhole_timeout - INTEGER (seconds)
 	MPTCP is re-enabled and will reset to the initial value when the
 	blackhole issue goes away.
 
-	0 to disable the blackhole detection.
+	0 to disable the blackhole detection. This is a per-namespace sysctl.
 
 	Default: 3600
 

-- 
2.47.1

