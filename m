Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630D9182C8
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 16:27:49 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-317c1845a07so871982f8f.2
        for <mptcp@lists.linux.dev>; Thu, 03 Aug 2023 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691080068; x=1691684868;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oivLDNLKkbgHfQKfV5yU0mJN6s95zYt0ChN5nVAL+kg=;
        b=iErEyWVcm5qD8UsitXkSDWAF0kha9IVb7gVXRvZ/wTty/v33XUnluYoS2Z9ksAtBds
         gen7aj3jFAW810VdGF+aigl979PWnjEBZQEvMGT9Z+04eeI8X69bhW03SsM/ZpMICc9g
         fISVYSz3Oj1EBkrrJLHlB49eklecv1fLYgCwVW828K4W42/y8CmVXlWQe5zZeUcqI6m3
         +ksucjVIEVkwVIR2mvTuM7LlMvNP+OXio3RrE6u0qMtMIYy7uc93vhAFF/oohiy6J9fn
         GXFYiejB707p9khJSjRJKas8Ks6Z1G9zlT/CIvl0T+1MJtp/oG7dBfPQbet54j0SvgMA
         1HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080068; x=1691684868;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oivLDNLKkbgHfQKfV5yU0mJN6s95zYt0ChN5nVAL+kg=;
        b=Y4aVpfHg2th9OvOuKaLhtFgeNdVQt4bQVFRWk4W5LOodFsb8KaCzUQFabEzA3bHf3d
         OPg5ndyX5QjmnUUDe3LM4Girhj3jY5QzEErFGnMCDKbKpkEA7tO6KDcpl8JclZzN97p7
         qAQeelviLCoKzknnzGVZyKEVDUDMfs3qrwuig26nlaUmtJmnv+Ih8sbCSVkNgONqnVYJ
         X9f7ZzaBXmJMkRVSDdg2F2u9x3cb+/MjRQcSIPUgvU7FWjBLULonV+ns4XYpYr8kXI/S
         SKmB21Iu4jyfrrYTTSZS4ooOQFeA9wwA38y6TtTqWHZJaFE5yvwtGnjOfMrlc6UZMs7V
         waEQ==
X-Gm-Message-State: ABy/qLb3k0JMyBvNxQu6kM7ozjHpRpL3NsWH8kXWPSkPn+RU5zC/mXOD
	R1LwgMSoUPmX4zdwAhcSspSUsQ==
X-Google-Smtp-Source: APBJJlGiRMsmYRdqHCoU9ATM7nk/5tBK6TRxPWlfPRz0TrDPQ/mGmPFDHXr42BSQVKQLr8hpCIFfgA==
X-Received: by 2002:a5d:4c8d:0:b0:317:51ff:c249 with SMTP id z13-20020a5d4c8d000000b0031751ffc249mr7649766wrs.13.1691080067890;
        Thu, 03 Aug 2023 09:27:47 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b003141a3c4353sm253167wrs.30.2023.08.03.09.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:27:47 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net 0/4] mptcp: more fixes for v6.5
Date: Thu, 03 Aug 2023 18:27:26 +0200
Message-Id: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG7Vy2QC/z2MSw6DMAwFr4K8xlLKx616FcQiBEO9IEVxqCoh7
 o7FguW8p5kdlJOwwrvYIfFPVL7R4FEWED4+zowyGkPlqtq9XI3bqjmxXzByxntdRANO8mdFwhb
 JNRQo+GczEFhqTXydVurAROiP4wQmfvYXewAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Geliang Tang <geliang.tang@suse.com>
Cc: Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=hgCwEKZgy/8nY7p2tutm9i8Gq8mlRZAT01grbY/3qkY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBky9WCazqpy0eFdeJz/pfyJ9oT+4Y4qjuQQMuHU
 YsGuqL+9YGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMvVggAKCRD2t4JPQmmg
 c4tpEACMT/28Wn9oxoeqlckZ63o6dknucVWGKpYJfLf4KZFUEjwqVBxmJanigxdgq9DmJ1M3gtd
 ustvow4UL+TaqKrnvnj7Gan1MepJpoo2V8gI3YYIPUeW+lyf3CNwdlVl/5YMkk86Hqs+1uVqCGr
 7bPAU0WyCLVdZcFwqoNKWac68WKTLEESOjWN8jb3RSz9yjrqTnpz9JcrZMI5wqbm9ttg3JcYmlU
 E3UPkEVI10F34ybTjGlyGq5JrZI0tqQwvK9WqgECsDD5qYG/rlgVyeH7oYY0e7uzaFdyk94iPcx
 LZJb0T0gVqZoXExoz6QGVmg5EqACV8lYOTwmbI6/KGADcbMh/dJF4lj7ZmmNwXrbUzM2ifOwvVa
 5bGc7N4eIYMwLjAkPnXW0dnWMvIR4XVjo6Pbymvh0S1y4y0npMSAGAKTu8sJ9vA3D6vd2xGjc58
 aRR5MNjy8XOT3H1gjy31HsRuF4LUfG+/au7kzZJHqSofmYXfcQNKkBf/n4qKHYQnlQ/GojCFMjZ
 0xhD5xemaPvg+0JqNaVr/PkDe4Zot2MWQNMKIjJdXSqsY8Ix1hPwM4uHXM5ZMcO20HkEeZkP2bd
 HWovI9sanLv4VE/Qp+MYunVPqgMvwieY3An9iKGQJJRgVbs/pwxY1Gt1eiCBqUrKD15k496BBit
 DMQVKnLYAJPz4EQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is a new batch of fixes related to MPTCP for v6.5 and older.

Patches 1 and 2 fix issues with MPTCP Join selftest when manually
launched with '-i' parameter to use 'ip mptcp' tool instead of the
dedicated one (pm_nl_ctl). The issues have been there since v5.18.

Thank you Andrea for your first contributions to MPTCP code in the
upstream kernel!

Patch 3 avoids corrupting the data stream when trying to reset
connections that have fallen back to TCP. This can happen from v6.1.

Patch 4 fixes a race when doing a disconnect() and an accept() in
parallel on a listener socket. The issue only happens in rare cases if
the user is really unlucky since a fix that landed in v6.3 but
backported up to v6.1.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Andrea Claudi (2):
      selftests: mptcp: join: fix 'delete and re-add' test
      selftests: mptcp: join: fix 'implicit EP' test

Paolo Abeni (2):
      mptcp: avoid bogus reset on fallback close
      mptcp: fix disconnect vs accept race

 net/mptcp/protocol.c                            |  2 +-
 net/mptcp/protocol.h                            |  1 -
 net/mptcp/subflow.c                             | 60 ++++++++++++-------------
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  6 ++-
 4 files changed, 35 insertions(+), 34 deletions(-)
---
base-commit: 0f71c9caf26726efea674646f566984e735cc3b9
change-id: 20230803-upstream-net-20230803-misc-fixes-6-5-6046c6ca74b6

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

