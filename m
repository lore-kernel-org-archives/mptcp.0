Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5994431
	for <mptcp@lists.linux.dev>; Tue,  6 Sep 2022 12:20:49 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id gb36so22760025ejc.10
        for <mptcp@lists.linux.dev>; Tue, 06 Sep 2022 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=GRTfSPLn+k+vQfLFpcNft/6XFJLQTxw6fhR7tuExFQ0=;
        b=4O/GLigFu43TvninyDv5t1hN6YV3yByFcKVhHafcbY+lspiRyCKM581YFgcyH1W9I+
         qfN4+xb++NPXPhlrrfjfHgay37EgCcjuVjL0bJD+i8LKHX3spp+BGQsStjnHj9zU1WkH
         GapPHEUA+EnppfBLlw+Z5oeTClSMvfRZjzJy6J+P7wUlZISVCZ+004JBhpCF0HSKdZ9r
         tsCCBBa2gbkiHdh28mi9uB7KOHzUH/jhXzM5CZXKtwrkRACEUW0cb5jNDGPzzi3exd/4
         JsHvdR4skqGhgptMtjE2Rx46knRNOrDOXKCdmRz7ykg2ykEIa1n/MssEvaV3SSMP6d/l
         CAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GRTfSPLn+k+vQfLFpcNft/6XFJLQTxw6fhR7tuExFQ0=;
        b=OoFaUXzPBjmzcBAXzIT/wNBfkLEPJRPza26jELwO6Sv+sA8IHZK6MCcNFEi68vXT1G
         VsZI4/3BA6QYpyT7DoLUbBerzPzmbvyjoEQKjaRCTrGFwPHFs5HGpj/AnELZgVbU/wKl
         ACo4grQ6TnBKTSp8rEPQlR83R1Y5jRDxiM+JCWclckCOc1QMJuWyBJt3b6uxojnfirXb
         NFH3Ahq8zcirH8+qxVRutlikqqs9iB6iIILqunDzTn65f9sAFOzkHvhSvZrteZJGp80z
         jTmj+Lk2BXFRQcLbiwmW5jAjLyWq+V2DWMe+1VhauXSXSrL+7w4WkLufTIRedj1ySgTm
         wFZQ==
X-Gm-Message-State: ACgBeo2sFZHhtBG5xiFqSad/INDRczzR3UK7Lg0GB7P0KfhwZhBpzPan
	6Epz6LZvMCBkUgMC+/PZ+dKcGCVPtN08INkC
X-Google-Smtp-Source: AA6agR6VGAootg7XClm6wYtC85I1hXIoaQdXpCJadm5TQ3URur2uGf6l4EN9JLHmWyBXb3lY4NSwWg==
X-Received: by 2002:a17:907:7242:b0:742:7c5:46b5 with SMTP id ds2-20020a170907724200b0074207c546b5mr25978258ejc.274.1662466847598;
        Tue, 06 Sep 2022 05:20:47 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id ku9-20020a170907788900b0072b41776dd1sm6511455ejc.24.2022.09.06.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 05:20:47 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net] Documentation: mptcp: fix pm_type formatting
Date: Tue,  6 Sep 2022 14:20:25 +0200
Message-Id: <20220906122025.743592-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=8lkbVPs0DQAkm5oCbLXCEBCH/iUSURDiBMAAfwgwibY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjFzr9XbtNaQKRY6P0vuDBM36icTPcP7W9ZORym760
 MAzkaAWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCYxc6/QAKCRD2t4JPQmmgczsKD/
 4tPTrfuLJt90Oa7yFy4IkteN/dWSnxHU69Ki92vaUPsIx2h4jaj2X7JeU/iT2lRn10XcJlZ5K20Eo1
 HtAiMSqfvYlS1Kr+eWuUas3NLKyaB3lsf7fB3xvsEeLm7qc1vXhEIPsHGj13AWnFX5c/4MdSITb5gk
 RXq9NXAo6J+fufXBGX0bAO0Gl/CMrzrdqFIQB1QJzBFRdQtgBs3gRVHR4kmcSOhFi03N8Ttkf2liE7
 5nWctiaf6z5Qon04ZKTx8vVU3p0DWeb5ED8gUssv1YM1jQ2cYaxUGkcGbe22Aho4VWPgzWp2tRI/Ow
 kkzUmkV7yk8QFs8C9bU1pcN/DDO3ZIXVDuU70VNrlfweG1dnzw9/Ao2n/xifv4QuS1Ou7YdlD5fAhF
 LTKw7TmR+af1XpATRYDPj6efHrLgprsoFat2wHkqEZQeD/t20RIPLm2Wx5BC5/RuQOGG/uF4qAcJOw
 KNJh+9TXvSm20HqL9wqR6blbjyY6H2vEzzqjl72cqynMcGrziPO6iHVDc63P/KhmHqn/Ic7VV117cB
 Y1kT292GHeXS0UHuj8jVQ8WLZMuccv2O/8m6DgJpJ1i1CFs9S/jEKTtOyZiwmi8HH+T9qNtpAAS0Ut
 zyniti3c/a9zCzGL4SDZ3VSD56mIUS+d9Wtuv9BWRNmKGGySt7kxDLl3D7Vg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

When looking at the rendered HTML version, we can see 'pm_type' is not
displayed with a bold font:

  https://docs.kernel.org/5.19/networking/mptcp-sysctl.html

The empty line under 'pm_type' is then removed to have the same style as
the others.

Fixes: 6bb63ccc25d4 ("mptcp: Add a per-namespace sysctl to set the default path manager type")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    I guess I can send that to netdev, no need to send this specific one to
    Jon Corbet, right?

 Documentation/networking/mptcp-sysctl.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index d9e69fdc7ea3..15f1919d640c 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -47,7 +47,6 @@ allow_join_initial_addr_port - BOOLEAN
 	Default: 1
 
 pm_type - INTEGER
-
 	Set the default path manager type to use for each new MPTCP
 	socket. In-kernel path management will control subflow
 	connections and address advertisements according to
-- 
2.37.2

