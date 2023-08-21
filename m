Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F0B846F
	for <mptcp@lists.linux.dev>; Mon, 21 Aug 2023 15:27:36 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fef4b063a7so5331035e9.2
        for <mptcp@lists.linux.dev>; Mon, 21 Aug 2023 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692631654; x=1693236454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYlvgPz65adELEIRRcwUbscJD9ZOKyNA+Rby4qa0iI0=;
        b=iUmWgrrPcLtPILerCX3WuyNE1JSKbxeeEZXzHwTwgRRIIV1pZFU0M8ccUA9NM95Wkq
         0PrqZw1paLDRaaq45qBO/96s3MVzOV4XpMOSHJWsl9B49qCJFnEP+jXsnYs2/kecXO8x
         QCBRK39aifyxzoR52POSgic67cm/aCfi75T5JzSVB/obPp2q0fNu4IlJf042C+kqNCuP
         jEuWHtm4xZf+Pmlea56hHLKGVP+xKptX9DgpOJpL3Xn7CRkqzMmHRWBYBKV5lBzBquXN
         mehAv0cNUmZh4/Eq02dq041TU+kN03azUdyX2PSwY5cARp3lGu7ACuJ0xCuSdWL+Jyal
         o7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692631654; x=1693236454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYlvgPz65adELEIRRcwUbscJD9ZOKyNA+Rby4qa0iI0=;
        b=dUMdoBTc2r3WFj0GEcWmmaJtSTME2qycZlHMDpT1upf/ea34tUfecKq3rGrl5gPumO
         ZkrLk2tsmL7OnVONJRSu/w8L3MN0eRlAWNJUWTKjLUQjQZgr+zbyNbXPRMc4kQcZ1zvi
         8AOhfPTbb0/3Mv5mySW2h6v9KC90Ole4RMGjHtUKmByNSTIf/T52vS88Q3f/aLMHvkOH
         NMZmLU1X1n2cK+fYwADRFiql04oGAPlqOeUdX09LghggKrYMrpsgdx8IXvo9aaUp1DoE
         yvUJUHUSQsNTZoncbIfykAEnmJ7KqTivvLHRa6ZDpgUiDlHpkYjcgaLX8ZXS+2Y3tua2
         Ka5Q==
X-Gm-Message-State: AOJu0YyONMug4ywu+9ExBWK9xWW3N5wrO4HnxjH592Wbj8vHipdJIPYj
	mLJqRdFg1+3kbY/fOpnmREw4X+xnOvyF5uaZ6cZW3Q==
X-Google-Smtp-Source: AGHT+IFertdJJfnxT+Hu/QqnLtAw/Pcu04PNbV6qvBubIXmiuRrbSYxOmQ22+Z0xhJzCrNxTB3tB0g==
X-Received: by 2002:a5d:5222:0:b0:319:8ce0:4e52 with SMTP id i2-20020a5d5222000000b003198ce04e52mr5129903wra.67.1692631654112;
        Mon, 21 Aug 2023 08:27:34 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id a19-20020a5d4573000000b003143add4396sm12803959wrc.22.2023.08.21.08.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 08:27:33 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 21 Aug 2023 17:27:26 +0200
Subject: [PATCH mptcp-iproute 1/3] ss: mptcp: display info counters as
 unsigned
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-1-e5d91ad566ca@tessares.net>
References: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-e5d91ad566ca@tessares.net>
In-Reply-To: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-e5d91ad566ca@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=HAP0+aBhau5VfIHQt0T/KP3IRwQUcG2SXQDFWB3fpbg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk44JktsiRZ0aDcuOc/t0dfWGdLBD65cx33FQzB
 Y3HXUMpFV+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZOOCZAAKCRD2t4JPQmmg
 c1Y1EACCNg1IhNX4h2y2VSNQzvlByySSXJvfKrSzqEyYRQ9Zq0RmtS5q5HSL3hxtD2K5A5l/Us8
 ymxb/+/lJtMPwStiLYNaQRenWnMpWixxxWCk2bEIaX6y9X+LwgJX/5boyF+rEY+R7q67gUrOxUp
 xwaflMNTKM1w/e/oqut+pC//TTMKPRrv6TYCzCstcXBU6ZYuLyFvcwy0CG7rYXeGWSkorzygftC
 ytoASK/cnVda3DP9yGDY9fa7drLtyLw6bZmcxZHNeyldBjjd8NdXAfSrQD5raK9zZCgEfzf3QgR
 7PPRzHazwhemuDFPENHSvYsBUzTkFSwtj5S2pjgJ9Webtz9UwI0kcyb7BYebLFTWZ83UwYalZVF
 YbfIuOhfLUO2fL5EIAZnhNMys1ADuNPkFcdGWFZhM53U9DgHFnOk5WreqgfCTI/QGdsCeT60uDZ
 qW2wTNMgRrf6ePSstrcLAgSPAd2x4BBcw+kQXSveePMX+VqQAlH2as23sDjXEVN27enDE3mD+cX
 MunG9d+tW9MXikJC1CT7Rlyz0ijWeEv/W/EdsGJTpCBw/HxDUgLI9SQdmEx+NjtXpKMcv0/qvQO
 yaeLUshKGREzOx8zl6IKfM3BpVfVuQjUwCtuL4kdh9znhOpIHQYbjrLvg0tUhzWX0v9834nAWo0
 UD0KRcmMQxIQijQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some counters from mptcp_info structure were stored as an unsigned
number (u8) but displayed as a signed one.

Even if it is unlikely these u8 counters -- number of subflows and
ADD_ADDR -- have a value bigger than 2^7, it still sounds better to
display them as unsigned.

Fixes: 9c3be2c0 ("ss: mptcp: add msk diag interface support")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 misc/ss.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index c71b08f9..34f82176 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3232,17 +3232,17 @@ static void tcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,
 static void mptcp_stats_print(struct mptcp_info *s)
 {
 	if (s->mptcpi_subflows)
-		out(" subflows:%d", s->mptcpi_subflows);
+		out(" subflows:%u", s->mptcpi_subflows);
 	if (s->mptcpi_add_addr_signal)
-		out(" add_addr_signal:%d", s->mptcpi_add_addr_signal);
+		out(" add_addr_signal:%u", s->mptcpi_add_addr_signal);
 	if (s->mptcpi_add_addr_accepted)
-		out(" add_addr_accepted:%d", s->mptcpi_add_addr_accepted);
+		out(" add_addr_accepted:%u", s->mptcpi_add_addr_accepted);
 	if (s->mptcpi_subflows_max)
-		out(" subflows_max:%d", s->mptcpi_subflows_max);
+		out(" subflows_max:%u", s->mptcpi_subflows_max);
 	if (s->mptcpi_add_addr_signal_max)
-		out(" add_addr_signal_max:%d", s->mptcpi_add_addr_signal_max);
+		out(" add_addr_signal_max:%u", s->mptcpi_add_addr_signal_max);
 	if (s->mptcpi_add_addr_accepted_max)
-		out(" add_addr_accepted_max:%d", s->mptcpi_add_addr_accepted_max);
+		out(" add_addr_accepted_max:%u", s->mptcpi_add_addr_accepted_max);
 	if (s->mptcpi_flags & MPTCP_INFO_FLAG_FALLBACK)
 		out(" fallback");
 	if (s->mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)

-- 
2.40.1

