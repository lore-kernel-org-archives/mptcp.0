Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9509168
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 11:08:31 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id m1so12400293pjv.2
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRtdLQPlhi0CPveWaM1Y2ugnAVwaKIFHKhTFIxHyRWQ=;
        b=Q+bzPROGRQKA5lJntKnR4Nu0haBS7Ie36usKv/a6/VXSrBsv39RvC2W3JFvh95RBYA
         k1GhPtRWox6qV0q6dj7yg3wTyMvuCTYTohtok++K8S7A0sFQG1QWEryi/uNiAGlUM0XR
         iTJKfYvhXYJPdjNi2lXt0nf8Su180NLGhkcb7O1FhIrtmAA/K+o+lv2Sv6lqS5hmG9gb
         MP5bGbDp7R/AuYE5k9ARSMRWpeGutYnVrdJTYdx0+h1pkv+3KV3SdmxkODTHJO78457z
         SDCzoILry1QngfexC6e+OXiktX2lbD0jWo8DBlwRnbGlXrXqVnZapiNooa2C4eHoz93/
         7Jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRtdLQPlhi0CPveWaM1Y2ugnAVwaKIFHKhTFIxHyRWQ=;
        b=jtsn1s2SNlvgvt/Ntt+gukJ3POKLMpPEXyMgHe+E3yJGRMskpbXWfo8O+NLKEuxNP5
         6elXC9SmuOeqwI0jrKIfnkJnsjcm/EAcVvoEfTJiPdH2bHrNE19N1gIxo2KC6sRD+pOz
         tJtZJQ6NlDH/1Tu6p2IQN0Mk7c1hWNWAy2Pxw1noO0P8Xo6kDOjUsHOPVMGXXO9LDrBa
         q54nqaAZfEH7CGt9c2o1MvDxUJU2yGUoxrAyXp7wZnyHH4gtD26OnzeJ/3lTYYIdZPcP
         P/vukHyJue5T8TgECapd2tZDq+m8jVPVGJXPh+prsLtC43XzrvQ/n9LFvowe3zSROcq2
         VdgQ==
X-Gm-Message-State: AOAM532zaX7XisXwUHMgKMAoR71zhOnstE3nb01Z6nIfOQcFiQbv4LBw
	iVLZLgtQgnAFg38my7wK0545njYm9oJzoA==
X-Google-Smtp-Source: ABdhPJxBFvNyqoe+DrMPsAqRUJHeUZOZI6n4BkkJ3Wr44OOAs0nTw+JmUmbqxb0ePMPI0os/k6IcHg==
X-Received: by 2002:a62:8f86:0:b029:32e:33d7:998b with SMTP id n128-20020a628f860000b029032e33d7998bmr17929997pfd.64.1627297711173;
        Mon, 26 Jul 2021 04:08:31 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id e30sm50282700pga.63.2021.07.26.04.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 04:08:30 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v4 mptcp-next 0/5] fullmesh path manager support
Date: Mon, 26 Jul 2021 19:08:21 +0800
Message-Id: <cover.1627297096.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

v4:
 - add new helpers, fill_local/remote_addresses_vec
 - add max_subflows checks
 - add 'local' into the local addresses array only when no fullmesh
   entry found.
 - add signal,fullmesh check

v3:
 - the in-kernel fullmesh path manager has been dropped from this
   patchset, only keep the fullmesh flag support code.

v2:
 - Implement the fullmesh mode as an extension to the netlink PM, not a
   standalone PM as Paolo suggested.
 - drop duplicate code.
 - add a new per endpoint flag MPTCP_PM_ADDR_FLAG_FULLMESH.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/193

Geliang Tang (5):
  mptcp: remote addresses fullmesh
  mptcp: local addresses fullmesh
  selftests: mptcp: set and print the fullmesh flag
  selftests: mptcp: add fullmesh testcases
  selftests: mptcp: delete uncontinuous removing ids

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/pm_netlink.c                        | 125 ++++++++++++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh |  59 +++++++--
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  16 ++-
 4 files changed, 181 insertions(+), 20 deletions(-)

-- 
2.31.1

