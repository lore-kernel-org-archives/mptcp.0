Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EEE1F951
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984514; cv=none; b=gNhJaO0QbMNut/qk0T0vTF3vwMYeGC3TAM3h+w46ldRohuLvm9PYMqQyyw7ROfvJNjTlGaumJtTef4KwgSHLZXd2HooFg3ltb0VPRXqjKogcTBxNpMaDvFmYSHvnZiHvp3Y4EatK5dBIExH6BL0GQ7Y4ofp1jIKxikVsFDATlLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984514; c=relaxed/simple;
	bh=LjtnQPANnSg5t2n6XNeq9rMALo2ilBott2YSuABt+Oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QUddz7TEq3J9IrrH6+lxKOcN4xZamq8Z1dM5khaOIPO24tCh4mjX6Kq9KL71rzU2sTkvVo4dF+5b/iYXOqaWNOzSJ4XTKatbjQPyToOueT3CGXuZKtltAlGcEabCIDE8tv3MIE3yr5I2+jxiP6qSMHRckUiC2xcF2GyaVSrM1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaIjKCJJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaIjKCJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC07C4AF09;
	Fri, 26 Jul 2024 09:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721984513;
	bh=LjtnQPANnSg5t2n6XNeq9rMALo2ilBott2YSuABt+Oo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LaIjKCJJW40UYAi7BoLUU9pRk2wcLdzCFwscnEYd2GVEn7ht4RTN6oeSDWc0Bfrbd
	 sMUXtr0Qw/0h4UnSg5tCP2rwTB4WB5bsGNCu/h8weLUmhj14SIkS49hXbZxOlOD3tT
	 1CL/z4JzMYrB7aj1VeW43llusrRwVm0mJbVbs8pO/4zb+2WjsAc4TWDLfPR0pr6IxP
	 Tq+MeDCkTdSvIBrL77M/tYhiDHta9cyPfMSDUhNDF1HvYJWZe9p4SF+l9NT0R6EQKr
	 GYTaDNQMxpoRt4II2r3vqwRTP1aXGm5Af/dK1UXXoNrMa1Ld1HjjvkFGoNJ9F8hAn4
	 N1ZJI32nLA5zA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 11:01:40 +0200
Subject: [PATCH mptcp-iproute v3 5/7] man: mptcp: 'fullmesh' has to be used
 with 'subflow'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-user-feedback-v3-5-c6ba1f5fa13e@kernel.org>
References: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
In-Reply-To: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LjtnQPANnSg5t2n6XNeq9rMALo2ilBott2YSuABt+Oo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo2X6X7MHo46kcjM7K0bbrGrZsVP11QsPd5Lir
 qaIBlX4F1eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqNl+gAKCRD2t4JPQmmg
 c/t6D/9dA7B/HObygMZaaYqr3Z0YFdxO207ojrNcMCijerRFo0Eglus59j3PkX4TpZAaLKvYsWf
 tsXz7MCVQpikSrH+n98HcTzQc9XuKE5FkLWsJ1Y+FI2yo0QVJt2b3ayEFefz1JBgYHI8Ra7gQXi
 IH5z6g0dS7ijt6Y7grcCXu02H1TnCxKe+sRyfGdpfJmtNL212OxTzphIY5hpYNWycKsaAmEgAjj
 Mi5ZZ+NEDYTmiC6iZz+bWVUPTg5gks9Kc17Jmm3mrK4zp61KX7fHkBAF8XbqT2CDeL2f/Sd0egu
 aX0GRoyakX2jmlTvoA+Ww8rS5ND9g9FQc3dIyv1/MuvD8qLgDhkTDDf6hlogo+EmDsl+vft9Hcg
 rlwyrJ3BWCw6jmAIvDT3bNzRgiXKbShX05SZbGaspo85A5tomw5naiote9+gXUB8zrSfq8hEJ2j
 pnSLO41E0v5zwIlYZHkmpB4Y9gaOLpXIws1NO9yD0ShGIkSrbc8bF+oVS/qq+LJwRlUkfbK9JAQ
 Dc0UFBgM2WcXDq3sxILixbhLQtC9NOGy6ReROjdWmTRA7xlYmVlQUwTcSRvckNM7RvzP8/bqXYt
 1V9uNi65N3hMlXhAMu5ILzu5WNcq+lne7fA4BxO4wLIzIxt61sSKtXIaqV4thqOlLFESho7YITB
 762NKhTPbyImoFA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'fullmesh' affects the subflow creation, it has to be used with the
'subflow' flag. That's what is enforced on the kernel side.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index f3d09bab..4c1161fe 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -190,7 +190,14 @@ this will behave the same as a plain
 .BR subflow
 endpoint. When the peer does announce addresses, each received ADD_ADDR
 sub-option will trigger creation of an additional subflow to generate a
-full mesh topology.
+full mesh topology. This
+.BR fullmesh
+flag should always be used in combination with the
+.BR subflow
+one to be useful, except for the address used by the initial subflow,
+where
+.BR subflow
+is then optional.
 
 .TP
 .BR implicit

-- 
2.45.2

