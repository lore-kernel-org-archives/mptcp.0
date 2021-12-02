Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED15F2C9D
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 17:32:37 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id i12so344244wmq.4
        for <mptcp@lists.linux.dev>; Thu, 02 Dec 2021 09:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fC/kt59qQj/B59dQLWBjUn2IOeYjPexxlfgQm4tbvcI=;
        b=nizMsLlbiugrsaByty+Shs67e/7b4El1N+0f3moTe6zz9OjRq9EWPYP3nDWFPdNIA9
         q7oHOXNjuVZ3GBYOX8VgoUlP1ok1o/p3vaVyx7nJSFmu1rheS2l/qBkt1s5pAriUsV50
         1f6M/f/slzAAZgISYSIfIFYyjWT1VPlahOBpeLW40npYwMoqbPDI/L/l1dnG9LsTnncv
         GhBRZZtGonML1jVqNa4fAH88ha9ZNq7+qEG17GoUcfYy8NVjh75yXeaS0Iq+zQOba8h6
         gWmgF8Flaqx/W/69EJIngIuiL1Pv0jS1M7wM+Zfa+wA0w4E4PLwopg2mcec4EAD7oYvU
         D10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fC/kt59qQj/B59dQLWBjUn2IOeYjPexxlfgQm4tbvcI=;
        b=PaXbFkVEKubaz6uaEWTjNUL91nPhwB0u+OKCkMjvX8GCI1Etm5QRy5Q0BQSNC5khb6
         RTxw+ksbLlzd37YTrne3JK504sFdMgPNMyF9It0yu1hqKBUXOfqUvGlr/BttBahZLy3e
         OSqg17mFaQ2y/5cbz5y5/mOe3TnfZFRroiTEPF8HC67qNvTgHzSxWCQhrqcK/IrYDNbn
         JPc+P3DxwL5gIusfVxqAPHFRAVt31b0DlaZv4vIAEPZ4JbKnmytYQcq2AIVF0rH01RQb
         bR8NXo8HxO1esW104VLjeYonym0lNDx+19hMcdE0Auf+nOy1XUO1jLmiOeXMlfVCvprF
         2ukA==
X-Gm-Message-State: AOAM531zgDC9HzGRskqX64PoijV0DbFF8gAnRCzPVMImLVVlDg/EeYLp
	RaZn524dkZ4olfX6Xv8ATCtNDijaTozMB6jU
X-Google-Smtp-Source: ABdhPJximwou6pALld76bjwf9S4kpgm9R/sru6w+EC5F1LVQfHff8D6KphjScIA8RlBxBzCC4yg6GQ==
X-Received: by 2002:a05:600c:2f10:: with SMTP id r16mr8124463wmn.141.1638466356116;
        Thu, 02 Dec 2021 09:32:36 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id v15sm417649wro.35.2021.12.02.09.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:32:35 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 2/2] Squash to "selftests: mptcp: add inq test case"
Date: Thu,  2 Dec 2021 18:32:16 +0100
Message-Id: <20211202173216.2982478-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211202173216.2982478-1-matthieu.baerts@tessares.net>
References: <20211202173216.2982478-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixing a -Wunused-result error:

  $ make -C tools/testing/selftests/net/mptcp
  (...)
  $ gcc -Wall -Wl,--no-as-needed -O2 -g  -I../../../../../usr/include     mptcp_inq.c  -o tools/testing/selftests/net/mptcp/mptcp_inq
  mptcp_inq.c: In function 'connect_one_server':
  mptcp_inq.c:303:2: warning: ignoring return value of 'write', declared with attribute warn_unused_result [-Wunused-result]
    303 |  write(fd, buf, 1);
        |  ^~~~~~~~~~~~~~~~~

It seems adding "(void)" is not enough. As a workaround, we can also
simply the output of 'write()'.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: add inq test case"

 tools/testing/selftests/net/mptcp/mptcp_inq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 07670f649327..b8debd4fb5ed 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -300,7 +300,8 @@ static void connect_one_server(int fd, int unixfd)
 
 	wait_for_ack(fd, 5000, sent);
 
-	write(fd, buf, 1);
+	ret = write(fd, buf, 1);
+	assert(ret == 1);
 	close(fd);
 	ret = write(unixfd, "closed", 6);
 	assert(ret == 6);
-- 
2.32.0

