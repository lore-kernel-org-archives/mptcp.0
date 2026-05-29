Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360233067C
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053258; cv=none; b=aG9l01UMqezz6KoMJQB92Kja7pXefcvpm+ckq7JdA0BqjZsnzwTJ0NDDyeQi2CyjWdlmN1m2aQwHO0E5m23TDKWOPzWrTQ34dMM1Ui95Nve4Io8G+6aw0JHihIkBbk7hBmoGwrJuEbJkarCE54fY+C8myOgoHbYTZp0WqLO0DAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053258; c=relaxed/simple;
	bh=pefUPGrJtQmpA7Mei7yXQD1BajBEZunb+ZJNbzi5vHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbbHOeasjXYHbEgOGp6NBXRyGQ00BF/tD4aoTIb86Qwel6M3LHLeye9SQ5K6L4LtvDlMbUHlPnyMuVm1XWovGmx2KLuXv1F260A+28/D+bsIhdn9dnofE9ovE6F4iYk1UL8eURZ+d6lsT662iysS1TqhIMDKAaEEU7v3Z9PqZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YapUl8S6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YapUl8S6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912221F00898;
	Fri, 29 May 2026 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053256;
	bh=WaVXx70jO+Cjdcsj6TsN53LD18R7K6tLhbg+q5ufX0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YapUl8S6F2aOBfTcoT5/77n2SjbsnZB2YWUT9w1uJpnDmXvImiy7kTG+YD1YL8M5t
	 n3J1Op8r+2NuLuQQdZ+ITurIoz0yeQh9utKZl78tuOdKiQ1c94JyIXhUBQCb+xGHCH
	 LsryjnT2lDL9bj7J6Kl2xdbStyZxNXTX60yfpA9iBmgmobitGqn6F7tj0Md/Gl0Ix8
	 3UfZeUFBA8fpnuj6FRIYkp15Dhcp844bxHaMKs8or90jBnIE6NL/UKZ4GuXfk7523w
	 ypbpNXbzstQPwD82PQLiiOe4Y9yczVZBf9cTxPZ+SWpWX8PeOhujCQPhbWxskX9o73
	 hvTQHV8JeLPvg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v22 01/20] tls: add clone callback to prevent NULL accept crash
Date: Fri, 29 May 2026 19:13:43 +0800
Message-ID: <52eca39c284a3831111fe790b74e5a78fceceb69.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When a TLS ULP context is attached to a listening socket (e.g., by
calling setsockopt(TCP_ULP, "tls") before accept()), the subsequent
accept() triggers inet_clone_ulp() which accesses ulp_ops->clone.
Since tcp_tls_ulp_ops lacked a .clone member, this resulted in a NULL
pointer access and kernel panic.

Add an empty tls_clone() function and assign it to the .clone field.
The existing ESTABLISHED state check in tls_init() already prevents
TLS on listen sockets, so this serves as a safety net for any remaining
paths.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fd39acf41a61..51ae8925d891 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1082,6 +1082,12 @@ static int tls_init(struct sock *sk)
 	return rc;
 }
 
+static void tls_clone(const struct request_sock *req,
+		      struct sock *newsk,
+		      const gfp_t priority)
+{
+}
+
 static void tls_update(struct sock *sk, struct proto *p,
 		       void (*write_space)(struct sock *sk))
 {
@@ -1231,6 +1237,7 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
 	.name			= "tls",
 	.owner			= THIS_MODULE,
 	.init			= tls_init,
+	.clone			= tls_clone,
 	.update			= tls_update,
 	.get_info		= tls_get_info,
 	.get_info_size		= tls_get_info_size,
-- 
2.53.0

