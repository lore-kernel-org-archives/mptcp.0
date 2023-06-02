Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B317AA2
	for <mptcp@lists.linux.dev>; Fri,  2 Jun 2023 09:36:19 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso2456454e87.3
        for <mptcp@lists.linux.dev>; Fri, 02 Jun 2023 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685698577; x=1688290577;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3hnBdT+4sofW6weHvtY0aB3YDwyxDO3yd2SZl1VkXg=;
        b=2wuqAodsy7HoWHGvVe5jW9OMuhCUSqCgb8Q0X68MCniJvVWk9vSjxsqaheCfDOBU8O
         24yDaRZOpd5J0iwC57SUBC+W7AlUTyQyZVNzxQyXE3BWnDp4h/vzBlhMvJXE/r3gDkLb
         WjnexhCx5w40GmlXK2o14O8O9cdTLSdVJQPp81Bpu6BE4w9iXFlXke4oS3FsjQ1Stjdy
         bMmu7yvhb6tfKKVnQPh6EnC/I5TuWLiEGVYu9UJi6uF8tmUevyGqwjpp2kIL7zcY7Fd6
         1qRcsy6jALhfJkXQkc1AZ5tHpuKziWKUX2JJz2zP1BQ+UUPS/cZFWLyWLg3Oo5Zp2aNO
         vbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685698577; x=1688290577;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3hnBdT+4sofW6weHvtY0aB3YDwyxDO3yd2SZl1VkXg=;
        b=BXP5qa/RqDYgpHngKpZzYP3wxvI6v9fVabyfUtWWLWDh9QJn/jAldOIMm7ZkiAHAaq
         cVuh4m7yN6zqCUb9vKeNOkMwWX61KE3wzcXkSjRNYU05LO4bpYYaDkatpRr/uIzz3VQH
         Fq1jNbX4R3zQ7DCEUG13FdPwbINSU9Xx5V/a7rPnGol3Xi7yUwHVJB6WUdTUqL5tsRyQ
         LwsuVVET5Qpg7bciI2RRKgSafvpPrmJM+XfzgpBI45KAcpDRYfSeUNMC+3Si5FhmWa3i
         5cQVjyGdIjFUS0idhlxL0Cs7ZpZoiE01/h/qhX6l4jm1GJAfaM4JCykR05Zd/QM9KRbE
         oOJA==
X-Gm-Message-State: AC+VfDykmqA8Ov+fFh/k1LdeUWhF/0pq3Pgowe0E0vHBfqnGROejnxxt
	LSCyOhVw4pnstwN9coddWjqF6w==
X-Google-Smtp-Source: ACHHUZ7qQeDUha9mDyy+gujyAY0nQj03FED/BjoEl5XPG1LJTS8xMalacGSsIUEV5xttDjR8WUG5Zw==
X-Received: by 2002:ac2:4824:0:b0:4db:1e4a:74a1 with SMTP id 4-20020ac24824000000b004db1e4a74a1mr1516894lft.0.1685698577315;
        Fri, 02 Jun 2023 02:36:17 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1337446wmk.33.2023.06.02.02.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 02:36:16 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 02 Jun 2023 11:36:07 +0200
Subject: [PATCH net-next] ipv6: lower "link become ready"'s level message
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-net-next-skip_print_link_becomes_ready-v1-1-7ff2b88dc9b8@tessares.net>
X-B4-Tracking: v=1; b=H4sIAAa4eWQC/5WOwQqDMBAFf0VybkoSjdCe+h9FQhK3dbGNkg2ii
 P/eKJSee3iHx8AwKyOICMSuxcoiTEg4hHzkqWC+s+EJHNv8mRKqFLWQPEDKmxOnHkczRgzJvDD
 0xoEf3kAmgm0Xrp1XtdattapiWeYsAXfRBt/tuq9lR2OEB85Hw/0Hmkw6pDTE5Yib5MH/7Zgkl
 9zLEurKy0pc9C0BkY1A52xgzbZtH2KCdjkEAQAA
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=U6Zkq3srBMQTPaEUG3HGzM57fXdxB8VpRxHgcFT+el8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkebgQCX/9JMKftJ5U7zjZIG1X6H1AAnSt9raUN
 Q69PhpcIq6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHm4EAAKCRD2t4JPQmmg
 c2fnD/wIHt1J8gTaEY6Rcdt3ayLx76pBwCzZswplm6GiaI/S8iZLz455CLHoimDPXcXBSpAUyoL
 kWp/OQkiH975/TGlrBDM4BwCxBz0ARMag/uKrruFCcM5f6aNe7ySXfZ31EU3+JM04CnrZG8uSKY
 UPChOnXVtmj6M5JO4kd/oS/YxRSoHs1vwl1/khOvmPWAuPyR/mMqp6+LGq6GA3yrI8jh4fFV3Y/
 0SgIhKBuZ7fPkNqf3GQcRQovUFymy2xrv6SxnbgKq+PlzgzN2RSo6vioTAIssIDdvBQIdAvYz06
 cu7RaU2TK9aej11QEMO+f54t8WtzJAecJEbUw3gy2mxmp5rlQHqUlpjCd7dloQoE0pjQMk23iY7
 /EVBfwTzCCb6Iv1pYUJewm8WTfkrFssO0+mb3DFXHfossfEfKnba4NE4jVjkBIyWskZBY8hasmw
 MKJUW/rsG+o4JtbV9gzjc6WOkM75IdxPAAnKXqcv3bTsWzEiJ6cctRY0NZawt/jV9662Ez/SUru
 e4wO3PU5iT1UK8jksUMzhmFyQ2v93J0eQbjYwb4q9D0D+WJFqUnS8nkIbArunPiasf/w2aANQk5
 RQPS/folm9oM8hN/6ycoOvaE3kGvmXH/PzQcSuVyt6FxuhVfn4WfTk92+0iJqi5AefH6sh5hxo+
 pUqGEH8nxY9tbMg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This following message is printed in the console each time a network
device configured with an IPv6 addresses is ready to be used:

  ADDRCONF(NETDEV_CHANGE): <iface>: link becomes ready

When netns are being extensively used -- e.g. by re-creating netns' with
veth to discuss with each others for testing purposes like mptcp_join.sh
selftest does -- it generates a lot of messages like that: more than 700
when executing mptcp_join.sh with the latest version.

It looks like this message is not that helpful after all: maybe it can
be used as a sign to know if there is something wrong, e.g. if a device
is being regularly reconfigured by accident? But even then, there are
better ways to monitor and diagnose such issues.

When looking at commit 3c21edbd1137 ("[IPV6]: Defer IPv6 device
initialization until the link becomes ready.") which introduces this new
message, it seems it had been added to verify that the new feature was
working as expected. It could have then used a lower level than "info"
from the beginning but it was fine like that back then: 17 years ago.

It seems then OK today to simply lower its level, similar to commit
7c62b8dd5ca8 ("net/ipv6: lower the level of "link is not ready" messages")
and as suggested by Mat [1], Stephen and David [2].

Link: https://lore.kernel.org/mptcp/614e76ac-184e-c553-af72-084f792e60b0@kernel.org/T/ [1]
Link: https://lore.kernel.org/netdev/68035bad-b53e-91cb-0e4a-007f27d62b05@tessares.net/T/ [2]
Suggested-by: Mat Martineau <martineau@kernel.org>
Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
RFC to v1:
- Thanks to Stephen and David's feedback, this new version is smaller
  and simpler: only the level of the problematic message is changed, no
  more sysctl.
- Link to RFC: https://lore.kernel.org/r/20230601-net-next-skip_print_link_becomes_ready-v1-1-c13e64c14095@tessares.net
---
 net/ipv6/addrconf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3797917237d0..5479da08ef40 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3633,8 +3633,8 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
 				idev->if_flags |= IF_READY;
 			}
 
-			pr_info("ADDRCONF(NETDEV_CHANGE): %s: link becomes ready\n",
-				dev->name);
+			pr_debug("ADDRCONF(NETDEV_CHANGE): %s: link becomes ready\n",
+				 dev->name);
 
 			run_pending = 1;
 		}

---
base-commit: a395b8d1c7c3a074bfa83b9759a4a11901a295c5
change-id: 20230601-net-next-skip_print_link_becomes_ready-5bc2655daa24

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

