Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4925187C
	for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 13:18:29 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id m2so15682028wrh.6
        for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680095907;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KALfhiBcHvAMy0ehu6CWvsYPaDO4LCFJfgZBSfAH/M8=;
        b=o+WZ09Edfqra4o32BmgTWDYli9EWYn64CjPIRoFQw5pPaWNYcXWPDHjSA9E2B2SksT
         5g5Lr4Bn0huksn5PbSyHMvFnV7uuvpiHySwktKqvWWjKkx/oTQGEnuz7iQbySZ+Fk1CX
         JbKjc7yHRJpLbi5VAt7C8QmEkeiKBEulwmGAZNhTwZDAPUN7ATNulxp/JUTBM373qx/B
         lvsZQWedx3uziHjc9hGzCet2FR970IoTxFxd/7oGFaKU81oC40Mw2C96sw4mBAdUL8sH
         AXzCWbTM2clAyoEP4JnrSMSOStjw5WokIXapVWp6bLkWvy7cHXjAxlmQUrqz8ZarQKVc
         y3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680095907;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KALfhiBcHvAMy0ehu6CWvsYPaDO4LCFJfgZBSfAH/M8=;
        b=VUREOtteZmz3dvAMCCeuaFBXUWidV8i+NPdoEGpgpzDldXKYTL4WxC29vbPTv1A8JZ
         J2CQ63YjzJSq2MaNCbc5wu1a3QkCpQVcjfdthWoxh2NyK5bnaXx7SF6E9vdMIddjUSuN
         iQB0xjyWYbhFh80SOWetwViB1zjKQkl65kC+oIRBqUq8rl2HlL5cqnsa+J/Grpy1MDE1
         a461lWS/egzfN2tJRdcaLbMoqmMEGRTg95+TU46eoHWE+gbAnW1yTzfkU+PVfjp8wap4
         JOBmhgWrtMNiFnOVqX5YfzrZdPPILmIcMGN+/3IKBHTy51DN3cVffugAvJSakxxqdkLQ
         aCqw==
X-Gm-Message-State: AAQBX9c1iMWzf/cyb4tYmWG1GQe5hzw0Dszr00uMXBqC3rkRYlCJJBtH
	6pqc9896XpKlNnXMPH6g6HJqlQ==
X-Google-Smtp-Source: AKy350Zcnv/SzCbrnGySej51gMfkPXMzzYsbXoRU2d4xOYP/kVwLUYStlDd64gbJ8UXRRm8SFmI5Fw==
X-Received: by 2002:adf:ec0e:0:b0:2cf:ee28:5024 with SMTP id x14-20020adfec0e000000b002cfee285024mr14846283wrn.42.1680095907675;
        Wed, 29 Mar 2023 06:18:27 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020a056000120d00b002d7a75a2c20sm22933678wrx.80.2023.03.29.06.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:18:27 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 0/3] mptcp: misc. small cleanups
Date: Wed, 29 Mar 2023 15:17:55 +0200
Message-Id: <20230329-mptcp-misc-cleanups-v1-0-a839001f0b05@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIM6JGQC/yWNSw7CMAxEr1J5jUWS8itXQSySYKglEiI7oEpV7
 04Ky6eZNzODkjApnLsZhD6s/MoN7KaDOPr8IORbY3DG9aZ3A6ZSY8HEGjE+yed3URzMcb+jcLI
 Ha6CZwSthEJ/juLp120pVyKc1LEJ3nn6XF/ivZZoqXJflC3pzHdGOAAAA
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Abaci Robot <abaci@linux.alibaba.com>, Mat Martineau <martineau@kernel.org>, 
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=838;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=pFyNtbCa91e3xA8KC7byNiQ/srUXMmO+QLVWEhoue5Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkJDqiWCJQSEuZelk28lgZlWWV+UhhQcCY98Okg
 R4438Af+7WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCQ6ogAKCRD2t4JPQmmg
 c6QTD/42b/7sBb1xd5BXord4L8Jrxk0GL3t1xzbJatBmbrrLah2nP1aIsMGaGFa6XjkR/9Xi1UC
 POsuZfJUvO7bJXINGTGDbqlMs4CaiXCOnjkT+6INTGE8Wn0zbaIhlZQOyjWognxmKTtyld2fk5+
 6PWF4Oe9yaDNl6tZKpALRd+0UkB3yK+vx7i6YViZhzSAnH11BUQaMaV7y4XWiW6aisq4Rq6lon/
 mev/NbjTSS0TrCYeGjzxZkJ6vB049F9FvigoXrWf1uCt9JwExoWDVzo4mPQ0+ikI9JfewPs2quG
 zsDcewy25/8CaDoR1BgCh4D4UMmsw1iQDEtm+4oK/CkEhjxEdjScl8YmLY0dhp4le0X3zDDPETH
 VUHKu8NUQD4Z3/QKVbY5wdk+OzRSnRrGCBMteng1h8QtY+G0XoOc40iBtXWfNZUrLPaVJGVYule
 TJwEHfpJ4ykkF1RfqKjOu5RpbQm/k1T8uaTMwz9f3j2PiZjJ1Ob8fnYkAOJ8kqAMecpHWHAUzUc
 OvFdYrOyxRit6oE33O7jGaHOkmrRH6MrlP45U1kd4i4RG8mgOjJJ1bNNgjWJOnOxtaB8dVmb/GS
 ffOKAdyBs5iyNV1+8jtVNdSSVFB7VN1Xj0UX41LN0YLKCzW5NS59AP6DS/Pa8KWFRg0Dt3PU+Gw
 EOhMMuf3Bv75O/Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is a series of small unrelated cleanups, nothing very important nor
big.

I don't know if the modification of the MAINTAINERS file should go in
-net instead.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (3):
      MAINTAINERS: add git trees for MPTCP
      mptcp: remove unused 'remaining' variable
      selftests: mptcp: remove duplicated entries in usage

 MAINTAINERS                                       | 2 ++
 net/mptcp/options.c                               | 7 ++-----
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 ++++----
 3 files changed, 8 insertions(+), 9 deletions(-)
---
base-commit: b2c5489c86ee1881dae3bc431ff6f284eb74f7ef
change-id: 20230329-mptcp-misc-cleanups-90754eb81610

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

