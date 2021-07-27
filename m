Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFF972
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 04:06:21 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id n10so14405830plf.4
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 21:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=po/Yc0BE1Ja6dZC68gtNP4l/1SdyZ1NMASv9dhFwyfY=;
        b=XWg6d+q/luHyqUDs8Ar6Iz/RuYTKZ5PzfQQSGy5IZyhVevDzLVP0mvpM/GM8CgLYm8
         wBok+dXw2Y93jN73VSiVG7EMJFaEqBDYwu3L5WWhslungLtfx7Sb2ActvpkB8g3Xlyyg
         7GSrkCLXXMObajf8k2/LXGlqHbQ5g07x6eH/ajq3j5oS1Z8L7g6xvjduHCVPun6HooMk
         BLPgIr+0j91vZTN3cf2rWK/yOvi4U/j6kODGSmgyiWuU76lE0NcRVFs2WyuCvxyCZHvC
         +hZrXM6BKYkt0R6cwlET2kmCh24Bb9z19XFLHfli2zkhyCT5DaxR2hBD0OT7EHLf2Kpz
         qnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=po/Yc0BE1Ja6dZC68gtNP4l/1SdyZ1NMASv9dhFwyfY=;
        b=AAXp+iCB9Di3+kkCHmU6W/T0S0KYTOKgewQE7W2yZW8hC2rw+1bMJMylHYTAhf2NC8
         YVWf284p8Kgja7LDeIzbekaTYgPZyoewlsjTMWYMYzOI+Tf6OU9JexlXmSQthmb6dent
         eimk24KLQFtHo9/yRB4WbfxaeWirGTv4chQ/9P5JQq+imTLwMAF5k5qcHRdE/ZeY3o8y
         uy3myRcDNEqajGb0rQ7+M6cZ+JFFEBn2TMs+gVWVLYVyvcuoUAzQysRdPUMN+4LHnvDh
         +lqqVbrjoaVbzyLF7zqWZvZT3FRe6FkLehD+Hv76BS9n2KTCOu8hqWOdsv3hFVBUd1kb
         9kGQ==
X-Gm-Message-State: AOAM530Yv9/aqsoGa0zzn4uPTNACVsT7F+9gzG9BVlHuvCCiZT2T4cT0
	JKvYYP0dnRmm4DoOZZba//YkOVZSmNrX+Q==
X-Google-Smtp-Source: ABdhPJwk6o55t8xBJDcp6a+M3Yhko4Xp4xdCkjdD08TuRQGMjJvJWPwHL6u0urF3qM5xgNSxkDvOLA==
X-Received: by 2002:a17:902:6b84:b029:ee:f966:1911 with SMTP id p4-20020a1709026b84b02900eef9661911mr17160752plk.69.1627358780643;
        Mon, 26 Jul 2021 21:06:20 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id h18sm805136pjv.21.2021.07.26.21.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 21:06:20 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: local addresses fullmesh v4"
Date: Tue, 27 Jul 2021 12:06:15 +0800
Message-Id: <8e259a61af93e5a2a66318c9515fd6f740d59c77.1627358725.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

pm.subflows needs to be updated in the non-fullmesh case too.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/pm_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 10f09a96952b..a8d7fb99a3dd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -581,6 +581,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		memset(&local, 0, sizeof(local));
 		local.addr.family = remote->family;
 
+		msk->pm.subflows++;
 		entries[i++] = local;
 	}
 
-- 
2.31.1

