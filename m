Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9562F21
	for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 20:42:25 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id j1-20020a05600c1c0100b003f04da00d07so1339983wms.1
        for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 13:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681245743;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yLw+Q9jRLjBSRcIOCrWWTPAtbf14hoPj7TuOVMiOlaQ=;
        b=iwDG2NgSrNS+WGzysNtYXdJWA3DWB5fN9hnDIvSQ7oEhhsJ3RsK9NbJZ0cX220bwv0
         BvQq2vugPGpeh0O9c7YrZoJ/YWhSmvwF+oAAwt/wM1Sud9nUZXb2y92LzcpI8RuPiSzN
         7KPENpWrf0c9DT4/Z4CFoNgCWii5AfQRz4/BNwpDwB1Tzv+jhdJ9hk1s2u4db5Njb/Kb
         hd7uPsIbpx9qyw8xQ0xeyM9m/OoHkooeUuDCafenat9bAhKjc09NJpfRE9CYoQeq8JKG
         ogONEPJIjDnQvfxXBNiGQF1ms3oDWJ/cWs3UhUmI5xBidabHaaZM0eqC5N0+fvVMZTVY
         Y6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681245743;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLw+Q9jRLjBSRcIOCrWWTPAtbf14hoPj7TuOVMiOlaQ=;
        b=31J0t7WjV8cO6VN6IHAhX1IiibNwCe4QCQ+dc6taiIWB7YfIQxM36xfSq4zZjLQejj
         6E6kxzzlBfXhYLEbIL5sB5ITxXeYgq0Ght6CsapmplION5J5UK7gcH+c0x+mNsDnTEWA
         UyE1WWLKxsrGwrEhLzAYV/kF8aZBa2xQj+xbcJQFw4thvf6rkgjb3SNhEUmKI3tJVqZt
         n3fubvAhJDC/AU0IEhrGtCBJJamX/VtkM6DYJwAuYF9/eoEdWdDLFDh3scAx3L6RLxpm
         2/dzhUeWAcaU9/N4oBW8cKoJ41X961nQh8J+eTXLJT50aIpgsyGYu5XOrZf0VaykF1sg
         MPBQ==
X-Gm-Message-State: AAQBX9f122v82l+m8nIsivvgl7NNtMxkTv1jPnjoPSWHm7npyGLVbHeX
	OcbwVx8VceUzYpapMJalglToHw==
X-Google-Smtp-Source: AKy350ZrPZmJoZzqx9ha+ZRrg8c0OK5tUwNwVi2LISl/wtLxuyv+DaURwvKXSo4+X1d2wgHnRrozcg==
X-Received: by 2002:a05:600c:2158:b0:3eb:3945:d405 with SMTP id v24-20020a05600c215800b003eb3945d405mr2959574wml.38.1681245743301;
        Tue, 11 Apr 2023 13:42:23 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c7417000000b003f0824e8c92sm86887wmc.7.2023.04.11.13.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:42:22 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net 0/4] mptcp: more fixes for 6.3
Date: Tue, 11 Apr 2023 22:42:08 +0200
Message-Id: <20230411-upstream-net-20230411-mptcp-fixes-v1-0-ca540f3ef986@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACDGNWQC/z2MSw7CMAxEr1J5jUUSClRcBbHIx6VeJERxqJCq3
 p2EBcs3M282ECpMArdhg0IrC79SA30YwC82PQk5NAajzEmNWuM7Sy1kIyaq+E9jrj7jzB8SDG6
 8zmflzWWaoP04K4Su2OSX/tS8QGvXj9Fy6otc6Ke2+t57eOz7Fx+OcKCaAAAA
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Dmytro Shytyi <dmytro@shytyi.net>, Shuah Khan <shuah@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=Qu/CYuD3UnLcvbNoUFhk1/XXHx+nZOplbse+R6F1NLM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkNcYtnYL2zHzJFK+uDtjyJTHmad+2rXZzpVUjM
 eFGVz9GlRCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDXGLQAKCRD2t4JPQmmg
 c5k6EACNWOxesNG8X52d6QRhRwdefUPp7R4Czldp5iiZQ4qb8XfwvNgWAZzHB06N3RC3ZCu4hr7
 Po94OYc7661HCvz8qt3FqOA7h8sHiXnbQb3EP1M9sBBuFKIPkfsFUhNV57o0NWW1gp9t4xpYkqn
 xcB3CIucSjNbAn+/kmxsouoplTWO1uH1/AOhUTfaddzh5feu2nceaRv7joBN+qrbtJ391Bwt6Yc
 QafFlJHyNxHj8+JNOpZYOCkX5X3QEuLxNr+GrrASTsCxFTFdSL/Zfr1MM6WlBkCE3bkq65ICfPA
 hqlD9Fx6ranlJFlmhUHeaLMe9ydLYKjcsVfVp7ve6c2ArU4WNec7huUq+bRSNj0l85CKI9te8FE
 F0XuIzCtxkTJVsjfZV0PDcRuP19hb8kTVh1GyRvL1xSkFL+5nws8Ak6Q+y+E9gIRDcCxAWAsxSX
 MPM4pHPe+3gTknlM9DtqDqqjIK+bCfWAGHmMGIYc2pw8rdlqEBvQCx6jhxADWlpwtfW81bNVQei
 8z2S+Nts6HEyiBgbBY4tYK0JBFzk4RAe5sCPX9gD91xIQ7syIvNWg9sp/AQ9ulpAdsuSiIcRoeo
 mNx2xb1eyMnJ+LgZnGkYVLLgEzP+07LE49fa9knC6AcSo+n9Y8MdFWC7QrdsPwUMoCvxRmwA6tk
 T9CwhvWbi4zB54g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Patch 1 avoids scheduling the MPTCP worker on a closed socket on some
edge cases. It fixes issues that can be visible from v5.11.

Patch 2 makes sure the MPTCP worker doesn't try to manipulate
disconnected sockets. This is also a fix for an issue that can be
visible from v5.11.

Patch 3 fixes a NULL pointer dereference when MPTCP FastOpen is used
and an early fallback is done. A fix for v6.2.

Patch 4 improves the stability of the userspace PM selftest for a
subtest added in v6.2.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (1):
      selftests: mptcp: userspace pm: uniform verify events

Paolo Abeni (3):
      mptcp: use mptcp_schedule_work instead of open-coding it
      mptcp: stricter state check in mptcp_worker
      mptcp: fix NULL pointer dereference on fastopen early fallback

 net/mptcp/fastopen.c                              | 11 +++++++++--
 net/mptcp/options.c                               |  5 ++---
 net/mptcp/protocol.c                              |  2 +-
 net/mptcp/subflow.c                               | 18 ++++++------------
 tools/testing/selftests/net/mptcp/userspace_pm.sh |  2 ++
 5 files changed, 20 insertions(+), 18 deletions(-)
---
base-commit: a4506722dc39ca840593f14e3faa4c9ba9408211
change-id: 20230411-upstream-net-20230411-mptcp-fixes-db47f50c2688

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

