Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE537492
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 16:46:42 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id y14so29789766ejd.9
        for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJAkMZmPTXd81mYjHRUWlG7lWbfI6wrWe3E8hF+LyqA=;
        b=ALrg11XwoUoLFXRcSUadjGPbCMuRX97qlqGJch/od7TyAiWLwRGEBopn0qfkmd2avs
         8HQpwhmXwbNFG/JJBnJRR2/XnILTlxbkCY6HWVLLXCPyslQ+zXBegYd7m1lrzdXRUp6B
         KRGgVeqybbhtAKXm64EJiSEomLNJxvsk5FTygMTFQsJ2TrYBagx8meyHnglaRC6ZkdmQ
         BtuDseollBLoajqHB6Mncr6hIsm6MGSKObVb/eSxoF2Mig+Z/F/CY/R6w3Mu1VqgOv9k
         UyEMEHisq9R6TZKwTqpKr2S3GZUoojMLuJkz7xtIVuwVRBSgpEBKEFzh1ppgeCuEfZAP
         FE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJAkMZmPTXd81mYjHRUWlG7lWbfI6wrWe3E8hF+LyqA=;
        b=qLvlPj2rbiGX2oLi8ysGtowJqhBvTvV0uaW1y6HK9QWu+B1IIcV2OIi7Srd7imnfnZ
         QFKlNpCQdRbeo7WBxqI1C/29EBoRxQ9xRZWoBD+H9n8ijVtq8Q3F86FOv8q0yIdbIu3N
         UWaYtD7bI6Resw7BNprDc/BPkylN617OFIoJpR8CBqxZc9m3tjftirJacQ51Qo5PTTHA
         brQDBFtZd5Oo3IveZRta2YBcuta5LO3BQv6LCuAxtnKVVP6qVQTm7DbOCU8fX8SylbNf
         q8RvqUQLKme4LANoXPihYpS8Fjn+jIiHnzL9m2A4XFgvefrGHLkc9ECQQfjojqQR8m0u
         btRg==
X-Gm-Message-State: ANoB5pkH4vslzCC08jAbUtBymg+gk6ptxdgBQKTgGQxH09OlCSQ/rxdy
	73Os6pk4yAUsgcIg8f/FV5cyVMkxhSEjGQ==
X-Google-Smtp-Source: AA0mqf5fuH88DJSE3RM6nLmvDq1T+TD+0XuE1ZfEs4Nr0RmfoMmlXXE4F/NQVmSjWVX8aBOLzfJN4Q==
X-Received: by 2002:a17:906:71d8:b0:7ad:b45c:dbe1 with SMTP id i24-20020a17090671d800b007adb45cdbe1mr10988205ejk.726.1668444400510;
        Mon, 14 Nov 2022 08:46:40 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b00773f3ccd989sm4377877ejb.68.2022.11.14.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:46:40 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 5/5] Squash-to: "selftests: mptcp: mptfo Initiator/Listener"
Date: Mon, 14 Nov 2022 17:46:01 +0100
Message-Id: <20221114164601.861295-6-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221114164601.861295-1-matthieu.baerts@tessares.net>
References: <20221114164601.861295-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=C4MOV1v4d8mrKObij1JhZkoEZ4glmkOlt1ohhxb4w2E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjcnAx5C6/CS9eSkcT3EgREzTmToJzsEu1IfDpru7C
 cRIR+eCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY3JwMQAKCRD2t4JPQmmgc9itEA
 DVi59BUHzdsK0EvD9A+qJPKl/YJQed+W+3TuQk1wDcd92Sm7oT5V8hudusUQ40An53zlLfWxYjN3uh
 3PUeY9UMUi5toP1CmsG5QXLnsW+xd43+SdybxBHFx87wV48FIJ8d3F9RvoeWuRHRiGyB7WWoP3THbn
 hycrZD38h8GCh6k6y2qurk0KiJw7XxSzKK/2gONzTb1pDPjItKj/pF5bWLxJoaGG03yDHJDNJBzsZL
 4OdJhCCcEcGaFlj1Lx9JsHWFUmcKRELH4KUc3lNHKdGY7UkjaOH5WcU6dgw8ouGsSiaGCx6tk9Le8g
 rLrT88wWQq7UrFKnRwyaaKnWCFEHaPQCSjrJX/6ygDT0KOHBpNxC10dZvkVEa6SUAFwRimgnScjHej
 Ae7X+YTBJkU8rQh0pKIXQ/vTEalkMrWxE6MDuJXVVoKRRdBg0M7PdCvbavQwR5OlmOtYeLd9JIhM7j
 tqpMD4UlnHfJV0hzKUpkoaFTmOsPvKeq/JBz96X2dGTklpb0H6kRS9St+dlbe28zXBt5XLdKbNlSt9
 OoELkpKamCcD+/d/S1g0wnY5zOxstFmqt96OwIDjxAojS5FVLTjvYh7rXNLmxiOiEGSpgVrVC8ckWl
 UVhKgunmIiYN4D/j0Redvd3aJXkWb8U7Ybdd6uzK/QtOf7TRD0GXK4P7ec0Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

mptcp: fix warning reported by checkpatch:

  mptcp_connect.c:398:  Blank lines aren't necessary after an open brace '{'

(while at it...)

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c8bd109c991f..8a8266957bc5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -399,7 +399,6 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			close(sock);
 			sock = -1;
 		} else {
-
 			perror("connect()");
 			close(sock);
 			sock = -1;
-- 
2.37.2

