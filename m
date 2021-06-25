Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15663168
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 11:53:36 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id gn32so14734177ejc.2
        for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 04:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYbe3SdY41ma8c3XS+/9kwCjP5lF+nhigkSASwnSSjI=;
        b=MqDZzyKBbposn9wdtBKdZLWakCajrRuLoM7HBK3iZ+v3lx5aAvlkuhwUSWQQrkhk3f
         Z1pwqqViZGbneRuSKbMkyK48p/TZ0URlt0B7XRKv/yGfQjxlzIGjzSdmfFt6DrOGfvHt
         02rhe49Ag4kJ7pXsUen41NaEglQQ7eyImbxYG4Eq/PKLztlBXaiTp+0Ya+/wzvQr9dkT
         kXDRWNUWYb+ksbJEvoLv8zirqCMMWz9bOh20oRpb/F2Z3pTMws7BC3htuy18sF66d66K
         DnsFax35QVU2Pa6T4twzKk8BrqmVeUG+9Ltoj8e+PRLsjwXcIZaFWRq1gam+5pC7fEiG
         BQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYbe3SdY41ma8c3XS+/9kwCjP5lF+nhigkSASwnSSjI=;
        b=admQlDSbr9veKTNamcSvH7PKm+A6TifjyxY8WYWnHd3a2d+lUtS5cWYvkqIKd3VzxM
         T5nSWBZyT+SY8Vls+sGuLSy6QQFR0l9r1yyZdSR4g2L4WSBkqDmK2z2LpF5tPWDqjcGE
         34/ErD0urIAoU6p/xxeqfrH+vxW4PNsXcE56Hd2lLHKQQ9aSyPjLdEMUCGXRNEj3f3y3
         +ZFics6W8n4RAGH0q5OqWYsOvybAxBvH9isgxgjgWgKfhuoKwfxwpXgA5ayVhZDqwgjH
         PaqtcWUK4Ws0x5YJWEs0BVEYVCYRS5s3Ib7Nw1AL4HrBuj1MFjHr0qguMKrFkVmA6Fj0
         n57w==
X-Gm-Message-State: AOAM533nASl0J4gJtDsFzM4YbkSVEvO1s2iNfj/qyIXNb0IdrtJIwV99
	HOqJaNRdLputE145/ee8v+9ROLMTGRPQ/wUPIB8=
X-Google-Smtp-Source: ABdhPJyDwUmqYzFghmpkpJLIyEfh+R/zUJtwzfRQkEZH+xwyeESvZCTu1MIoXEK0xHZIEJ/W4/4K7A==
X-Received: by 2002:a17:906:ce4f:: with SMTP id se15mr10711993ejb.232.1624622015210;
        Fri, 25 Jun 2021 04:53:35 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id u17sm3756998edt.67.2021.06.25.04.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 04:53:34 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH mptcp-next] mptcp: fix 'masking a bool' warning
Date: Fri, 25 Jun 2021 13:53:29 +0200
Message-Id: <20210625115329.858684-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dan Carpenter reported an issue introduced in
commit fde56eea01f9 ("mptcp: refine mptcp_cleanup_rbuf") where a new
boolean (ack_pending) is masked with 0x9.

This is not the intention to ignore values by using a boolean. This
variable should have a 'bool' type but we should keep the 'u8' to allow
this comparison.

Fixes: fde56eea01f9 ("mptcp: refine mptcp_cleanup_rbuf")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ddce5b7bbefd..199a36fe4f69 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -455,7 +455,7 @@ static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)
 static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
 {
 	const struct inet_connection_sock *icsk = inet_csk(ssk);
-	bool ack_pending = READ_ONCE(icsk->icsk_ack.pending);
+	u8 ack_pending = READ_ONCE(icsk->icsk_ack.pending);
 	const struct tcp_sock *tp = tcp_sk(ssk);
 
 	return (ack_pending & ICSK_ACK_SCHED) &&
-- 
2.31.1

