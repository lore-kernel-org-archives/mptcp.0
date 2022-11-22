Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C487EA8
	for <mptcp@lists.linux.dev>; Tue, 22 Nov 2022 03:51:27 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id d192so13242296pfd.0
        for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 19:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddvDW/MDUtgM+qsmGJtiTql+jw6vfIq1S7pyop6Cv2k=;
        b=OZLE+ZYJegoTvyjsPlGfv/KHH7144dl/v2J6pgfgO3R3zk86KeT7ESSob/8R6kh3E9
         s9jIkEDv3VJT6N41qfng8fNCb0zYQu3TZ05hRX8VAbKn8Xmvipf0E3d+LoKqYrIO2T52
         tYxKAiknXOyAk001BeOl3//qqi2XJ+7yd5pfSCR8QQtC5ZSZAE2QCUT6Uh4qHTAGPAXT
         uhvxO6gSkVXDRWR4/rwQqmLdH/QeGzL88LZadaMSIO3FmKFqHUeMj1wXt5V4uIdlhZl7
         ka2HYHyiXcsy+bzElE5Fraqi8YPzIJXja27vK/f7++XDXCNOAID26L6Ch2SRqugd2ge/
         Ishw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddvDW/MDUtgM+qsmGJtiTql+jw6vfIq1S7pyop6Cv2k=;
        b=3KC76ybxRz5bkY9XAmtjbGqZUbnGU5CzwVfrULxglk1y9BXbY1C9/dkmwM6aWhDDk9
         dBc4IuX4S7LesQ4aik0+3FgYzv1N6CPYTYmucNOUVtPptgO90uBCVVPuVqlKFMD4KW9l
         zd2hB+343Zbi1FbdY9vtpHW4ZrP9d4JfHoKgAXm19neIQGkfm4XBCP157XK/ErNbRaWS
         fIlCJvMnLFZBA6wiePnFhzaRtMKQfmuyFKeqzK46+VBh2XfJIFBJMmoSf/P2LYr4lfVF
         ntGBE8wizeC2/Wqvz16p2OnLxu52JAdxshlp8Vy90o0Httx8DWOMNPa18stjWNTFAl5i
         ObOA==
X-Gm-Message-State: ANoB5pkvzOsOHTfRahpSY7tHJNMHtoJpekhrLOlZnjIbsBCgv2graunT
	gVbiBmpYEVX3RBNPDrBvuNoBSATThVgMDUQ0
X-Google-Smtp-Source: AA0mqf7Ut+5MgOdEqCiLGM1S0Ji9DhX3sYaDnP6X1t+ggiphU9+Ogmiw+f17uDVzPGh7uamilqMTwg==
X-Received: by 2002:a63:2043:0:b0:477:5e25:4ca8 with SMTP id r3-20020a632043000000b004775e254ca8mr5067885pgm.511.1669089086758;
        Mon, 21 Nov 2022 19:51:26 -0800 (PST)
Received: from localhost.localdomain ([162.14.78.182])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902ec8b00b001869d71228bsm10707220plg.170.2022.11.21.19.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:51:26 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v7 3/4] selftest: mptcp: exit from copyfd_io_poll() when receive SIGUSR1
Date: Tue, 22 Nov 2022 11:49:22 +0800
Message-Id: <20221122034923.804955-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122034923.804955-1-imagedong@tencent.com>
References: <20221122034923.804955-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

For now, mptcp_connect won't exit after receiving the 'SIGUSR1' signal
if '-r' is set. Fix this by skipping poll and sleep in copyfd_io_poll()
if 'quit' is set.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index e54653ea2ed4..518c6d653c0e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -586,7 +586,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 		char rbuf[8192];
 		ssize_t len;
 
-		if (fds.events == 0)
+		if (fds.events == 0 || quit)
 			break;
 
 		switch (poll(&fds, 1, poll_timeout)) {
@@ -692,7 +692,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 	}
 
 	/* leave some time for late join/announce */
-	if (cfg_remove)
+	if (cfg_remove && !quit)
 		usleep(cfg_wait);
 
 	return 0;
-- 
2.37.2

