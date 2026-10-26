Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010943;
	b=yKUptoDmyIH59IUGMhK/lsjfn+OsBsBbCbgrYWdPvuBA7PU38UJhmowQdrMXZhKUZ7hN
	 PPJgzFQ7fcvBHtifYoRWmRm6vY1P0vrWkfRRL8ePMjtkno9AE0oFG8fW/x89ORgHcQpIt
	 hcJ9DNbWjTbd6Pc1AzslKYssKm/38EJgOJAoDH0r2OROO5PcjVtPaDDeMwtFEN9tNltLP
	 yF2WqBuXo9vBCjQrVN48ZRcX69PQ7ALU0nsUVfKy5vHBf7Fn5dDPwD0obpWapBAdZG0PU
	 ZHzRHPaUqKT9JUG2DIwb/xwTU57MPB1nMozf1ArH+C8poDgMRjNT+OLGTAwf7wuycIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010943;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=t04EphSPfNStBcFThpXgmL04PnNNqPMwD29cgZSCzqI=;
	b=qOx9gqjVaaJDm+sGTuhXs5I5PcA39KR3W/nTlwO+XuQnBOEkR/v4Ym8x/b1aQ9zuvCgW
	 3xWckxeQFvSSITv33nDM5zDvCjsLhfiSpFYnjtNNTmCwXK1wRTQllWsLsHYSPDh2p35Qe
	 bkbJ39jfefXThgtaQc0MVZz2Vy5p5VzCi8NeuA5dNvEGTDqUM3+a0VGlfWNzN3cdGJWw3
	 gvKD1xRdxoICbtqh2Nt4OgxW9y2E+nQyCe8JgtbQhCYAiCU9rKaXGKor0edpNVkXHG0mB
	 WGxfR3umacwGFCXos8yrwteattuT6r0qkQw30dByz6wFDkVzuOF6txWgyUKVKZNpt/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fjgw3Hsc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808C606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fjgw3Hsc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355C71F031E2;
	Mon, 26 Oct 2026 10:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793010942;
	bh=t04EphSPfNStBcFThpXgmL04PnNNqPMwD29cgZSCzqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fjgw3HscjN7xxDD4LtQP9+tFWOiMgQ82U+cPgrnj5s5cHDwAEWPFZMCChKiAfQhm6
	 ki+5WAOtool6ytgB1U+TlvbwASGYy72EsHjaE4jaTjbWrMx85M4N2ciddztvz1yRUp
	 ziQbCX5Mn/jRbm/08PYP6O6ujbtgcHzUSYSoWmnrt7i+NIsRE7NgDCw259sI1pE0GZ
	 /6Jv5j4dk3R2U/pszv4QIwvCfCo2r6+o53GB5678nb2XzOqbkEJHz9ZAdaNCxuRuHR
	 8PBANuvN0tNR0YKgKtbe5Ab9MZ6M4FlNhhYqKqnfhS+nitA9ib6HCA58HCD/tLSVLc
	 yPsm4GRccknYA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/4] nbd: allow MPTCP sockets
Date: Mon, 26 Oct 2026 18:35:27 +0800
Message-ID: <ed971f839d9482713fca427b4b3dad3935a593c4.1793010744.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793010744.git.tanggeliang@kylinos.cn>
References: <cover.1793010744.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP (Multipath TCP, RFC 8684) is an extension to TCP introduced in
Linux 5.6 that can combine bandwidth from multiple network interfaces.

For NBD (Network Block Device), MPTCP provides significant bandwidth
aggregation in multi-NIC scenarios. Our tests with 4 virtual NICs
(each limited to 1000 Mbit/s / 125 MB/s) show ~4x improvement,
TCP achieves ~110 MiB/s while MPTCP achieves ~400 MiB/s for both
read and write:

 # ./mptcp_nbd.sh mptcp
 INFO: nbd-server lacks native MPTCP, using mptcpize
 INFO: nbd-client lacks native MPTCP, using mptcpize
 Negotiation: ..size = 256MB
 Connected /dev/nbd0
 connected

 fio-3.41
 ... ...
 Run status group 0 (all jobs):
    READ: bw=406MiB/s (426MB/s), 406MiB/s-406MiB/s (426MB/s-426MB/s), \
		io=4063MiB (4261MB), run=10001-10001msec
 ... ...
 Run status group 0 (all jobs):
   WRITE: bw=376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), \
		io=3758MiB (3940MB), run=10001-10001msec

MPTCP sockets can be created with:

  fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);

Or enabled transparently using the mptcpize tool without modifying
applications (mptcpize run nbd-server, mptcpize run nbd-client).
Future patches will add -M (--mptcp) options to nbd-server and
nbd-client for native MPTCP support.

Currently, the kernel NBD driver only accepts TCP and UNIX sockets.
This patch adds MPTCP socket support by adding msk_is_mptcp() check
in nbd_get_socket().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/block/nbd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c5e26fc98d1a..9cf89d53839a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -33,6 +33,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <net/sock.h>
+#include <net/mptcp.h>
 #include <linux/net.h>
 #include <linux/kthread.h>
 #include <linux/types.h>
@@ -1222,8 +1223,9 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 		return NULL;
 
 	if (!sk_is_tcp(sock->sk) &&
+	    !msk_is_mptcp(sock->sk) &&
 	    !sk_is_stream_unix(sock->sk)) {
-		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: should be TCP or UNIX.\n");
+		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: should be TCP, MPTCP or UNIX.\n");
 		*err = -EINVAL;
 		sockfd_put(sock);
 		return NULL;
-- 
2.55.0

