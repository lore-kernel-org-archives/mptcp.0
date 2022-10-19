Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11037E
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 16:20:05 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id bu30so29974694wrb.8
        for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2lPRs7Kx/WagMGH7bcySHv4DxfUXEXphMDypO3oJ3E=;
        b=r+0Rgi2eRkosnuweznTB6u37eUAYCesZrHSZ+OriOdtawRb73L2NlSX2VD0jiqDgzu
         EitIHDHOAVRzGaatfM5zgNXBF1DOdV6zckKi03Tsre0GRmwfoAkSXL1aGI0BrJuPn51z
         u49yfr5mHBXR05vTuJhAbx+JiXFjqlNtldB9AN3bU9euZ8y3b0ty29+RA1sY1bUkFMZy
         EQArv12iCdZekm9UTyXyYppI+qOls0mAj5lUi4YiYu4Yi8I4i6iD/ovGkWmUgQXgriIX
         TSVhRVVLjq69cwOPUL/ftOYgkxug+3Ucw13qDCwRSxP1ZPVxXUmbWcc1Zdr50eb6biUZ
         O/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2lPRs7Kx/WagMGH7bcySHv4DxfUXEXphMDypO3oJ3E=;
        b=I8KM+C0JX3+CwBP2hU4PO8z8JJbpWsjIXy/GLT+bNzprLXU6Jwc9B778kPa5XBg4kG
         dsNureBgsx3ebWXIhpixhhv9hjHKTPvpmUNCtA2mdu8p5NXvPBNioni08oxRxEsF7+Kh
         Mevk+WG/00d2lDbThRcxTytN3WvN2j6eFm3tGzgpbFaxEJFaM4EZ41uUvkEc/cARkjYC
         cJ9T/cI6LFp2w2GtyuqJJqSNyPrrsSEcTSFfuvm961CFcOKC3/NeYNwW2qkExi7IzWr3
         mFwQKSCgMU32Ygff0VWjC/I4jvCZOBBJrXu5Am4pDd4cBy2/cXpBFM6Svkiuzz/nhVAN
         LZEg==
X-Gm-Message-State: ACrzQf0gOHfWZwVimjhoinzrEFRPhQCjheSJy7vGLS/gY7DYjbSoQAyG
	FLITDaHZb2CgvXccWYbjIEyZkksl3gw4VyKZo04=
X-Google-Smtp-Source: AMsMyM6ezD34eY1nfXijYK7FmkikEmP1pNNqUANSp/1UIRdiW2ny4Di0BRmaYSBMyiTTsHAIlTthmg==
X-Received: by 2002:adf:dc4b:0:b0:230:5fe6:69d2 with SMTP id m11-20020adfdc4b000000b002305fe669d2mr5724447wrj.469.1666196403353;
        Wed, 19 Oct 2022 09:20:03 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m1-20020a1c2601000000b003c452678025sm433717wmm.4.2022.10.19.09.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 09:20:03 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 0/4] mptcp: run mptcp_sockopt from a new netns + cleanup
Date: Wed, 19 Oct 2022 18:19:36 +0200
Message-Id: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1202; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=Z9Eg3vsQP4IsdIb2JApXFiRU7BJ0/NgFj3H29DDMxKQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjUCODl2XoXRJLxczlvNZBzdyy88wBv/R5lHgvl9Ct
 5L8f5WmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY1AjgwAKCRD2t4JPQmmgc+jBEA
 CWLokFSoIf83OG36bcXaQJdABtcOzJ5Y6AwcUjY785cLOndtxc/rCLC8MV+I+MosT4sUrloj4X+bWU
 uwgRQrTe+mbHteWEFUrzhTXI5MK7vq/rincU08LJpXaWn/IpU4tEj7P8bgppIbMtXL9gpO2wc/iiWV
 cGjYWnp/ztEsKaMoDWKoqLUnmuylabY005jE+r22EYHumVQYw7Ycb1kBim+J/OlBAEChr3r9n0H1rw
 7YSEFsfE++nWBUANsOsafGPa3CEWKM2RDg6WH+We//wlbmgtMpTkO76AzrMvtqb6WWapIioU+ZkSyS
 +ne/SV/vx8VBRgeMSV+Xu5s8yAr20UROtwqomxyKkANP74PZxpNl+0SdyHETRx1bibD+TL2qFAAB2B
 pkZAsru7ZILx/4u7y2WbjOIZNN/02FOK9UBYTijTCfJtpAFLlYFjvEviEFyWJKsphs4E8Q73JTb9uU
 urJYr14FAgD3T/w95FGji1IBNxIwHqrJJVPfp0intllLyRAKW/3MNuCKga5elSndx78+taimXoBQy6
 m9UJxx9asSEpaKIb6SRJZjYVhnVqnF1c1VtXPsjO5D62QkSl8eP87yO2F4C4aIJtul/8/46trrPDIR
 sNQweFMojJPmGJTuf9jnOm4YrUsw1N9WCoh8S760Lc/fHHcUUPmrKvVUuKug==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Here are some small fixes for the MPTCP selftests, no big changes.

The first patch is a fix and for -net: if we run mptcp_sockopt.sh after having
modified some settings related to MPTCP on the host, we can run into issues
without this patch.

The second patch uses the new netns for mptcp_inq, cleaner.

The third one remove some defined but unused vars.

The last one uniform 'rndh' variable because it was declared with undefined
variables in a few places.

Matthieu Baerts (4):
  selftests: mptcp: run mptcp_sockopt from a new netns
  selftests: mptcp: run mptcp_inq from a clean netns
  selftests: mptcp: removed defined but unused vars
  selftests: mptcp: uniform 'rndh' variable

 tools/testing/selftests/net/mptcp/diag.sh       |  1 +
 .../selftests/net/mptcp/mptcp_connect.sh        |  6 +-----
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  5 +++--
 .../selftests/net/mptcp/mptcp_sockopt.sh        | 17 ++++++++---------
 .../testing/selftests/net/mptcp/simult_flows.sh |  4 +---
 .../testing/selftests/net/mptcp/userspace_pm.sh |  2 +-
 6 files changed, 15 insertions(+), 20 deletions(-)


base-commit: 1907372cfe4315a0491ae262ac23b1b4cd9cdf94
-- 
2.37.2

