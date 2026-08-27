Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606663E1690
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874921; cv=none; b=gcuWLUMAgoZ9KNzKxrx+b2SF0MEkdwHnXCPdw1uwXLonqN32fSFQipNMtuVSNpqsiqyAciorbkvETA64VLwJKJE+IOT/dPZfmpDh2e0u22Pd2uMigZGRHQsBp/jmVkkVmAs9IQozYSJFqVVgTW96KPUdGYfwQ7o9wXOozYdzrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874921; c=relaxed/simple;
	bh=17DL7rhafk1dsgIeYoK4mS2o50WhRjWyO2dEKqAEpdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXXYsGUrN05EjPWZrTqAhPUmdDAZ2ogF6uJrSkcnb7mUL04sBQsauCuUICme4glTrxkutTiqZ3UghAUI6v+CkUsszkIlGYKjLnhQHpnipqdKxAjRg1srXOGPHLrHi9uNzaTFAvPx1ZeaKhjfuojZOUGEtrb3p4x7lJwx8ZczxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5FeWItm; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5FeWItm"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66c711b7f2aso765568d50.3
        for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874916; x=1788479716; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvm7J3YSk1/1T92COXCSTc907ZSd3vJ2D2ODqJKXqh8=;
        b=q5FeWItmA+WyAsysGlU2kuoI6LfSklnKDaFYSSkHtUHBJ6Gv60G3KUHX+1WpQwuAI7
         6CDf3wEUia2u3NYz78LCB43nB+h2HpmuAK7VxfcC2XFyJGOFqBUQMxYM6wBpskP8swni
         YstoMfsdGqeLp+rUHaxTucM3Tr47/0kHs5qgaRzci/AXcwF6c0FXJkYAMTZ0gxhRu+WW
         gMOMZkWccJ0n7luHrxGFrzFN2Lpd59y9eJ6f6FnU4a5B3DCeJ0XgqoXhRTH3S/G7LLJl
         gOgQTai2g9HBmUqhmpYLN92UhnWtlr63Kfie8BljmG08FXCIkhGWweNvC+Vv77luWS1o
         S8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874916; x=1788479716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvm7J3YSk1/1T92COXCSTc907ZSd3vJ2D2ODqJKXqh8=;
        b=pNyjw/jqVVRLaQrdnBbbVlJin+J3Fs+q/O3wBRYxht94ftUlYK/tyErkpoL16fOQb2
         Z0CPBYz6f1lAnQt0cPpXaSPujCkAMh39iBg+FaYu6rPHqIdnSJUdzc9+E1iwXlKV6zWd
         TNDhYxftT8zmcKWA9DakyU5qkOHWrDbzHzjm6nUwbR0bpmhiBdmmHmCcDGFWY+w16KNI
         n8s/TUzEXSls7/eCejynGDmfI691bEa2zciDuUrAAbhBS8P8j0T7GeprQgnkHUp7fdnR
         uqo9aQLrNBhA8U36C6y0Dt69ZB0z4HXdF2PxsZaK1TYAXE01X6FqxpbWuImuj6qqz/mO
         80zQ==
X-Forwarded-Encrypted: i=1; AHgh+RpxRY8vWb7t3CSwBhjqHSIgfupWBADCyu77bKCXFjCWxCOf0caBzEOk00yWypcI3ICOGQS5Yw==@lists.linux.dev
X-Gm-Message-State: AFuF++ne/1q0TjR4cvBZNkUjMf9ByEyw3JvrSZT7ixSqty6f5b85W0WP
	i63ChPDLADTvBjWaWbwGN2H7K5gxrQwz+vACjEnzI/4HxG5J3zO3Lq0h
X-Gm-Gg: AR+sD11nbJCCH2dTvxhYEIWyvVPwCyk1coLy6EYODQLaK0YYDfHEJc/uPUWF52vagdW
	Nqy2UxA64dzGDJrscoJODBxWPEktPT0cG/AzQVK8JXanjNH23tMrdmiI2prCBb2KoOP42q2/WsZ
	30asy2Ag/dDM4rw9uTWnnr+V9hYcgKRV7SvrKQHoEzg9ztekec5bPrT182hjVM7j6O8TcPC+y0V
	H5Hd66m0rwzjkXesK27toeeDzS/ImC8VZRuIUpB+XtEW40nWmN487kU9I7T/rFngfuKHOr+hkZC
	vzDcVgy6wLRja2I0G71JLQlNjcNhCS4FKiOF7gwJ+dDdbwsw7HWKA/twsryH54kMNca5kmynMUq
	KbwA2rZIfIZJp3OqIpq6hqMXh2N3q5hNHnMiAHOnqCljCuXvoF0kFETlmcEX4m74oGN7CscXWj1
	y0MFssxgoQcH8M3wuGJKF2Sdcmzf6OfT+2XYxBlpE0MTVdKnNR8KBhDNzj+QtrzHxrYaCEUjSso
	ckcMQ==
X-Received: by 2002:a53:b812:0:b0:66d:2b87:67d2 with SMTP id 956f58d0204a3-66e4c6505demr643968d50.14.1787874914413;
        Thu, 27 Aug 2026 16:55:14 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4eb3dcdbsm55704d50.4.2026.08.27.16.55.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:55:14 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	yhs@fb.com,
	kafai@fb.com,
	andriin@fb.com,
	ast@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
Date: Thu, 27 Aug 2026 19:55:10 -0400
Message-ID: <d3f97f1acbf0010898148be6e6406e4b8b4a5c84.1787870710.git.blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787870710.git.blbllhy@gmail.com>
References: <cover.1787870710.git.blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>

do_tcp_getsockopt() reads icsk->icsk_ca_ops->name without holding
rcu_read_lock(). Since commit 0baf26b0fcd7 ("bpf: tcp: Support
tcp_congestion_ops in bpf"), icsk_ca_ops can point to dynamically
allocated BPF struct_ops memory that may be freed concurrently via
setsockopt(TCP_CONGESTION), leading to a use-after-free.

  BUG: KASAN: slab-use-after-free in _copy_to_user+0x37/0x60
  Read of size 16 at addr ffff888013505260 by task exploit/149
   _copy_to_user+0x37/0x60
   do_tcp_getsockopt+0x158a/0x2460 (net/ipv4/tcp.c:4585)
   tcp_getsockopt+0x91/0xf0
   __sys_getsockopt+0xf7/0x170

Fix this by holding rcu_read_lock() around the ca_ops->name access,
using READ_ONCE() to load icsk_ca_ops, and copying the name to a
stack buffer before releasing the lock. Also annotate the relevant
icsk_ca_ops stores with WRITE_ONCE() to fix the accompanying KCSAN
data-race issue.

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Suggested-by: Eric Dumazet <edumazet@google.com>
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Link: https://lore.kernel.org/all/20260821182449.79785-2-blbllhy@gmail.com/
Cc: AutonomousCodeSecurity@microsoft.com
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.6
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
---
Note: The adjacent TCP_ULP case has a similar read pattern on
icsk_ulp_ops->name, but icsk_ulp_ops always points to static
module data (no BPF struct_ops equivalent), so it is not affected.

Changes in v3:
- Fix the build failure by loading icsk_ca_ops inline.
- Drop the unrelated WRITE_ONCE() conversion in mptcp_ca_reset().

Changes in v2:
- Add READ_ONCE() for the icsk_ca_ops load.
- Add WRITE_ONCE() for every explicit icsk_ca_ops store.
---
 net/ipv4/tcp.c           | 14 +++++++++++---
 net/ipv4/tcp_cong.c      |  4 ++--
 net/ipv4/tcp_dctcp.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv4/tcp_output.c    |  2 +-
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b..55ca74f60 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4576,16 +4576,24 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		val = !inet_csk_in_pingpong_mode(sk);
 		break;
 
-	case TCP_CONGESTION:
+	case TCP_CONGESTION: {
+		char ca_name[TCP_CA_NAME_MAX] = {};
+
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 		len = min_t(unsigned int, len, TCP_CA_NAME_MAX);
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_sockptr(optval, icsk->icsk_ca_ops->name, len))
+
+		rcu_read_lock();
+		memcpy(ca_name, READ_ONCE(icsk->icsk_ca_ops)->name,
+		       sizeof(ca_name));
+		rcu_read_unlock();
+
+		if (copy_to_sockptr(optval, ca_name, len))
 			return -EFAULT;
 		return 0;
-
+	}
 	case TCP_ULP:
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index e9f6c77e0..8e83ef81f 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -223,7 +223,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 	ca = rcu_dereference(net->ipv4.tcp_congestion_control);
 	if (unlikely(!bpf_try_module_get(ca, ca->owner)))
 		ca = &tcp_reno;
-	icsk->icsk_ca_ops = ca;
+	WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	rcu_read_unlock();
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -253,7 +253,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	tcp_cleanup_congestion_control(sk);
-	icsk->icsk_ca_ops = ca;
+	WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	icsk->icsk_ca_setsockopt = 1;
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 274e628e7..99f68c299 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -111,7 +111,7 @@ __bpf_kfunc static void dctcp_init(struct sock *sk)
 	/* No ECN support? Fall back to Reno. Also need to clear
 	 * ECT from sk since it is set during 3WHS for DCTCP.
 	 */
-	inet_csk(sk)->icsk_ca_ops = &dctcp_reno;
+	WRITE_ONCE(inet_csk(sk)->icsk_ca_ops, &dctcp_reno);
 	INET_ECN_dontxmit(sk);
 }
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 6ab3e3a0b..def3b25ab 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -507,7 +507,7 @@ void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
 		ca = tcp_ca_find_key(ca_key);
 		if (likely(ca && bpf_try_module_get(ca, ca->owner))) {
 			icsk->icsk_ca_dst_locked = tcp_ca_dst_locked(dst);
-			icsk->icsk_ca_ops = ca;
+			WRITE_ONCE(icsk->icsk_ca_ops, ca);
 			ca_got_dst = true;
 		}
 		rcu_read_unlock();
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d7c1444b5..e72ebfe7b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4092,7 +4092,7 @@ static void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst)
 	if (likely(ca && bpf_try_module_get(ca, ca->owner))) {
 		bpf_module_put(icsk->icsk_ca_ops, icsk->icsk_ca_ops->owner);
 		icsk->icsk_ca_dst_locked = tcp_ca_dst_locked(dst);
-		icsk->icsk_ca_ops = ca;
+		WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	}
 	rcu_read_unlock();
 }
-- 
2.43.0
