Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B8133B6C7
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964723; cv=none; b=pQQUD2v0R5pt8bu1UsA5y5eJod1CQN9tGiFnRMQo7eoClaqhtpwrrd6igZ7FQ+Gi1mpwzTuNkelJ5EsNZNfZAW3apeHM0ZkWztzKJkxnmdvLY1nHbOn6LxlwpSKVnC3m8bAc1u+2eshhNjagBMUB1WNF9BN5N3c0ZpzgTD1g6PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964723; c=relaxed/simple;
	bh=wyCRr6vLc0SnEfJ47n3ZzKCFP0ZUNFZxmEKtHCDYEnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9b3Qgck1m4EaI3pbk7C//j4J3eujptCwDd8O08FPpCKvhEMRnmWitzbshadSKP/qnb1lkUdO6vLO+UGZlKn+qECtye/yP5SJKUkbPYH0CVFJytJ14N/z46vfzT63GiWR9IEhfippMgiUpD+3HK7Pw8UjyFaU4K/0O3p/IecMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3qHE3g7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3qHE3g7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E9BC16AAE;
	Wed, 12 Nov 2025 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964722;
	bh=wyCRr6vLc0SnEfJ47n3ZzKCFP0ZUNFZxmEKtHCDYEnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m3qHE3g706eMkvMqIkpl22NMakWMY6so6ubtRpRfRvyHrq7uhA5IzGWqDnbEpOzHX
	 YTMalc+HVWQeN3dIyhPm2zfs0On3k1VgJbHZ1DQuMnt72fCMEKD/4bdH4gS6w/xzWj
	 VHlKFZ1mLf7B71ikONpO3aLUz8+NPHMS+VljcOkmHD6HvHB3VrfmbgSjE97BOOOz/h
	 YEWeqLWsBJmRdopVPZFUM3Mq8Lf6i4Lbk9QEGvO98UqY3bDn01tsxrCu8EL2dtI3mQ
	 cIhexGOxdtqUeIACZEapMI9kQjEPHSTjIQ+zhxHKncfSvLzWsALdkwqstPAhNFYPA7
	 0QEj6RAXNX9zQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Nov 2025 17:24:46 +0100
Subject: [PATCH iproute-mptcp 3/6] mptcp: add 'laminar' endpoint support
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-laminar-v1-3-e23dbf584aa4@kernel.org>
References: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
In-Reply-To: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3215; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wyCRr6vLc0SnEfJ47n3ZzKCFP0ZUNFZxmEKtHCDYEnk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJFtrxed6Njm9NqqcbdDydp6ZzilJZl3h+5Ri1I4Mfru
 u6me3dudJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEykOJqRYf3SjfZXvxjLmgne
 OdIQvco3dIujGcdWZdHDWzwFd7Wv+sbwv7hCOGFWE0fA1MOPSl8oducq6AvoNQafL/zqE6sVOiO
 UEwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This new endpoint type has been recently added to the kernel in v6.18
[1]. It will be used to create new subflows from the associated address
to additional addresses announced by the other peer. This will be done
if allowed by the MPTCP limits, and if the associated address is not
already being used by another subflow from the same MPTCP connection.
Note that the fullmesh flag takes precedence over the laminar one.

The support of the new flag is easy: simply by adding it in the
mptcp_addr_flag_names array.

The usage menu and the manual now references the new endpoint type. The
new corresponding counter has also been added in ss.

Link: https://git.kernel.org/torvalds/c/539f6b9de39e [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c        |  3 ++-
 man/man8/ip-mptcp.8 | 13 +++++++++++++
 misc/ss.c           |  2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 2415cac8..2908b69e 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -32,7 +32,7 @@ static void usage(void)
 		"	ip mptcp limits show\n"
 		"	ip mptcp monitor\n"
 		"FLAG-LIST := [ FLAG-LIST ] FLAG\n"
-		"FLAG  := [ signal | subflow | backup | fullmesh ]\n"
+		"FLAG  := [ signal | subflow | laminar | backup | fullmesh ]\n"
 		"CHANGE-OPT := [ backup | nobackup | fullmesh | nofullmesh ]\n");
 
 	exit(-1);
@@ -59,6 +59,7 @@ static const struct {
 	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
 	{ "fullmesh",		MPTCP_PM_ADDR_FLAG_FULLMESH },
 	{ "implicit",		MPTCP_PM_ADDR_FLAG_IMPLICIT },
+	{ "laminar",		MPTCP_PM_ADDR_FLAG_LAMINAR },
 	{ "nobackup",		MPTCP_PM_ADDR_FLAG_NONE },
 	{ "nofullmesh",		MPTCP_PM_ADDR_FLAG_NONE }
 };
diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 500dc671..d821f714 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -66,6 +66,8 @@ ip-mptcp \- MPTCP path manager configuration
 .RB "|"
 .B subflow
 .RB "|"
+.B laminar
+.RB "|"
 .B backup
 .RB "|"
 .B fullmesh
@@ -169,6 +171,17 @@ path manager will try to create an additional subflow using this endpoint
 as the source address after the MPTCP connection is established. A client would
 typically do this.
 
+.TP
+.BR laminar
+The endpoint will be used to create new subflows from the associated address to
+additional addresses announced by the other peer. This will be done if allowed
+by the MPTCP limits, and if the associated address is not already being used by
+another subflow from the same MPTCP connection. Note that the
+.BR fullmesh
+flag takes precedence over the
+.BR laminar
+one.
+
 .TP
 .BR backup
 If this is a
diff --git a/misc/ss.c b/misc/ss.c
index 989e168a..b3566f6b 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3308,6 +3308,8 @@ static void mptcp_stats_print(struct mptcp_info *s)
 		out(" bytes_acked:%llu", s->mptcpi_bytes_acked);
 	if (s->mptcpi_subflows_total)
 		out(" subflows_total:%u", s->mptcpi_subflows_total);
+	if (s->mptcpi_endp_laminar_max)
+		out(" endp_laminar_max:%u", s->mptcpi_endp_laminar_max);
 	if (s->mptcpi_last_data_sent)
 		out(" last_data_sent:%u", s->mptcpi_last_data_sent);
 	if (s->mptcpi_last_data_recv)

-- 
2.51.0

