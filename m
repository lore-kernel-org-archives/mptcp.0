Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9A6FBD
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:06:53 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id m2so42792369wrh.6
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887212;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JRRGwFMXeMZ6k/lAyWPThbA0Nv5bQXjkYBX7biIFAoc=;
        b=GIXJ0no0Kh/zTWLBE9xTbx/myACazkbPQz/+FzHlg3hhdvO9CdmbSvbkpR0CIF50kJ
         Tzz6SAcvFPSmLesro1/iWRfuxyP9/EIdW2zP1k7ZzgCVSeEthNNgyYUkv++cjwzzXwig
         8i7uZPw4YG8xz5d9aj5SA4TDPm4WHpwY1+2zyzy59cJIDEYaXkTDMaiNFoxuzTOWGsq9
         MyxtMI8PFKWuZP6OSAGqxrXMXhQ4bLq6qsXWEv3OvKZ1msL3LKP/3DK9vxz+FJDmHLnm
         VIW0QkYy9/7ZdpUGzjGkv9mE75hmaJB3BiC5EqietIPfJAWeuDvcTFW99nj14AMdta+L
         45AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887212;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRRGwFMXeMZ6k/lAyWPThbA0Nv5bQXjkYBX7biIFAoc=;
        b=nOBjN6TjOou79pILkTe+1zAluVqQeRBgK4pl7RoA0R2zQPS3VOLxXvskxlnzPLzeQE
         rGgssPTG+UzaiM8bDDfXjbMog6DmTPsVdfb+diYOnkhzaZz6kCZDPAt308c0DkQ7YlEh
         ycS3RjRPCg/NTN1dITSylfZip5uUd0Fuixiun1/KZLkyCFA99QDl6MqAEdAqluN8mL12
         Ab8pey+vi0zqLRfvrwP40yOOSPj5dkaa2G2KEGiMAv1Msqc0p27YCvKKzkbRNtnRYdJi
         CzkPa4jxH72C4OCDw4W+vDu9QH6dgIGbRr+QA9PHznygiG6Oe4lIg4xwW3hyA4FY1zMC
         3NfA==
X-Gm-Message-State: AAQBX9edx5VDoLGnrbl/pqwH6fhiJ6kKNVB4MIM+D/t4HsgTs9pvsBxd
	5zp8ZgTW0PrdGk//I0o1XkhGu1IlxnLvALMiA9YPpg==
X-Google-Smtp-Source: AKy350bRG/WM3dLC26pxKf6PSB8LSYY26se9Pl/NiI9BlnAQ/+Fl5591gcGeiSBIL/GD5CQUqq+XIw==
X-Received: by 2002:adf:ef46:0:b0:2cf:ee6b:36aa with SMTP id c6-20020adfef46000000b002cfee6b36aamr2171809wrp.64.1680887211946;
        Fri, 07 Apr 2023 10:06:51 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:06:51 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net 00/13] selftests: mptcp: skip tests when features
 are not supported
Date: Fri, 07 Apr 2023 19:06:34 +0200
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJpNMGQC/yXOywqDMBSE4VeRs+6hXkpa+yrSRTSTGqox5MRSE
 N+9sV3+DHzMRoLoIHQvNop4O3GLz1GdChpG7Z9gZ3JTXdZNeSkVzyENgZ3ICm7UjQWTTZAkvEy
 GX4gek7C11qjWqKtpK8pWrwXcR+2H8dDSeQ2SIvR8jCHCus/vREd/3yPRY9+/M/WEZp8AAAA=
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=nxgSbhPgQWWgX6bFW8s2vLLy36z7W4QWFesr5brmytM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2qARX//++QnQ3Vu0CZALX4VOd4wF2wbEyzq
 0m2MRzGLSyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqgAKCRD2t4JPQmmg
 c+3cD/99Lb0d02iWkRe0+PfVPdYU2m5y8sCojHTiJddR28XKVgPf+vXtGJ6UfEST6UnqpBkOmcz
 DJ6W0sHakh5Xy58vICrdfg/sfLupi20YmOFlHSuaCpACdV7YgS188uf3ru6W8ni3j2yrMC/FH1d
 ZXjw6wf3nz+3kHNXwQKwAHwinShF4s6eExDSxdt5n6hRg9C6mtBjzsn4CD2zQCJwHxuIJ0xkVnf
 3xI8NgirNbIaT6Abi1n6O7ofcJwmElPYG+xhMrzWayMo28ZVz3Yy5mGysN8KWKqB1qnQBcrbymb
 +51V75n+YMUxUjKzneqH29+1daK5fT7berEmicEayJq3VbA5qzHLJLKWiuhUixBkarfyKHBoXUj
 z943k9RRY+QIzLCPc72R8QG9S1b9fg1kRnazhYROcksF5HgiaQXy8ae/+HktUaC2CmUcSCJHdD1
 Vou7zEIvDTfVTIB0zkwnTL3sjDiB/svTo5egnHQuy/6WhVlxTRveIgitE+QTi3Z/SNsbiKQwW62
 Ej5YqFv2u43yCGjYFWk/H6Qm4ZMuZPiyD5Yqz3tLozYJRnbSpusotdkLKLhtA6vSx85k/8yLj6D
 dyHQexINQX/jeKgrMSo+esmP+2tu+SalZRHToQrzZ7fwa56l5SNEuyIilP2bsMr0x1pRJKTbJkk
 WenI6GGIaPZuYOw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

These different patches add support for older kernels. More similar
checks will be needed but here is a first batch not to have too many
patches (because each patch fixes different commits).

I tried to minimise the modifications and do the checks from the bash
script not to have to detect the feature when being used in a .c file,
then pass the info to the bash script, skip the test, clean the
environment, etc.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (13):
      selftests: mptcp: connect: skip if MPTCP is not supported
      selftests: mptcp: pm nl: skip if MPTCP is not supported
      selftests: mptcp: join: skip if MPTCP is not supported
      selftests: mptcp: diag: skip if MPTCP is not supported
      selftests: mptcp: simult flows: skip if MPTCP is not supported
      selftests: mptcp: sockopt: skip if MPTCP is not supported
      selftests: mptcp: userspace pm: skip if MPTCP is not supported
      selftests: mptcp: lib: skip if missing symbol
      selftests: mptcp: connect: skip TFO tests if not supported
      selftests: mptcp: userspace pm: skip if 'ip' tool is unavailable
      selftests: mptcp: userspace pm: skip if not supported
      selftests: mptcp: userspace pm: skip PM listener events tests if unavailable
      selftests: mptcp: join: skip PM listener events tests if unavailable

 tools/testing/selftests/net/mptcp/Makefile         |  2 +-
 tools/testing/selftests/net/mptcp/config           |  1 +
 tools/testing/selftests/net/mptcp/diag.sh          |  4 +++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 +++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 18 ++++++++++--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 34 ++++++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  4 +++
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  4 +++
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  4 +++
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 17 ++++++++++-
 10 files changed, 94 insertions(+), 4 deletions(-)
---
base-commit: 016e68a1441264585c15defedc5ccf883b3b4211
change-id: 20230406-mptcp-issue-368-selftests-old-kernels-fffd69d67d91

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

