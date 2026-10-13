Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD55531626;
	Tue, 13 Oct 2026 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914223; cv=none; b=g78UL1CdaXfRfeNdHbQLe38k5BALjKIV6Lhi4BS5+WweXW9QLSfqhtsZsXkzzlguELrsEBjWVTruWlU+vCr0spI0DWCHG2HgeT9L7ItX6vTP8mKViy1BSFLA+TsuQTfe2gEEXvyRM2Zc9eZRoVfg/O/E77jQ6/kmEGHDSHacLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914223; c=relaxed/simple;
	bh=5G3PTa9hbd7RXa/CWpMrArq5NOwRQO0Y20KCA1few7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WirPo9pePniH8s0BpRCw4c1vCdyf1l/FBU1F39DPQC5hsvm0/+1YpoCeYKl7j94wn8WWi3VaGMf5HcddHt5sT8ZYPKW4jmorbQUx8So+uVmgJa1A06XziRFGrE4KMtlrcBAmeC6K+4HdMfq8zH8hBNyqNsZtN9mrRN0dBPNvrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLS/vWLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLS/vWLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B091F0089A;
	Tue, 13 Oct 2026 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791914222;
	bh=nZ4NLWObKhXX589fAh4UKiTeEKN9HN93nK5DqJUebHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eLS/vWLNQodTq88mg0XtLDscVeliOuk5/QQHH82R+EX1hLz9HV0ZSysHoU/M5PmVu
	 u++dnYMC8xFSIM7q7N8xWbKs9j7m7ce+9dwJuN/Ctft62bSHLP2FsfaEw7Fsi+ewwu
	 Tcu5nB86bU0qWlAZmCCinjJPaCt7uAx319Wor/0lK7CON9V4Zt9BIGtY7rXx+vMiWU
	 Kp6eksm+PHYMEpf5oXjRKNOAXa9S2FXfIY2+wPmySpelwUh+XB/ofj469nJdzSSBoy
	 8MWx6ZKde5gMrV2ButnPl8neBAQ1UhKjUBrM380k9K40YXKC/nc96T/AbXbgKbSwJP
	 H48tHTCNUlBqg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Oct 2026 19:56:39 +0200
Subject: [PATCH net-next 2/4] mptcp: options: dss: avoid printing uninit
 csum
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-2-1181e5d2fda4@kernel.org>
References: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-0-1181e5d2fda4@kernel.org>
In-Reply-To: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-0-1181e5d2fda4@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5G3PTa9hbd7RXa/CWpMrArq5NOwRQO0Y20KCA1few7U=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLOFTwtn/KYy+tpQrt3qHP9XmvfwIXnvD8mTt/H28B45
 qnYZ4aJHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNx62RkWPj11rpzbJyn3x28
 l9dT3J4xr21V5YOq5U6Kr8JeNTzdmsXI0DrvDW/DhOksX7/a/7v5cs7qGff23ZZfumhB9iRB0ae
 V0UwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When parsing the DSS suboption, this pr_debug() might read and print
uninitialised checksum value.

That's mostly harmless, but that's also confusing. Fixing that also
avoids some tools to complain about accessing uninit data.

So read this csum field only if it has been set.

Note: this was initially reported by Clashiko as an existing issue. The
code has been analysed by a human and confirmed. This is a non-urgent
fix.

Fixes: 390b95a5fb84 ("mptcp: receive checksum for DSS")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3b4a22846055..64aa7a516a23 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -259,7 +259,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u\n",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
 				 mp_opt->data_len, !!(mp_opt->suboptions & OPTION_MPTCP_CSUMREQD),
-				 mp_opt->csum);
+				 (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD) ? mp_opt->csum : 0);
 		}
 
 		break;

-- 
2.55.0

