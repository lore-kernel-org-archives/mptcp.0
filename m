Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75193FC0
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 07:58:22 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id y17so4997816pfl.13
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 00:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPzm3L6Lm/y9qXXvjV3D7Ueebj6tefIxr2YJ9fwBYtI=;
        b=PvwJ1k4tqPas6r/zbuLXkGEwt+u1f7vxU660yGFK3PjWqJGn405WBG2cNGpTyJM6Ld
         iVruUlLA6I+7TGxts4ZcsHxhTS7juqiG59DP1HY2TKFLjwi27gYzn1lFxIHhZRIYCBkE
         BRdn9CHCwUxOzQ8xOO18ByX/dySpTceUoPyZSAAyOns63ita27ig6SY+gZStrIk2frVI
         CYjxo23Q+0EMOxuiLraMIlAish7WlXb16KaM0Iucf71ubmkk1Z3o3vOwUO2Qr6Kcc/D6
         Ek1Uc0hv1o4ueQFDFmrc1X3HGtSyRJIdPnP+naSNJZx22A/VRmACPvV11Yt06yme7tsf
         rVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPzm3L6Lm/y9qXXvjV3D7Ueebj6tefIxr2YJ9fwBYtI=;
        b=qmt+dYcK9JIqCJ3QiNFw1caUZRobxwYQ93eA8dYX/8AEcl0ZsDakmsjZh81H6N49Rs
         rHyNEkGcM4pdzhyEmWhMPVAHpeQqp1g/WY1be6f2emaxmHOleW8OzMYPaqEE8vh7xFX/
         9aXwclJr9XKiHxjDWbOqYBHnTDDIQfTiN8gQgEa/KnmGkupiBpM8wZllKfDQuTfJHyfj
         IJCb16a8Pu0HUp4vphZ9Qmsg8O8me52tB60UhVTzOR/A6MnPt3jVsZ6JYAsDE2D+CA9h
         8c147hqW5q+pr2YW1S+mHe1bMoxiVvLRW2zjqMRjdO45fCxO20IbYcviQZIrk5oA0KGB
         sU9w==
X-Gm-Message-State: AOAM532dYVyJqrvEWjoRdEKk12pglS8UU/+opJczXwhTOyi/2duHhT+T
	NPt+ScJij4ZAPPUV//a1pSfb41b8YRk=
X-Google-Smtp-Source: ABdhPJxl/MQKxUvigGzDfDYMYztYcOOQ/AI/eQlLeEdktTYr8BZhSM4NIDiyb4LIAZ8kvlx+xmJg3w==
X-Received: by 2002:a63:e50a:: with SMTP id r10mr11171860pgh.84.1630915102345;
        Mon, 06 Sep 2021 00:58:22 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id c24sm6895702pfd.145.2021.09.06.00.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:58:22 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next 6/6] DO-NOT-MERGE: mptcp: mp_fail test
Date: Mon,  6 Sep 2021 15:58:07 +0800
Message-Id: <004a49d4abdafdd8965d6da07a702db1c310e5a1.1630914699.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630914699.git.geliangtang@xiaomi.com>
References: <cover.1630914699.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

./mptcp_join.sh -Cf

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/protocol.c                           |  9 +++++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh  | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b14023301975..b7f344fbe322 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1289,6 +1289,8 @@ static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_e
 	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
 }
 
+static int j;
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1423,6 +1425,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mptcp_update_data_checksum(skb, copy);
 	if (READ_ONCE(msk->snd_infinite_mapping_enable))
 		mptcp_update_infinite_mapping(msk, mpext);
+
+	pr_debug("%s j=%d", __func__, j++);
+	if (j == 20)
+		skb->data_len = 1;
+	if (j > 40)
+		j = 0;
+
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 	return copy;
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fe0c8f3164a7..38663f6373b8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -977,6 +977,24 @@ chk_link_usage()
 
 subflows_tests()
 {
+	# 1 subflow
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "1 subflow" 0 0 0
+
+	exit
+
+	# multiple subflows
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "multiple subflows" 2 2 2
+
 	reset
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN" "0" "0" "0"
-- 
2.31.1

