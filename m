Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80823AA
	for <mptcp@lists.linux.dev>; Mon,  5 Sep 2022 05:04:23 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id 202so7139406pgc.8
        for <mptcp@lists.linux.dev>; Sun, 04 Sep 2022 22:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=5DQUMFXxfA32a7aUWkNHYF5YjobVzHhpLj7ZM8/Qyc4=;
        b=U5LX8GJPY8K55tWotkGyIbYRSUEpT0P9JtF7vMlWWJfOv1qnio5NozJioiBOnwhKoZ
         lIrTCXS4Y5RmdWN3aTzrvb4Evgb8pnvaNuUPLsHVCvNlSAkf1PAnKfBIE7b83KymfqUQ
         MqXs4DE/O3NOhZNAwN0YP8CrnUHoGMGpQbQmFGjV08M5s/LEfq1cCTatHtBFzJkj/brg
         0mmi0RKi9/HYygc8T0AeQ4NybMZ7A+VQH+nSh3m6Gc3S2xDz/yRm6q4ukDGRZ9Dfwlye
         KqRbUsJbhEeXW9Gvmt9st21wlnKypVNiz7WXiuuYChZhBeng0z3VQi+WzkcPHuTNuLil
         6l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=5DQUMFXxfA32a7aUWkNHYF5YjobVzHhpLj7ZM8/Qyc4=;
        b=5MK96zm0V/kLisBz8iWcDoTxhbCeibt/4yZrzfC43LtFRp/gGrAxFJYKck172AfqdX
         4IlTZIl4uMB1ZXnSPlyII+HcrUsIPqXu10Xn/BTFDQpvYACpVcr3KPmOFlQyhRp4zD53
         4GJ8p+J2ZWbfwxz/27YEXZZrEyqfpzcivqU8FFmwhHNQec7qE5Dv0VzrMcHIJcRFSYfs
         M5sVKSpl+mDU9/Z6Ee0P4oKKfV6/XCMVavmxUK85nu8Apv3AEwCNW/dPG1MUAa8GV14w
         joZtkoTEy2vjj9JBlrgoWm9Lj+fX48yQBtUwuYmhyiu4rgcqrbL4MaEQh/O6Pia/figh
         PXIQ==
X-Gm-Message-State: ACgBeo30OSC+0P2O1gCUjYUIIGLe+0VWdi/V/E86Lp+ugJJvJaJVRDuA
	mCEtsrOFVAyoCr1e3/wf+RA=
X-Google-Smtp-Source: AA6agR6pvn1FU7kFUm/ufBbt+Cn5QuJED8ghP52KyOItCepMBytmJz/qgxEs2mm4NQfZdAiychTKcw==
X-Received: by 2002:a63:2582:0:b0:42b:aacc:807f with SMTP id l124-20020a632582000000b0042baacc807fmr34221015pgl.120.1662354262610;
        Sun, 04 Sep 2022 22:04:22 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.23])
        by smtp.gmail.com with ESMTPSA id x3-20020a17090a46c300b001fd7e56da4csm9423901pjg.39.2022.09.04.22.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 22:04:22 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: matthieu.baerts@tessares.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net] net: mptcp: fix unreleased socket in accept queue
Date: Mon,  5 Sep 2022 13:04:00 +0800
Message-Id: <20220905050400.1136241-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

The mptcp socket and its subflow sockets in accept queue can't be
released after the process exit.

While the release of a mptcp socket in listening state, the
corresponding tcp socket will be released too. Meanwhile, the tcp
socket in the unaccept queue will be released too. However, only init
subflow is in the unaccept queue, and the joined subflow is not in the
unaccept queue, which makes the joined subflow won't be released, and
therefore the corresponding unaccepted mptcp socket will not be released
to.

This can be reproduced easily with following steps:

1. create 2 namespace and veth:
   $ ip netns add mptcp-client
   $ ip netns add mptcp-server
   $ sysctl -w net.ipv4.conf.all.rp_filter=0
   $ ip netns exec mptcp-client sysctl -w net.mptcp.enabled=1
   $ ip netns exec mptcp-server sysctl -w net.mptcp.enabled=1
   $ ip link add red-client netns mptcp-client type veth peer red-server \
     netns mptcp-server
   $ ip -n mptcp-server address add 10.0.0.1/24 dev red-server
   $ ip -n mptcp-server address add 192.168.0.1/24 dev red-server
   $ ip -n mptcp-client address add 10.0.0.2/24 dev red-client
   $ ip -n mptcp-client address add 192.168.0.2/24 dev red-client
   $ ip -n mptcp-server link set red-server up
   $ ip -n mptcp-client link set red-client up

2. configure the endpoint and limit for client and server:
   $ ip -n mptcp-server mptcp endpoint flush
   $ ip -n mptcp-server mptcp limits set subflow 2 add_addr_accepted 2
   $ ip -n mptcp-client mptcp endpoint flush
   $ ip -n mptcp-client mptcp limits set subflow 2 add_addr_accepted 2
   $ ip -n mptcp-client mptcp endpoint add 192.168.0.2 dev red-client id \
     1 subflow

3. listen and accept on a port, such as 9999. The nc command we used
   here is modified, which makes it uses mptcp protocol by default.
   And the default backlog is 1:
   ip netns exec mptcp-server nc -l -k -p 9999

4. open another *two* terminal and connect to the server with the
   following command:
   $ ip netns exec mptcp-client nc 10.0.0.1 9999
   input something after connect, to triger the connection of the second
   subflow

5. exit all the nc command, and check the tcp socket in server namespace.
   And you will find that there is one tcp socket in CLOSE_WAIT state
   and can't release forever.

There are some solutions that I thought:

1. release all unaccepted mptcp socket with mptcp_close() while the
   listening tcp socket release in mptcp_subflow_queue_clean(). This is
   what we do in this commit.
2. release the mptcp socket with mptcp_close() in subflow_ulp_release().
3. etc

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/mptcp/subflow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c7d49fb6e7bd..e39dff5d5d84 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1770,6 +1770,10 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
 		msk->first = NULL;
 		msk->dl_next = NULL;
 		unlock_sock_fast(sk, slow);
+
+		/*  */
+		sock_hold(sk);
+		sk->sk_prot->close(sk);
 	}
 
 	/* we are still under the listener msk socket lock */
-- 
2.37.2

