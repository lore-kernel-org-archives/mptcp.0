Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030F6D13
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 08:21:59 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id d8so11628866plh.11
        for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 01:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qHJ3um6bQ3ScnGx8Hwl+b1jmvYZFDhC70xJxMNsbuzI=;
        b=NtjH3bIzlkPKEIZM7eFmBZ8QecbTVkD1RFtdUpNfuPnJTscu3Zekql3Mfx5WRQEvtF
         EVhpWV9JLR6AX40R4DgI4n3jYDc+/SJRpn/QR5exmNK0J+zpuPVUgi0XwcP4c6DVkdUF
         gDyuRNG5kSDbB8Re0KTKK7leKZt7xRiRUG2RcMResh6yySqe6mbnyWzGG8GJJPbJObPY
         lpIHQdrizbRadoJNdPX7yQkAbPCNbScCo2HjGvVIK6vPAJEYfZ8gQqxOcMXG+cNhrd/o
         mLVSRNoxB5XkJJ91n2XA2AaWdEDfojQMIl4Kjr3SWYM6MXvzlwlgIV5zdkm3a+N8tAgA
         mdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qHJ3um6bQ3ScnGx8Hwl+b1jmvYZFDhC70xJxMNsbuzI=;
        b=qZvg/Weds+QFS+weu65u6R5XxATKri2K4yFfbhKO0wbKVPRBnlxJVwvJHhA6RpvVCC
         KHwNWggHlEKpYzUm0YVaQJgtZLw8K7ZwTd1Il9qIlMX7LP1Ay2BVUdZL2+ddX6gvhcD+
         VToJh9lNf9QCk+FFHgmQu78aRHo3xy01LfPsN/fvD1Nl17MowTQxo6aeDvRaqWgyFwfE
         OjZT/TA4hqHx59sHLNLSdQBhVIwZRAs37Sic125SwZlDK/b50ghrCWfcvpgioFw8rEJx
         jwROyiysYS19ZubHHEK/mbq6e1VyJPVs33ioMrslCihbPA+NgcP1OWC3fv1Q9WyMgRGx
         kBlQ==
X-Gm-Message-State: AOAM5315co+PaepJJ3pfP+73j68fEj5A0laW1p/heAdzZmWTtRdN4BBm
	eW+vT0/6o66pS8mRNvGvtftvnYwhJXc=
X-Google-Smtp-Source: ABdhPJwdMnyVrh14XYtXvWeFSAurystnyX6PpQMCehO3DJD9eQZz+wZLpddH6kpC28V7BFa1mbGsIA==
X-Received: by 2002:a17:90a:a505:: with SMTP id a5mr2572890pjq.58.1618474918214;
        Thu, 15 Apr 2021 01:21:58 -0700 (PDT)
Received: from localhost ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id k4sm1726362pgm.73.2021.04.15.01.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:21:57 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] mptcp: fix format specifiers for unsigned int
Date: Thu, 15 Apr 2021 16:21:53 +0800
Message-Id: <dd7700ac7ca1cc9d515e0993f5c35e50741c1221.1618474874.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the sequence numbers are printed as the negative ones in the debug
log:

[   46.250932] MPTCP: DSS
[   46.250940] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=1 use_ack=1
[   46.250948] MPTCP: data_ack=2344892449471675613
[   46.251012] MPTCP: msk=000000006e157e3f status=10
[   46.251023] MPTCP: msk=000000006e157e3f snd_data_fin_enable=0 pending=0 snd_nxt=2344892449471700189 write_seq=2344892449471700189
[   46.251343] MPTCP: msk=00000000ec44a129 ssk=00000000f7abd481 sending dfrag at seq=-1658937016627538668 len=100 already sent=0
[   46.251360] MPTCP: data_seq=16787807057082012948 subflow_seq=1 data_len=100 dsn64=1

This patch used the format specifier %u instead of %d for the unsigned int
values to fix it.

Fixes: d9ca1de8c0cd ("mptcp: move page frag allocation in mptcp_sendmsg()")
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0437fe4f0552..16d73ece8634 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1285,7 +1285,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	int avail_size;
 	size_t ret = 0;
 
-	pr_debug("msk=%p ssk=%p sending dfrag at seq=%lld len=%d already sent=%d",
+	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
 
 	/* compute send limit */
@@ -1700,7 +1700,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			if (!msk->first_pending)
 				WRITE_ONCE(msk->first_pending, dfrag);
 		}
-		pr_debug("msk=%p dfrag at seq=%lld len=%d sent=%d new=%d", msk,
+		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
 			 !dfrag_collapsed);
 
-- 
2.30.2

