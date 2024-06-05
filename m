Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273E153BC7
	for <mptcp@lists.linux.dev>; Wed,  5 Jun 2024 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619905; cv=none; b=E5ztTR/kpOBb5dj5/lAtZH7DMI4PwP/7RyZuIPAxTe3G5xacaHsdHHNX3oJ+7dE84cUuJCs12AUL5VoB8gt8ivVnFPUQgpbnThiVfrWMUkqnVIvIxs8SNM1EJmTgMEGVAX0DB/Cy/Zz5utVwtUxBceEttnDP03kXDUKYeYWwuO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619905; c=relaxed/simple;
	bh=pIVfNkxc+mPYqZGQojFIn+WxckG/GUW9vK4e4w4W1C0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7192leImCm/JfTIHWlWaKVkOCLv7VgJU4/oYcIStuhhuCw3rJqz+i8gQt/rACcr8ZII0kAvNAvs+kEIiU6Vpf4EEFR5kRK2hUbfEUhC+510CmyYStfJuS8PuxOvVp95gd3wzKWZWG91ADMG98zBNKFITnFpflHWFZ44HmGm0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVLtaRj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVLtaRj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AAEC4AF09;
	Wed,  5 Jun 2024 20:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717619905;
	bh=pIVfNkxc+mPYqZGQojFIn+WxckG/GUW9vK4e4w4W1C0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PVLtaRj+Ndig5puPIoh0q7RkHk95KrRmyeIT8Sibp6Y2z+dL5uUj0y9+UlTjwvPz4
	 BkS5Zlmpm96Zw3TDOI6bwRHShLlW90J4hExX25mtC7niujrFZSIyTp9uHhDQ6O+3vU
	 2a34txiuJDMZifW5KL9dPrtsFnGlSDUuy15l946LbH+UTDNFnDXr8mM7V/dy6mZGwM
	 hLTe9XC6gnaYqbaAPDdRm1p0ks0wA+aU7Qab/wy9m0U4nct8vwKLRs6tIqrP/OxQeb
	 gKTawyCgiypsKPc/qqNbUI5kuyocTrjZRnzZRB8n3wx4w2UyfPJL7FjunuwDqGwp1D
	 XB6eekVXC5bdQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Jun 2024 22:38:12 +0200
Subject: [PATCH mptcp-iproute 1/4] man: mptcp: document 'dev IFNAME'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-mptcp-user-feedback-v1-1-d2dc3b399643@kernel.org>
References: <20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org>
In-Reply-To: <20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pIVfNkxc+mPYqZGQojFIn+WxckG/GUW9vK4e4w4W1C0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYMy9Z4NoFkQPZ8RBU9Rcax3wBOzDbZtTQkahz
 TkXgkTOFN6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmDMvQAKCRD2t4JPQmmg
 c4VSD/49Q51RTaobCNiTEAZKxS6O6pvee8FBzH63ZZUGTjU30nZcOuOLs4JBQi1MlMq7C4fg3Fq
 6EyeSkkmouktOQktSVLkfcRYhqkiIlt0BGfcmH6OsQnOxz2c3N2s/aG48tXeWUZBqA99q6gdri9
 Dp5vpkbv5XNPoxEE8Vx+E5ZDbOCJw5mZ5VdUkQsJ5yGZYD++nXi2WCtHnlwdyEzmhJORKJEEJBQ
 Nj//FSo91m/bjKrI6qeHk3UcXfOu3gcwkdqD8d9eY09YypebBcBPjaZtYo4dLeiubsKVg7LLzpO
 epbZ5EY5lh1nyqOqvShg7eWRjw3dtDvVymOKxDdf/MIZUiP05PdaiBb7jtamkDZh+BI6U6+Slyb
 TqxVOWLP+4LcciEYKC1J8r4p8Z8QbrAZQ9tMyiZptKuUPKWBeL1EboQGS5+6Uk5w/MIEDg+YgON
 DUQ9Ei4clKRwT+OovPq4hwphb5wT1yPDYccJPQoprvHj7hIAM98PxBrBXW8RbwejbyULGN6AnXK
 2mvFXEnnWArOUyrRlEdjZceJ7Qi5duxONvJe5XefaxbIRpFFbhrklCQEXJwHmSO0yHxTJj2fRsh
 qzLhkTCv2xXqiIFi4WJfilRzBFKMwSedJH5tcOIKY3d9nbB04wMlMjJWGKAQfSLS22oRuaDM8cs
 2vog6P7zEt5L8kw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It was missing, while it is a very important option.

Indeed, without it, the kernel might not pick the right interface to
send packets for additional subflows. Mention that in the man page.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 6c708957..89fcb64f 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -135,6 +135,14 @@ established MPTCP sockets will be accepted on the specified port, regardless
 the original listener port accepting the first MPTCP subflow and/or
 this peer being actually on the client side.
 
+.TP
+.IR IFNAME
+is the network interface name attached to the endpoint. It is important to
+specify this device name linked to the address to make sure the system knows how
+to route packets from the specified IP address to the correct network interface.
+Without this, it might be required to add IP rules and routes to have the
+expected behavior.
+
 .TP
 .IR ID
 is a unique numeric identifier for the given endpoint

-- 
2.43.0

