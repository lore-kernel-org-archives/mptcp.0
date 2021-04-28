Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7242F80
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 15:48:53 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so7144259pjz.0
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tA5FkjFow1OVyRQX6e3K4Lj7EhUbIJjoSiQrtZA4QRY=;
        b=KKFZooJru5IysnDeNI8ONSBRNrX47HEWOuvNv42MXzcREKqZVCLiQEbdNHPIKTtVai
         w4QA3lGqvhHS8kZbtCYFuXbwEF5uI8wkwAOZ4Hw4/wHmQfWdLSoqgmiNSbXkp3OAPNyt
         Sa+tDC8hBuUXnNHDWYmHTdHhFGgeQfPss7RBsIgXD/ImFgSr/C7pbQMpfPo0wxn9rGUz
         UiIsny5QRKiuLmjRISlufQv1dP8RKqrnl9qS0ZBZH6t9RdOq7lMogAsFzwYOoNLr/vIk
         nzewTVcOnWhV5/0aVx7VNtk5iD3j/uREEMRnRMSZSkphkcDBldBQ/9YEfn4sDU9HI348
         LspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tA5FkjFow1OVyRQX6e3K4Lj7EhUbIJjoSiQrtZA4QRY=;
        b=RzNyBO5ZMSDb28pgBVANLZvfA7ju1mC2NE9Agu+CsHUYap7XWnT/mmfXZnl/iFvcbA
         9xbPKuJku4iJuHatusuHLO819G4X2q8fZzLHKC4GyxSO7ni8khU6rSW1i8FmmbWM3QIH
         977L5fDBXaiDfFzGJX1AmEqeenxdtHAZhh64Cjep4hUD99BD4qHk1k2TgkLGLmeOKJcH
         XMUMGYfhvgQYcVIyhlDrDK55hsjaO8hoYB7380c2yU4uM9ssUxAB4fzGB6vrtcant+oT
         WgeZ+DeTFaARn1V9v+TMd6SgLudMN63G/N0CJeCIcHhNPA97Zx1wV1VOb+KQ9h2JU396
         0dJw==
X-Gm-Message-State: AOAM533wInoTMh5g545R6DPdOeviHN0kh4LMuETYKj50mzPsmGWqKfJP
	joanr7jJhRTURv0N0ameQjbTGERAltY=
X-Google-Smtp-Source: ABdhPJzeO+HwCnhZsDEPGSJJ0aVZZ2mBABBgBKwYlHfBxTKbxIZxL/57eqNRW2iJWq/EPZPUqrKlSg==
X-Received: by 2002:a17:902:854c:b029:ec:f7a9:9feb with SMTP id d12-20020a170902854cb02900ecf7a99febmr23750488plo.59.1619624932752;
        Wed, 28 Apr 2021 08:48:52 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id j189sm153146pfd.21.2021.04.28.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 08:48:52 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] Squash to "mptcp: add sysctl allow_join_initial_addr_port"
Date: Wed, 28 Apr 2021 23:48:50 +0800
Message-Id: <236391c475f7b8a1a7c4bb3127eae379fb89b82e.1619624900.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use BOOLEAN instead of INTEGER.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 Documentation/networking/mptcp-sysctl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 6c67ea3d0b7f..e2921346e2fc 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -25,7 +25,7 @@ add_addr_timeout - INTEGER (seconds)
 
 	Default: 120
 
-allow_join_initial_addr_port - INTEGER
+allow_join_initial_addr_port - BOOLEAN
 	Allow peers to send join requests to the IP address and port number used
 	by the initial subflow if the value is 1. This controls a flag that is
 	sent to the peer at connection time, and whether such join requests are
-- 
2.30.2

