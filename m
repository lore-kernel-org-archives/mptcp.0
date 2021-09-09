Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114663FE1
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 11:51:19 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id bb10so906677plb.2
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ksHfRdLNAT5ZNfowzKnhb5UjbUd0I7Vxkd6ao2gZxc=;
        b=pLwTYRrzeCQSCAGlBAhTtmYUUbHzBgLc9klCSAmFhdhGPqGJxcIFp6BleelaNi+NxF
         tJxaqHya3Fly+z0bPqbd3ZBnTm/JCzjUVLY0v6hG0nF+UanqBkHGZYO+eDHhBjbAPEH3
         kUlH1jkTh0j+Y5Jw2wxRhIOGZWKi30AjWdp2HegjjaU//GqssVg4HzziUzxhhMYc2EM3
         eIgFne59eMdyjtvKnV3Euw1dM+AHyMSXiDP5sRfTUfCnNsv+TqMe3lE2siqDwsD3WKKj
         tF+mqyLhLZ0p3NjpDEZ2JMXLTcw5hMxa6uECKQY+RKn43GOQdsshdq3u7XZ8p1Sgzhru
         R7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ksHfRdLNAT5ZNfowzKnhb5UjbUd0I7Vxkd6ao2gZxc=;
        b=F48YSgxXm4L1D0l/OzKuLl2St3DXrzen3UPg8dUjblofrjvG38cJg4NHMaCz0hqijG
         Xw44jOwPsGFVzVQs43I4OQ6QFG3utX1IhCWrQPAyujdTe9E70GSgqd4VFjER/BzmLzHj
         ahbNg2NmU+LsRC1BHHzPKXqwzEKeghgE/TFC84Y24ndbayT5tR0KNM+WVUNDroennlzn
         XBy+k75jfJ1JxNgeUKi6jEWh9AsZ1q3Mpnk0u1qalpzkpsxFnni8Hi3N4C9jX8XZfNRZ
         0OMRlqij4QOf0Dv3DaKPuN03OB7icKicNP9T786qGtnGYouhRHBPDepwXrHyOq6ddufH
         fhbw==
X-Gm-Message-State: AOAM530niL5s9qgulXvCGw1XlEhVNUGqvMSXC5J1hh/iCayvUNRH+SJO
	f0/uKrCfMJAHvf82RGtrhEp24VYg5EU=
X-Google-Smtp-Source: ABdhPJx+6LEe63rVvdvSFj6XyoKD+jTTkhab7W8s5MvwiILmzYlKRhe6CFnGhpluC7jtam2XimTKkw==
X-Received: by 2002:a17:902:e5ca:b0:13a:4f10:b1f0 with SMTP id u10-20020a170902e5ca00b0013a4f10b1f0mr2362841plf.54.1631188278423;
        Thu, 09 Sep 2021 04:51:18 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n14sm2458225pjm.5.2021.09.09.04.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:51:18 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next v2 0/9] The infinite mapping support
Date: Thu,  9 Sep 2021 19:51:02 +0800
Message-Id: <cover.1631188109.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

v2:
 - add MPTCP_INFINITE_DONE flag
 - add MAPPING_INFINITE mapping status
 - add start_seq in the msk

v1:
 - add noncontiguous flag
 - add the mibs check
 - tag: export/20210904T080009

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/216

Geliang Tang (9):
  mptcp: add noncontiguous flag
  mptcp: add MPTCP_INFINITE_DONE flag
  mptcp: add MAPPING_INFINITE mapping status
  mptcp: add start_seq in the msk
  mptcp: infinite mapping sending
  mptcp: infinite mapping receiving
  mptcp: add a mib for the infinite mapping sending
  selftests: mptcp: add infinite map mibs check
  DO-NOT-MERGE: mptcp: mp_fail test

 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  1 +
 net/mptcp/pm.c                                |  6 ++
 net/mptcp/protocol.c                          | 41 ++++++++++++++
 net/mptcp/protocol.h                          | 37 ++++++++++++
 net/mptcp/subflow.c                           | 24 +++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 56 +++++++++++++++++++
 7 files changed, 159 insertions(+), 7 deletions(-)

-- 
2.31.1

