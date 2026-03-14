Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C4D38CFEA
	for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519303; cv=none; b=e0928flqSkNYm6jBzOOBl0gJp93EjN+q9GUuaPkwgEit8f5cEDOLeOiSp5Z0Vf1n6MhHVDVhjWOZWOfzWHa7NyoBHBTOlZ7FrPL0c2icH4Vh7IC71TVT9mt8AVF+A743Ojd8LbAbS5NFrqL/GjaAi5Ve816TdRWSBYGrWdYH8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519303; c=relaxed/simple;
	bh=h2w84+E53fjjORSXCTmZqDRXCz4rcg4b0xrFtcD8+/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2F+0I2qOt92MbNaBCRXCjPjFEZDBvzKZsvpKkJdVgDhAjD3ebRHcTjia8H08FQAhhgeWlDDwoSFbQp2rDXyBsvd1vyBnhmX4A41vzQeR8gMDehJ+0wJIb+Jcf37HXtvI/HDWzLnUyFXfiYzEzhDRYRn7LafIOfyDw8vahI0XJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieO66LH8; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieO66LH8"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-67bb04151dcso1903294eaf.0
        for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519299; x=1774124099; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzFkYp6vQFMuSQL+rwhcnHsZCs8WUPXFTJK3qolPQ8w=;
        b=ieO66LH8KLOSGIXddCVh3wgX188fg8hPREGH0bbzVJbQTodWuNEHf3oJXThB0W0EXj
         xeFqqS6itwF0450ixxMRtHc8EejK9ULUv8cayWyeuiWu/ShiyWAXuysJXss6WO2cW7qo
         ZCh0g2QWMtIgvWDgnlcgaFrbIdnVlAbGx5Hw5+hzCRTe3BTrui1d1MtQElSdDQPMB3m3
         yJeIZD5LRuci73QVt0ZMchf5jWO40a/i0aY/PpxP/p/Pqo1C1th7y89pht8jvHdVzQ7c
         JX8ZaQJVZetj7cUWqnmYshafi/lQglgLRDXTjp9qiWo4/bqDUVfSt2CZqli0EQb6hwUh
         04jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519299; x=1774124099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WzFkYp6vQFMuSQL+rwhcnHsZCs8WUPXFTJK3qolPQ8w=;
        b=sbICKdAaf8UEUGQOxiBt2Cj3JpLdzet5bCgWcU5V0Xx+isM8wdQbDYRuzmWyFk6Hz8
         lshTspos95gObfZfneoLJ5t3L0pzLD1+0q7ZcS4mEqX7lTbImHPJvJBtKguJl6vKu2iJ
         eHCoRJ3SnvHfJJdKEWfLojhI93gUSa9XPIQwvFSGA5Jx84rOL4OUExBRJ3PIatbo2PJi
         4TwVv4pp7osW+GM8tbV8SnDZxVum9sYagYj+hPj3JI2QxoqrP0v5RhUYM2T6wmp+Suk9
         O9ni8js3zxvND6Jibwh03B7fiK8BTWHJWDD8zumhskuL+2+uhBHMw1DwtNMEl7vnXmiR
         EIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnzb5LwQfS0zF56Qot8wHoS706lIiI5WBV4JvPIBvzbSltE98RSqE+pZQoe4dEC8Ysm4rYKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwggEUJFmZVoYgnRKITwxD8jd7fsfH65qixPo6r/iKH21Dk5baV
	w27XgJgaR2WvrTUu+pYaQwZScqUhkQdkTfG4wS8WnrS3oym8AIeAQEvG
X-Gm-Gg: ATEYQzzdmxX0SRiAkc44ZKWvKYxiBabs4kfkcOqipHaj+WPHZHB2X0QctZe6FSmXzTL
	I5oiX6aE61zLUGSxsqYQFHXdtr4h1FePK1/IvVBgwv8SX170ndoJGsx6i5TS+rsmJStG8TPl4jr
	Lv91ROW0DPHU1BYK9OXHhrY8TdwcYWh3h1fFrssL31DZI7dEHXYVxzdZj4G4gmTHgAy93Xioxfd
	amzwvlEU4qUB+T9/WlyjilSCzUZntD2L5NbEdT7rOy0andbl+ni8P1taMex9Pccw8HWSSheU4Ux
	iugr3VpBsAFwe/6L61fhddO+drUFKIlScSb+RqEH9olqvhDD+G2LsfZ8Yx3JqN5JQgIujYU3cJL
	uqRhUMoOo7gOkZ5Oaqrl1CQpjKUOe7jwoWDzSUidp7H3zg/I6DjHxm+7/vZXUgl7QFlfv2iEb5I
	Ftzt9w95iu2UMBx3HbftI/HnXpg+N+PHc+1nrjxA2AF5ehYJc7SUHy85VZCK7KmqoHxDxcFc/8/
	5dQLH601KttT80GGRsJDO5mH+xHT0Lihucg/ElM
X-Received: by 2002:a05:6820:616:b0:67b:aca0:3d96 with SMTP id 006d021491bc7-67bdaa7db03mr5100287eaf.65.1773519299237;
        Sat, 14 Mar 2026 13:14:59 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:58 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 11/14] selftests: tcp_ao: cover legacy, v1, and retracted repair windows
Date: Sat, 14 Mar 2026 14:13:45 -0600
Message-ID: <20260314201348.1786972-12-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wesley Atwell <atwellwea@gmail.com>

Extend the tcp_ao repair selftests to exercise the legacy, v1, and
current TCP_REPAIR_WINDOW layouts, plus a synthesized retracted-window
image that preserves a larger historical right edge.

These tests validate both the append-only ABI contract and the restore-
time rebuilding of any snapshot state older userspace could not save.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 .../testing/selftests/net/tcp_ao/lib/aolib.h  |  83 +++++++-
 .../testing/selftests/net/tcp_ao/lib/repair.c |  18 +-
 .../selftests/net/tcp_ao/self-connect.c       | 201 +++++++++++++++++-
 3 files changed, 279 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index ebb2899c12fe..ef08db831457 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -13,6 +13,7 @@
 #include <linux/snmp.h>
 #include <linux/tcp.h>
 #include <netinet/in.h>
+#include <stddef.h>
 #include <stdarg.h>
 #include <stdbool.h>
 #include <stdlib.h>
@@ -671,17 +672,55 @@ struct tcp_sock_state {
 	int timestamp;
 };
 
-extern void __test_sock_checkpoint(int sk, struct tcp_sock_state *state,
-				   void *addr, size_t addr_size);
+/* Legacy userspace stops before the snapshot field and therefore exercises
+ * the kernel's unknown-snapshot fallback path.
+ */
+static inline socklen_t test_tcp_repair_window_legacy_size(void)
+{
+	return offsetof(struct tcp_repair_window, rcv_wnd_scaling_ratio);
+}
+
+static inline socklen_t test_tcp_repair_window_v1_size(void)
+{
+	return offsetof(struct tcp_repair_window, rcv_mwnd_seq);
+}
+
+static inline socklen_t test_tcp_repair_window_exact_size(void)
+{
+	return sizeof(struct tcp_repair_window);
+}
+
+void __test_sock_checkpoint_opt(int sk, struct tcp_sock_state *state,
+				socklen_t trw_len,
+				void *addr, size_t addr_size);
 static inline void test_sock_checkpoint(int sk, struct tcp_sock_state *state,
 					sockaddr_af *saddr)
 {
-	__test_sock_checkpoint(sk, state, saddr, sizeof(*saddr));
+	__test_sock_checkpoint_opt(sk, state, test_tcp_repair_window_exact_size(),
+				   saddr, sizeof(*saddr));
+}
+
+static inline void test_sock_checkpoint_legacy(int sk,
+					       struct tcp_sock_state *state,
+					       sockaddr_af *saddr)
+{
+	__test_sock_checkpoint_opt(sk, state, test_tcp_repair_window_legacy_size(),
+				   saddr, sizeof(*saddr));
+}
+
+static inline void test_sock_checkpoint_v1(int sk,
+					   struct tcp_sock_state *state,
+					   sockaddr_af *saddr)
+{
+	__test_sock_checkpoint_opt(sk, state, test_tcp_repair_window_v1_size(),
+				   saddr, sizeof(*saddr));
 }
 extern void test_ao_checkpoint(int sk, struct tcp_ao_repair *state);
-extern void __test_sock_restore(int sk, const char *device,
-				struct tcp_sock_state *state,
-				void *saddr, void *daddr, size_t addr_size);
+void __test_sock_restore_opt(int sk, const char *device,
+			     struct tcp_sock_state *state,
+			     socklen_t trw_len,
+			     void *saddr, void *daddr,
+			     size_t addr_size);
 static inline void test_sock_restore(int sk, struct tcp_sock_state *state,
 				     sockaddr_af *saddr,
 				     const union tcp_addr daddr,
@@ -690,7 +729,37 @@ static inline void test_sock_restore(int sk, struct tcp_sock_state *state,
 	sockaddr_af addr;
 
 	tcp_addr_to_sockaddr_in(&addr, &daddr, htons(dport));
-	__test_sock_restore(sk, veth_name, state, saddr, &addr, sizeof(addr));
+	__test_sock_restore_opt(sk, veth_name, state,
+				test_tcp_repair_window_exact_size(),
+				saddr, &addr, sizeof(addr));
+}
+
+static inline void test_sock_restore_legacy(int sk,
+					    struct tcp_sock_state *state,
+					    sockaddr_af *saddr,
+					    const union tcp_addr daddr,
+					    unsigned int dport)
+{
+	sockaddr_af addr;
+
+	tcp_addr_to_sockaddr_in(&addr, &daddr, htons(dport));
+	__test_sock_restore_opt(sk, veth_name, state,
+				test_tcp_repair_window_legacy_size(),
+				saddr, &addr, sizeof(addr));
+}
+
+static inline void test_sock_restore_v1(int sk,
+					struct tcp_sock_state *state,
+					sockaddr_af *saddr,
+					const union tcp_addr daddr,
+					unsigned int dport)
+{
+	sockaddr_af addr;
+
+	tcp_addr_to_sockaddr_in(&addr, &daddr, htons(dport));
+	__test_sock_restore_opt(sk, veth_name, state,
+				test_tcp_repair_window_v1_size(),
+				saddr, &addr, sizeof(addr));
 }
 extern void test_ao_restore(int sk, struct tcp_ao_repair *state);
 extern void test_sock_state_free(struct tcp_sock_state *state);
diff --git a/tools/testing/selftests/net/tcp_ao/lib/repair.c b/tools/testing/selftests/net/tcp_ao/lib/repair.c
index 9893b3ba69f5..befbd0f72db5 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/repair.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/repair.c
@@ -66,8 +66,9 @@ static void test_sock_checkpoint_queue(int sk, int queue, int qlen,
 		test_error("recv(%d): %d", qlen, ret);
 }
 
-void __test_sock_checkpoint(int sk, struct tcp_sock_state *state,
-			    void *addr, size_t addr_size)
+void __test_sock_checkpoint_opt(int sk, struct tcp_sock_state *state,
+				socklen_t trw_len,
+				void *addr, size_t addr_size)
 {
 	socklen_t len = sizeof(state->info);
 	int ret;
@@ -82,9 +83,9 @@ void __test_sock_checkpoint(int sk, struct tcp_sock_state *state,
 	if (getsockname(sk, addr, &len) || len != addr_size)
 		test_error("getsockname(): %d", (int)len);
 
-	len = sizeof(state->trw);
+	len = trw_len;
 	ret = getsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &state->trw, &len);
-	if (ret || len != sizeof(state->trw))
+	if (ret || len != trw_len)
 		test_error("getsockopt(TCP_REPAIR_WINDOW): %d", (int)len);
 
 	if (ioctl(sk, SIOCOUTQ, &state->outq_len))
@@ -160,9 +161,10 @@ static void test_sock_restore_queue(int sk, int queue, void *buf, int len)
 	} while (len > 0);
 }
 
-void __test_sock_restore(int sk, const char *device,
-			 struct tcp_sock_state *state,
-			 void *saddr, void *daddr, size_t addr_size)
+void __test_sock_restore_opt(int sk, const char *device,
+			     struct tcp_sock_state *state,
+			     socklen_t trw_len,
+			     void *saddr, void *daddr, size_t addr_size)
 {
 	struct tcp_repair_opt opts[4];
 	unsigned int opt_nr = 0;
@@ -215,7 +217,7 @@ void __test_sock_restore(int sk, const char *device,
 	}
 	test_sock_restore_queue(sk, TCP_RECV_QUEUE, state->in.buf, state->inq_len);
 	test_sock_restore_queue(sk, TCP_SEND_QUEUE, state->out.buf, state->outq_len);
-	if (setsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &state->trw, sizeof(state->trw)))
+	if (setsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &state->trw, trw_len))
 		test_error("setsockopt(TCP_REPAIR_WINDOW)");
 }
 
diff --git a/tools/testing/selftests/net/tcp_ao/self-connect.c b/tools/testing/selftests/net/tcp_ao/self-connect.c
index 2c73bea698a6..a7c0f2edd351 100644
--- a/tools/testing/selftests/net/tcp_ao/self-connect.c
+++ b/tools/testing/selftests/net/tcp_ao/self-connect.c
@@ -4,6 +4,14 @@
 #include "aolib.h"
 
 static union tcp_addr local_addr;
+static bool checked_repair_window_lens;
+
+enum repair_window_mode {
+	REPAIR_WINDOW_CURRENT,
+	REPAIR_WINDOW_LEGACY,
+	REPAIR_WINDOW_V1,
+	REPAIR_WINDOW_RETRACTED,
+};
 
 static void __setup_lo_intf(const char *lo_intf,
 			    const char *addr_str, uint8_t prefix)
@@ -30,8 +38,157 @@ static void setup_lo_intf(const char *lo_intf)
 #endif
 }
 
+/* The repair ABI accepts the legacy, v1, and current layouts. */
+static void test_repair_window_len_contract(int sk)
+{
+	struct tcp_repair_window trw = {};
+	socklen_t len = test_tcp_repair_window_exact_size();
+	socklen_t v1_len = test_tcp_repair_window_v1_size();
+	socklen_t bad_len = test_tcp_repair_window_legacy_size() + 1;
+	int ret;
+
+	if (checked_repair_window_lens)
+		return;
+
+	checked_repair_window_lens = true;
+
+	ret = getsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &trw, &len);
+	if (ret || len != test_tcp_repair_window_exact_size())
+		test_error("getsockopt(TCP_REPAIR_WINDOW): %d", (int)len);
+
+	len = v1_len;
+	ret = getsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &trw, &len);
+	if (ret || len != v1_len)
+		test_fail("repair-window get accepts v1 len");
+	else
+		test_ok("repair-window get accepts v1 len");
+
+	len = bad_len;
+	ret = getsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &trw, &len);
+	if (ret == 0 || errno != EINVAL)
+		test_fail("repair-window get rejects invalid len");
+	else
+		test_ok("repair-window get rejects invalid len");
+
+	ret = setsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &trw, bad_len);
+	if (ret == 0 || errno != EINVAL)
+		test_fail("repair-window set rejects invalid len");
+	else
+		test_ok("repair-window set rejects invalid len");
+
+	ret = setsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &trw, v1_len + 1);
+	if (ret == 0 || errno != EINVAL)
+		test_fail("repair-window set rejects invalid v1+1 len");
+	else
+		test_ok("repair-window set rejects invalid v1+1 len");
+}
+
+static void test_retracted_repair_window_state(int sk,
+					       struct tcp_sock_state *img)
+{
+	struct tcp_repair_window trw = {};
+	socklen_t len = sizeof(trw);
+	int ret;
+
+	ret = getsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &trw, &len);
+	if (ret || len != sizeof(trw))
+		test_error("getsockopt(TCP_REPAIR_WINDOW): %d", (int)len);
+
+	if (trw.rcv_mwnd_seq != img->trw.rcv_mwnd_seq ||
+	    trw.rcv_mwnd_scaling_ratio != img->trw.rcv_mwnd_scaling_ratio ||
+	    trw.rcv_wnd != img->trw.rcv_wnd ||
+	    trw.rcv_wup != img->trw.rcv_wup ||
+	    trw.rcv_wnd_scaling_ratio != img->trw.rcv_wnd_scaling_ratio)
+		test_fail("repair-window restore preserves retracted state");
+	else
+		test_ok("repair-window restore preserves retracted state");
+}
+
+static void test_v1_repair_window_state(int sk, struct tcp_sock_state *img)
+{
+	struct tcp_repair_window trw = {};
+	socklen_t len = sizeof(trw);
+	__u32 max_right = img->trw.rcv_wup + img->trw.rcv_wnd;
+	int ret;
+
+	ret = getsockopt(sk, SOL_TCP, TCP_REPAIR_WINDOW, &trw, &len);
+	if (ret || len != sizeof(trw))
+		test_error("getsockopt(TCP_REPAIR_WINDOW): %d", (int)len);
+
+	if (trw.rcv_mwnd_seq != max_right ||
+	    trw.rcv_mwnd_scaling_ratio != img->trw.rcv_wnd_scaling_ratio ||
+	    trw.rcv_wnd != img->trw.rcv_wnd ||
+	    trw.rcv_wup != img->trw.rcv_wup ||
+	    trw.rcv_wnd_scaling_ratio != img->trw.rcv_wnd_scaling_ratio)
+		test_fail("repair-window v1 restore rebuilds max-window state");
+	else
+		test_ok("repair-window v1 restore rebuilds max-window state");
+}
+
+/* Synthesize a repair image whose live rwnd was retracted after a larger
+ * right edge had already been advertised, so restore testing can validate
+ * snapshot preservation without depending on the live receive path.
+ */
+static bool make_retracted_repair_window_state(struct tcp_sock_state *img)
+{
+	__u32 gran = 1U << img->info.tcpi_rcv_wscale;
+	__u32 max_right;
+	__u32 shrink;
+
+	if (!(img->info.tcpi_options & TCPI_OPT_WSCALE))
+		return false;
+
+	max_right = img->trw.rcv_wup + img->trw.rcv_wnd;
+	shrink = img->trw.rcv_wnd / 4;
+	if (shrink < gran)
+		shrink = gran;
+	if (shrink >= img->trw.rcv_wnd)
+		shrink = img->trw.rcv_wnd >> 1;
+	if (shrink == 0 || shrink >= img->trw.rcv_wnd)
+		return false;
+
+	img->trw.rcv_wnd -= shrink;
+	img->trw.rcv_mwnd_seq = max_right;
+	img->trw.rcv_mwnd_scaling_ratio = img->trw.rcv_wnd_scaling_ratio;
+	return true;
+}
+
+static socklen_t repair_window_len(enum repair_window_mode mode)
+{
+	switch (mode) {
+	case REPAIR_WINDOW_LEGACY:
+		return test_tcp_repair_window_legacy_size();
+	case REPAIR_WINDOW_V1:
+		return test_tcp_repair_window_v1_size();
+	case REPAIR_WINDOW_CURRENT:
+	case REPAIR_WINDOW_RETRACTED:
+		return test_tcp_repair_window_exact_size();
+	}
+
+	return test_tcp_repair_window_exact_size();
+}
+
+static void test_sock_checkpoint_mode(enum repair_window_mode mode, int sk,
+				      struct tcp_sock_state *img,
+				      sockaddr_af *addr)
+{
+	switch (mode) {
+	case REPAIR_WINDOW_LEGACY:
+		test_sock_checkpoint_legacy(sk, img, addr);
+		break;
+	case REPAIR_WINDOW_V1:
+		test_sock_checkpoint_v1(sk, img, addr);
+		break;
+	case REPAIR_WINDOW_CURRENT:
+	case REPAIR_WINDOW_RETRACTED:
+		test_sock_checkpoint(sk, img, addr);
+		break;
+	}
+}
+
 static void tcp_self_connect(const char *tst, unsigned int port,
-			     bool different_keyids, bool check_restore)
+			     bool different_keyids, bool check_restore,
+			     enum repair_window_mode repair_window_mode)
 {
 	struct tcp_counters before, after;
 	uint64_t before_aogood, after_aogood;
@@ -109,7 +266,16 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 	}
 
 	test_enable_repair(sk);
-	test_sock_checkpoint(sk, &img, &addr);
+	test_repair_window_len_contract(sk);
+	test_sock_checkpoint_mode(repair_window_mode, sk, &img, &addr);
+	if (repair_window_mode == REPAIR_WINDOW_RETRACTED &&
+	    !make_retracted_repair_window_state(&img)) {
+		test_sock_state_free(&img);
+		netstat_free(ns_before);
+		close(sk);
+		test_skip("%s: no scaled repair window to retract", tst);
+		return;
+	}
 #ifdef IPV6_TEST
 	addr.sin6_port = htons(port + 1);
 #else
@@ -123,7 +289,9 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 		test_error("socket()");
 
 	test_enable_repair(sk);
-	__test_sock_restore(sk, "lo", &img, &addr, &addr, sizeof(addr));
+	__test_sock_restore_opt(sk, "lo", &img,
+				repair_window_len(repair_window_mode),
+				&addr, &addr, sizeof(addr));
 	if (different_keyids) {
 		if (test_add_repaired_key(sk, DEFAULT_TEST_PASSWORD, 0,
 					  local_addr, -1, 7, 5))
@@ -137,6 +305,10 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 			test_error("setsockopt(TCP_AO_ADD_KEY)");
 	}
 	test_ao_restore(sk, &ao_img);
+	if (repair_window_mode == REPAIR_WINDOW_V1)
+		test_v1_repair_window_state(sk, &img);
+	if (repair_window_mode == REPAIR_WINDOW_RETRACTED)
+		test_retracted_repair_window_state(sk, &img);
 	test_disable_repair(sk);
 	test_sock_state_free(&img);
 	if (test_client_verify(sk, 100, nr_packets)) {
@@ -165,20 +337,33 @@ static void *client_fn(void *arg)
 
 	setup_lo_intf("lo");
 
-	tcp_self_connect("self-connect(same keyids)", port++, false, false);
+	tcp_self_connect("self-connect(same keyids)", port++, false, false,
+			 REPAIR_WINDOW_CURRENT);
 
 	/* expecting rnext to change based on the first segment RNext != Current */
 	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
 			      port, port, 0, -1, -1, -1, -1, -1, 7, 5, -1);
-	tcp_self_connect("self-connect(different keyids)", port++, true, false);
-	tcp_self_connect("self-connect(restore)", port, false, true);
+	tcp_self_connect("self-connect(different keyids)", port++, true, false,
+			 REPAIR_WINDOW_CURRENT);
+	tcp_self_connect("self-connect(restore)", port, false, true,
+			 REPAIR_WINDOW_CURRENT);
+	port += 2; /* restore test restores over different port */
+	tcp_self_connect("self-connect(restore, legacy repair window)", port,
+			 false, true, REPAIR_WINDOW_LEGACY);
+	port += 2; /* restore test restores over different port */
+	tcp_self_connect("self-connect(restore, v1 repair window)", port,
+			 false, true, REPAIR_WINDOW_V1);
+	port += 2; /* restore test restores over different port */
+	tcp_self_connect("self-connect(restore, retracted repair window)", port,
+			 false, true, REPAIR_WINDOW_RETRACTED);
 	port += 2; /* restore test restores over different port */
 	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
 			      port, port, 0, -1, -1, -1, -1, -1, 7, 5, -1);
 	/* intentionally on restore they are added to the socket in different order */
 	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
 			      port + 1, port + 1, 0, -1, -1, -1, -1, -1, 5, 7, -1);
-	tcp_self_connect("self-connect(restore, different keyids)", port, true, true);
+	tcp_self_connect("self-connect(restore, different keyids)",
+			 port, true, true, REPAIR_WINDOW_CURRENT);
 	port += 2; /* restore test restores over different port */
 
 	return NULL;
@@ -186,6 +371,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(5, client_fn, NULL);
+	test_init(14, client_fn, NULL);
 	return 0;
 }
-- 
2.43.0

