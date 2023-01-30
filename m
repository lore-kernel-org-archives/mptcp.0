Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214F17D9
	for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 10:26:26 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id d14so10540182wrr.9
        for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 02:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWD34Aoq6uhQ6TSuu9z4VKxzK49tgZOewgaCTVhCCcw=;
        b=BdZEtHKc2wSoi16fbiZL2ylGPi9bnIEizqwLwtc0yuRSsoGIXleDLhXItHQWiJ1X+V
         UriSLofFzGefudJcOHpqng71UAiErWhHz9HRM3baqCs9aySYb/oAhM396sx4DF6h2X6d
         Wo/MMEsKjWS50aDUImpg9XdM0RjHXb//8iUfSv8YrdJQvzAcC0Tm+ExHlqq8b1FJiTdt
         CiNRl7dFlIgON8ozNxDR0TexCIIgxlohRpwQ76Jj+Ju1WMu4Zq31dWlFpG6QkBfBiIRV
         HRAjhK15AMzprnLRsLP24q9rTMgdzgsfMLwSrTGvWaK0GyDKiSEY7Di8ZQ3iABZ6fdyc
         97FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWD34Aoq6uhQ6TSuu9z4VKxzK49tgZOewgaCTVhCCcw=;
        b=VbYCBPVy6xkngQ1IaJ5r3UDAw4R0zbzoOT7Tsr7VfHKKBRYQDQ521OyASJDQhtSeof
         /cyMrdTCOuh3t5RFse2NA4cQPsvdoQciBI4yfmzMoXC7VEDTbNKU3GCtQhKfFidcUt+l
         x6koe7yjW5p5si3vN5UDXpQpgGvUGOnWmu9MFpHyVLpcaKkKcQOtvY7BBc66InqmCrvj
         0XmkfZxckSyRjXVrFogn7UXIHx6wfd6ctkbZNyKedY4o/y9EzBU8v6frZN7LvwlWrZYs
         3SnnHiZNRXbErMiJfaWSWNWOsWuYnLya49EQqNCEc4Rxh+fBKCkk8t212mM0njc9JpBQ
         mxBw==
X-Gm-Message-State: AFqh2kq0/+YWr2FpX9q41JZvUzCtplP6CCJb3pW2QC5XmMVZR2P/TF4D
	Lfjn63yfX/V7T7OqKbb6ewpjBwtdV254zKOR5EM=
X-Google-Smtp-Source: AMrXdXs0xj3V2SCfpxBxjJA0JY+ekJVi4NOs2Q6kXubZ0K10j7zEx7KFLgMTigOrF69n53ioqhIizw==
X-Received: by 2002:a05:6000:3c9:b0:2bc:7f32:e6ae with SMTP id b9-20020a05600003c900b002bc7f32e6aemr42518730wrg.64.1675074384234;
        Mon, 30 Jan 2023 02:26:24 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p12-20020a056000018c00b002bfe08c566fsm6029187wrx.106.2023.01.30.02.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:26:23 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-others-next] mptcp: bpf: Pass const struct bpf_prog * to .check_member
Date: Mon, 30 Jan 2023 11:26:08 +0100
Message-Id: <20230130102608.1278837-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=715; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=1s91bTVh6puK0DmIptNBz7Wut7PFeGLaQWwgK03/iBc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj15s+SENkOaKZ27nhPVBpMGe2z6sow0AHM8zs4
 GeNjgC75K2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY9ebPgAKCRD2t4JPQmmg
 c7nGEACRkrtiUbIAUCEbqrwUjEuJjngqhSfQRvv4zLOQk8ep92BQvnCS89fTZnRO7naZKhM6f05
 a7TJBvXig9HJPJ7EaHUQ2nJ+KE96J2LTn2kBn/R9tkq2RJqKdtGUQ7j/v+uGotvHvyaykACKBpv
 aHfV3jVdyh4AnX5Mci7sK2K1NeUTsBSVAKOJf3vPuZNen5DaaAQBQ8mD0t9tdBXHLG6V+FmC5Oq
 V/6q/pAA+r5MHBbaO4rR9E8D6uwNUDY90OUh5RMqwce/xm1rQAi0W3O5pNK0eINfen9Hr/pEyo0
 MqCx4GqU13Rt9z+w1rUTygMOgd/m+5aDEsiJM7PAqur4QqR/B966190J2qt5w4c62SkDSMQvWeL
 HF4JAhTTHHFbXChV/9Qm80x1INbgvAROf+A+6N5cb2y1DoVEZ3Cp7x/JJjt2M3eW1hyXckwnaeS
 Gz2WbstIcP0txgd9aCXuM2TZCEtlsw2rQ0UvOpXNpHEC1BvsUNdFctRrEYfNQG2wU4rzKLM8CoX
 Q8cY9LmIDluDOjulT+A/b1sf++/mcb4tp27ecd4YXN/pc6UVPkpMsKTJl5ecCPt8SKyeoAXyd2U
 h5UwPUTD4fY3AILyuHlJpd8LBywXeCS6ZhqeGIJ101Vvm/vsHORJdNXdrb20x9A78m32C63t6+F RCchj1/JfqJ3QrA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Adapt our code to a recent API change in BPF, see the Fixes tag.

Fixes: 51a52a29ebaa ("bpf: Pass const struct bpf_prog * to .check_member")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index c08458a31f46..14ea1342598a 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -89,7 +89,8 @@ static void bpf_mptcp_sched_unreg(void *kdata)
 }
 
 static int bpf_mptcp_sched_check_member(const struct btf_type *t,
-					const struct btf_member *member)
+					const struct btf_member *member,
+					const struct bpf_prog *prog)
 {
 	return 0;
 }
-- 
2.38.1

