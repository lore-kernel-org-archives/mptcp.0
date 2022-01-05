Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890352C9D
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 15:57:31 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id j21so163732985edt.9
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 07:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tSZzyt54Pf2HY2RcVG2ElokQ7IM5r9YHdrxX4wJkPaQ=;
        b=HT15LD4DJxWimiOy1421dMNnz+ocWlTRnezrnxva+D1AuYzEscy2nrcZqm4yRKpNTE
         YXjhJodLEBHDeqwyMRjk3Yoaeu8gVC6HSvA4U1O2Ui3WhhE5J6EM7aAbLBwgBqmPZiPt
         5RnWFraTcGhYda0pdafUCpVynAEYWa+quhrEJiVVWwoeZlibU+21VpCflfkFQ4cLwY/s
         6B/80hUcivtmXw5cndf0sBVzhEwRRm6fR+iC5qwEGUqq1Kt5ofPMDuswg00/06aWhBcT
         XR0O3H2QQLwEntjTOJT20UNKaF1Ck0Lu1kcdbA0Amunt/fMOlKzu+aQgzF7YR7XYWVvb
         K9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tSZzyt54Pf2HY2RcVG2ElokQ7IM5r9YHdrxX4wJkPaQ=;
        b=LTvOdK+64Jq5lBpwMJAUZpxx6jlUqIdYyQVWkp40rl12Hpk7WiA1mp4Mr6LPPaIvpE
         VBKQz8kmTlJ2NaJXDi6CJD56vstkCFCYOEFPrhAx04Tv265yli0OPY4erBuUj4xG2UwT
         Jtin1jao1wMEjXzLtgR5umBP+5ReCWXmOc9gppOQmBFFy3Pb88LzPwAsns1sGqdfqbFq
         YFFUheGUMCQmf3EpsytEGjZ+tnB25kbw4O5PjNbdz3wkthnXx9vdOlrisVFLoBIAcBhM
         e2mxqD1yGRvW9oegb78v5R1/ebpnK+PeOZLz7LqBOq2mWFaPUgi0b86fKyKigjd20VIC
         /QIw==
X-Gm-Message-State: AOAM533PsrL5wacmuYodpTwmNL7DH50gRmgUxKleTJoSqGYlynUGxWJ5
	B2fbmPIGL8t3FC1TiIelLgTq3Fw4r7JK+QW8jJ0=
X-Google-Smtp-Source: ABdhPJxPVaQhiRngAauXFMKdkIhbAIqdxEbj5edP7Q2No3WAFxJYpOPcvMO5P2h2h1+AY8efczqDEA==
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr52258309edx.218.1641398249245;
        Wed, 05 Jan 2022 07:57:29 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id c30sm12399684ejj.190.2022.01.05.07.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 07:57:29 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v8 0/8] Clarify when options can be used
Date: Wed,  5 Jan 2022 16:56:54 +0100
Message-Id: <20220105155702.165123-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a new version of Geliang's series called "send MP_FAIL with MP_RST and
others" (v6 + v7) but also include this time:

- "mptcp: fix a DSS option writting error" (v1)
- "selftests: mptcp: add mp_fail testcases" (v5)

On top of these two new patches from Geliang already sent on the ML, this new
version:

- includes one new patch 2/8 ("mptcp: fix opt size when sending DSS + MP_FAIL"):
  hopefuly fixing the issue reported by Geliang (MPF+DSS ok, DSS+MPF nok)
- has the Squash-to patch 1/8 split: the other part is in patch 4/8
  ("mptcp: reduce branching when writing MP_FAIL option")
- has one fix in patch 1/8 reported by Geliang

Notes: I still have issues with the mptcp_join selftests and TC but this can be
fixed later.

Geliang Tang (4):
  Squash to "mptcp: implement fastclose xmit path"
  mptcp: fix a DSS option writing error
  mptcp: print out reset infos of MP_RST
  selftests: mptcp: add mp_fail testcases

Matthieu Baerts (4):
  mptcp: fix opt size when sending DSS + MP_FAIL
  mptcp: reduce branching when writing MP_FAIL option
  mptcp: clarify when options can be used
  mptcp: allow sending both ADD_ADDR and RM_ADDR

 net/mptcp/options.c                           | 105 ++++++++++++-----
 tools/testing/selftests/net/mptcp/config      |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
 3 files changed, 182 insertions(+), 39 deletions(-)

-- 
2.33.1

