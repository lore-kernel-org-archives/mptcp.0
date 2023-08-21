Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618F8476
	for <mptcp@lists.linux.dev>; Mon, 21 Aug 2023 15:27:36 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-31965c94001so2987413f8f.3
        for <mptcp@lists.linux.dev>; Mon, 21 Aug 2023 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692631654; x=1693236454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qom9yPJvuOB0nZei7EqgkCG8EelwzqY9NqWp9tSqDJ0=;
        b=Lu/oWz2q51oH/A/nZUf7A94l0Mx1yS0berhpvAI8rahxWlwFT7A35O55oZ/6eh1HD3
         HWJ5EuNeMSMBneKjI/yGqXihsTy348el0dd0tfdpokldxl7hvzmQTnNh6AOIC3QARRdS
         rG/8rmhVbs0Fbnhdf/K7MeMIIUBBFHg77owzZI6i29hVDr4VaJ5QDlLo53wQ6BwWeqFt
         0CzUN+AFOIj4xEGXCErVsChWmRm08HbwQT9cOGE8PD87gfIAVGAwM13zE8Fb8+tQiwkS
         sHli+goZqTlROwIw0D3fs6AfYU5webgkBfAXnojlwbutO8EiqVpAUkDQesgpea/+kJ5c
         IFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692631654; x=1693236454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qom9yPJvuOB0nZei7EqgkCG8EelwzqY9NqWp9tSqDJ0=;
        b=KivsLaQ8IY3b1hX3LN+sArQylrG5837qmjdfL7ZMaS4q07OugY1odcVQQXe5mlbu1R
         fOzd3//qyH+sUrnMKI8Dv5pDertvPSQT6KZOZJbgXjZU6+dy4bTjtfM69BnGAx2PfZnz
         +XkJcnANn/xzDrJokEINCTIZLL3WO/i4av5Yb1Gm8nmImuqbx/oJ00i+chZh9S1jSv3c
         f1178wJ2KIOCDG5kGRUyTv3Jh4u2akQr/q2DUHXEFC6GCip0l1/XB74VfRRyhNLtmv6T
         Ko8//iMjyYxgyNenG0N7I1lPp0o33lk8tltMbr0CCTqYnOwhDea7S18CckBkT6GdhcuX
         pVWg==
X-Gm-Message-State: AOJu0YzT+pyDxa29gziO1K6loMvy8Bs+ESq1YOOlHMuxTleIIun8XdyK
	y6052KPFVutt4AxQP5iq6EhelAmGFSaQrqSa5nPZdA==
X-Google-Smtp-Source: AGHT+IGiPFJwCBKYEBkQVxM1LzZIbNF1Pbldi3MHJZiOtmYSvSbhKzy4UDP60C3ylQnLzTPEtm/NSQ==
X-Received: by 2002:a5d:5225:0:b0:317:708e:1c29 with SMTP id i5-20020a5d5225000000b00317708e1c29mr5323396wra.40.1692631654618;
        Mon, 21 Aug 2023 08:27:34 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id a19-20020a5d4573000000b003143add4396sm12803959wrc.22.2023.08.21.08.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 08:27:34 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 21 Aug 2023 17:27:27 +0200
Subject: [PATCH mptcp-iproute 2/3] ss: mptcp: display seq related counters
 as decimal
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-2-e5d91ad566ca@tessares.net>
References: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-e5d91ad566ca@tessares.net>
In-Reply-To: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-e5d91ad566ca@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=vbXdybGQWDpAUL1i4jV1YfqMzubN5jdXKmllYmO4PAM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk44JlT0+//fwDrzLTRJgDI2+N16FwXk1yatta6
 laqvqEDiMGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZOOCZQAKCRD2t4JPQmmg
 c+AwEADllRjAf5UuOcex5qJAHrU/QPijPI+ZzG/TVA5upNRSEo7OO9lte4xr47dQYHnmqi14KmL
 nRVNHc3yvTp6As3e4hQIHRby9uIytpmVBnD621TT80QdThXfzfqANoPC00hVa+PEzQbbZG54xmA
 FgLTu1fOm9xLvMHEGmvG9AiDR8g/qNuWmdIIUmjUb3ZF7OfPIC7CN0dWgTKm8d7nOBNtKieCqJU
 A+ag4CPy/9gjyoKohr5xwYqVl6eFyzTfOhqCn1ae1brA/0pzYwTeNZPv/sIRQi2gsKFWoZ59OMi
 m4Mi7HUyo4OUursjHoCjlqliOUVLIVKS6QEuHebAcpLke+Ku5neVAn0aqo6FY1529YpaYSXrb7Z
 pfj7I7ZotI+UhbhSSzAfevyjcbQaSpLH5/2TWSFFYB0UF1rTb0NUfPPWsiQxlEeHFmT9QU5uEc5
 fRbDpjBCrj+Pvru9IOGN21vwVUa/Fve2ByK8D8Ia279EIC1ZsZkAcrgY/lRSNPikQ9MlAtRH1zk
 zCJRj+rmZ7RC7G513xfakjmZrthutTIGP89TOYEjsbNjtmLp+T51F1hwMOSVMBQclgYdn/XBPG4
 WKljXAymeof33pnh2n9Lz5LL4FYDOqUt9bbar+uzbElOFPCTd+RNYiZtov2E6mX1FY4DcT4A8sy
 lCagoyoklMNgbow==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is aligned with what is printed for TCP sockets.

The main difference here is that these counters can be larger (u32 vs
u64) but WireShark and TCPDump are also printing these MPTCP counters as
decimal and they look fine.

So it sounds better to do the same here with ss for those who want to
easily count how many bytes have been exchanged between two runs without
having to think in hexa.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 misc/ss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 34f82176..d1779b1d 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3250,11 +3250,11 @@ static void mptcp_stats_print(struct mptcp_info *s)
 	if (s->mptcpi_token)
 		out(" token:%x", s->mptcpi_token);
 	if (s->mptcpi_write_seq)
-		out(" write_seq:%llx", s->mptcpi_write_seq);
+		out(" write_seq:%llu", s->mptcpi_write_seq);
 	if (s->mptcpi_snd_una)
-		out(" snd_una:%llx", s->mptcpi_snd_una);
+		out(" snd_una:%llu", s->mptcpi_snd_una);
 	if (s->mptcpi_rcv_nxt)
-		out(" rcv_nxt:%llx", s->mptcpi_rcv_nxt);
+		out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
 }
 
 static void mptcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,

-- 
2.40.1

