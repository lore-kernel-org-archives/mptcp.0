Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D52F8E98
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971560; cv=none; b=KKS6kuc+o7EumZWmC0Lv/d+uIRbQo6paYOTQEwYIoyQO+b71LXGy9ZCG4POI70Zn2/qWFmx9BpW5mzU4OkbbGeD39sQ9sLZelMIyUOnZyFKSEzI8HA7moPDwi68a/D0X70EMRaqTKGZKDfqKJnfY93W5/PnCqEgBz/CvkAR71SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971560; c=relaxed/simple;
	bh=Op4/qidNO8/EEe0sw4xhDG6E3OdgHtNYgc2N5+3BTik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+5rmtoudGaH6fUFhNKKFJxnnScpfoDvi3aNZpRNWnCcGnYqQ5/agUBa8efTZwyq5Aw7GjYddWt0V9FE1ZyrlEEi1gXTdoOsdL9mfyr5rBQdaG7fqHmWsq5c4FQvn41OzYe69rPaAP1Z3qJst6KygO3n5dpnDe8lliUuHQ7JuYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH9UiJS7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH9UiJS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B991F00893;
	Tue,  9 Jun 2026 02:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971559;
	bh=imOyKEOqZ1XlIkcEU9jy1P7MzSTycLzbZZSOKast33Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SH9UiJS7zeTRwS+L3ZQphuqRAgVrgwPeTcbvPGlEqhkdZERQXVw2ETVmYWW/oIea/
	 togb4wirOwvoki/yFO+UsyDF8sorg5F+PEdSv1xYNgFSF9cmtWr2ShJ7Xl/ItQ9XtQ
	 qvlVGys507alDVuHczV3J9In3qvb/8BDzP6uaLm7CdvEfFfRn47/pVfxYkF55k7iad
	 /eSCF1hqoNxtyBn14XF3cPJHszZIBSszuIiupOWHmos3zMdxZ2LHac2JiU6Z2Rl5xA
	 v6Fkj2/+hv+qdtxDvR/VaS5BiJFGiJyspGf1xKsEoI5WivxkCr8Pp2zEUGugQCP33W
	 wEn9C/YP+BZpw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v25 02/22] tls: use sendmsg_locked from the underlying socket
Date: Tue,  9 Jun 2026 10:18:28 +0800
Message-ID: <ffdba5765d2cd4696bbb32e756329be6ae95dd88.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

TLS offload (device and sw) may call tcp_sendmsg_locked() directly
when pushing TLS records. This assumes the underlying socket is always
a TCP socket. With MPTCP, the socket can be an MPTCP socket, which
does not directly expose a sendmsg_locked method via its proto_ops.

Replace the hard-coded tcp_sendmsg_locked() call with
sk->sk_socket->ops->sendmsg_locked(). This enables TLS to work
transparently over any socket that implements .sendmsg_locked,
including MPTCP after the previous commit.

The change is safe because both TCP and MPTCP now provide a conformant
.sendmsg_locked implementation.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fd39acf41a61..15605ac45ba2 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -194,7 +194,7 @@ int tls_push_sg(struct sock *sk,
 		bvec_set_page(&bvec, p, size, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
 
-		ret = tcp_sendmsg_locked(sk, &msg, size);
+		ret = sk->sk_socket->ops->sendmsg_locked(sk, &msg, size);
 
 		if (ret != size) {
 			if (ret > 0) {
-- 
2.43.0

