Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E247237E5F2
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786160496; cv=none; b=sag0loHvDA2DhG7livlIt/nuhj8Y7xQnxH69xSZssN/Pe5hXWu9nZgkjQb7NiZUYufFIELoWj6Ue97AI8i8QGtkPL93czwGt7kz5z9nEgDFzAb6ksb0AK2S0sA11n5dmtl2tUVApyo0NAhMzAyy9rSeymY7Sl+Kdw7ySThkyMfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786160496; c=relaxed/simple;
	bh=hhCIURNC+LAUD0hvbcVJnJclG9LApujDepDP6o9d6A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxe8Q7HdA5Vv6qlmKOPEwqiIl05w7Pukzf2On/ix5QYkJvLw7cxp1LENCgG0fjAqOLDe0GF0Z6XYza9/WmnBbC3ZKPCRsmfwUekSC2S6vWm11Hk2rU0m/cZ/7NlsEDs3o6M9sqZlDapDnGLMtVQE/y5M71f7US1zjABzD3ttIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd47vvx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd47vvx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4E11F000E9;
	Sat,  8 Aug 2026 03:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786160494;
	bh=bSJcrshk9pMImz1aRnkL+JcH54NcegLybWsRd1vENL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nd47vvx5+2DINKBnU/oHi4eo+8prUkTbwlJdpo2gAah6CNlie8RXetPWPa+swhowP
	 6LFG3K+i7rxmmaMYQu5u2T77RrUHG7Sk/c1dgJhM0rfeTN4hHeAWh6B1/XzDbHDW+3
	 uXcN/45hC5XgB56/mrjN4fzYt/asXqOh/dYwEFOCnjNaOFQRNsv2V+PamH7GVUscJi
	 lnPW6pflV/mc296JGQfEaGYYpdkrwh7Z5B3vIik7q8hoFrVnDyN5RbEXNfDcKmHOvh
	 Reg4t1oCIL+OtmXKamyu/FGziovk328aOfzCBvwp5Gi1o8j6/ATHPyzODqUGdxj11s
	 r+XfbS72RJSOQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 10/11] nvme-tcp: support IPv6 traffic class
Date: Sat,  8 Aug 2026 11:40:40 +0800
Message-ID: <5f82f0aac4bf1f879c5ff01bd0f8310c20738f09.1786159812.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786159812.git.tanggeliang@kylinos.cn>
References: <cover.1786159812.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The NVMe/TCP transport needs to configure the IPv6 traffic class on
its queue sockets, but the fabrics option parser currently has no
corresponding option.

Add the tclass option to the fabrics parser and store the validated
value in struct nvmf_ctrl_options. Negative values are rejected, while
values greater than 255 are clamped to 255, matching the valid range
of the IPv6 traffic class field.

Keep -1 as the default value to let the transport use its default
traffic class.

The fabrics layer now supports parsing the tclass option, but the
NVMe/TCP transport does not currently advertise or apply it.

Allow NVMe/TCP to use NVMF_OPT_TCLASS and set IPV6_TCLASS on each queue
socket when a traffic class is specified. Keep the existing IPv4 TOS
handling unchanged.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
 drivers/nvme/host/fabrics.h |  3 +++
 drivers/nvme/host/tcp.c     |  8 +++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ac3d4f400601..643c03dc7bcb 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -695,6 +695,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
+	{ NVMF_OPT_TCLASS,		"tclass=%d"		},
 #ifdef CONFIG_NVME_TCP_TLS
 	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
 	{ NVMF_OPT_TLS_KEY,		"tls_key=%d"		},
@@ -734,6 +735,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->hdr_digest = false;
 	opts->data_digest = false;
 	opts->tos = -1; /* < 0 == use transport default */
+	opts->tclass = -1; /* < 0 == use transport default */
 	opts->tls = false;
 	opts->tls_key = NULL;
 	opts->keyring = NULL;
@@ -991,6 +993,22 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tos = token;
 			break;
+		case NVMF_OPT_TCLASS:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token < 0) {
+				pr_err("Invalid traffic class %d\n", token);
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token > 255) {
+				pr_warn("Clamping traffic class to 255\n");
+				token = 255;
+			}
+			opts->tclass = token;
+			break;
 		case NVMF_OPT_KEYRING:
 			if (match_int(args, &key_id) || key_id <= 0) {
 				ret = -EINVAL;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index caf5503d0833..3dfd40bd8960 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -67,6 +67,7 @@ enum {
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
 	NVMF_OPT_CONCAT		= 1 << 28,
+	NVMF_OPT_TCLASS		= 1 << 29,
 };
 
 /**
@@ -109,6 +110,7 @@ enum {
  * @nr_write_queues: number of queues for write I/O
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
+ * @tclass: IPv6 traffic class
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
  */
 struct nvmf_ctrl_options {
@@ -139,6 +141,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_write_queues;
 	unsigned int		nr_poll_queues;
 	int			tos;
+	int			tclass;
 	int			fast_io_fail_tmo;
 };
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..cabbf67d24f8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1837,6 +1837,11 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	/* Set socket type of service */
 	if (nctrl->opts->tos >= 0)
 		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (nctrl->opts->tclass >= 0 &&
+	    queue->sock->sk->sk_family == AF_INET6)
+		ip6_sock_set_tclass(queue->sock->sk, nctrl->opts->tclass);
+#endif
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
@@ -3041,7 +3046,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
+			  NVMF_OPT_TOS | NVMF_OPT_TCLASS |
+			  NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
 			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
-- 
2.53.0

