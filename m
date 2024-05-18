Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77D4D517
	for <mptcp@lists.linux.dev>; Sat, 18 May 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716047578; cv=none; b=gQAnJmYhg9s0zh3MMdWvUGLEJ0456fBjyZWB0cxDvxtZXwvQljD8Y4rKL7xR0dv3XZnh5GXu/j4QA5Ax5Qtr02N6ND8KV4TARdCxP0Jhig+smsfFIDm+whk0S9zFwLoargZI/XGoESI2R3B3eM+cQDosb3KBZBLROh5fXN45zp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716047578; c=relaxed/simple;
	bh=ypvHqt2ffZwH1g8JlbofDCv9yboiuwJHzR7LWZNKd+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agHqePUmAsS779y2vUBde7yhqckvVwCqLllY8CG/pVuD6XL22LE4899EfoR/7LcMJstQvm+wHBXhkw2JVj8LGhQWYYGGpZ/dPC2N3dJiIUniVtDKn1jk3rMK8O+HbqJUtHzHgDZcWi/GZiEno9GONA6Rb9EhY1qzwCDcYTJapR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4100WGi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4100WGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BDFC32786;
	Sat, 18 May 2024 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716047578;
	bh=ypvHqt2ffZwH1g8JlbofDCv9yboiuwJHzR7LWZNKd+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e4100WGistkSi5zZzRcON4gEvHAbbaPpCsNaljeMBXoQNdNBhx7sphLtDeKLYh3RK
	 lzBSB5+N+V9qw9yT/y26DGrSgr+g4zCZXXUSXiPRAdVjFlMJZJO4Mk5dkdrwH6T73q
	 7yDSpWYyrzN+ijAkBm4WVAYq6Ev3TUYT5/xSAoHeLf8TO+3PUf8G7CoaXeB/wNm/so
	 AemD1s/A8QIJhtJ6iaEfmonn0qHrCl/qHi/TaGst12W1rMZg68BP88NZ2H1uqULckY
	 61DLErlDbaT9v4DJMPVBeEK7/i65s4JH5ZSy4OgqZm1IaY94Gg87CnLIOoyBmX+iRf
	 ys2yjgHgSpSAA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 18 May 2024 17:52:41 +0200
Subject: [PATCH mptcp-next v2 1/3] doc: mptcp: add missing
 'available_schedulers' entry
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240518-mptcp-doc-v2-1-68304a17cd7d@kernel.org>
References: <20240518-mptcp-doc-v2-0-68304a17cd7d@kernel.org>
In-Reply-To: <20240518-mptcp-doc-v2-0-68304a17cd7d@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ypvHqt2ffZwH1g8JlbofDCv9yboiuwJHzR7LWZNKd+E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmSM7TYZ4k3s5FlXoR2X/BSo2U6M8TVrwVshhIe
 rUb+Ou17S2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZkjO0wAKCRD2t4JPQmmg
 c3dSD/9ChzkMXm9u6eVZgOs8DjXNHeO16njcMztEQWRefFcgIN0o8kZ3VHn1NFs/6nPjc+HyDfo
 INq18ybs8bp5Q9QMgPf8YhMNPzR5KZd/YB9+6Dr1oa4n2wNEsPwa9NArqTdhGWDn7Zh6GrBlWEN
 2mjs2bQ2Zuqn+wYQYJb+bZA/87zSQrp90uh1e0udYrAqC/37KwtaRKQGgS9wGyEZ49sRThoXOmN
 vZ7fZi0kcu5qIdHyhimmAZfxK3Oe43Mmq93n8MUhRBKULPLWKsJINTQJBKzPlHvwl8ndou5phch
 LxreWiGuYcDvttknqn24HsFYMsciq0AiCy8iUTVc6bGgO0NQBz3vyfhKB2SQv3rJ9YB5MsF7OIU
 kFDi5YqgB490YMboaNr3hjRRMNGBRxLFmT5W5lkbHbu15Lm82m3cylJDERg55AUX55Cr8FFcVNO
 knbdWuO19VIq2ZK8qawWgzZJ7aP8avvtOOWyJGXltJjGthUErZw+7qWN/ZEW+8/SIFQteW7UqdY
 lMrcHQ6tTLxXqGXWwQEcW4VDBXl+5orLEU9I4px1JSl5JhKG4xFzdnjVB+BLeglzkA32i8toEmw
 hK68G0HqvQS+vV45AiCUMkz//oNgfy8i/7H8JAHA1QK1P3gB4cMJ/+xisvzrlo3iU2tMxVCLepR
 H6jMDoVxI2wN6SQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This sysctl knob has been added recently, but the documentation has not
been updated.

This knob is used to show the available schedulers choices that are
registered, similar to 'net.ipv4.tcp_available_congestion_control'.

Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 69975ce25a02..102a45e7bfa8 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -93,3 +93,7 @@ scheduler - STRING
 	sysctl.
 
 	Default: "default"
+
+available_schedulers - STRING
+	Shows the available schedulers choices that are registered. More packet
+	schedulers may be available, but not loaded.

-- 
2.43.0

