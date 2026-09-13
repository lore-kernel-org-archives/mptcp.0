Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8623356754
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294529; cv=none; b=OIu1b+6C5b0r4HLv2HVJlQdFFKg4QSIi0DiF57TxaOjzD/iaTfP1kGLlSH44gGQyXHpMfxpbj/OHLeCedTAm/qK2Zkw7g4MH/SephNY9P/FogdhKJsDpOi0nl4JqSWx7TIISFIVnJUe83vmoPgV/2zOrgIuGK7op0eu/UzBC5hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294529; c=relaxed/simple;
	bh=jjqtykYGtXXv6+EvzDwNfY8QyD5HhYlzWFJHkxaSSxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ew1px8n93jTOSIxRmgnnknvFXt2m6jPsK6dRfAmip021DODFWosj/onll1kq/9zl5imOUjtxnnRgKr2NoNhPwVUvH9NtqEx1B/PwXguoQgcdQUOTbewzOuK3n47DueOrZafXmc73BRKa68JRnIrawc2FjoUO6bceEXyy7T0xWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuiISwdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuiISwdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74DB1F000FF;
	Sun, 13 Sep 2026 10:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294528;
	bh=ayBL6lZs1xweCV6e2FL/UZlwP0pu/Rx0XOYDCx9CWUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MuiISwdi+Qgrq/Vv570lv9lk/OiyzhzIjD5VDJOShQklECxDCk7QH2AiOcsYe5j1G
	 kSKcZmOF4YkmeCYkUAoCFwTFPAPXuFU1RruHw/Au4rmjEfFZWYtfy3R8UFo19tpxj9
	 3wHz45uf/AN5wH/bf7b6TM4n+yMTW9g2wNIYyMI6zBKlDJ2UKHnFPgU7SlX9/SUSlj
	 wFz8OawNqL9v0iIinkdZ3I8+pu5MqPllEViDBEdUGAhBQNAeA/Jkt+WfkUXWyLizY6
	 aGklqZoHA3W10CKw2e60EHUWUEmQcQTO4wguUU1d0JJsg3bgUhb/mN45ByTdpNWWy/
	 diBPMnofsXv9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 14/16] mptcp: add SO_ATTACH_REUSEPORT_EBPF support
Date: Sun, 13 Sep 2026 18:14:53 +0800
Message-ID: <89f683b22bcd2e0ade93fe16108444ea1aee0e52.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add MPTCP support for SO_ATTACH_REUSEPORT_EBPF and SO_DETACH_REUSEPORT_BPF
socket options by forwarding them to the first subflow via
sk_setsockopt(). This enables MPTCP listener sockets to use reuseport
BPF programs, which is required for sockmap reuseport integration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index d2d1c9d1ed1d..e740207f05ce 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -338,6 +338,18 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 		}
 		release_sock(sk);
 		return ret;
+	case SO_ATTACH_REUSEPORT_EBPF:
+	case SO_DETACH_REUSEPORT_BPF:
+		lock_sock(sk);
+		ssk = __mptcp_nmpc_sk(msk);
+		if (IS_ERR(ssk)) {
+			release_sock(sk);
+			return PTR_ERR(ssk);
+		}
+
+		ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
+		release_sock(sk);
+		return ret;
 	case SO_KEEPALIVE:
 	case SO_PRIORITY:
 	case SO_SNDBUF:
@@ -385,12 +397,9 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 
 	/* SO_OOBINLINE is not supported, let's avoid the related mess
 	 * SO_ATTACH_FILTER, SO_ATTACH_BPF, SO_ATTACH_REUSEPORT_CBPF,
-	 * SO_DETACH_REUSEPORT_BPF, SO_DETACH_FILTER, SO_LOCK_FILTER,
+	 * SO_DETACH_FILTER, SO_LOCK_FILTER,
 	 * we must be careful with subflows
 	 *
-	 * SO_ATTACH_REUSEPORT_EBPF is not supported, at it checks
-	 * explicitly the sk_protocol field
-	 *
 	 * SO_PEEK_OFF is unsupported, as it is for plain TCP
 	 * SO_MAX_PACING_RATE is unsupported, we must be careful with subflows
 	 * SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
-- 
2.53.0

