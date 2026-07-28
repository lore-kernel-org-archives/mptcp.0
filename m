Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78273A7F48
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238822; cv=none; b=iSpl4fC1oqUY0wH9e2rYFEeQ3F/OKqlA4KO7ILMwB2cp+aRtxQx43GQJoPFYqrnCICg60uaOi4S1TDFPA9dSQrXhW0Gto/+TSCrHhNkj72V7Hz2YnJqhrL8oIu45ocq2TZLxf53d4QGyeMfvLZZmYtZXpmnwA3juMDXNaL9/G5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238822; c=relaxed/simple;
	bh=z+MT6iHR90MH7fR8Zl/cDG8NUYSXrnAPDc9MrmBqMnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRkrgCvk3u8MyXdrXg5ooUlvQGzgrXhnEBaepqf2plxg1q3OXHMwaKYvDZQRYl4gLjHtrR7/63IhG9Xlt5MxoEcCOQ12ZsI6CR9gJvP+hnRdFS4JBrqNB9++e7nRQCuJ4TuAPbYUwg8JJqBvKQO6jn2hWlwwhnn90cQGfTMf3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLiBVrxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLiBVrxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A781F00A3A;
	Tue, 28 Jul 2026 11:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238821;
	bh=xwgSsv+t31v8M0nIbsj0ejN/HhnKtVUxm/+T4c2rE4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eLiBVrxmhJfeyYR60Hk5Zg/2JDJuilVzQ/0fqONRJzrMfRb91H0KeS78UokSDuyO4
	 gdagj+TcWF6d8n5upYf9//EvC8U3GpZKZf+bCBsta/1/thL41CncmhMBJ9WpNdMnnQ
	 vmKC7/0L75pV1oQzsXgXvYEkfSEWvUrwDIRbg2I5Kabsgzs5/4FN1mVv6DPfUHvkq+
	 qRWW1NZMDUrzy+Sf6o/gBxGrtoTt00n1vdpegzVZmGvxoadPMQS/35tvFJ3Cc9wiaU
	 Lc7c349xwbGEG9fEJKCAOqOeIXlQqeWxgV/qKz+MXAELd4FYusa13Oo55U9eSI2cvD
	 1+nl2NRRAeiDQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 5/9] nvme-fabrics: add IPv6 traffic class option
Date: Tue, 28 Jul 2026 19:39:38 +0800
Message-ID: <f8f508ac3ae629a3094a582226632e9de9386f56.1785238723.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785238723.git.tanggeliang@kylinos.cn>
References: <cover.1785238723.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
 drivers/nvme/host/fabrics.h |  3 +++
 2 files changed, 21 insertions(+)

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
 
-- 
2.53.0

