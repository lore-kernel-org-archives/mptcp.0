Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF263B6
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:21:43 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id jo4so33588371ejb.7
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6E6SLEzYpkMhImNY09/lPTYQtXlDI04cgDyI9gS+K4=;
        b=pQNOnfMhabCOH4kajq86xFVlEbWgcfqeWQBK0rUJXtwqKxwXpouYbNZvNvIjUy2Sm7
         IPtYrGSiCeOkforCfUFtM91u+gaGQX6fhI9gofIKYfbdttYknm7TFZLUnMSn/2euZyCo
         0sQhfTEBA34KD/qBWteme3jOIwCLJZ8KXtjxnA5un6t2LsjQWlDePQmumkazkX2rldWs
         N4xRFz/DqiITRuh4kwLZNyLtPU3v5i+rzeE5jerr/otFVIspdbaM0+0uBm1GuelKJuar
         jZW3mPudFTXXB0LtSeDpIWusMQq62srWwAGlrNTcFVkAUajHBHW0R6jLswF+OobV9qLL
         YQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6E6SLEzYpkMhImNY09/lPTYQtXlDI04cgDyI9gS+K4=;
        b=KAyj8E+YVrski6fDHlWOFjwWys44oq5k2WtLjyAxtFgp1fz/pkSIeO4yDJUq78T8UW
         v6O31lt6N4rzzF/kpIrJbW/iV8YdBJxSo87sCIoQguTrMwJXfxnDwV6JB5/PSSqgRc8k
         dGCzqKf/xghTJgNkaqZhBHU6rYs22v1LSyBe5fuTCHRFbYRh0+BPEEoCh15jE6CMnCAT
         R2Lm0IHGVLYepNQ1JwwvApYNEELnCBfGOJ8q38MiJMSau0v66fTnbNSJL/PONumKl8Ap
         Qcyk8l/Sh7n7DQ3s1Hgx4dEby4o0CHIf8jFRwBxEo+9r7CbdVUybzGPnjul26ZT9vNY+
         QyVg==
X-Gm-Message-State: AFqh2kq2uU0ZMWM3UTBGOEdxSSMwNy1xQUp+c8e5J209ei+Wk+9ZxiQg
	5jFPeaaW4MYqti263c1kBgbAlrfIulrxc6hT1DIzOA==
X-Google-Smtp-Source: AMrXdXuYdlkvvhMo7JR7IYvuEfk1M6RumAut+2E6CP6yXDiHskTuAGy+yOCskPAN0VzmwVbkvDvC5w==
X-Received: by 2002:a17:907:d48a:b0:7c0:dac7:36ea with SMTP id vj10-20020a170907d48a00b007c0dac736eamr19582726ejc.66.1672165301824;
        Tue, 27 Dec 2022 10:21:41 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b007bd9e683639sm6336612eji.130.2022.12.27.10.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:21:41 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 08/11] mptcp: userspace pm: use a single point of exit
Date: Tue, 27 Dec 2022 19:20:54 +0100
Message-Id: <20221227182057.2288816-9-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
References: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=X6mqozSm9v09ThbI9m6Y8WiJzcaWWHTPW/GoY6CoJDo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjqzd6qFgL4NLpdLS1LTBJ9+x/e6ExedvLDzWRLObe
 Cf+N4dqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6s3egAKCRD2t4JPQmmgc4XjD/
 4x+z/WbkFSJibJI+12o7b8lbtvdHT3wNkqMQxY/w9AGLieAhn51GNU/sG53G/XWIAN8654BJX/LL3i
 GXnUJ3SFxQSB5+lI6dhGYkm+t65UICvpyCtFS2b18vfXvZmqD2v5xiK0RRmnAd/+MIquVq4IsnUHpu
 XRTEoLTyeK3gKR1W6PSbQdm4p09EhgcRvx+AXvaNy+KcnGfb3GMokaoA1JTyyW/5rwWe6VBdoqHnAQ
 s6xZvGeAmfUJTtGGdmWd7F88hDuMsoPMJvmahcDFlCedcndbF/tCwDdr83dD2AeIThTJUs3+AcXvmd
 q0l5WpwxX8UIZjvRkEc1FijMUlf+spchgZVX/2tGrlVnAe7IeSGhfUSeptJ4UaZAsOPUfPw4k/uFK3
 84+t4NWxfBOIxy+6vwmaNNdorfRCOldiCq06Ryy3h6y2Zib/k84MPbH42X2hm0+1PBTqSLWZmWhkf6
 dwYjP0+ek0yviNF5CBVC8jTIMpckMeenREvysdm0JbUFu7RNyNavSXL2IWyuqSFoyi/TQBV45NflJs
 sS8rZ6204kIRlh5rGs9gp6T31ORyFZphpVyi/j1TtDPE3S9WsKc1KhHQrQgjUaJz3U9Ufyt3ViUnn8
 LbkHvtHWJ7yx2Uuf/h/YwPIMoxjb6eNmS0Ft588qL7v3TLgQ51nec/gnKVRQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Like in all other functions in this file, a single point of exit is used
when extra operations are needed: unlock, decrement refcount, etc.

There is no functional change for the moment but it is better to do the
same here to make sure all cleanups are done in case of intermediate
errors.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_userspace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index be389dad3f0a..27badb5a5820 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -59,8 +59,8 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		 */
 		e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
 		if (!e) {
-			spin_unlock_bh(&msk->pm.lock);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto append_err;
 		}
 
 		*e = *entry;
@@ -74,6 +74,7 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		ret = entry->addr.id;
 	}
 
+append_err:
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
 }
-- 
2.37.2

