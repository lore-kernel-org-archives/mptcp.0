Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F99216426
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199668; cv=none; b=eW75zkghXxTjXPpEoFOUgSTHkFnFPpBfTi8rHrm/GrZm3DYDhheymNn7NBSXV+TNtHO3lHIfrnvIw1JNZO4x4LP5/qqbdO9okDcYH5OgCfdCPCuonRvjocuYp81VCIeYQ9wrKkUunXvngBh+/7LIgptOTDD6EwI3+AWwfi700g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199668; c=relaxed/simple;
	bh=yxpq6RkzEsi6kX1M4qSfSK4O4X/GRQsN8XU1Jdh8WaY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HiOc2llw+GspKoTW35Io7sytIDbbfahE5VUdgBTil1PgkrOtw3Tc5nb1BGiYXPrNEgneA4tO4vN3lx4a1qydIPaAgrplkhiIikLRm3q7+d1m5jp7cYHaDONlQ76hU/k8H03U0YrYEg2XvLsRpsGuEDOvLEqYgDvW8YV9J+WB2Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6/0H1VL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6/0H1VL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14712C4CED1;
	Wed,  5 Mar 2025 18:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741199668;
	bh=yxpq6RkzEsi6kX1M4qSfSK4O4X/GRQsN8XU1Jdh8WaY=;
	h=From:Subject:Date:To:Cc:From;
	b=T6/0H1VLiyeeklUY64VNzQRXv3Pf4hzwxfQ8hA/7ZirjIZKLmbSpNx3lcpYFqaKej
	 PYYbrZ3mHaCqf55Qqat9qpYYdMchUrtzJDWak8+mlsShZ1AUJySjA4WGfDOdv1lruS
	 AuZI/sPQ6YP6DEs6+5QqVVKS7khpHkAgaNgp2Ky5mWK+kNBqXKYT0ADAOIIpfScdBh
	 OYoTPWnN1jpOftcKWgPuBmJY6GLAWaYpLDViJONv9u/ACi0tkVctmaQ+o7WMBdlY84
	 Dpyl1XDqqf2rRajBm/5hsXzY2HGgsQozWapMu9c5VDCRDFe764HTR/ito0dDw4prvN
	 UPpEltvkOgQIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 0/2] tcp: ulp: diag: remove net admin
 restriction
Date: Wed, 05 Mar 2025 19:34:17 +0100
Message-Id: <20250305-mptcp-tcp-ulp-diag-cap-v2-0-d53fd80748eb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACmZyGcC/4WNTQ7CIBCFr9LM2jGAWlNXvYfpAmFsJ1ZKoDY1D
 XcX8QAu3uLL+9sgUmCKcKk2CLRw5MllULsKzKBdT8g2MyihTkKpGp9+Nh6/eo0eLesejfaoj7a
 5nY1tJBnIZR/ozmsZvsKv42idocvewHGewrt8LrIk/s0vEiWS1EIctBW1qNsHBUfjfgo9dCmlD
 2OhTxbJAAAA
X-Change-ID: 20250226-mptcp-tcp-ulp-diag-cap-a4d9b7cd91ec
To: mptcp@lists.linux.dev
Cc: Davide Caratti <dcaratti@redhat.com>, 
 Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yxpq6RkzEsi6kX1M4qSfSK4O4X/GRQsN8XU1Jdh8WaY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnyJkyVey/Sfoxb10OlSgPcgkHmN88ymcq2toNl
 s4fBtsyy06JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8iZMgAKCRD2t4JPQmmg
 c98AEADBYoirVu86ipA91W9Ai7J1H3hTztqiUjjpU4eaZMYEI39jT1n8Jo+pbVXAi1vcKuKmTmB
 r0LjJEKa3JYYEj31NlOZXgMIGHBcovWv4mjMHn0pHc6377rHbpy9cdPYEbfE9m0GAD3zYLg/Ae7
 pE+bLKuRunQs+IyxJOC3w8ejIljPvCFjEma2y0CQsCjn0P00pHQAJr9t5tXbPoI0tYFccoSfODa
 bUla/3ZQw/qS7gfXt546UX9M6fTZqitL/iJP6YsY+Opn5ugv4Npz4Tdlq9hefF01fLksuayNMEr
 /xGMjYudPNaRyJl0D/OWG53ozlknKCj3Qq5DNaHTxeqNa429vEY1sA5W6jsB/9aaOjbyTxM1yCm
 jTbFWfwW8GA2fSpOg2DBV7P3VfoSC0RaqANNGgekAAZWNHOfxTAvHb+9hJVaCOtK1Zh2UhUi9lC
 7C19eMbOmCJwqDYBlx1R5wY5KwF2Dlo2bILHFE5WWSRc5bnClbAK1ZngvNq5j83YhflXYYPLVbC
 gn9emYEcbudJvs+R6Da18RvVSCGM3WdJs1+JFQKeXXHdlRmJhDS/+p98+Fd8S8amxgrtryd5eDO
 /h/UcL0YsZyaICr1Zao6lbldCESKNroYGDR39xJIZTvj6rLsqQN/sm5dBaElhIG9Y3Azyl/fJPx
 +5CFXhAT4brRKeg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since its introduction in commit 61723b393292 ("tcp: ulp: add functions
to dump ulp-specific information"), the ULP diag info have been exported
only if the requester had CAP_NET_ADMIN.

Not everything is sensitive, and some info can be exported to all users
in order to ease the debugging from the userspace side without requiring
additional capabilities.

First, the ULP name can be easily exported. Then more depending on each
layer.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Do not export MPTCP-related sequence numbers per subflow (Mat).
- The single patch has then been split in two to ease the reviews.
- Link to v1: https://lore.kernel.org/r/20250226-mptcp-tcp-ulp-diag-cap-v1-1-e1a003ad0606@kernel.org

---
Matthieu Baerts (NGI0) (2):
      tcp: ulp: diag: always print the name if any
      tcp: ulp: diag: more info without CAP_NET_ADMIN

 include/net/tcp.h   |  4 ++--
 net/ipv4/tcp_diag.c | 21 ++++++++++-----------
 net/mptcp/diag.c    | 42 ++++++++++++++++++++++++++----------------
 net/tls/tls_main.c  |  4 ++--
 4 files changed, 40 insertions(+), 31 deletions(-)
---
base-commit: 62dab9e8d979a45d72cebb74030b937dc5ba9452
change-id: 20250226-mptcp-tcp-ulp-diag-cap-a4d9b7cd91ec

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

