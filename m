Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C873772
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 11:04:41 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so8037601pjs.2
        for <mptcp@lists.linux.dev>; Fri, 09 Jul 2021 04:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWbk6bV5ugg66jIoYQJCtVv54Kf7kg5jPycqF4PJVvs=;
        b=aFSDlk5gF6tSPyreGhO05OuOQ7fNRLpfPWwjDkYDhk7uqJvjHvlg1OClT90l24s6qM
         GuZQ/6r4hF8QqSeKOu4KEKJBBod6/TXN2oWX69B84bqbChAG5m0Bkj3UiSQd+B4xtCmg
         v8AJnX3oxguN8iRcCVMUZ/5LZbq6pvM7SELWG1pIDBBswkI8AhEoMa/RozbJebCEG/d7
         bB3UPrvpQSH1iANheAqR5KQw3/iSdpCn7EnLLBsyWWVMt7bkt5rxfH+fqvGP79Q3fnzE
         cVyVCIFzDyXgQBtz1WHg7JEvlIyftmPr0BH2NZCAWFyCiysBms02+XPQmPCQnOv/eVbw
         vF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWbk6bV5ugg66jIoYQJCtVv54Kf7kg5jPycqF4PJVvs=;
        b=c9I70UMopTCITNvhq4p0ixN0BPR2vbs0bUO8c3M9EkVaXY0Jx2UCv1isAZMavQgc35
         V3/X9eEU3jHpyt2GSwnXTC5vuOL8W5Iq6MLaagPr2svD8U54hC4lLUs8rkJt5U7deslz
         GByjR2+z0PLjzli1k0+DrDQaU1QxAmW80Qy0u4ggMNg3MTxUk6CawSHELA786nKaqH9W
         MnGHs0OxNmLzQt/39r4wOF8tQ4p61kpU9rbWbJYtLOJ0z0NnbVRo9fBR92Pb8MYCbehf
         x4T9ZYXOG9TW/40wtcs8oXZY00lM1KTB0kB96TQKCv/pcJjZp1I7din7+pe/dnxpQmES
         hVKA==
X-Gm-Message-State: AOAM530qkDL+Vksf/3DuSTHGvCNBmATNx8ffmLJUFEdJhtUHgfmyQDtt
	nujLA24gakp653yw46PH98w1Jo3FX84wFg==
X-Google-Smtp-Source: ABdhPJyM23/EketIkFwJ9Tn/MDuaq4JFkaiKganyc/UIf6ATpxsq775yw6ruaWosIkx/QnZFWkAwPQ==
X-Received: by 2002:a17:902:d694:b029:129:b8db:c815 with SMTP id v20-20020a170902d694b0290129b8dbc815mr14291986ply.74.1625828681052;
        Fri, 09 Jul 2021 04:04:41 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s15sm6247902pfu.97.2021.07.09.04.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:04:40 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 0/9] fullmesh path manager support
Date: Fri,  9 Jul 2021 19:04:27 +0800
Message-Id: <cover.1625825505.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the in-kernel fullmesh path manager like on the mptcp.org
kernel.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/193

Geliang Tang (9):
  mptcp: add a new sysctl path_manager
  mptcp: add fullmesh path manager
  mptcp: add fullmesh worker
  mptcp: register ipv4 addr notifier
  mptcp: register ipv6 addr notifier
  mptcp: add netdev up event handler
  mptcp: add netdev down event handler
  mptcp: add proc file mptcp_fullmesh
  selftests: mptcp: add fullmesh testcases

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/ctrl.c                              |  16 +
 net/mptcp/pm.c                                |   9 +-
 net/mptcp/pm_fullmesh.c                       | 463 ++++++++++++++++++
 net/mptcp/pm_netlink.c                        |  14 +-
 net/mptcp/protocol.c                          |  11 +-
 net/mptcp/protocol.h                          |  11 +
 .../testing/selftests/net/mptcp/mptcp_join.sh |  66 ++-
 9 files changed, 588 insertions(+), 12 deletions(-)
 create mode 100644 net/mptcp/pm_fullmesh.c

-- 
2.31.1

