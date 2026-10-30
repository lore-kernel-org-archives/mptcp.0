Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334179;
	b=FlCX1cuA6ukCxPY+vysjNUGqlEyc8l1Sz4rbj8i4K0ZgJ53QTaXPQaZJ+FBNbwZ/PHta
	 BeE0DYvEdkxeUeWFmO6lDe3ee6AlLgYhitvPpRAQPll9DhqHJeSI/UsvBBe6iEg4C18Dd
	 N6l02IL8E4xgAXed9/aqzaz0UOQVGHt6Fhebd/aVJ5PIJSXLrFhLfzH7nhQy5NQ7gTTON
	 ykD/Tg04rbl9idyDCPIQaOGKCj9UaSG1zjszoNe1Jxk8X/+Sss1FpiwD2g7tS586m8ofN
	 FA3bfV49zaU22fhAUeohRww57Ps/r3u8hVz4HMP/PgBbzWjpNW2E07O4exm0ffUEpWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GJHR2hSEQjDA7JEPW4kRvNrUrFju1iQ8fE/qcrxDnx4=;
	b=0Ja7N0JKJgmwR65ZIMO3ti4WTQs99WZpIpzBFB9lbxlOPewyr7xu7seBgQL18o7RtgC9
	 0oCcVF0RfTtk61tqmtzPjVz5fQFbjJnc9zZP7+h1OHQUwa1C862oB+A6+KDfS25nCestn
	 /4RVvifD+JQ1izPZ6jBo4uUlvZYl0tzbspvqn7tsq8SzxKWPWnagDFcHbyi/8KDVl/hJx
	 HvYkAYxbFPvCGgB8qYVjbZ98AluQBLvFBPx3UVvV1/1OQjOxgmSg099wU0dnx39Ns/vtl
	 PaK9gUZUVmYUUG9cOt7Q/R7X6Qv6F3jv2vdHHHXHq5LVNeZVWTLTI96wgFwkcjxDNMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=X0FwmFFm;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300A606A31E
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 04:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8300A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=X0FwmFFm
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-7037daaa820so109442eaf.2
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334177; x=1793938977; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GJHR2hSEQjDA7JEPW4kRvNrUrFju1iQ8fE/qcrxDnx4=;
        b=X0FwmFFm2QF623Qw4K6bbrlTr/nh1xvV8gbLZ/z4tPKXmwXeqRNA+ag2nZ9uPqsn0A
         AQoGNV4cmANYnkpmGOLgmlOr34k2ccrCeezRTEgJtZ8t4DtI7lhwGlzJhp+OQMM3taB1
         PONM2yTLiABBkJLSFnJucYuiInrh/keY2DS/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334177; x=1793938977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJHR2hSEQjDA7JEPW4kRvNrUrFju1iQ8fE/qcrxDnx4=;
        b=YqO7I4Jf4ncmffY1WEmozPythJjWGkS8+L+VteSgeVWWcClLeUfNRAz3qAt0dwaC7d
         aam63o3h3X/N0F5NjFJ57Yby1H5dMuLXYytY3DgxyenlMbnqQMTMIVNNU+xgQ+E5zU1z
         2XVMYIFgaV1s76qgFZOLoRzk29JJM6qVRsxsXmK9fQQETZsiW31RgW9e4sLTbbvmuwix
         49ApZRHu3Tj+AG1S72wZfi9x9moFDzByoTWE/wjjn/Pr5Li/uL5MVg1omkOlkYNxb4yy
         shospGJnQ9ekt1AV2sMbEMVodDtMIx7QXl08bLihbvjOkgm2f4xgNIUodwetfncqn50P
         MaNw==
X-Gm-Message-State: AFq9FYIIfpBD+/x3bufnPx1CAuSugE6/+0ji7J4Z3zZQvTWyuWg+p8+s
	EEqF8ecH3h81MOu7/7RbsF+/an5B1cm1R0r+sxc158IuyFJSWiZPtgB1Em8sfvI91giy6lh+538
	+jkzvroM=
X-Gm-Gg: AYBFou3BbG7oc9jA6IkzF+hjwz8paXPlIZQqgrGSCFxza4R+I4izOiuOsTRJkuu1+us
	hye6G91OrRNF5bJm85SLL8NLGBpPM66r59JnsxzUu17xTqU2A9UHU+RUtqcKr6Q+NFq/1V5b/Fm
	SsN1bEe4MBcNLtU68hmSrwKdTUujvnF4NWeTaCgPpmYRWbclTXRXh9Q+hSD+Rr3taRe5QqBsTpy
	AlUX2oms30Vxc8J8dz5bSmqfpNkDQUrGZAFIpEolz/MfSqWmspdMfs3L1VHcvfzi0Eb8Ud6uVK0
	VjhfKFKorfC26F/fvzSWla2fZHLDMu2DqLbqn9Sr+Ku40T7Q2vxdNdtLW4bfa9przKyg3/uA/wQ
	ChGkmTjJa0P4drCmyrcE8OlE/SdAqiHkjvChQQiB51ZW+SS5ZzDK4cCjuRY0U2nRctgncE2KmPS
	S/m1lJk/Jto+mE2bIugQNKKvybjZjPsUewz09daeqWghgwYlj1T3mggxzlb+89DD/5syesbXupQ
	vhZ63dPem/GuJq5ZpJxE8GqBEq6RFbP92cxodWmVLTSA6f7sTp4GMYlj+ple6Jpzw48mUw1d0OB
	B+IYf51Z8xv/EyA2OcY4VyuN15JiitOQB61t8F36S2rlA0qTuDSoTfWzILgRq/W3Xe1GegDLcBD
	i5evt/qyzBoTKmqM4UyI4HTRn4+pHqA==
X-Received: by 2002:a05:6820:55d7:10b0:70a:598b:127c with SMTP id 006d021491bc7-714f29e7222mr536195eaf.45.1793334177541;
        Thu, 29 Oct 2026 21:22:57 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2a818b9sm1094944eaf.1.2026.10.29.21.22.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:22:57 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] mptcp: pm: kernel: use RCU to free endpoint listeners
Date: Thu, 29 Oct 2026 21:22:55 -0700
Message-ID: <20261030042255.74216-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_pm_nl_create_listen_socket() starts the TCP listener directly
instead of going through mptcp_listen(). It consequently misses setting
SOCK_RCU_FREE on the parent MPTCP socket.

tcp_child_process() can invoke the listener's subflow_data_ready()
callback without holding the MPTCP parent lock or a reference to the
parent. An authenticated MP_JOIN racing with endpoint teardown can
therefore access the parent after its last reference has been dropped.
The ADD_ADDR error path can also close an already published listener.

Set SOCK_RCU_FREE before __inet_listen_sk() publishes the TCP listener,
matching mptcp_listen(). This protects the parent on every subsequent
close path, including a failed endpoint addition.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/mptcp/pm_kernel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a7750813235..f7396628490e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -906,6 +906,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	 * old status is known (TCP_CLOSE).
 	 */
 	inet_sk_state_store(newsk, TCP_LISTEN);
+	sock_set_flag(newsk, SOCK_RCU_FREE);
 	lock_sock(ssk);
 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->pm_listener, true);
 	err = __inet_listen_sk(ssk, backlog);

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
