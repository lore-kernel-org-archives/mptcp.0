Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0912B95
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 10:53:56 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-31aeef88a55so2575504f8f.2
        for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694861635; x=1695466435; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqJ79R2SnJAHHfAI9dTKO9toC5LU8hBRU518BwY/FZA=;
        b=P6jBEuhUWdWcyU4/E/EE8A3AQgTfyOufHBsR7Z2y5hUacSqlRMkuSXFb/8knvvQL6q
         aZp9uSSkOTUzKD9ncRVsk4xEih6ofAP6QbLS8LFR6COtroDbrSCN5rDQNLcxCsG80uv7
         DmXlNO6rOVGyjCc9dT9W877wVNLO4prG82vT3oGSG96h6gCUqlDG+cqPeGWPM3MnRHZi
         O9jD5WKE1XMZBP5QpDa1IjIwldsocpUkBIs6vLDtgBvO3WQOCICqrDfxoa0IfNTibfsJ
         QeODB2FgpTYXu9hDpUMUtu9YIWyS/tXsCmZPsbBTXqALi/+3xENleFQknYymz454EGlp
         dxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694861635; x=1695466435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqJ79R2SnJAHHfAI9dTKO9toC5LU8hBRU518BwY/FZA=;
        b=ejRyfQVAwr9b5oJwr4PzRq31bGbAZ/sxX9LIazzjgp5Ycib/uhKCDZsvnRWOp193x8
         aWTeQhXPHea4MDfh70GjXNN03/gVB2noqQH9qPDt682X/lmSfdF6HAvOMCRpIla38nxW
         M/rioEOJYkTTS2Ttphqm9hKGHNczImZOWgL7nUDTW3J8WNWR6Vy8JhnwgfuCzXbkxogK
         B5wdWV4Xs9ZYXdtIbdO8DpS153OkJ3DfwjWppyeOh/8JWxuk/BcWmMdZdk/ayKrPNReU
         0umJ+5xXUO5Sb/bhRdt5LqcVoyYMYTuTdT04bzfGTvAC9PxnE5bNL5qy5ZxWeHaUbcer
         3Hxw==
X-Gm-Message-State: AOJu0YwW2C1hXWiRW7YRgaGlpLyxe5wSMWH7v2diiJoOUqR7NaRGHVEJ
	MjDaKGZyjBsKxx4yktcvs94oMA==
X-Google-Smtp-Source: AGHT+IHsZm0HQC9qiLlex5/BpHC1RrP5Q384dz5/IrZZm1i/R4fOEFUr8sglC/57npnA1QpgbQt7dw==
X-Received: by 2002:adf:ea0b:0:b0:314:15b7:20a5 with SMTP id q11-20020adfea0b000000b0031415b720a5mr3605338wrm.54.1694861635092;
        Sat, 16 Sep 2023 03:53:55 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003feae747ff2sm9900743wmk.35.2023.09.16.03.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 03:53:54 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Sat, 16 Sep 2023 12:52:45 +0200
Subject: [PATCH net 1/5] mptcp: fix bogus receive window shrinkage with
 multiple subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-1-05d1a8b851a8@tessares.net>
References: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
In-Reply-To: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=sz+nh5NIsadTNPEpnKohPqzpae+0POVMkN8Lp2ml4e8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlBYlAdD3Es2m1E+RxWvNs/6/5QPODTmMhRSwga
 qJifHcbjWyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZQWJQAAKCRD2t4JPQmmg
 cz88D/49ajLuykR6XBy8Phzep80ts3D/bLO/Wts9WXfRmd2F/xNh4N/cdCe0DbPX+wZtnmqMVKp
 3pmPgHBKv08muyta2rpwqA7GylzSd0e/1ZYS3IGJ/J7hjWkNKaX4bxBxVB/q1lUb+22gSHacwKB
 ruuSHNc9CGczV7vsE+BACTuqa0O3WgGCFG6IgMGOnyM6Ox0sIcu6aJ7O9M2h8TRcwmNW9/17k1m
 OE3qmsghIv8HuxMswryoWTF7jefrzEHUIX5P6C06oCQ9Qc/usq9Y4SUWZT46ZZrCuAzkxZRbzec
 QeUMZMuXAov/AyzwQlqccOLUme9Ae6R0u9ofRhbBIjvr8jKaS+QVeUNekIeDgdJQOb4A7XM08Xz
 ILodhtl8IqGn2VuKMFL1nzNuVEaT/vXXEQ2jjIQJyP/DILkbPKpkhAWAYM2IeIYZx6ZUrF92v9N
 vYZX1+zPl1DW++NrwG21eNtLWuHeay7haUgFDiMiS8x561d9GjatxgQ92rv1KQn9Q5K+1Md+2j4
 3Dp4lqfBYbbAs6bT8BRPuQSzWkK8zecRQHOBwvMaSpKOeRmvTeAZkHC5V5S/U9mvz2MieztvHAB
 xWpwFB7o4BrkrXLVpc9rNjBRaLO74SXEVxhHD0I6S+2Wgd5hKW7lxKsu2UyCwdqTf/PktTIcBaD
 j34N2UGTmFlme1w==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

In case multiple subflows race to update the mptcp-level receive
window, the subflow losing the race should use the window value
provided by the "winning" subflow to update it's own tcp-level
rcv_wnd.

To such goal, the current code bogusly uses the mptcp-level rcv_wnd
value as observed before the update attempt. On unlucky circumstances
that may lead to TCP-level window shrinkage, and stall the other end.

Address the issue feeding to the rcv wnd update the correct value.

Fixes: f3589be0c420 ("mptcp: never shrink offered window")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/427
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c254accb14de..cd15ec73073e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1269,12 +1269,13 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 
 			if (rcv_wnd == rcv_wnd_old)
 				break;
-			if (before64(rcv_wnd_new, rcv_wnd)) {
+
+			rcv_wnd_old = rcv_wnd;
+			if (before64(rcv_wnd_new, rcv_wnd_old)) {
 				MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICTUPDATE);
 				goto raise_win;
 			}
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICT);
-			rcv_wnd_old = rcv_wnd;
 		}
 		return;
 	}

-- 
2.40.1

