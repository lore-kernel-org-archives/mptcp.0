Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3681F280331;
	Sat,  8 Aug 2026 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786172175; cv=none; b=D2phcELK0z+zuHTr4Tib+LdX+yuEZKRwPneL7TMsh1wCPm7F1aCvdHRIfOBotjANPi5r/bAivUx4A0skHEXx3kY0r++OGHjZAJ4L9awvR2sGVURvfx+7wqHO7SjIfo01wHGz3uSNmZeAQqB/+g5seQCMswayUkNojQmDvWx5UAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786172175; c=relaxed/simple;
	bh=wnU18rO59vYny4m1dksZRR9Uym7qPigyN1s5mB7eEMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVQ7juSmjjhNEuAL2p9pX/cfQmgpMssEcGb69E4Zvu0CKFZg6f5VnCEqmnGF7sMMPPW5Nic2FO4JAHRccWG9IQqL35RVecoBxOsUnFHXHpJQ65QWuBfPfbVwGfDUInKQlk/JZWywaS73pANDsqHMqpLrufKmrtAMcdjp9xE3BDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdzpqnUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdzpqnUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2571F000E9;
	Sat,  8 Aug 2026 06:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786172173;
	bh=Yul4QY+Tdr6oGd1fEwZXgGg1iq9NHlfdi5APnyMx7cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hdzpqnUIA/C/M8bsYHrsDeHIsH/rh7hNEomSXsr1M38DcuONF4A2LErtIDNEim9pj
	 rYkahJjlw8wxxplm+Pyy/W10LQ5a4QvbHx98YNlgOS1dOWsXcBSBY6PgfSbbasrBn1
	 UVYpNVmNT26KXEEBBMBTtDoT2AjCa5CuyLHTo/uh9ooq70LYeeLk7px7lrbgPBcPzB
	 FHcxvt2AjvLpahVtdtcvX/hVLNLHNlw8FRjOojrVIxhkfkqvjOedV2fqafqSEBdISK
	 vdmXwCj54/R3Fk3MzvbetM0j0DOpF8RkOzbPClbdOmuGsXYx3qv0p9mbhnPQO7f2M0
	 +RCI0VXF2K8wQ==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v2 2/3] nvme-tcp: support IPv6 traffic class
Date: Sat,  8 Aug 2026 14:55:00 +0800
Message-ID: <3f5e4c84d3fe41601b29468fa4128d4639d56685.1786171863.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786171863.git.tanggeliang@kylinos.cn>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The NVMe/TCP transport needs to configure the IPv6 traffic class on its
queue sockets, but the fabrics option parser currently has no corresponding
option.

Add the tclass option to the fabrics parser and store the validated value
in struct nvmf_ctrl_options. Negative values are rejected, while values
greater than 255 are clamped to 255, matching the valid range of the IPv6
traffic class field.

Keep -1 as the default value to let the transport use its default traffic
class.

The fabrics layer now supports parsing the tclass option, but the NVMe/TCP
transport does not currently advertise or apply it.

Allow NVMe/TCP to use NVMF_OPT_TCLASS and set IPV6_TCLASS on each queue
socket via ip6_sock_set_tclass() when a traffic class is specified, keeping
the existing IPv4 TOS handling unchanged.

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

