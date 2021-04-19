Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC12F81
	for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 20:34:30 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id w23so39151822ejb.9
        for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 13:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNj4V6i8oXz9wd2fzjKRKjlHasp3Jv0jenSciEK/LCk=;
        b=i+Am/lD05E7ym5Z9wfqdUpDWNjiXSae7myWqcMdq3LURutMTz5uBe9TOtKhLUfAcct
         acpCWrZMoPRe+0JbhCxnFJZzT9p2VTFPP7olhkDDBwcX5F2KevOot4a2pmHr70ux5zEm
         U3nKZPE4/SxIQ00h33PW6o1my9zitR0HYgHPfrfxNJwCRTnaw+bkw/2Bm5E62pUDB/D5
         N3mf9yZrd52d0cATU8WMnHIdqAPl7Odf2Kiclqe9qEQN6o8BeceZ4xkm/YKn+OHF9krQ
         GMwkzaJLcGz728Levyu6/tSYlJqUAXvfxYPU28sXVc+EZ+mzvJYtpakqg0U5EKwZolLo
         ZZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNj4V6i8oXz9wd2fzjKRKjlHasp3Jv0jenSciEK/LCk=;
        b=sgcew8atG6HF5nng39r6XeynKifuctLMspk6caqouQTb787P56ozFMCra+CtN7t4iL
         jsJ/bAA9lAnXkNuAGNPDTQ0tV4n+IhWGZN640nJZoyf8jazqaWRXxcZeOpfaqOBt4z2j
         U5l6VpoDjplzogxTnOUmLBuazZ9+5ub0NxTAx+hZDmkcI2ggp0Tj9to+s+COUqQtfAIC
         VPLHt7yq/nhdrQlcxLzHUcDa3tLI92upuDb5tXBxIuPVtB8R+rSU7RErBvnrMohenfvL
         4cVm5sMBNy7/bhjxPd5OFZdo+th6vpV1KW3WQy5oUcne8lPdn6ATvqYytVMTCzIKURQj
         sKcw==
X-Gm-Message-State: AOAM531ckOQ3QNMumMN2WwJkq60lV5SmDXGuPOcIOyBv5Nwizrz970g3
	SOUu9yo1HVyrzHLwA1Hm4qKbumgP96b2O8KsRHw=
X-Google-Smtp-Source: ABdhPJzxyQV4EbdW/Pd5qDUmykVLUOMoNN+MtP6zJeuoaV2/qUsj2bLO0QAObapyKjymv7s0lhnSOA==
X-Received: by 2002:a17:906:b7c4:: with SMTP id fy4mr23645815ejb.489.1618864468733;
        Mon, 19 Apr 2021 13:34:28 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id e16sm13941867edu.94.2021.04.19.13.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 13:34:28 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 1/3] selftests: mptcp: use 2 different 'peek' modes
Date: Mon, 19 Apr 2021 22:33:53 +0200
Message-Id: <20210419203355.3937162-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419203355.3937162-1-matthieu.baerts@tessares.net>
References: <20210419203355.3937162-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When refactoring the code around (see next patches), I noticed the same
'peek mode' was used twice.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 319d1662f4fb..28530f1bd285 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -740,7 +740,7 @@ done
 
 testpeek=true
 options_log=true
-peekmode="saveAfterPeek"
+peekmode="saveWithPeek"
 run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
 run_tests_lo "$ns1" $sender dead:beef:1::1 1
 
-- 
2.30.2

