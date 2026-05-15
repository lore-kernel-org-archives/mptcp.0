Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471123B47F7
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778811824; cv=none; b=ZRiJKdUSxHPbaD03T922e1pv+TC0kFd7kg4cY1Veg0AfMG3Gk7/lQZ86xT8X93U6X0efBLxTuTwa2WevZMwHo7G/je0fatxgvA5rPM11NnSrvsZP+h7QtSXv7OR8IXeHuLdi7NesiA9DeoHyO0437iUBcK7KfXFv5cHJdbyC8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778811824; c=relaxed/simple;
	bh=Qag9Nmk4dleI1XBDj2bnl9NsaNnosjzSXM6xlLVQHoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9PRrVYe+KiA6JD1ojMzuys57OnmmVRadIEuvdv1s8gTmgpMQtH1cMamk5gYPUD30YoAcJ8GF4VVT9ZG13uQe87P8Uu0WV8N50JDX7DLm2mqRd5s0uTt/ZcOijXSQEY0yzEulbVnGgl0AiPRooHkBB6vfIElA7if91JIgTJz0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUyznPRu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUyznPRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C435C2BCB3;
	Fri, 15 May 2026 02:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778811823;
	bh=Qag9Nmk4dleI1XBDj2bnl9NsaNnosjzSXM6xlLVQHoo=;
	h=From:To:Cc:Subject:Date:From;
	b=cUyznPRuPZTZeFOPy8/S4UGsguPJDj9wZ2zIICBFblr0BvlRin2KN52tSfit/VEXo
	 IMVicxaHYyKR7GFl75Jtdycw4MTV9XE5env+/g4ZQH5nmLstnGD0AXYFiOEJQgja7d
	 axfaAtr6Jm27kg6BR3CEi8L6EaOYfnfGH+k43tOPUa36Hbn5lansseNlSegFraoS04
	 5db7dA5MexLH2QSc0fmyMW+4fzgN87rTvpbsw3a+oKgZIwUiQepkHtO0g06FTpOAQq
	 u2F8TzMfWZstrEaGNgsaFZ1rs4/j9X4Su+JPMZEhHBABL2N8M/UnaOaG8HwaePpx6N
	 qYUytcN2aPPFg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net] Squash to "mptcp: update window_clamp on subflows when SO_RCVBUF is set"
Date: Fri, 15 May 2026 04:23:33 +0200
Message-ID: <20260515022332.55392-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=876; i=matttbe@kernel.org; h=from:subject; bh=Qag9Nmk4dleI1XBDj2bnl9NsaNnosjzSXM6xlLVQHoo=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqBoOkRfWRpEW3vqH19M+q8Mh/hntKHM2EIg5b+ 4+IHizVqGmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagaDpAAKCRD2t4JPQmmg cy/0EADQ84O+PHPTnTQ1TAbs2kXqoPBDKmlan4cyJeGEIEYQkAtj2A3WiNEFSmGmCHRJRo0kZQo bQeqi3KCpTo0nCBl8ikOQa4PhavKl4XVHQbC71Bsjyl8gqhv1wXCaOnqI72iy80rsgLlw313LHS inhQ0Z8i5A+RGJNYFjSTGwOvcGSrGBi4aRGbN7Td6ccCNuIHg6/P0A3KNWZNrKla+XAVeHJ41ry PDWJXiBMKs9twrdT9tCY6cI3rBtrUi/oJpZhXB7fRpIIdVoekfFUl+RZAod8OOaiZREv6pR03AM oKlyjpWSgWNFku1r1babBR9VWBzYACQ3cUHlbo539i9JWATRFN7W9gnugvheCtsHQPqv/D7RAm3 TTFdinlBSlC1hXVoYb2lvrGL0GxPu76xs2qQI9MQTk9oWQ42wc/F44apW79lZ1Cqcj9W6z5QG0L 7an3gsrS+5G4AwuKilyHx6wyFMyb4Id45UTgkgT6ZgYOrTlphDPV73GRzisveIA1IW6fmxPyE11 opKi/ZES1Yr9bPotR7EP0aSa7+xNhDwfPN+z6A2U0Fk3Cq3lgq16iwaYbAyV/OF2Jr/iTeHTzlM eCaZeZ9ku7D0r2CKWKUifqZtEKNyxFaoaR3CsTyG0XCMs3GTaILIj0BmETuhxDL0AxhAyrK5cfU fTU1E7F5bCX6UcQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Remove the useless 'inline' keyword for a static function in a .c file.

Spot by NIPA when sending the patch.

Link: https://patchwork.kernel.org/project/netdevbpf/patch/20260511-net-mptcp-misc-fixes-7-1-rc4-v1-5-5ee57cb2b7eb@kernel.org/
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1544e3563852..87b5796d0135 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -67,7 +67,7 @@ static int mptcp_get_int_option(struct mptcp_sock *msk, sockptr_t optval,
 	return 0;
 }
 
-static inline void __mptcp_subflow_set_rcvbuf(struct sock *ssk, int val)
+static void __mptcp_subflow_set_rcvbuf(struct sock *ssk, int val)
 {
 	WRITE_ONCE(ssk->sk_rcvbuf, val);
 	tcp_set_rcvbuf(ssk, val);
-- 
2.53.0

