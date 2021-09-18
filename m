Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5172
	for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 08:05:47 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id h17so38952652edj.6
        for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 01:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=393B17tFjI0wvdXC8Fbv7zukTxL+XgmJG2QQo8dRRrk=;
        b=UWPWdduS3B7aYUuYXYO4ZhtU06amldo0YtywLwXlvkOsLqgam5tYdwH8GgBclVfag1
         rm+VlJVZC2wf9erCZ5ng5nvk4vGUeUNjtlkGyjAtGHub2+K6xoQafU3dGS+1fGdo4hlR
         E59bLFr4WkNC0UYnOuCw+RfMumYGHyUMvYbYv/AiA5oZNHOpheYu7KJTrmuL8nMyua5t
         UxtWHy+dlZ7cjHPLyi+8giy9wp9DMZjgR2pTWpISO/SLXphbD7YHozC3z0g9W29CzgAp
         S5SzJqScwq82Ihd1C8rFlvZhiO9QerN0aoXaIAaMpEVKYR/xj23ap/JIJK8J/zUicRMf
         DnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=393B17tFjI0wvdXC8Fbv7zukTxL+XgmJG2QQo8dRRrk=;
        b=71YCqIFUN+Q+9bVR6fIZqrbLeZJdTshGh6RJecwfYl5LCTQ1ntvFeS+oU0pfmiDMmb
         iULPT27JcHWITas6IhPZ7tIL8ZhVe+Y4CHDIIKh8wEFLrjNzJItmnNOx3+KjCw246LJ9
         mkKAy/0eqxq2tmodi057s5LPQSCBpyQ5Ep5EVpjNGZAL5G7h/iQItJ+wJa/UONhcw0DX
         +rW21ebKW4lqGIorBW9eJfiVcMiEV+XqBjMNRIF+ohCF/JMAAnrnAyESn3iiaOctVwDj
         Rl6+Au3OmzThOlVCx5xCHd01XnqORJmfax0dAF9/9pStbJK727l21baayuRWrtCt+AI2
         mi0A==
X-Gm-Message-State: AOAM533IvKl1v2+yvwekgexalPerSEBl4c5q/2c1kdlaJSrWK6LOCC4T
	UbQ9znup40Tp1hw/aQ2YQsgtylOANGoV8KMsPgc=
X-Google-Smtp-Source: ABdhPJz1FTNK2QIE/747g15SJZ6c3FVeexV4xOGhrEsXaOJsZy0nGyBAJNtDBN3YO5dexsZlI9jwcw==
X-Received: by 2002:a17:906:180a:: with SMTP id v10mr17070930eje.112.1631952345735;
        Sat, 18 Sep 2021 01:05:45 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id mq25sm3245201ejc.71.2021.09.18.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 01:05:45 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next] Squash to "mptcp: don't return sockets in foreign netns"
Date: Sat, 18 Sep 2021 10:05:39 +0200
Message-Id: <20210918080539.2051616-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing doc for the new 'net' parameter.

'make W=1' returned this warning:

  net/mptcp/token.c:242: warning: Function parameter or member 'net' not described in 'mptcp_token_get_sock'

This caused the failure reported by Github Action job:

  https://github.com/multipath-tcp/mptcp_net-next/runs/3623640967?check_suite_focus=true

Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "mptcp: don't return sockets in foreign netns"

 net/mptcp/token.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 313a3e793e61..e581b341c5be 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -231,6 +231,7 @@ bool mptcp_token_exists(u32 token)
 
 /**
  * mptcp_token_get_sock - retrieve mptcp connection sock using its token
+ * @net: restrict to this namespace
  * @token: token of the mptcp connection to retrieve
  *
  * This function returns the mptcp connection structure with the given token.
-- 
2.32.0

