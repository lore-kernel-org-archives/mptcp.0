Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9FA924
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 07:24:28 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4ff8cf11b90so8288452e87.1
        for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692775466; x=1693380266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xk88FLEvdheX2fQPNktcYYYOPUp9QaORQSzAgtkIwG8=;
        b=eZLbwyyjmFE9caPXGyk9wZvJ64gT0Otek+R7WS3lRUWZt/ESfP5FOGci0zG+BPzhlH
         VBJqePJK0amOhRjq6zok0cUI7WlteNmh2ERMQOWiZgwp2rtyRyyO7AicbKwmXxgJCpTj
         kiM+H1zncIjuTCqVK2yO4HSvdYNf2LdmEy44YZJXiKOq1NyYY2fnFW9SPzFdvNAAPee1
         Ovd4gXgG3/6toFxIUo+iF/m2Sqcu6NUOEbTyDfVuATJNfH5LIjMRYGQz8bQWnpdGFA0R
         CG5FGpHQhUGd1Y3SBJN83Di5C1EKuur9vU+6mu9X5HuYGEl8NfNaRk2wT1kTSBmgn4NF
         hKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692775466; x=1693380266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk88FLEvdheX2fQPNktcYYYOPUp9QaORQSzAgtkIwG8=;
        b=XiDmgRRIX+iAPB9Ij8OWFsf9LCcUqnVGV0bj2C3Fzi6MuoUqIAKcyJ53vnNMVv8e7H
         sK0xhAIHiSyKr+98bidFbp9HAGrfEN6Gmog6SURHNQxDKrinxRZjLpKvdR8bB48w2Py8
         JFZ6OBcMLUnE2//Xs/i2buG8z6cwopzMFT05KTeiTrEQ0Q5HU+x0DjFYlCCy7xx5c3In
         gQeMSkXCnqoWsnmuR8WJYcdTCbEXdImLkvmfcUAb18JdEY1HbW0Bi4JtHA0tJqNO3kKG
         c25cDw/vbwSZwadSUrUeo7mSERjJk4TB0qqFJz/YCWH84PCpt4/fNeF9em6ANvev+ftW
         bNog==
X-Gm-Message-State: AOJu0Yy2tYWVRHYJnR4cqqLboeE6MtdDODIjmAGE+M+eJevJuEBl0hQc
	wsFPLiG5H+E2m2MJnMFF0JUZwQ==
X-Google-Smtp-Source: AGHT+IFFRukbMWljQM/oTprnPna+4vPTuLC1n1cKjbww/D5CIS9gavPhpnbZgTCwXCwkUVEY2sIKTA==
X-Received: by 2002:a05:6512:33ca:b0:4fb:8616:7a03 with SMTP id d10-20020a05651233ca00b004fb86167a03mr10149648lfg.4.1692775466384;
        Wed, 23 Aug 2023 00:24:26 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d594a000000b003140f47224csm17975418wri.15.2023.08.23.00.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 00:24:25 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 23 Aug 2023 09:24:07 +0200
Subject: [PATCH iproute2 2/3] ss: mptcp: display seq related counters as
 decimal
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-mptcp-issue-415-ss-mptcp-info-6-5-v1-2-fcaf00a03511@tessares.net>
References: <20230823-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-fcaf00a03511@tessares.net>
In-Reply-To: <20230823-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-fcaf00a03511@tessares.net>
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>, Andrea Claudi <aclaudi@redhat.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=aPMCGBRNNu8FR+HlpeKtrb2of0i6DIq6dP00GRu4wAM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk5bQlVbXG5hGqZnfk0pruaQ1KIdL1dZ9Smlfw+
 8Lo3CiaQ6iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZOW0JQAKCRD2t4JPQmmg
 c5QQD/9jvH067R6OBwwtUcEs8GhVYUjTeJBgq9Nmjls9KCR6kENs89eMGkQYxHcRhvnL6fy2tEP
 RIgDHTToeCbQAbJ/vjiZox6PFcIldmljkYrA0ORkNYzsnwpSs0qsrmkNdXlRHeaobS2VcB6LvRI
 Ij+H5iqnQG39iM9uyA5c07I7ZNrKY8JjVwdIVV0JrbhbLp6tZnEJK8ImH7wckZ35wtixzN+4KID
 LqHy4+MhzTp2w9hC6/V8uks+buYoGyYxOMTGLufaSNLZS4G8ZaVoTMkear23WLPM1oUIav0ryuT
 I43WDi4/+Y/g+E1NrOjgZxtbqOYlNnukww7qInOxNaqysvl114A3jconozSBk36oyAVJSidjVV9
 5RPR8hYKJzGc4DGyHSYVkP80SnSoHJZ0VCbOETDkIw+ktlJtoTAHvbMheT4jZtrkjNN4+4hOJTp
 wm1nc/BvwLgR3e7mq8v3IlFTildhYVXh/koi/AWVyX8MpCh6JXaa7PSxFA9OUXwpyzx6i1hcWCu
 TfIczvcw3BKb76VZh0hsvuNfVG8qG8CI+kVLS1OiwUzjdmPVunmtsg/4T+vzj62liOBkjrthHWa
 lZcowN4X1v6L5lHl9YJwASdaOmmOYYnZWHvqMgUYgn4odOkMcHriWRXEaNQ1HP3/XBROt+7UElu
 MV6cSHqI5k03Rqw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is aligned with what is printed for TCP sockets.

The main difference here is that these counters can be larger (u32 vs
u64) but WireShark and TCPDump are also printing these MPTCP counters as
decimal and they look fine.

So it sounds better to do the same here with ss for those who want to
easily count how many bytes have been exchanged between two runs without
having to think in hexa.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Andrea Claudi <aclaudi@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 misc/ss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 34f82176..d1779b1d 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3250,11 +3250,11 @@ static void mptcp_stats_print(struct mptcp_info *s)
 	if (s->mptcpi_token)
 		out(" token:%x", s->mptcpi_token);
 	if (s->mptcpi_write_seq)
-		out(" write_seq:%llx", s->mptcpi_write_seq);
+		out(" write_seq:%llu", s->mptcpi_write_seq);
 	if (s->mptcpi_snd_una)
-		out(" snd_una:%llx", s->mptcpi_snd_una);
+		out(" snd_una:%llu", s->mptcpi_snd_una);
 	if (s->mptcpi_rcv_nxt)
-		out(" rcv_nxt:%llx", s->mptcpi_rcv_nxt);
+		out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
 }
 
 static void mptcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,

-- 
2.40.1

