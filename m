Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285622BCF4C
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380069; cv=none; b=nVa+u/GQ1h9zWIFG0c2hdXm3RSVl0cD8xV7Gn29J2drgnfEjSiceyHRo7h8TA9J1vyPvId8RVaCu7qKw2gTlKtbF/cT2QUY4HVCvMymNHGPRTEbaS1ziQRHCWLuYQz6a7A1i7JT8KwlHnGvkkj3u2CmFP49b2HLm6oRfoPkz3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380069; c=relaxed/simple;
	bh=z+MT6iHR90MH7fR8Zl/cDG8NUYSXrnAPDc9MrmBqMnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6aG9cVPcS6kjrkTmqlXXonAsN7J49SAy0ZhrKK6EGsEjDfUGsm0PowcBIjZP+OAm2Ms/TWF8iHA26pStU7jrS0Gya306mxc9zkt9pKMRJ2G+yK4asophMVC7mBsJkNsR2KU3OzNb8I+vXAXN0mEdAxf0ypQmvAfFNP5wUHUi1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3foItBY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3foItBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18091F000E9;
	Thu, 30 Jul 2026 02:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380067;
	bh=xwgSsv+t31v8M0nIbsj0ejN/HhnKtVUxm/+T4c2rE4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h3foItBYRYaf6lqhEHdAZjK3zChuQTZMk7PY9WvjwL/gWN20CqN+kpojKrFocjR4B
	 Tr7eD4jHeoxvH9hhlyw8MqUNIKKqU/ATH98mWrsKnDUeG+r+Rrp+kuOY3NI7LtcMq6
	 z4MH7uE9FdTFTuTQ6NRy+yIm+2nanHMTpNri97QVsw0j5K/8f7BHojiqNQZ82W0mdJ
	 myXEz+93hY5SXq/Gj2GYDKqF9Avse3vHliC+0p9e0l9VdkOiq3u077iUnWuz4lQ01u
	 eE1z+SNZNN/qWG0Dqd0ag6dvQrpbcfGFYdszDuC5sEBj/ut9Va5N2QdaukzNAlh5jA
	 R9TWKL6LdmK/g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 08/10] nvme-fabrics: add IPv6 traffic class option
Date: Thu, 30 Jul 2026 10:54:01 +0800
Message-ID: <7bdbc9a0e60a3688ca9c7ce2eab7396c82679a93.1785378180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785378180.git.tanggeliang@kylinos.cn>
References: <cover.1785378180.git.tanggeliang@kylinos.cn>
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

