Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1995D2FB5
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 07:59:03 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id t21so4742480plo.2
        for <mptcp@lists.linux.dev>; Fri, 07 May 2021 00:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVPCve7MJlwmWgonas781N7SAX7ibjpEuIpqcfoJb/g=;
        b=cPLIrQVmjzJi6vCEGrlDfIwmNwmYxXZMd/POnja8M+Bbuyp9hwgS/NVddSqpP5FaH+
         DOyaJBRzfh3Y8JuYumJIMIW1+XLtFsrhVcbvowanm/1H3J6RxwtGDOPgL5DzqaQJQ/Du
         5sWxa+SmVcqPFatkDFVsBtnRzehnYTz48ZdEEoDcI1Z9BZ87+CfJtPIPKiS3+9c0bZX2
         IL1rBaVbupzLLGgqz+KL8s6QyIzBcXgq7VE7Jb/YOtzXnH7+Gba4Auf5F5X6x87PHG8j
         npqkDV2dbiaN7erEjo8WEFHqfeGQiNd/zHxPNuBgNesCoMGL88K1QV37qYcs3UPsYE2D
         /0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVPCve7MJlwmWgonas781N7SAX7ibjpEuIpqcfoJb/g=;
        b=XidZQ1xioc9/sCVKnnUuXLE0XjG2v7qSyxScJBn/kulU726rYJ80fyCd9AnukbK3Gk
         BwzYovnx4p0Vij2qZVIOq/Ppv4iPIoSYVvnZl/UDbk/dmXpAjYR7TicA9CW/rmqiwfpv
         NGJwSKgBNOqF7q5e/hloFEou8vEDIJCWQBldSD1Ormv5qXOuwA57lCjpj1HDZWcKvSC3
         vdnY9A/SD9O1/mVzBe9mGf0Nu3rUzcGrcWaPDd/Afs4GKWthMEf4l+CTdMSaLiUTS+4m
         mPEVwfSm1pVkMQH5vc3gXkhERYcS6MQsAKN+2+5Z5RSVeRwcrukZKNC5VGRsdgGBmY2X
         RtRg==
X-Gm-Message-State: AOAM530JJ5zTcw0PZRBKeGD6M8zrWFXdpXRJptgKuvgm4k0QuJy9uX6f
	MpNMYEo0mFj1K8cqo74mLB0bunymFjY=
X-Google-Smtp-Source: ABdhPJymmo99H60Ziv32uIvrCYeYCHhTUacA06GbHu5/AUYpz7LZhMh6unwUbACMnjqSC0G+DVJjIg==
X-Received: by 2002:a17:90b:4908:: with SMTP id kr8mr21540445pjb.85.1620374342477;
        Fri, 07 May 2021 00:59:02 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id k38sm3956799pgi.73.2021.05.07.00.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 00:59:02 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] mptcp: don't fallback when data_fin enabled
Date: Fri,  7 May 2021 15:58:58 +0800
Message-Id: <c8b33d7b10e063f3bd93d25955d539a6af7f0372.1620374286.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixed this fallback error:

<7>[ 1477.059635] MPTCP: msk=000000006bf0cf61
<7>[ 1485.132216] MPTCP: subflow=000000002296fc22
<7>[ 1485.132233] MPTCP: subflow=000000002296fc22, family=2
<7>[ 1485.132242] MPTCP: subflow=000000002296fc22
<7>[ 1485.132411] MPTCP: msk=000000005b84960a
<7>[ 1485.132688] MPTCP: subflow=000000002388ad62
<7>[ 1485.132695] MPTCP: subflow=000000002388ad62, family=2
<7>[ 1485.132702] MPTCP: subflow=000000002388ad62
<7>[ 1485.132974] MPTCP: ssk=000000005ab5dbc8, local_key=9186175039591172243, token=2833190200, idsn=13562085501921405456
<7>[ 1485.133131] MPTCP: subflow=000000002296fc22
<7>[ 1485.133200] MPTCP: subflow_req=00000000ca26b42c, listener=000000002296fc22
<7>[ 1485.133209] MPTCP: MP_CAPABLE version=1, flags=1, optlen=4 sndr=582, rcvr=18446744072046692096 len=65535 csum=65535
<7>[ 1485.133227] MPTCP: req=00000000ca26b42c local_key=9900409276882973726, token=2796355457, idsn=5747750831347864753
<7>[ 1485.133288] MPTCP: subflow_req=00000000ca26b42c, local_key=9900409276882973726
<7>[ 1485.133384] MPTCP: subflow=000000002388ad62 synack seq=72748901
<7>[ 1485.133393] MPTCP: MP_CAPABLE version=1, flags=1, optlen=12 sndr=9900409276882973726, rcvr=18446633460193955073 len=0 csum=0
<7>[ 1485.133402] MPTCP: subflow=000000002388ad62, remote_key=9900409276882973726
<7>[ 1485.133409] MPTCP: msk=00000000875940e7, token=2833190200
<7>[ 1485.133416] MPTCP: msk=00000000875940e7, token=2833190200 side=0
<7>[ 1485.133457] MPTCP: subflow=000000002388ad62, local_key=9186175039591172243, remote_key=9900409276882973726 map_len=0
<7>[ 1485.133490] MPTCP: listener=000000002296fc22, req=00000000ca26b42c, conn=000000005b84960a
<7>[ 1485.133499] MPTCP: MP_CAPABLE version=1, flags=1, optlen=20 sndr=9186175039591172243, rcvr=9900409276882973726 len=0 csum=0
<7>[ 1485.133587] MPTCP: subflow=000000000587a2a5
<7>[ 1485.133625] MPTCP: msk=000000005dcb6e30, token=2796355457 side=1
<7>[ 1485.133658] MPTCP: MP_CAPABLE version=1, flags=1, optlen=20 sndr=9186175039591172243, rcvr=9900409276882973726 len=39782 csum=65535
<7>[ 1485.134972] MPTCP: msk=00000000875940e7 snd_data_fin_enable=0 shutdown=3 state=4 pending=0
<7>[ 1485.134987] MPTCP: msk=00000000875940e7 snd_data_fin_enable=1 pending=0 snd_nxt=13562085501921405457 write_seq=13562085501921405458
<7>[ 1485.134998] MPTCP: Sending DATA_FIN on subflow 000000005ab5dbc8
<7>[ 1485.135083] MPTCP: DSS
<7>[ 1485.135089] MPTCP: data_fin=1 dsn64=1 use_map=1 ack64=0 use_ack=1
<7>[ 1485.135097] MPTCP: data_ack=2683442354
<7>[ 1485.135102] MPTCP: data_seq=13562085501921405457 subflow_seq=0 data_len=1 csum=0:0
<7>[ 1485.135198] MPTCP: msk=000000005dcb6e30 snd_data_fin_enable=0 pending=0 snd_nxt=5747750831347864754 write_seq=5747750831347864754
<7>[ 1485.135233] MPTCP: msk=00000000875940e7 state=4
<7>[ 1485.135297] MPTCP: msk=000000005b84960a state=7
<7>[ 1485.135302] MPTCP: msk=000000005b84960a
<7>[ 1485.135387] MPTCP: msk=000000005dcb6e30
<7>[ 1485.135436] MPTCP: subflow_req=00000000ca26b42c
<7>[ 1485.135472] MPTCP: check_fully_established:fallback to TCP (msk=00000000875940e7)
<7>[ 1485.135628] MPTCP: msk=000000005b84960a
<7>[ 1485.339305] MPTCP: msk=00000000875940e7 snd_data_fin_enable=1 pending=0 snd_nxt=13562085501921405458 write_seq=13562085501921405458
<7>[ 1485.339329] MPTCP: msk=00000000875940e7

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/176

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f3e379a0f08d..940b32511443 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -901,7 +901,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	 * MP_JOIN subflows.
 	 */
 	if (!mp_opt->mp_capable) {
-		if (subflow->mp_join)
+		if (subflow->mp_join || mptcp_data_fin_enabled(msk))
 			goto reset;
 		subflow->mp_capable = 0;
 		pr_fallback(msk);
-- 
2.31.1

