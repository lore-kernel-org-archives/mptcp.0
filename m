Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7475170
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 02:42:19 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id cl24-20020a17090af698b0290157efd14899so4575100pjb.2
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 19:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NMCzX+2omN8qhSubNg7df4+Qok+dANayJUbS6dTAiRQ=;
        b=barSYPSsl+DBcWITkVHj59Hqf72s4Pl6OdwxEfFJsi8dZMVHl27Ct5ZwfGnMUO2WMX
         CUpxFnqHkYgLkUUWxxx7+U7CjNSttpQCOKK8C8mp7DikDQaP2KAjxc86Wloeg3S45Tam
         OpzErpVCAPb1Qavmwt8EtGc1Jm1J3aKAFsilaDmYf6YV4Zd0S3q6Jv/qLgquNO9JpXSF
         8P66NM1ip7bDrnAVMYorJFctAcjQEN4Ea5sQRNj4LPE+8iAyMlkOjwwbLiNiUSRnadlh
         p5QgrGDWHnUOL8uZTnbqJMK5ZzEwH1kxe+BTL58bqOTL/rfCqBNlV5ecZ0B+Dv7zzbAB
         kpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NMCzX+2omN8qhSubNg7df4+Qok+dANayJUbS6dTAiRQ=;
        b=eEKu9JE/qxMpDvckDZCOWPwC5pzT39NNggNaUJvPXnp3dIt4mkEK+EF64Egfzj3i2h
         4Up83zhN63ezPE4AqPbar83i3FQqtJLAVhis4NtjzFyspevIyT0IJw4KSHT+e4uuERlj
         gKUPrgOES48rT/HDFkWvSQ6f+tggURtHGTUaJpsGyxHMkMAhm/ZgSItM47Jeu1VMuI61
         HqyvtfSjZugr7q1ajT3RHqqyFy5JvoLgCqGn78ZRgTqoy/PxvWt/k99XmrxuDw8nRgc/
         sWct1sQyInfHaqPr/3r2RSyPIU7rLy0TO8D1+KPFakXXAEGi5r3twmYLUyT2Opyk9WU8
         2u2g==
X-Gm-Message-State: AOAM531YPuFuQ17AhEp1QFOVGrkCa8nxMdCc+R2uJEfMH4+HetV7mGKj
	68XfKS8YKNhK/2kOc7557yRR6r6QPA0=
X-Google-Smtp-Source: ABdhPJyF2wwNCcOqPRCp/vmtmkNRTrI/hav8WNkDy6yfl8r87HqXDY5WHqj0im9HfICCa4akwGHw9g==
X-Received: by 2002:a17:902:a58b:b029:ee:d13a:2642 with SMTP id az11-20020a170902a58bb02900eed13a2642mr7761722plb.35.1620355338742;
        Thu, 06 May 2021 19:42:18 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id a65sm3458367pfb.116.2021.05.06.19.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 19:42:18 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: receive checksum for MP_CAPABLE with data"
Date: Fri,  7 May 2021 10:42:14 +0800
Message-Id: <135787a3f77e222df41dc187395cb4f9181191ac.1620355254.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop useless braces '{}'.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5424fa6326ff..cce90c16e47d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -34,11 +34,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 	case MPTCPOPT_MP_CAPABLE:
 		/* strict size checking */
 		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
-			if (skb->len > tcp_hdr(skb)->doff << 2) {
+			if (skb->len > tcp_hdr(skb)->doff << 2)
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK_DATA;
-			} else {
+			else
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK;
-			}
 		} else {
 			if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK)
 				expected_opsize = TCPOLEN_MPTCP_MPC_SYNACK;
-- 
2.31.1

