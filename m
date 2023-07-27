Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840CC174F4
	for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 14:15:48 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso11395015e9.1
        for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690467347; x=1691072147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUTyC4acFyvgFGwLwOB3Um17AnP3SMbPa7d0UPDlcYY=;
        b=PWDHu+ZtqZH6Fam6cltbUrQF7q0zaaOWs1jJvGr5Odw6DJEFKNuFGbkBnOLaS2X6n/
         /Wzmv9j47kgOC3srSvbyAw1v5rzYHdCw0iOEOZLbHF+w8AVFj3s6kheAN5w9urcG60bS
         pwoXifRWAKR6AOrGz4yiEE4a/pM4Q/+OdvL62V5IlBT9+pkaDWz8QTFgGL0vkl73pYkG
         BKAUNAO6hRCczpNQHYpC/V8hNwtd2Q1dNIpPwyY78Ew4AglYJjIjPtKn825oqRWeOIUG
         CO4hAIriNxDrQMXCyWPjW0hoo9QZ+fpc8sFazCbws+V/N11n77bbjFJ2sxGEx6ak1KHk
         QBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467347; x=1691072147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUTyC4acFyvgFGwLwOB3Um17AnP3SMbPa7d0UPDlcYY=;
        b=h6+F94EDjb4WuixMVeuididxkTBzh/i9/k0fn8A7EKA7W2XcM21cfpigYl3QErvjw+
         bU5GibiLp/5HCWITV+hn/YDl1Tsc0nvHRPEId3VsScZBcvWIBx+X6bxnXjvrdmscVoW4
         AfypzB+J/SaAZY4xJz9Wu7QXVD8TuQQ4WPW+wdHFNslXUnMAEtXZrzIu48OR4PrI3GwV
         n7w67BPOtTJPglS1dGzCnsvIsvEr6tvs+KyN01JWB7+0hwoVAm6oevEBzUTzFJTSEbFn
         5lYTeOdcGOyONllZGZ21UqjkNMDCRe00Pwvn65sC+ks+CJlViK6nS/fpKHOkmCLfuSud
         kYyw==
X-Gm-Message-State: ABy/qLZiaO+IRYUQfiIY7NbodrRFDSoRaGHfErA9l+HknZ3E2C/+Q6Y5
	6Qbu2JEmC0/81Jq6hvNHNP7AQg==
X-Google-Smtp-Source: APBJJlH0/Xmo6P55SNMxQDufy7JV+SnpeOLwPYQewO3wu1mi3cf2482eqphtyLZ+haJwIV1XVQB2XA==
X-Received: by 2002:adf:dd52:0:b0:315:964b:89b9 with SMTP id u18-20020adfdd52000000b00315964b89b9mr1742208wrm.52.1690467347111;
        Thu, 27 Jul 2023 07:15:47 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm2145405wrq.115.2023.07.27.07.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:15:46 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.1.y] mptcp: ensure subflow is unhashed before cleaning the backlog
Date: Thu, 27 Jul 2023 16:14:57 +0200
Message-Id: <20230727141457.2522904-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023072102-finicky-everyday-cce4@gregkh>
References: <2023072102-finicky-everyday-cce4@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=iINWTQLqXuf9BqfqCJJtElqlaK4/W/YWj+/Sbg1H6lY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkwnvhJx1CYP72oqfBeDwO+vY9ia3y7nJhqt7cy
 XLaV39sO/OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMJ74QAKCRD2t4JPQmmg
 c5OkD/9maxrV3IGumIUvnnyPk4D2Yzq+IMbPtIDnmdSlWuR9b8T+T0BWfDwgrlt4q8SNUkoebGv
 ugzpskBC6+2Tio8SHZ6jlhw8DmjubT+D2SiP27wFi1strJiugbPCDD4jykHWsGFkNC0umcN0bjZ
 27Ji8uFgcptRtHJEgnrvZVplEKYqx0rE707PAPoE0erJ45VscV2DfnEYLZ0OzgfFRBUF2Zbt59U
 g25lIpD4G1rM+EBpYCrYCkGG8FwKMbsLHzOQSHghHdoo8K4lviBq19kENFJ8i19NmjFBeWUHbmr
 A8EJLESpQFN7EbZf/jiLBwEm9on/qpUGQRYmcTeCX1xMT/NIVZSbEL8HDAwP+hK2H0KrBoYVNFF
 KdNU5Nfil/ONPHc9O2ibK+6nrMh2vB7qxwpDf5CM1YW4iQ92XDGwqD4YT5W6OX/ATJlGXvqimpv
 6pw3CNI29Po7JKHqFmmSWOcVMrEn4zUoT9i4IAvvRq7tlsP9A1kblZ0Jbx6a3g1J1W7B0NEKJya
 AOugPNnNqrzyirVwGDnzrIfBq117ahrPFnir/0IvvFOHXUJtNiganQzd23GlSRLccZ/ojOasF4c
 UisF++S3JQpuJYbnNBGS/yvyGcKQ1Vo4UDhryVv9I30NeZUVWHKFQYb7hF4A4eCznjiAYetzeVi PmpPum9xEu0pOSw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 3fffa15bfef48b0ad6424779c03e68ae8ace5acb upstream.

While tacking care of the mptcp-level listener I unintentionally
moved the subflow level unhash after the subflow listener backlog
cleanup.

That could cause some nasty race and makes the code harder to read.

Address the issue restoring the proper order of operations.

Fixes: 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the sk status")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Backport notes:
  - it was conflicting with a new feature not present in v6.1, see
    commit f8c9dfbd875b ("mptcp: add pm listener events"): the call to
    mptcp_event_pm_listener() has not been taken, only tcp_set_state()
    has been moved here.
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4ca61e80f4bb..a6a5c16f2a49 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2945,9 +2945,9 @@ static void mptcp_check_listen_stop(struct sock *sk)
 		return;
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	tcp_set_state(ssk, TCP_CLOSE);
 	mptcp_subflow_queue_clean(sk, ssk);
 	inet_csk_listen_stop(ssk);
-	tcp_set_state(ssk, TCP_CLOSE);
 	release_sock(ssk);
 }
 
-- 
2.40.1

