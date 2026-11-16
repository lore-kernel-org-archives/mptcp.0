Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870365;
	b=28vbKK3TWjqpLnYnWDp+u67ymhzmODB6JS+4Fo/NqU4mC54E364ZLo0ib2Or/nm8iEyx
	 ckSJB5JQhrsqEffeFb3gIwq0X/67VkCHOOI8lOR7v33qfE918GuKCGRNy43Xdns7wYlyJ
	 WVwdO2YLWoaMW+0ULHEljgMYkTE5ULZEUah4iskJ0nW7VsgTKimcdKBdqYLZgNd9++XCq
	 gMYuEzGGCnQa5WYnvgzvfQ+DrY7/N9BeO7hIxMx8aZGnNm7I2zRZALP3CRgBOS8sR6x1f
	 Dtkm8Jn3i2zrO6tNMJJk6NPiMq2srY8sALL30klv1QBAOKc9KYe+dV3uWRivUinVeCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=jv4M7a0nbU2bS4cFmSjQv+EpzgY561iWKyksbxiqZK8=;
	b=KzaLDKabZF0LXk8GYXH/70ibeCFMv8z4OjfBxNtWBavnG0uiEW8qgLTDFkpCfW5ubaFv
	 sQEmEuI+qIwnJ2vKMXT1wlgsV8gYCaRVIm5F1UNSs+q2ADbqbF0QiGJMaJTix1Ly9GvK6
	 AWcrpCaUdtw+TwoFrnB9WP3qlVBOH13fvYjmC6mNvtoPnl4J4U/NDHIGNSt1xXAm9MZSs
	 u7EUAv8RR9AqxWjgAaNWFcAywX/+7GdmCGsmf9haP95QwNqxMPTyGlRsl9XvxSSsKMR5f
	 J6T4J99vooV1ltCkbAMFbg12rT5iAFxCD+CSzM68++CLxZDUqE9xrAC5weZayoxx8Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=olnGKwNy;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950E3606A31C
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 23:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 950E3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=olnGKwNy
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eaf3f829b3so33614505ad.3
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 15:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794870364; x=1795475164; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jv4M7a0nbU2bS4cFmSjQv+EpzgY561iWKyksbxiqZK8=;
        b=olnGKwNyguynKViLDIs/8MYqVN4Q14DF+a9aJd6OGeQsggIl+agWFg+1s284ibjdxN
         pZ15st+2RThpVFofm+szxRCLJOHvxtYiz3ILyVNJlJf1iYblb0Pvwjv6qKlIMXU4gxId
         OyRG6qz+Di5z8bVNAAahrglZLR7go3rl2ubwMyhJjyyrFohgWGbXUIh83duq5Xlhrj0m
         cDT1tjnsY6U2LOMxq5UqA9Q0Ngf68da1scFY4oBao4yL5LIorwRYV59hb7dg7wZTGKEV
         9Uwdy7A6NbwaLK50nu4GTBmsQyNK+A0C/pbyaKa9DcTlI2AFHvhDDTQueaW9A0W0ehFd
         amCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870364; x=1795475164;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jv4M7a0nbU2bS4cFmSjQv+EpzgY561iWKyksbxiqZK8=;
        b=h7sou0Azunr70vu38rlvQpiSrELfTmUT5r9BKGh1xHXRJt5NFgoVokjrBzBWp5g1Gy
         GOZQR57r/1stAO3ncBuqzbtly0fZ/m/VW6zsGNiEyKBceB9M1+s+OSkWZLnu4b+anKBG
         c4jonUDLeUdSLE4PE474645Z9vHuMgEbgGU85e4TwMIwKF4Exx7fVFknBh8cgPlFjs25
         1nwKY5HDsv7IJd9U5wQKvClRSg5zVGA4yz9BsI3h9FITw+MmqTge5D5Kod8O3xnQEYNG
         tbL9BnC3If0FOO4zDpxKPKyApoehLy7GuJrri8ZziM9QksnKNj/iaFvySryrU9cqGyCf
         ScIQ==
X-Forwarded-Encrypted: i=1; AL+hErEp9TG3a3l1noMK0zeyu8XumAllJVEaKrP3pzMWgG+3TATHNjl1NmCIu3iqSiWfb3iiku8LWQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8xNZKnRLFgA6q2aVrfZeQuN9EEBFI1LClAdDeDyxFlqm6lYa7/
	/f9PNZ+CtBV4zwRTW26f+9t4itBG0jpbo7fQn+nQzt6pmWnx7/7IVXnqc9b3DUfYpRNOgysFrx5
	pV1JYXw==
X-Received: from plbjy6.prod.google.com ([2002:a17:903:42c6:b0:2e8:7c73:6eb4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d590:b0:2dd:c053:82f6
 with SMTP id d9443c01a7336-2ee0dc06de5mr102245185ad.45.1794870363434; Mon, 16
 Nov 2026 15:06:03 -0800 (PST)
Date: Mon, 16 Nov 2026 23:05:31 +0000
In-Reply-To: <20261116230555.2305867-1-kuniyu@google.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261116230555.2305867-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261116230555.2305867-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 7/7] selftest: packetdrill: Add test for tcp_collapse().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

tcp_collapse() now does not collapse high-density skbs and a
low-density skb sandwiched by high-density skbs.

tcp_rcv_collapse_bloated.pkt verifies the behaviour by

 1. set a large SO_RCVBUF
 2. send one high-density skb with 100 bytes read()
 3. send one high-density skb
 4. send one low-density skb
 5. send one high-density skb
 6. send 30 low-density skbs
 7. send one high-density skb
 8. set a small SO_RCVBUF
 9. send a small data to trigger tcp_collapse()
10. check TcpExtTCPRcvCollapsed via nstat

Without the series, the first high-density skb is collapsed.
In addition, the first low-density skb drags the following
high-density skb into collapsing, consuming more memory.

If we remove sk_forced_mem_schedule() without this series,
sk->sk_forward_alloc becomes negative at the end of tcp_collapse().

Note that 30 segments are to make the memory savings large
enough so that the margin can absorb minor size delta of
struct sk_buff or L1_CACHE_BYTES across configs.

skb truesize, TCP_COLLAPSE_MAX_SIZE, TCP_COLLAPSE_SCALING_RATIO
depend on PAGE_SIZE being 4K, so the test is skipped if getconf
returns non-4K PAGE_SIZE.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../selftests/net/packetdrill/ksft_runner.sh  |   9 ++
 .../packetdrill/tcp_rcv_collapse_bloated.pkt  | 135 ++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_collapse_bloated.pkt

diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index 0a97d5ae3469..250d143bb9f7 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -44,6 +44,15 @@ if [ -z "$(which packetdrill)" ]; then
 	exit "$KSFT_SKIP"
 fi
 
+page_size=$(grep -E '^--define="?PAGE_SIZE=' $script | sed -E 's/.*PAGE_SIZE="?([0-9]+)"?.*/\1/')
+if [[ -n "$page_size" ]]; then
+	cur_page_size=$(getconf PAGESIZE 2>/dev/null)
+	if [[ "$cur_page_size" != "$page_size" ]]; then
+		ktap_skip_all "requires PAGE_SIZE=$page_size (current: ${cur_page_size:-unknown})"
+		exit "$KSFT_SKIP"
+	fi
+fi
+
 declare -a optargs
 failfunc=ktap_test_fail
 
diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_collapse_bloated.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_collapse_bloated.pkt
new file mode 100644
index 000000000000..90e8be86968f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_collapse_bloated.pkt
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test that tcp_collapse() only collapses bloated skb runs, skips leading
+// and trailing high-density skbs, skips isolated bloated skbs when collapsing
+// them would not shrink truesize, and properly recovers receive buffer space.
+
+--mss=1000
+--define="PAGE_SIZE=4096"
+
+`./defaults.sh`
+
+// Establish a connection with a large receive buffer.
+// __sock_set_rcvbuf() doubles, so 2000000
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1000000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,nop,sackOK,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 4>
+   +0 < . 1:1(0) ack 1 win 65535
+
+   +0 accept(3, ..., ...) = 4
+
+// 1. Queue two high-density 62,000 B segments (each adds 15 pages of frag
+// truesize with enough margin across NET_SKB_PAD, L1_CACHE_BYTES, and
+// MAX_SKB_FRAGS configs).
+// Read 100 bytes from the first one so before(skb->seq, tp->copied_seq) is true.
+   +0 < P. 1:62001(62000) ack 1 win 65535
+    * > .  1:1(0) ack 62001
+   +0 read(4, ..., 100) = 100
+
+   +0 < P. 62001:124001(62000) ack 1 win 65535
+    * > .  1:1(0) ack 124001
+
+// 2. Queue an isolated bloated 1,000 B segment.
+   +0 < P. 124001:125001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 125001
+
+// 3. Queue another high-density 62,000 B segment.
+   +0 < P. 125001:187001(62000) ack 1 win 65535
+    * > .  1:1(0) ack 187001
+
+// 4. Queue a run of 30 bloated 1,000 B segments.
+   +0 < P. 187001:188001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 188001
+   +0 < P. 188001:189001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 189001
+   +0 < P. 189001:190001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 190001
+   +0 < P. 190001:191001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 191001
+   +0 < P. 191001:192001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 192001
+   +0 < P. 192001:193001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 193001
+   +0 < P. 193001:194001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 194001
+   +0 < P. 194001:195001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 195001
+   +0 < P. 195001:196001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 196001
+   +0 < P. 196001:197001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 197001
+   +0 < P. 197001:198001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 198001
+   +0 < P. 198001:199001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 199001
+   +0 < P. 199001:200001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 200001
+   +0 < P. 200001:201001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 201001
+   +0 < P. 201001:202001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 202001
+   +0 < P. 202001:203001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 203001
+   +0 < P. 203001:204001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 204001
+   +0 < P. 204001:205001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 205001
+   +0 < P. 205001:206001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 206001
+   +0 < P. 206001:207001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 207001
+   +0 < P. 207001:208001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 208001
+   +0 < P. 208001:209001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 209001
+   +0 < P. 209001:210001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 210001
+   +0 < P. 210001:211001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 211001
+   +0 < P. 211001:212001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 212001
+   +0 < P. 212001:213001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 213001
+   +0 < P. 213001:214001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 214001
+   +0 < P. 214001:215001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 215001
+   +0 < P. 215001:216001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 216001
+   +0 < P. 216001:217001(1000) ack 1 win 65535
+    * > .  1:1(0) ack 217001
+
+// 5. Queue a trailing high-density 62,000 B segment.
+   +0 < P. 217001:279001(62000) ack 1 win 65535
+    * > .  1:1(0) ack 279001
+
+// Reset SNMP counters.
+   +0 `nstat -n`
+
+// Shrink SO_RCVBUF so sk_rcvbuf (320,000) is smaller than current
+// sk_rmem_alloc (334,592 on x86_64 default), but larger than sk_rmem_alloc
+// after collapsing the 30 bloated skbs (300,288 on x86_64 default).
+   +0 setsockopt(4, SOL_SOCKET, SO_RCVBUF, [160000], 4) = 0
+
+// Inject the next 1,000 B segment with a changed window to bypass
+// header prediction.  This triggers tcp_prune_queue() -> tcp_collapse().
+// Only the 30 bloated segments should be collapsed; the high-density
+// segments and the isolated bloated segment are skipped.  sk_rmem_alloc
+// shrinks below sk_rcvbuf, so tcp_can_ingest() succeeds and the packet
+// is accepted.
+   +0 < P. 279001:280001(1000) ack 1 win 65534
+    * > .  1:1(0) ack 280001
+
+// Verify exactly 30 skbs were collapsed.
+   +0 `nstat -s | grep TcpExtTCPRcvCollapsed | grep -q " 30 "`
+
+// Verify no packets were dropped.
+   +0 `test -z "$(nstat -s | grep TcpExtTCPRcvQDrop)"`
+
+// Read all remaining queued data to verify data integrity.
+   +0 read(4, ..., 300000) = 279900
-- 
2.56.0.679.gc527c65306-goog

