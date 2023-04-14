Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10A20F6
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 14:08:28 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id i3so8327173wrc.4
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 07:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681481306; x=1684073306;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1PB0Wv+X709r9gK1DvzM1L0T2wxDcvnl72V9qpeZSo=;
        b=WTswzxto2LWs5T1ZZv4PfRoEv2lZ+IBkWicbwaiXNBl9NFYat2/WH0uxvXwRofEqn3
         CidhDsjz7VIW8P3YV3Y1X/ntkrrmGH9eW2HFU2SJWzi1xuCsI5tnptZVOC+aGGG9cZuf
         ZOWw+t/zlqev4P+EexhxM+qZ4wBrQ+u841VHiIDaBWW+ijMw6s8yHjRGroxef49S9XCh
         tJ0H8bxT+koL2Uou5KV9XKYNwwDtmzOPSsWo4KrZw/Yc40NmNWJA5Nm2uWr+i4jYfZPx
         DTc2m1iE4NRDkl3zqWios+VBrS+PClqIrVWUcZ2OQ8IniqiSJniMX6Au/VtRhdFR68ny
         rTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481306; x=1684073306;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1PB0Wv+X709r9gK1DvzM1L0T2wxDcvnl72V9qpeZSo=;
        b=azsFPxCzj7PwYrwo6d8Q4g7m7DrUGtr+DpOYyFQEGe1vg3gzmx3Rlt6D+EL2bQFlMR
         KC3v/kLda7US5j4u8FAU836OxgZDrBcTBYR2oLchCsahWr+uR1wQP9eaobEQJur8pHUj
         j/xQ+zLcIqXc5sb+dgHzx/ec/u2bZb+VVdlYG7lxwSPwcvinbmNwnr1suMUAgPa+02/1
         xp9Dfj9C8IO7mAC9Z8AbvXbyQB0v9ReV4ZC/+WBGmQy3wHal6INwUi+00jAJhb3mPOLH
         c0Lvrd6QK6197Md3/O6/3FcVmCzFYR3W6vUlU0fzjQO4w2dkXdJw1DQ8gvkWkGE/Weko
         1gRw==
X-Gm-Message-State: AAQBX9fGjkEAeYm2pLHRJR0xA7o1eq39kq8egm+ufUl1yvK0QVnc70E/
	5iTkTB3YVyc8+ANIdM0708gLKQ==
X-Google-Smtp-Source: AKy350aGsOrJZHd0G9sjH0pEUFtRZ8X58J4OqAa/eg1kMTvhXqxCJotBcKwF6hELCEaKdNPm178A0g==
X-Received: by 2002:adf:f492:0:b0:2f0:df59:1ea7 with SMTP id l18-20020adff492000000b002f0df591ea7mr4382632wro.31.1681481306425;
        Fri, 14 Apr 2023 07:08:26 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d58c5000000b002f47ae62fe0sm3648185wrf.115.2023.04.14.07.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:08:26 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next 0/5] mptcp: refactor first subflow init
Date: Fri, 14 Apr 2023 16:07:59 +0200
Message-Id: <20230414-upstream-net-next-20230414-mptcp-refactor-first-subflow-init-v1-0-04d177057eb9@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD9eOWQC/z2O0QqDMAxFf0XyvDDnnOB+ZewhrekMzFra6ATx3
 1eF7SEPl3s5JyskjsIJ7sUKkWdJMvocLqcCbE/+xShdzlCV1bWsLzVOIWlkGtCz5lsU/9UQ1Aa
 M7MjqGNFJTIppMu49flC8KBLXza3tXEOmhawwlBhNJG/7XZKRHc8H9TyQ+H0SMk+W48MH/Jzw3
 LYvICelMbsAAAA=
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2218;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=HU9Ki4cI++7m6T8hYN0UqK/vmUY+R07+hTP2VGju6xA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkOV5ZSkCmwdWKPC/lxOxiCWwqJbVICR+LGlNlL
 N7BxQ8mHTGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDleWQAKCRD2t4JPQmmg
 c5fmD/4gtUdRr0TmXmfPmZmkvMiJjlxQBr0/fCh0UzFh4XlZ58xuk18KsQBYfmmftx/j2+e5Y8R
 9CBeqUCGrmaPr4oKxG9O2/Y0hJu1CK0CL/L44hJJoCOhO+DVlro+3qG1zsCl12WJzzE0utO0FMM
 S1rIinJ/71SgRhfnTwr7wH3MGj5MdF1NcNXMGqiHHYyuvUvGYTE6SWZYhgR1mdZwYzKXiL0at5g
 XfAGKhc9AkCNSoZTag1zV2VMeqOqtlglyjCyl1gdX61BuJAbw2NrF+VWyU6hgqPSQunDrqwGdDy
 i6GwlWv7qIcixFRQtl7ZEgA/AnNedZfT8oNbQDiNSKDSitbOebghdafrjMM7e6j0bRpzFnCJVNp
 wA+jEL6q0UiLcZFIdoXGKdUKsJtwfayOG3mDivik1krleg1DSb4vbATjCp+BL5N7A/RMZ3tOPqj
 y1gA98HnHzrTK+yl6BFgQzqTCXbCntak4NNGQYiBSSOuLJ7Snlm0N55b45RrPK6U+xUXUBaahWL
 pg7Z93+A308UPD99z2bolS7fdsnkdglhlV+2sZF9ngKbrtkapm5KFvkDR64OKC8EJnfcp+KYYLv
 /nWM/7GyG9B3cRO3U5rnKAkOEwW0Mj2G/iPNzZXXp3K5i12dh9VybB9j7KO6aVmT8G0Mxqa0k+q
 i5OCsTP7LkgfxJQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series refactors the initialisation of the first subflow of a
listen socket. The first subflow allocation is no longer done at the
initialisation of the socket but later, when the connection request is
received or when requested by the userspace.

This is needed not just because Paolo likes to refactor things but
because this simplifies the code and makes the behaviour more consistent
with the rest. Also, this is a prerequisite for future patches adding
proper support of SELinux/LSM labels with MPTCP and accept(2).

In [1], Ondrej Mosnacek explained they discovered the (userspace-facing)
sockets returned by accept(2) when using MPTCP always end up with the
label representing the kernel (typically system_u:system_r:kernel_t:s0),
while it would make more sense to inherit the context from the parent
socket (the one that is passed to accept(2)).

Before being able to properly support that on SELinux/LSM side, patches
2-3/5 prepare the code to simplify the patch 4/5 moving the allocation.

Patch 1/5 is a small clean-up seen while working on the series and patch
5/5 is a small improvement when closing unaccepted sockets.

[1] https://lore.kernel.org/netdev/CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBkMkwFeM6qEwMKCTw@mail.gmail.com/

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Paolo Abeni (5):
      mptcp: drop unneeded argument
      mptcp: avoid unneeded __mptcp_nmpc_socket() usage
      mptcp: move fastopen subflow check inside mptcp_sendmsg_fastopen()
      mptcp: move first subflow allocation at mpc access time
      mptcp: fastclose msk when cleaning unaccepted sockets

 net/mptcp/options.c    |  2 +-
 net/mptcp/pm.c         |  4 +--
 net/mptcp/pm_netlink.c |  4 +--
 net/mptcp/protocol.c   | 97 +++++++++++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h   |  4 +--
 net/mptcp/sockopt.c    | 24 +++++++------
 net/mptcp/subflow.c    |  2 +-
 7 files changed, 86 insertions(+), 51 deletions(-)
---
base-commit: e473ea818bfe42cbdf872c41593cbaf24dbf1297
change-id: 20230414-upstream-net-next-20230414-mptcp-refactor-first-subflow-init-ae4659df6ab9

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

