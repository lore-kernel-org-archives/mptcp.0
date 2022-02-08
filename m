Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45702F26
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 09:10:36 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso1113784wme.1
        for <mptcp@lists.linux.dev>; Tue, 08 Feb 2022 01:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VJY/s0Ymy2GvPYWmhVYqLgy8IdGkR/Hi9JaHk7vDvZw=;
        b=Zm/WdaoVimz/0PmQrjVI5RlXTYXTICxDNFur+4gkc03/OjjCzERbyefZocDoGMxnbF
         YqCRY0MM950SHUlcmShs2lujDR7jWbdN3Uea1F+9F4+9qFMSzncHh5gkrpBL/V8Tfmvz
         femkkCpZqwtxOLGUteOL+xEi179k3xshe5DyZrb1ELLWI56vUG0CMsEoJ8KNNhMfom3Y
         4JGbKrK9FsUGpcMoDLTwnf+v+cznRlflglkCNrNXAO2CGOkM8WDrBL/na3edxIg/IwvH
         xKTJdF8a2VfklbE6plLpv8yewTYjI0/CIaDvPLk9DS8t36o6aKCHOtx1BsSKKGLkeARP
         HOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VJY/s0Ymy2GvPYWmhVYqLgy8IdGkR/Hi9JaHk7vDvZw=;
        b=onqud1hKgXlVRmujVgM7yyqm2U2JCiSwILyA9fegwdMMiiklc6Knn15qboeqfazCCh
         0vzgIrg8cm8WtliwbF8XvJWHnUowuRF+SomEco69Ngao1hCH0m5eLd+BLNMpWIWl9Nik
         C7XVoNFx6xw+sbOF6IF1ErmuemhO6hBZzJ0Vw4Fkysi/4qAtvEppITY1oeyKvkAAItuW
         QtSXQQTMhpTYLCXQXunouTfssM28INQUpQ9JTQdmD3486R+GfFE7fSyWfUHh4l54bOX7
         emJrB9Zs59cu0+f0iLKyGBbVlAIZdRiWjUpfHtcschkZ4RxjbJacXGJeetXVsRetoovp
         t8XA==
X-Gm-Message-State: AOAM53158SEpxtmYmyonDW/KkWWVK1ljN231EqupnJ063hCNqbkPbq8b
	0o306W5YJDSCYsZcIENbpt6KYmjVu0Ztn9XrbGE=
X-Google-Smtp-Source: ABdhPJzDzbX2dgHWIHWKfncsRNOiIT2YOrHl+nl6ZR60DcTruvxrAh7e5FYWS0nRQxA0VubjQpOjmA==
X-Received: by 2002:a05:600c:4e16:: with SMTP id b22mr235178wmq.31.1644311434520;
        Tue, 08 Feb 2022 01:10:34 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id a15sm1100237wri.22.2022.02.08.01.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 01:10:34 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2] selftests: mptcp: increase timeout to 20 minutes
Date: Tue,  8 Feb 2022 10:10:13 +0100
Message-Id: <20220208091013.749627-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the increase number of tests, one CI instance, using a debug kernel
config and not recent hardware, takes around 10 minutes to execute the
slowest MPTCP test: mptcp_join.sh.

Even if most CIs don't take that long to execute these tests --
typically max 10 minutes to run all selftests -- it will helpi some of
them if the timeout is increased.

The timeout could be disabled but it is always good to have an extra
safeguard, just in case.

Please note that on slow public CIs with kernel debug settings, it has
been observed it can easily take up to 45 minutes to execute all tests
in this very slow environment with other jobs running in parallel.
The slowest test, mptcp_join.sh takes ~30 minutes in this case.

In such environments, the selftests timeout set in the 'settings' file
is disabled because this environment is known as being exceptionnaly
slow. It has been decided not to take such exceptional environments into
account and set the timeout to 20min.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    On my CI at Tessares, another machine is now used with a different host
    kernel. mptcp_join.sh selftest is now regularly taking more than 10
    minutes when testing with a debug kernel.

    v2:
     - from 1h to 20 min (Mat) and adapt the commit message to explain why
       this don't cover all cases that have been observed.

 tools/testing/selftests/net/mptcp/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/settings b/tools/testing/selftests/net/mptcp/settings
index a62d2fa1275c..79b65bdf05db 100644
--- a/tools/testing/selftests/net/mptcp/settings
+++ b/tools/testing/selftests/net/mptcp/settings
@@ -1 +1 @@
-timeout=600
+timeout=1200
-- 
2.34.1

