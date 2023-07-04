Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E67814
	for <mptcp@lists.linux.dev>; Tue,  4 Jul 2023 20:44:54 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3142860734aso30464f8f.1
        for <mptcp@lists.linux.dev>; Tue, 04 Jul 2023 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688503492; x=1691095492;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D7p+M80U1GYeG4EQloROMoimHvJJ+Gr6Qt5RflHkHcw=;
        b=M1UqHfYV5iTFuBkMyx2N06hk9zHxdmUXlwD5gsZVNO7zN+QaCZgniU+y2NXMwymf87
         99Q7D0/M0PHWAmedSvH8oRKU/jz8jNWTj5Pg1rnPAPBR6+nQ1ZGxxi10hWfFTpcDywMI
         K6nLj6BBEZnPeDX8nD3cmPmebxU2isy4Z8s1rWwnkP/8LW1I5mAxN7c2e/sR/RgwvOga
         WZoSO9EfD8vRcZBV7mTEbCT9lzW5F9wS0pNXVC1d/HyOhAJkTCEHcLtBkGTsnHGkYiQf
         3MvRINDYZENsjTFWTYxMb+V4L1cb/6EvqaTsOsejleS4MmQQcerlb2sQQJEjyZcvfKCs
         veew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688503492; x=1691095492;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7p+M80U1GYeG4EQloROMoimHvJJ+Gr6Qt5RflHkHcw=;
        b=N0HtUKeDyQW5vgC//CajwgbLlv1RLFVo96XIKkOd+u6VkRANfW87+URoMV7hHD4Cx/
         DvAultAvNso5XYXndFKShzwrhslCNMloR44RrGyF54bOQdLGcwza+1BS2sBaDfMwe/ni
         EsQa8NrPjCZl4FVN98BR/CjMLlRUW/Yi7emjrUtCP37IbN6Fosm5qB++sXyLYMb5ZTDv
         IJFKTZ/CKta8xBnB4kE1zhxiusZApwEhkCJW2YmlKF5SaYh2Yq/VERu+RzV/QnMekCKU
         XDC5gUB4MxdjoiVsoQkKdqpvjo4tn1WZmKzC7B4CxlPuDaC3I1vy6g7ebMO2uSd0mmiy
         gMiw==
X-Gm-Message-State: ABy/qLZn3gzQdGS8g6foGO1OfAKubkv47eEzoYMa9z/FtCaLhvadvcFQ
	GPYnrkUV70AGA/0rkH0d0x5GWw==
X-Google-Smtp-Source: APBJJlGJDEcokr+GcHU+9Qf/h2qQosHMZUQwXe9EmgGzJ3+LjM6YP7JNYrs43VTmd0jc5qdA5j+VRw==
X-Received: by 2002:adf:e6c4:0:b0:313:f000:5de6 with SMTP id y4-20020adfe6c4000000b00313f0005de6mr304722wrm.16.1688503492711;
        Tue, 04 Jul 2023 13:44:52 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003fa74bff02asm115332wmq.26.2023.07.04.13.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:44:52 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net 0/9] mptcp: fixes for v6.5
Date: Tue, 04 Jul 2023 22:44:32 +0200
Message-Id: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALCEpGQC/z2MQQ7CMAwEv1L5zEppaALlK4hDFQz40FDZBSFV/
 XstDj3OamcWMlZho0uzkPJXTN7VoT00VF5DfTLk7kwxxGM4hQ6fyWblYUTlGfs6ihU85MeGjAQ
 tLUqKOZxz16fUk+cm5f/Ba1dymW7rugFyB+rLfwAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2556;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=LrpdosI7KkBh+7o63PMBiX+cMjX7K8ZvW3l5GVO0yrY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpITDht9FvKyasZKl31DMWpyv+rEoet2oV7wpE
 XA80Kqe93yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKSEwwAKCRD2t4JPQmmg
 c+2ZD/459QZCT25gHkqWmvZaw9TtfYOOfjkLuFEIFGf/8muDhYY55mTQBm3kysY70oNik16HBFH
 nJETfi3nq0oQ3BxJolaRyC2oN8QK/fgHg2VfYLV8chUw+KeL3QWLN7NgCNXgtVB4lp8pTmmixVz
 WZnMdpUkutR74JIJddykGKzmQL/XEyQ42dmkf9oQNIpQT4ujoGkKnjkQ0ZjXW6gizWTO9FO6xk/
 HmfVDFiUmDlXwJyaH2084hWbFCbiVCf00XKFgvRmEGs4xiB/RclIdPVf8QaZcI3fg5UcRxdyrql
 dqpCm8oTAlo+Qo1hb795aA2wWv/gG94DnMllM7mOwPJrdiL/TlsQWnRrc7kfR9Qe1S9A4IATC0P
 v0VBQPHFKN1Dmjg+9fYMMG3z/8mBLotJh1QB2PdqsoEvF4MKXD6L1jg6COijonfGbWE+2tAlJzJ
 2T0hoGZDolGJzrvCTeIGkiW3X+z00+bao3BfcOgCrpw5SauPEt7ZExSYWVFoYEqpWVfNqu5rE0x
 8pkX6/2myChEUXOOPePFDdRXwIY8rjd6vO4pO4UJi+rWqwBlG/2PTIUSAXWjqAVM1d8ms0NeTxp
 NArL+xGx3CicDjD3OVxVkgwVEzUDLlps/Fnea61gtD7Gtre3zzz78v9FMc6GHHlruqaMZnI+K38
 pCoOntMnR09+xPQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is a first batch of fixes for v6.5 and older.

The fixes are not linked to each others.

Patch 1 ensures subflows are unhashed before cleaning the backlog to
avoid races. This fixes another recent fix from v6.4.

Patch 2 does not rely on implicit state check in mptcp_listen() to avoid
races when receiving an MP_FASTCLOSE. A regression from v5.17.

The rest fixes issues in the selftests.

Patch 3 makes sure errors when setting up the environment are no longer
ignored. For v5.17+.

Patch 4 uses 'iptables-legacy' if available to be able to run on older
kernels. A fix for v5.13 and newer.

Patch 5 catches errors when issues are detected with packet marks. Also
for v5.13+.

Patch 6 uses the correct variable instead of an undefined one. Even if
there was no visible impact, it can help to find regressions later. An
issue visible in v5.19+.

Patch 7 makes sure errors with some sub-tests are reported to have the
selftest marked as failed as expected. Also for v5.19+.

Patch 8 adds a kernel config that is required to execute MPTCP
selftests. It is valid for v5.9+.

Patch 9 fixes issues when validating the userspace path-manager with
32-bit arch, an issue affecting v5.19+.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (7):
      selftests: mptcp: connect: fail if nft supposed to work
      selftests: mptcp: sockopt: use 'iptables-legacy' if available
      selftests: mptcp: sockopt: return error if wrong mark
      selftests: mptcp: userspace_pm: use correct server port
      selftests: mptcp: userspace_pm: report errors with 'remove' tests
      selftests: mptcp: depend on SYN_COOKIES
      selftests: mptcp: pm_nl_ctl: fix 32-bit support

Paolo Abeni (2):
      mptcp: ensure subflow is unhashed before cleaning the backlog
      mptcp: do not rely on implicit state check in mptcp_listen()

 net/mptcp/protocol.c                               |  7 +++++-
 tools/testing/selftests/net/mptcp/config           |  1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  3 +++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 29 ++++++++++++----------
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c      | 10 ++++----
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  4 ++-
 6 files changed, 34 insertions(+), 20 deletions(-)
---
base-commit: 14bb236b29922c4f57d8c05bfdbcb82677f917c9
change-id: 20230704-upstream-net-20230704-misc-fixes-6-5-rc1-c52608649559

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

