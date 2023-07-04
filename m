Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF688F4A
	for <mptcp@lists.linux.dev>; Tue,  4 Jul 2023 20:45:01 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fba5a8af2cso62458495e9.3
        for <mptcp@lists.linux.dev>; Tue, 04 Jul 2023 13:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688503500; x=1691095500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROcm8QJ2e+dw2mPUFtaabOQUsfDn8kGV7/rCi5TCOvQ=;
        b=RXvVmuhsDZnZPpwiu+8sgP1Z4rjkv5PUtifD8CbgpYHIFevYuO/0HWUzj5MOT1Z8Gb
         yA5An4BtaNxyCJhTvnjGPWlPv7KTXVNpNzJ3+oVGqIxudC07J8gTR5C3QZtwnmRlCTlS
         dNz3k+2x6Oznew7ut+gvW+3AegcKbqgKRGeP6tv4hcjHIYNsiQTM/GXymOEJkU6kHr7d
         zu/dVEQ/tFJe6zyHPrm9sUZiCWCVQUbai4ZUtUlDiw6j7b4FcSDPtZOlzEq8n0tMEsF0
         SwPTNr98/byVmNUN5ONh+JK12PBgOzlgQV5kFdpa9zLXEDPzlFcVlwDiKcxJLxcyqHWo
         9NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688503500; x=1691095500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROcm8QJ2e+dw2mPUFtaabOQUsfDn8kGV7/rCi5TCOvQ=;
        b=aLs8CxT04O95mWkwyfs0C3H2d44J8zCi6TnFqtkABVnJeAkqlyhoGBotVQtDldGySG
         AQKiCz3+T6hKd6oeMR7n80knadQTB8aZr7VJwESzLzEKxGsUk7ELJpNVFewjeZaWxrUS
         wvd/3NdTuqeraHwFdPNLerOELHhMhuuII7BSztNsHYWAdr9RQrMfA6/iTJnLvCOa30bt
         yQE5IXMjRpcYBLhDl5/VgT5l21qyY3zTDbwXlqHbgE3e/BcQZepGgdRkwyd29kDyjVD/
         bST57fjt2sDR6Ng691cSjLFXVNNbfOabWRnijTvBC1gIm6RUwcJLJ1ub7yx4X1PqlemJ
         aM4g==
X-Gm-Message-State: ABy/qLaYM7h18YVXC/CnvBHIdAYQJQjxaD/p3mND1L+a0pZItd8R7SlJ
	tjvQP6UW98gAKv70PXQF93J2ZQ==
X-Google-Smtp-Source: APBJJlG/nJc3egHBVdE270fFoANsowlrZ6/nWxZkrl6x4oF6e4+pTuslUewPXYXwbG8eM8GO9As4EQ==
X-Received: by 2002:a5d:480d:0:b0:314:8d:7eb1 with SMTP id l13-20020a5d480d000000b00314008d7eb1mr11702617wrq.55.1688503500155;
        Tue, 04 Jul 2023 13:45:00 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003fa74bff02asm115332wmq.26.2023.07.04.13.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:44:59 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 04 Jul 2023 22:44:40 +0200
Subject: [PATCH net 8/9] selftests: mptcp: depend on SYN_COOKIES
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-8-d7e67c274ca5@tessares.net>
References: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
In-Reply-To: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=EmNPJqgedCM0JNAMFB2CH3QLw/R4hnbppjcIxXQiOd0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpITDD9VsgHS631Mvg0Gm+DYm5N4cq2S06n/cu
 7lo5VVo7N+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKSEwwAKCRD2t4JPQmmg
 c5ssD/9ug9mjKUFx87+QQFRsGILERM5pYGq9FgcGvawy+S/qYQcdSyuUjy/Bf0BjpZtIMG1cjCh
 udd+w6aMhI13stY5ti0O7bO4SU4yBoKJzsLD7/MlE+rojIp2mjpRnVX2FqzxkElHLIIc3cPBAIL
 iA5pHVhR+QDTL8vk1vdZA96NOk6kZOlbQTREOpeXwlcypCZcKSmgyp4nDt0CqZk0ca2GkUzJaUi
 1iqnJc47Ywyoyg/hDfWeuDf8WeYMJtOw7sUWd/XSm4WcFdUf2JVlfkScsrGU/sPtshPl7gXVOZ6
 Ws8fSNzU9htvR2TvL9lIy6iij53mL50PwTfR32MDhdZaV1WDdJGEFKwUup8iMVUchY6DNx7Tra1
 ppSHXre1rWKLFLd5eQyHOEIHrUDw0jOEwLHFIGy0XWvpDdD61DIuUkKB0pdw7/0hN/AlsWbQACy
 f9DL2sQgu3pwTekFzgqi3EDANjoiUZWs1u+jO7cBgJHQTBMRxD0Vv7IdlEfaa+lMqGWCt/odjU4
 zObewUPkezH6z+Dd2J/Tha9I6nTJ2fx1xQQFzDFUsIlh4F+CkZvoF4YzglCBuX8FM/GT74lAxaV
 uK7BcdRTDBNNcM6TrhpjIfzDYqW/VFfrDYJLSeE6QtZ5F2mwjY5kb2aKRMOp3KVouNIqwbjgLIg
 BsrhvQ/iyWnFB0g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

MPTCP selftests are using TCP SYN Cookies for quite a while now, since
v5.9.

Some CIs don't have this config option enabled and this is causing
issues in the tests:

  # ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP     (duration   167ms) sysctl: cannot stat /proc/sys/net/ipv4/tcp_syncookies: No such file or directory
  # [ OK ]./mptcp_connect.sh: line 554: [: -eq: unary operator expected

There is no impact in the results but the test is not doing what it is
supposed to do.

Fixes: fed61c4b584c ("selftests: mptcp: make 2nd net namespace use tcp syn cookies unconditionally")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 6032f9b23c4c..e317c2e44dae 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -6,6 +6,7 @@ CONFIG_INET_DIAG=m
 CONFIG_INET_MPTCP_DIAG=m
 CONFIG_VETH=y
 CONFIG_NET_SCH_NETEM=m
+CONFIG_SYN_COOKIES=y
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_NETLINK=m

-- 
2.40.1

