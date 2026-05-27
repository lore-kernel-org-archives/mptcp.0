Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19A3264E4
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890853; cv=none; b=cmipG5lEZrLc6I5E4HHjbjLZ/0q3fluwHzmApv7/yzxxCVNa5sNK4XknoU2vXjQjYpJ+cQshslQHWDmgC/kj5XYcaYjuFjyMKk/KsPXVbhVqOQFXVwvWZWtijw2tP9WBDOQ/ASc7G+5Jt45qhYs6pxP4Sb6yU5b4Sh4gNWZc0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890853; c=relaxed/simple;
	bh=Tx/zb9pg36aBzy2Rzy5NBmpqSk3pVmY/Ufp9Kga3Gx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIrERreWEHKxwsOe3gHn4OBHEd2M24DnqE7LBaytbVKpOca1OScuB1rohtmHfF7acEyBHyzbsJ6gwHmpiIdKBlrk20dqEFCjmRJ5xSLXWHcH3gOxQBapZBAAatr/ms9yj1LKZvHVmI45ludzoBY247Ot10hsy9djHykT7W2NaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYeK8lfh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYeK8lfh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso52503985e9.2
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890850; x=1780495650; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzaPU68M0pQLuUxyxSThxVxiz6eq+D2nBzZtqTTvNa0=;
        b=VYeK8lfh0DqsOLLh8ODVxTXj5ptJvxpWrOprB7MF20gHqZnUz/KgHZNWUG4YcHxSS/
         JqDMhkPcge8THI5PyNL4X86E8H6pCGT7F7iEAGcQZJh4h4TTKDaYAjszF9i500Wx6onr
         JrCgYlZRXFMdA+70f6DFEwE1zA3lKd1X2EJeyLYkGLvSpETpCzN32qfH8sMpoK6oo5UO
         8O1r7T0L8H+ALcZxaAbNQnO+QxyNS0bVRUPK5xHSd8f7pWmMISs5quXq0EQ2bPgl2aP+
         0Y1PiZ1jCiWCYpU6GnWZfCUrF7bhxlbI9Chh7nyhoa1zh/2ZBk0q7opM7n0NehmMrLnH
         EnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890850; x=1780495650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qzaPU68M0pQLuUxyxSThxVxiz6eq+D2nBzZtqTTvNa0=;
        b=N4t6rOXpSvO18splOvBoNp8BSOS5QONrBFFlvemTmlFp+H2G7T1jdXvnxqb9Ufyy7u
         M4ngkvPt75vkbZh7UNj0ksAW527ZiHWpTBubeSxNmOgwZsdvL+eFe9OkGQTXh0LSsO90
         Ldn9jjkki8yuX7Hy7ebr/+m2LhbUtmA0xXABxRwhxBpyIoN08ul6dDgspP733OK/4c5Z
         iAZcxPGrweDjAmxZr4mk++0FUe+PzJIYrfATgcOsZPstiz4GDqkOOVL9NgXFbalSmIEs
         0+WxVobOyT13CGWJVuodR7zFVqmBQIU0BbTGOEy8366u4MZRKrqKlMn8+2JY+rJHyu9m
         Fv8g==
X-Gm-Message-State: AOJu0YwrEZeiUHzOnvSm6SLZsO3VZ1C90/DJk96gXoTwXVTCEt1qovEz
	haQ6ps4PWUSPWNTXlGULPq1OgZ05/IgZt/JnBTteoPlgV5jL5tYP9InGgdyk4bJc
X-Gm-Gg: Acq92OE8ENnzs6bhwGKYp9803AeCynaiVv8KVZdoEqAnYtY8LWoaOM9fMWl9ylqTUnQ
	bbU7rEJl+9aqrmmxjex4CFRp7LMUgsU9+zt74oe+eUr1ynCx0/0WaTToOgUvG/oL9zTXZDXJtTr
	ouO8xtlcK5Rmk8iPYhlETH8bjFyYXC6vg7zE8MTyRgn0LMDXq/21nWBTZTUfYuJe/gc3PPriis7
	o/52g932MSo9Z6pTazMR9u7xkgJli8orv1zyYCKARHldzmAeL3UfEo5GBdLA82Mz3r4I3R73P2t
	SrABDJ4ohmkAyt4HZJCsbXtqXdx7IGDP7Ef/aq1B4CaUO69mhj8Pur51fdtyQ2zqjarTpfbOjD+
	e7aDODgSPQSKIX3VrEyhZpNACsWXlVLdGPQhFdA2WkUCkQ+6TMkhtjAFk7G/DY/GrtGY2fVZa3g
	OpqVTGnR1g/RDG7ZDBaRH0HJ95yfNDO+No/vNfozsDaWIkk1j8N5hKD09m6oqEiAC/oIzR3IrFH
	ZxrolqP8/w=
X-Received: by 2002:a05:600c:a402:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-490425ad10cmr316187545e9.14.1779890849432;
        Wed, 27 May 2026 07:07:29 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4907e6c7433sm19579085e9.8.2026.05.27.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:07:29 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v8 2/4] mptcp: propagate RECVERR sockopts to subflows
Date: Wed, 27 May 2026 15:07:16 +0100
Message-ID: <46f02f1f3bbc5ebd9a06efd88edc1361b8e6fa13.1779890764.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779890764.git.devnexen@gmail.com>
References: <cover.1779890764.git.devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate IP_RECVERR/IP_RECVERR_RFC4884 and
IPV6_RECVERR/IPV6_RECVERR_RFC4884 from the MPTCP socket to existing
and future subflows.

mptcp_setsockopt_recverr() snapshots optval into a local int, applies
it to the parent socket via ip_setsockopt() / ipv6_setsockopt(), bumps
msk->setsockopt_seq, and forwards to every subflow via
mptcp_setsockopt_all_sf(). Newly-joining subflows pick up the four
RECVERR bits through sync_socket_options() now that
MPTCP_INET_FLAGS_MASK covers them.

mptcp_setsockopt_all_sf() skips IPv4 subflows when called with
SOL_IPV6: ipv6_setsockopt() on a sock with sk_family != AF_INET6
returns an error, which would abort the loop and leave the remaining
subflows desynchronised. This branch was unreachable before this
patch (the only caller was TCP_MAXSEG, family-agnostic); it becomes
live with the new IPV6_RECVERR / IPV6_RECVERR_RFC4884 caller and the
v4-subflow-on-AF_INET6-msk case (v4 MP_JOIN, or userspace PM grafting
a v4 subflow onto a v6 msk).

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Assisted-by: Codex:gpt-5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/sockopt.c | 123 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 101 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b9cac04a749a..28229fe3eeca 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <net/ipv6.h>
 #include <net/sock.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
@@ -19,7 +20,11 @@
 #define MPTCP_INET_FLAGS_MASK \
 	(BIT(INET_FLAGS_TRANSPARENT) | \
 	 BIT(INET_FLAGS_FREEBIND) | \
-	 BIT(INET_FLAGS_BIND_ADDRESS_NO_PORT))
+	 BIT(INET_FLAGS_BIND_ADDRESS_NO_PORT) | \
+	 BIT(INET_FLAGS_RECVERR) | \
+	 BIT(INET_FLAGS_RECVERR_RFC4884) | \
+	 BIT(INET_FLAGS_RECVERR6) | \
+	 BIT(INET_FLAGS_RECVERR6_RFC4884))
 
 static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
@@ -394,6 +399,82 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
+				   int optname, sockptr_t optval,
+				   unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	int ret = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		/* SOL_IPV6 options on a v4 subflow (v4 MP_JOIN, or userspace PM
+		 * grafting a v4 subflow onto an AF_INET6 msk) would otherwise
+		 * abort the loop with -EAFNOSUPPORT from ipv6_setsockopt().
+		 */
+		if (level == SOL_IPV6 && ssk->sk_family != AF_INET6)
+			continue;
+
+		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
+		if (ret)
+			break;
+	}
+
+	if (!ret)
+		sockopt_seq_inc(msk);
+
+	return ret;
+}
+
+static int mptcp_setsockopt_recverr(struct mptcp_sock *msk, int level,
+				    int optname, sockptr_t optval,
+				    unsigned int optlen)
+{
+	struct sock *sk = (struct sock *)msk;
+	int val, ret;
+
+	/* Let ip_setsockopt() / ipv6_setsockopt() validate optval and optlen
+	 * (so 1-byte boolean writes keep the same ABI as plain TCP) and update
+	 * the parent's RECVERR bit. Re-read that bit under lock_sock() and
+	 * push it to the subflows: concurrent setsockopt callers cannot leave
+	 * parent and subflows desynchronized this way.
+	 */
+	if (level == SOL_IP)
+		ret = ip_setsockopt(sk, level, optname, optval, optlen);
+#if IS_ENABLED(CONFIG_IPV6)
+	else if (level == SOL_IPV6)
+		ret = ipv6_setsockopt(sk, level, optname, optval, optlen);
+#endif
+	else
+		return -EOPNOTSUPP;
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	switch (optname) {
+	case IP_RECVERR:
+		val = inet_test_bit(RECVERR, sk);
+		break;
+	case IP_RECVERR_RFC4884:
+		val = inet_test_bit(RECVERR_RFC4884, sk);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case IPV6_RECVERR:
+		val = inet6_test_bit(RECVERR6, sk);
+		break;
+	case IPV6_RECVERR_RFC4884:
+		val = inet6_test_bit(RECVERR6_RFC4884, sk);
+		break;
+#endif
+	}
+
+	ret = mptcp_setsockopt_all_sf(msk, level, optname,
+				      KERNEL_SOCKPTR(&val), sizeof(val));
+	release_sock(sk);
+	return ret;
+}
+
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -436,6 +517,10 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+	case IPV6_RECVERR:
+	case IPV6_RECVERR_RFC4884:
+		ret = mptcp_setsockopt_recverr(msk, SOL_IPV6, optname, optval, optlen);
+		break;
 	}
 
 	return ret;
@@ -781,6 +866,9 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	case IP_RECVERR:
+	case IP_RECVERR_RFC4884:
+		return mptcp_setsockopt_recverr(msk, SOL_IP, optname, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -808,27 +896,6 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	return ret;
 }
 
-static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
-				   int optname, sockptr_t optval,
-				   unsigned int optlen)
-{
-	struct mptcp_subflow_context *subflow;
-	int ret = 0;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-
-		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
-		if (ret)
-			break;
-	}
-
-	if (!ret)
-		sockopt_seq_inc(msk);
-
-	return ret;
-}
-
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -1473,6 +1540,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	case IP_LOCAL_PORT_RANGE:
 		return mptcp_put_int_option(msk, optval, optlen,
 				READ_ONCE(inet_sk(sk)->local_port_range));
+	case IP_RECVERR:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(RECVERR, sk));
+	case IP_RECVERR_RFC4884:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(RECVERR_RFC4884, sk));
 	}
 
 	return -EOPNOTSUPP;
@@ -1493,6 +1566,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_FREEBIND:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    inet_test_bit(FREEBIND, sk));
+	case IPV6_RECVERR:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet6_test_bit(RECVERR6, sk));
+	case IPV6_RECVERR_RFC4884:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet6_test_bit(RECVERR6_RFC4884, sk));
 	}
 
 	return -EOPNOTSUPP;
-- 
2.53.0

