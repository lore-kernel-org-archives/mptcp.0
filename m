Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747203;
	b=pgfvFpXe6m9T7Saus3i07Z7z6YRtPkbAv/p2OjtiHbGW4Has3wg0sBryJYXR+B8PVBTi
	 piYmfAreDSTp0v1Hbqcu8ze+hfYbJysfTa/WBAKgMlLywSN3gQffHl7I9MGeNHm7LRShg
	 8cU0x/Wlf2aLIehF67vvg3ZCGRYA8GMwVWN5N4BLJ639/bXjue1RZqe3M2+5meyCpgXzX
	 A9NFEJ90YouZlG9ZF0+2NWe+J2pbsEkjH6LCaUmBxfzVUaq+uNPhlY7T0q0fNUF1b9wSy
	 EgXMLgzhswHuVgllEZeUGMuLuj8dUlCfC3QTOywTzWP/x/cJJVaKGkz69Whw0eF+bsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=srre5pXT7Kp7PCGpwuXFI9khASn6cX7uiJTqdaBREXs=;
	b=I8koPAfWPUqY4MYV8LWug8LeDLOnBi2wPrLCnfF3JJiB8veqxy9mDyWvOrIFrYeYZnYn
	 p6kBGC//0Inv6L7YiN24Q+7yuNfgvJh8C++dEnvAcZZEeGq0jQ5PW06POfasVFzHdLPAy
	 Fi6V2nJ9AU4jiIZ046b7tmjFUqQaHtri6GQVKEYnK9Va+NobQbaQ79u3n8+OIbYtDfX69
	 O79NK5voQpjyGtdMKCQF1bbUjihLASaF+6Df9Ij5/2iKvypuVyg9gbjEvAtd8+OEOAEWD
	 j+KeX85BKTG4gdW4eqdh0cmRvOs+Nxb9gwkuSuyW7WBg5po5sC5ig9gyr55KJqvM2yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwLCy286;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD74606A31A
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwLCy286
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBDE1F01828;
	Fri, 23 Oct 2026 09:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792747203;
	bh=srre5pXT7Kp7PCGpwuXFI9khASn6cX7uiJTqdaBREXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GwLCy286ihLtkZ7khfJcZM5xW4u85pxfUmmhxmp8ICAzPgdobCQntJcO0h/+erj5C
	 ROV7lR04jASTcMIdvz0EcVIRCC6xFBHcuiUHWOx9/uRzcU5sG3ZTto94v3aXk8OpKQ
	 FuTFxMqXVUz1YWSCmn+8hGtULadEG8eXCty4qTpcfXzmYg00C3LWjTRym118oikh5F
	 5oSP7NBt2KxqWb/098c1/IUTw/6XF2X5zX/u4RMM0AG5JjYlKlD/fRv+7oCk8WcYj4
	 GuqqWWWonMAVdEsdhvviC7WRvdrwni8q2GqUpIxHP4Eo5bMcZdGDVKS3G0jGQi+E1v
	 NKqgaQ/PFZ+Mw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] nbd: allow MPTCP sockets
Date: Fri, 23 Oct 2026 17:19:55 +0800
Message-ID: <1612e1611a1e5d78d651a4c1a69da38fdcf98ca8.1792746800.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792746800.git.tanggeliang@kylinos.cn>
References: <cover.1792746800.git.tanggeliang@kylinos.cn>
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
index ffce519bf008..2aeb22b1ad40 100644
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
@@ -1221,8 +1222,9 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
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

