Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1588032ABCA
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764472; cv=none; b=oLiZZ+NAO3Ol+uyo/wY1qw5i+lW1A/y+o5kgQl1BTBOA6/kb9iZg3wg3C1QxKIR2RFs1vNgSqBPqOmsI/4RNVUoDuZtDQ+0o3PSWmnVE8h/mnwoGWrXL8TGAISJGyT2zWGnw2A5lpyuz/O1UH97eyNCcRjFBt6g5afYqP+zKHKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764472; c=relaxed/simple;
	bh=GVs+ZNQs+K6IwSJgOb8nQUeglTVCjZ+pd60CynzS5K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKImfo8D8vag/4quFbHmJIvEc9f08GLE4i/oyj0t+m47xuG6D2H9XQvYlpAKIxEt333tLFtLntozw0VWuZ+B4mtMGBd6UvcsvVQr0MZgumGiR/jez/d3la+fUir3LLCb+iBvQ0iH00bhxQY/I0KodnMcBAnDowXpEmQh3vTAs4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikWTvqYw; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikWTvqYw"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66c744a00edso1058095d50.2
        for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764451; x=1788369251; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccxl4Hbr9QQtr79HZmn4JSZFJJOV4fZach2l3iVk3ec=;
        b=ikWTvqYw86pAOhgfPaPZaFPbWjap1cJXiMq9ajrXtY4iBGta6p6QraMtjg9fdIP/xf
         TGNvM5wB1ZxDPa4B4gAOukf08O9tCcFeYqfi9Sma26yAv4bJXcGzAftWnKOJ5uXqfxVy
         rgkRIXzdDGCh+moxY8+Rwv86nkHwiJx/jHHaMiCbgsNSIludCes8Tm953cJ16EVc/Pyq
         0+SIVjy7weAe5vAwqJJJte/rdjRNvc7TCvm7RwkFxvvmksbDJNI4LO0+IuAqs+1ZWrUV
         6K3Ddg2KfnDj35XPCY1oMqwOP7q2pn0QU2LFPpcyGvgSBNpmoTtun3xb8q73KM4LQl/y
         cb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764451; x=1788369251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ccxl4Hbr9QQtr79HZmn4JSZFJJOV4fZach2l3iVk3ec=;
        b=jf07UcOANq5mqpglKztjBpQ5SXDwaUtN/Yvt++3lU8+WBAfqlKLfH5SMSocEiKpoTg
         OsgWxXUDNe1DHH67bG6PYEjFd8nRY+dZxdeuY9m97SfCTB1Tcb6bGDIMw2y3hfS405Wt
         ES4o3tq6HjZxZzLZ8Ivx6hrpXfhtyD8xwTT6JNLRN+b3z/vbtAgOqnBhY+rMiLEY128k
         NmmujdLH6XKOvClE1p/OXSHxB0hf+jYxNVRynnAEBbI17t7GSXP/xyNfCwlFfqqHn5Ex
         UZxYcRtjojW6/lviVDUKiyik+gpzfBpqIB04yqLSL+K0UQOULDvp9SQP9E5pheuHaYVx
         1/eQ==
X-Forwarded-Encrypted: i=1; AHgh+RoyvsS3F2r1Y8W066phalwzzUgpjvF0P6Doa3TxvmhyDUHHSF+G9y+ftZ0YWh3z/od8Sv2YVQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n8UHIH6ZokwVWllg1SFt4Lv3g+PMqQu20WoT+x+K+J8YGCosAD
	yRYovwjd/DaAHxEHATv3y8CxmYAoU5ttXOZik7hu3e9ru4Yu43bQKNtW
X-Gm-Gg: AR+sD11DOhA+mLUQ6VdWO5Xu2ohGLjQ8u+MhDZrtYlyTD82z9Jm3b/z6i+yg+ILfEdF
	IizRGxPoJBtII+x5Ljwnr3A8xyOJ4k7kY6fk8h4VVQJihWV//Y1AYQPxad2xE6oCw8EAPnUBxwk
	idtlsAiqlQbm0woT/6363bNahQeyPmirRi4mdSm/CX+SszgdAjl2koo/9d6fpIDELVzM1uBhWFH
	SKN8ge+8O6mU5NE2JvSsMo5dn0IcuOYttmaTErRgUp4Y2+vnjydBMeRf+Wzdb30GR331zsN0IYl
	+cMkPD2y5FGvZe2HxHP3dqqvVKAf902tghJdOAyXWBp+tqP1tS+eLDkHXRJtiM9s15pOSasHMDH
	gebV3nBIQI98XFopSjOYTbaty7Amh3P19cZ6HWaVrs73/qCHSBQBSjaXiYAjCRFmNzI/Bt3BF7k
	yD994fNKhRkYG9aUdkFD46Ccy+MOI5vxrgsnBOW8rwEmqNvVw5Zj1cmu2e//z0l5XFZ7M=
X-Received: by 2002:a05:690e:12c4:b0:667:97c4:7058 with SMTP id 956f58d0204a3-66d2578fba2mr2268394d50.37.1787764450695;
        Wed, 26 Aug 2026 10:14:10 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8570d620433sm19313287b3.42.2026.08.26.10.14.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 10:14:10 -0700 (PDT)
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
Subject: [PATCH net v2 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
Date: Wed, 26 Aug 2026 13:13:43 -0400
Message-ID: <20260826171344.4133-2-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826171344.4133-1-blbllhy@gmail.com>
References: <20260826171344.4133-1-blbllhy@gmail.com>
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
stack buffer before releasing the lock. Also annotate every explicit
icsk_ca_ops store with WRITE_ONCE() to fix the accompanying KCSAN
data-race issue.

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Suggested-by: Eric Dumazet <edumazet@google.com>
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Link: https://lore.kernel.org/all/20260821182449.79785-2-blbllhy@gmail.com/
Cc: AutonomousCodeSecurity@microsoft.com
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.6
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
---
Note: The adjacent TCP_ULP case has a similar read pattern on
icsk_ulp_ops->name, but icsk_ulp_ops always points to static
module data (no BPF struct_ops equivalent), so it is not affected.

Changes in v2:
- Add READ_ONCE() for the icsk_ca_ops load.
- Add WRITE_ONCE() for every explicit icsk_ca_ops store.
---
 net/ipv4/tcp.c           | 14 +++++++++++---
 net/ipv4/tcp_cong.c      |  4 ++--
 net/ipv4/tcp_dctcp.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv4/tcp_output.c    |  2 +-
 net/mptcp/protocol.c     |  2 +-
 6 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b4237d0e994d..4918f48ba76d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4577,16 +4577,24 @@ int do_tcp_getsockopt(struct sock *sk, int level,
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
+		ca_ops = READ_ONCE(icsk->icsk_ca_ops);
+		memcpy(ca_name, ca_ops->name, sizeof(ca_name));
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
index e9f6c77e0631..8e83ef81fc18 100644
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
index 274e628e7cf8..99f68c2992d0 100644
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
index f3fa0b18eda0..0ddfd5af6e58 100644
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
index f2709d585edb..74727b7eb446 100644
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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b474d03620a7..006de39e8165 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3218,7 +3218,7 @@ static void mptcp_ca_reset(struct sock *sk)
 
 	/* no need to keep a reference to the ops, the name will suffice */
 	tcp_cleanup_congestion_control(sk);
-	icsk->icsk_ca_ops = NULL;
+	WRITE_ONCE(icsk->icsk_ca_ops, NULL);
 }
 
 static int mptcp_init_sock(struct sock *sk)
-- 
2.55.0
