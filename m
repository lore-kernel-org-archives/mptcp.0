Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5A33939C
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129817; cv=none; b=nBVQbivR11RjRMx8nT8GqLUyG34wL5txW2C06GwC/RBQZeXGw6Rwc3A1uI8SRlBvtMUREydlm9PAMBJ2x132OrCd7ly+VZ0sgpkfYRtHfvzAi2kEd+6GeWgWGqBtd7lrFHbZ7E3FbP3OXI5OFziW7Lf19wcVGgFlMJmTT3izYj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129817; c=relaxed/simple;
	bh=Hrx60rHcRfZuaAMWCLO4dQ+akEroLRhHZfuY2h81dF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RDkdJcwllWhWedxZYNJD4lAoSGdqdrekZvABeJqXarROAyNszLKo4vVwYQqrTtToKHXpsPfKbyfXhnheyQKJzSwejTPCAAwBUp26MPjIdQxji+Zp9jLmqF1/7mlfxvYLdZzoMMKcprBZek4riQ1i4H3KpNdYrG24TEIWh3tuTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuimraTV; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuimraTV"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35829219da8so752952eec.0
        for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 22:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129815; x=1792734615; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y8uwftxzQ3qe2G1T+qJzRM5OtmdbAWI3lbQRcXY+nSI=;
        b=PuimraTVa3uslGSWBfAjrOLn9UyBpT0B4NN7CputrTmVkYc7H5SkTgtxheGkMENV9q
         3kcXVWU0YfEOAZXz2M5EfDuE8p/PuP67AFYqLoyo8NJBR20pclth0lg26bxhoc8pkJ89
         uMDNtXKWOcbucfbPkgeMkTbsxqAJKbVUiVNfdnY8QtulNn20jgtZXkhGnCmnEjavid5p
         Qup6SNZVapApZLEK1lp2ooac7q5/01+XiSXvYi/TyETRC51M7YQHGaNLmk4xk/W+pVtn
         I7AhFWyA5gcZ9eBSappsj8ANx+J7ojzkoVzwX38zO0CzvXd5VF8FdrVNdtds6Rkztc4F
         ahdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129815; x=1792734615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y8uwftxzQ3qe2G1T+qJzRM5OtmdbAWI3lbQRcXY+nSI=;
        b=BUXn29+iPVlxYJaYr8IWUV6P/ijsRFZEQze8QcS876Y8RsDztGfdFBnUu6wQSfBhQK
         M9At2OOH8b/fghw1j9dvN0gmXetFFzBq2wfIfWd+gvX+A+3kNXs0100pPSB87EbdnrRV
         hAEaPJX6CS+xwvQVwQmRlM0/F7njHp+KcN2S3uAdjCkXuH8G/0kempo1G+Jt4MWAlTne
         18YT21YSAGjK/QcnKy597e9AHPTdYIN/wF2XjbiM3TEByo9qkJM3ZdRlJMZ+IKGM4SwK
         +bjR+ucdo3hXD9PE0WN6t3qf8Q4FZGQjMCk6lSvmis1WOsq7ryx6TN1pnGBH1fweff33
         sDbQ==
X-Gm-Message-State: AFq9FYLjjSsOq4TFF9jvMZx2i4kpRH5CooN3eUyNUmeSun3OHnF0IKHE
	oKIDMMBx9zujt1WQLQbgxaSV9RhRL8PB4LbptL2UFP8sDaNWXOIOjlz1kq7+QA==
X-Gm-Gg: AYBFou0PGXrIGOypIiwUAaZN/IUAAhS1h6OzK3U9qrRQoYWkvAXKWHzTP8iSV0tNGqU
	imX4Wh+PgkCFSSd2yUFkqzGfv1F+68xBl4hkL4tjxn5f+h1H17Y5q7sq14o3R8tVnPy0mMlzflO
	SGVXYqVhY33ynholX1iwc9N0qpzQI9QNOWkT2OdjlMco8hpx0jjoNGfJb3pyHO9BDkrl+aGQ2o6
	YO+3q6It2XKZouFsYPAFRW4i3gqdgjLFa254GHPKg5GZ5zflS3ZNdqJ1tbXWlRiMBmaWxXv5Qrn
	9bi3Xp/6F4pXm1Yi3aH0/hc2Hh952nbjcqw0LZKX6goSAyjoJ21xbFaLCxJiYLqxBskVxPpU+V4
	FtFAhKe47kbu8AwlwceDMqNW5+9oUCLtevx7iQmn7RWEXwZq8oopJmSJE0GX85/lXPGcXJLht3T
	uzvi8ykXM8JXVV37R53Fst6QoLf5/uVWFZ2Q1Omqm9lnmg1RsxJy8bnyK2ZHSwmte/TSfvFohG/
	DcrzU1SC1jGy77Fwz+RUhrwjbvNHLe4o9PzzhiKuX3fGMqRXtl/KFOMVoNCUeA1r8BfrmfKSsie
	DtIqAh0+DQbzzAUs8XNuRqyrF+6fEBLtCHkzxW0Gdi8=
X-Received: by 2002:a05:7301:e2f:b0:354:53af:7f2 with SMTP id 5a478bee46e88-3602ddd1da9mr2778117eec.11.1792129814631;
        Thu, 15 Oct 2026 22:50:14 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm3928803eec.6.2026.10.15.22.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 22:50:14 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v4 0/3] mptcp: pm: kernel: retry subflows closed after an error
Date: Fri, 16 Oct 2026 05:50:07 +0000
Message-Id: <20261016055010.980819-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A subflow closed after an error is never re-created, even once the path
is back (#440).

When TCP closes a subflow we created because of an error, the in-kernel
PM now creates a new one to the same addresses. Its SYN retransmissions
space out the attempts. Their number is set by a new limit,
subflow-retries: 15 by default, about 20 minutes, 0 disables it.

Changes in v4, after Matthieu's review: netlink limit instead of the
sysctl, one new subflow with more SYN retransmissions instead of counted
retries, no MIB counter, and a test closing the connection during a
retry. Details in each patch.

v3: https://lore.kernel.org/mptcp/20261014143349.768138-1-anilkaushikwireless@gmail.com/
v2: https://lore.kernel.org/mptcp/20261013025653.523755-1-anilkaushikwireless@gmail.com/
v1: https://lore.kernel.org/mptcp/20261012171740.464517-1-anilkaushikwireless@gmail.com/

Anil Kaushik (3):
  selftests: mptcp: connect: retry write() on EAGAIN
  mptcp: pm: kernel: retry subflows closed after an error
  selftests: mptcp: join: validate subflow retry after link failure

 Documentation/netlink/specs/mptcp_pm.yaml     |   9 ++
 include/uapi/linux/mptcp_pm.h                 |   1 +
 net/mptcp/mptcp_pm_gen.c                      |  10 +-
 net/mptcp/mptcp_pm_gen.h                      |   4 +-
 net/mptcp/pm.c                                |  20 +++
 net/mptcp/pm_kernel.c                         | 149 +++++++++++++++++-
 net/mptcp/protocol.c                          |   5 +
 net/mptcp/protocol.h                          |  18 +++
 .../selftests/net/mptcp/mptcp_connect.c       |  17 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 124 +++++++++++++++
 10 files changed, 344 insertions(+), 13 deletions(-)

-- 
2.25.1

