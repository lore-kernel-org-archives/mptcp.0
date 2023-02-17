Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0B6AA9
	for <mptcp@lists.linux.dev>; Fri, 17 Feb 2023 13:37:41 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id z12-20020a1c4c0c000000b003e21e018039so2469457wmf.3
        for <mptcp@lists.linux.dev>; Fri, 17 Feb 2023 05:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DMOTbpon0SqIBvl5Vhav/F2dklt1xh6wrZ1YnP+gH00=;
        b=pvTXCADMqW+md3nuv0QlLT8w2Bmc/SErCOkXrzF3/arkfco/6GsGoMJ9pZPRJAafkh
         +YIRbEc2W+9d67R3j4QnIsDUhSl7wruXTTUp2NUGO+iZ/xR4yMt/4uqhV+JR3M/H1UOI
         eHG5KXa4nxiR4UCyx4p14N9SxK1pph1ZUJpnnxdikXnMBeTb/kNoCHN+4k1vx41s3o0o
         pbIKzVh6okRM73MRm+ZvVNmmspMC1k5Nr0hvbUkKRYToZk15zSn0FYfYQdojry7scuuj
         UtJJGRtXW+S5oSkOMLKp4BFsHhS1qOxgiUpsLbeCM4cbX0vI6g5sifLecPpmGk3BAh11
         Sl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMOTbpon0SqIBvl5Vhav/F2dklt1xh6wrZ1YnP+gH00=;
        b=w3MjXHdkWOg3Spz0YpruOUNOMJVch55klAOpCt6d1vlFfsbyzRYjeI79A5+Pq1a6fP
         OtnhyRe2duqus93yOZ1jLQO/0/y257PbiKRjpU4CSf0PSBFKrijUCDwXRKH1CfAmT1xN
         f1+xecVtp2Auuj7TWHpCpAmBGFojSrq1C9XxpCRXkGvxrmeozwv8n+6iB7/LrbA/Qnsi
         JD/3Ezm73M7lqcxseXt6MxxVMtvBy+6xaGhSomYmEoLT131aGoAJ7D2dgomG8OTQ/7gE
         8YJgqXERjkh4TUxzEIMx23XGLnUN9o53dvVlQb7qgevJa3wvZmDQP4zrA6nwd4h2hgll
         nWeA==
X-Gm-Message-State: AO0yUKVJceP6KLzv8lARdlgXPtvwfwkRgM8PjFF0Z7e0PtY51vNw4vQG
	JcXgDF5mQnTcvi15F3tmMgcnlri24FS8Lfw78vw=
X-Google-Smtp-Source: AK7set9SKUduX2vWpSp2cBaCJoG4bzfLNGjiW99V8PerBQaP03RVlNV/dfw+94VMDho2476/gcr8bg==
X-Received: by 2002:a05:600c:21d6:b0:3d0:6a57:66a5 with SMTP id x22-20020a05600c21d600b003d06a5766a5mr1007438wmj.0.1676641059381;
        Fri, 17 Feb 2023 05:37:39 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c205600b003de2fc8214esm4854230wmg.20.2023.02.17.05.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:37:38 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 17 Feb 2023 14:37:33 +0100
Subject: [PATCH 5.15] mptcp: do not wait for bare sockets' timeout
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230214-upstream-stable-20230214-linux-5-15-94-rc1-mptcp-fixes-v1-1-fc57df3fbda0@tessares.net>
X-B4-Tracking: v=1; b=H4sIAByD72MC/z2MwQ6CMBBEf4Xs2UVaaYj+ivHQlkWaQG26xWAI/
 26rxuPMvHkbMEVHDJdqg0hPx+7hcxCHCuyo/Z3Q9TmDbOSpkaLFJXCKpGfkpM1E+B8m55cVFQq
 F5xajFTiHZAMObiVGJbqBjFSmbzvIcqOZ0ETt7Vj0X9nx56iFql+FCpE+94xcodRw2/c3u72OF
 bQAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
 mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2694;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=xUwBLmQpTcbbug0sA/Z2SUqNiB7cZGhuCbj3EY+9cIs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj74MiuL9NwynFYUMo4zU5ro7EiyM0vETLLWfvA
 YWNs4N9daGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY++DIgAKCRD2t4JPQmmg
 c/nLEACa+jiP2SJC+Aot4HO1oIoz2rVH/tr+l4VG3B2BNwZWAbSIkHQajqWs9r5+E5azUn7NhMH
 SJJLiIEf4OF0W4z4+tk9zaRMd9EfXKllol9RAMXnPyS12bW35IBUokEqR/EtCri8M3e7VbJqrIR
 nnSYUV7bR8mMsZFbS/uE6E/9hp9ofCU6zEZuQ9Ybe+qw67Iem3X4nkgb+PAQEw6d/mvJm3mplU2
 3XOZOkAp6KjCtFTEetD8okYhJeggSdnsN/DCjU4l3gvDSEZSPDSZ390FOxQf4oWwVwJVMZqDwP0
 Dw3IoqqYI/bpymUEw7VD1rm0EhYjOzK2iuJ3I1nM55zrz4ewIpSjOQRuUue3ORSur7nTGNcMvF2
 OiV7lhwFhixYSCnJzKJ2UQlXCfeGMld88CgRHxtKLBUYDh/ecYqzTBaZzgSr6BM53VeE1jxPnz/
 /qxfsk6dr3nRnNyhfcct4lVuP631PYdg+oCjq20rUNxMVOdR3d+VZ+innohy79q7nRTA4nC7OhT
 6YkSfCHvkbmrWHo0ZwlDip2WlbViwoLbher1yZEvRhfyWTiXPnRIn8eIJQxITAwEd9dDVte+yqZ
 t/+OYxYN3TT6x7/Z7QPCTQ5ofnNPVe9nX5WBv8d0I05IxllI8jLAhl6ODrPb92VTI/ihq2SVRem
 eTRvO4NTQpeQ67g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit d4e85922e3e7ef2071f91f65e61629b60f3a9cf4 ]

If the peer closes all the existing subflows for a given
mptcp socket and later the application closes it, the current
implementation let it survive until the timewait timeout expires.

While the above is allowed by the protocol specification it
consumes resources for almost no reason and additionally
causes sporadic self-tests failures.

Let's move the mptcp socket to the TCP_CLOSE state when there are
no alive subflows at close time, so that the allocated resources
will be freed immediately.

Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Hi Greg, Sasha,

Here is one MPTCP patch backport that recently failed to apply to the
5.15 stable tree: it clears resources earlier if there is no more
reasons to keep MPTCP sockets alive.

I had a simple conflict because in v5.15, the context is a bit different
when iterating over the different subflows in __mptcp_close() but the
idea is still the same: in this loop, a counter needs to be incremented.
---
 net/mptcp/protocol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 47f359dac247..5d05d85242bc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2726,6 +2726,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
 	bool do_cancel_work = false;
+	int subflows_alive = 0;
 
 	lock_sock(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
@@ -2747,11 +2748,19 @@ static void mptcp_close(struct sock *sk, long timeout)
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast_nested(ssk);
 
+		subflows_alive += ssk->sk_state != TCP_CLOSE;
+
 		sock_orphan(ssk);
 		unlock_sock_fast(ssk, slow);
 	}
 	sock_orphan(sk);
 
+	/* all the subflows are closed, only timeout can change the msk
+	 * state, let's not keep resources busy for no reasons
+	 */
+	if (subflows_alive == 0)
+		inet_sk_state_store(sk, TCP_CLOSE);
+
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
 	if (sk->sk_state == TCP_CLOSE) {

---
base-commit: e2c1a934fd8e4288e7a32f4088ceaccf469eb74c
change-id: 20230214-upstream-stable-20230214-linux-5-15-94-rc1-mptcp-fixes-517feb25bd47

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

