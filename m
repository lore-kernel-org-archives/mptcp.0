Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D5F7F
	for <mptcp@lists.linux.dev>; Sun, 11 Sep 2022 04:14:51 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id v4so5217781pgi.10
        for <mptcp@lists.linux.dev>; Sat, 10 Sep 2022 21:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LhJhUyCsCXi2qaJD2JTMjj1fabu4ti5WGBu8gmWo01E=;
        b=dKnLIUlTw6r/3l4WrPoMrWipusUqCOxlgnSN5W+q1fhUeK8Za7EM/5FBa8zPo+Qtiv
         HOLm9jom5POv8HBdjGTEQSwELt9VGg4kC7b6j9UMATWWQZaX1MM2R/y3OLazs8YizP8V
         HLFfzEeO+5K8E+GQIxcpcIcbDNaAa2tQqwMr6Ifr14VtPn10uLjFGgjZHU4cfgz3UkVL
         ERUUUvyeDcsQ38ijshxv+GpT8nvcDqIKD5QPDN2fmMPl6pTJl3ocGoyo/TFnkN1Mg1A3
         T/Dx1b5Wp6gPY1Doz5egnoDTwen4zsRfR77FCW3HrIXfj7/weWKF3TUxfbbVBF3jqCOx
         Uhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LhJhUyCsCXi2qaJD2JTMjj1fabu4ti5WGBu8gmWo01E=;
        b=SLXsWe5BZ0zBb1FgiCW7ULRh+QGSHWbEd7ECtgfxswsxZanXOg+uXOHg08tQE4SwpG
         SodQFhfvxGBaDMPQToluFRJNzobSgOGPW2XTi780f3VBUFXYbOPsol14na5W0hZVg8qH
         GVs+M7AY8lhsGdhW/0OU52VmLAoLKSLI717/k15+gElSmeNSFcL8+HjDVCXTY/oC3QIb
         8BNwgpjBtJh9PraApa01sRjgKN0/EjOa3Sd/OO99kz+D7/JfbAtGX7paux2SF+1/xFii
         b7mNNajS2VDHgsDq+v+hX6TeTKqJHftRe0Ii0KbzRO+vjOeVxySNqy7D64TTrvta5yKt
         u9OA==
X-Gm-Message-State: ACgBeo21b5bG2LlIVudshym8MrhRKoU0zzpkE+IPJwQMYS/90CevAWfY
	R3UFW5R2eG9RCZKVy8JWr2ShFL9lhc0=
X-Google-Smtp-Source: AA6agR57bLmbQoUoVpg8+M1j7gz6I3bUVGti9eEnEg8lnxe4cpfqxuGrGOrvDPhit6UMOuqLky9r5w==
X-Received: by 2002:a05:6a00:8c8:b0:52c:887d:fa25 with SMTP id s8-20020a056a0008c800b0052c887dfa25mr21697557pfu.86.1662869691427;
        Sat, 10 Sep 2022 21:14:51 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.24])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090ad48800b001f2fa09786asm2783752pju.19.2022.09.10.21.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 21:14:51 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>,
	Jiang Biao <benbjiang@tencent.com>,
	Mengen Sun <mengensun@tencent.com>
Subject: [PATCH net v5 1/2] net: mptcp: factor out __mptcp_close() without socket lock
Date: Sun, 11 Sep 2022 12:14:17 +0800
Message-Id: <20220911041418.818201-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220911041418.818201-1-imagedong@tencent.com>
References: <20220911041418.818201-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

Factor out __mptcp_close() from mptcp_close(). The caller of
__mptcp_close() should hold the socket lock, and cancel mptcp work when
__mptcp_close() return true.

This function will be used in the next commit.

Reviewed-by: Jiang Biao <benbjiang@tencent.com>
Reviewed-by: Mengen Sun <mengensun@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v5:
- keep sock_hold() in __mptcp_close()
- rename cancel_work to do_cancel_work
---
 net/mptcp/protocol.c | 14 ++++++++++++--
 net/mptcp/protocol.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d398f3810662..06bb43455c62 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2796,13 +2796,12 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sock_put(sk);
 }
 
-static void mptcp_close(struct sock *sk, long timeout)
+bool __mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool do_cancel_work = false;
 
-	lock_sock(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
@@ -2844,6 +2843,17 @@ static void mptcp_close(struct sock *sk, long timeout)
 	} else {
 		mptcp_reset_timeout(msk, 0);
 	}
+
+	return do_cancel_work;
+}
+
+static void mptcp_close(struct sock *sk, long timeout)
+{
+	bool do_cancel_work;
+
+	lock_sock(sk);
+
+	do_cancel_work = __mptcp_close(sk, timeout);
 	release_sock(sk);
 	if (do_cancel_work)
 		mptcp_cancel_work(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 132d50833df1..8f123d450c76 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -612,6 +612,7 @@ void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
+bool __mptcp_close(struct sock *sk, long timeout);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
-- 
2.37.2

