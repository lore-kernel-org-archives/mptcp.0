Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F71738D00F
	for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 20:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519306; cv=none; b=eamBUQT5Qryw94/M4eC9gL8v/QARytcDT+5ZVpVb/KX9q4Mh8pKVTt7Cbb8eHpuVnEWDouJkYrix0r95ZBn/zBPH36ia545zD3zNb6ny+Kz7jqCNcrms7gZWMd1QcWP+38B6axzTIA4lXLSOSDUm+mozck/eqSKYF7UNQGYNiLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519306; c=relaxed/simple;
	bh=c3aw5VIxdZS2azxJsUSqQU6JjwbrB5pvPMaxk94MujQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoHGXjQmJkkok+gii+f6yaS/ZaaqI1B1FXN1JwhVljpt54g1YdSzxl4dVf4ayJYD2WKbarLJKPKmVXxxSdEDDA3K/ZmYBNpc4zgwOKkF4kaJfN0jcF9rEnjunCAoCtdJi/z4pkWiUP4F/Gf4vtqKmm6J+nfnYdylgmC23Tsk7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/YM8XUo; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/YM8XUo"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4c383f2fcso2747480a34.0
        for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519301; x=1774124101; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mcgGvP3OSrXTj+URf09ITzfMzhOZtxhsq3uE0kGGg8=;
        b=D/YM8XUoamMFzczoTnbwYhCqXHs/uChOlwePjUe0XUJxUY83GqzZt6KSOckCtAalk8
         H+CJ9675fp8AJtfow3SCp9KAdXS3TDkyNhijRPLXfiJvyIzVGkvlgtFI49K1i9JDsypp
         LAvvImPe4GMH9IPVg3nk0NsSrY1Ipl/LAzyuSR/RPT4Je7QSim8rJkPUJZek56GMYPWp
         4nu5Pm7V4/XeaeRCPWhkQZltfC7GFswyo52BQW026XsciRP7d5/vdwtj1LtPJ8sP+UG/
         56kirBFgVTdglYghSLQSR3xf9kN6GzQwqF0zIEmoTMXpbGWpwZss8wUJiT6aOpfoa7+s
         C25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519301; x=1774124101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9mcgGvP3OSrXTj+URf09ITzfMzhOZtxhsq3uE0kGGg8=;
        b=MVZKHM8hJDQcCXB3PhNIsGSlRHgFjOdurx1uPbjug0rkQvAiu80fyHMqOG6BKRRqk0
         H5911PJnlXqQz4Si8QcoVgnKMS1XxdWcoDoW4qM5Xtxu6tyXwINKji+b2ECLOqY1JGaO
         r3b+6dnPakeYqg+nBt8rlBOB3YG6nABl+f6qH2/b41YD/0AUVDc+SF71UMYBHzCLyH4j
         5lGWm6q1PFsesHCJNbbqb+bjE8xnTRG4fRkf99Mg5O2tCawoG+HScRRZYCLdvHH5SYY7
         r+jXiD26j9PgHEd3BvRqC6Xuz6h0QU/a1FxOCqvViTOvfnf+BCnIzL5zPapCg+7LP8+l
         onWw==
X-Forwarded-Encrypted: i=1; AJvYcCWbIS09TFG2v/J1/lRL2DXx1ZTfJNpoY1KcVE7Pw/h284msF1qMuomHKSeXsTFgJze9txEkNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYttuiK/U5yEFUMh8C0CGZNMvUHpmqtaR/1GRjddogszZaxQQW
	zC5nZjFccEqefV1EMlbGZPMGBUL5J+J2L2musVfCu6SBxrz9XYAYt/H+
X-Gm-Gg: ATEYQzy2ZVwmc5w0eAg+SWMPOQCPUClIDubAEAmo8764Lt3HyJtwvAZ+5peYjYqVPMC
	F44QcMwnJAeGVpiYuu2goPK139/gC4oJO7vHMvU3ju/B+iOVvpa3p7CZIvA4ddM4oXH+kLyW5Xd
	B0vJn/En9sKxon4gfBMSvyGt4h7jF+Ogcq8gkCysXdKCvEwESjvA2LnjLdJCm4ATekN3fhwa0vA
	wBa4eU486RPdtqfCQWzpRgZMFzPdNqXoBxgw0TEQp/7nMq/wthV+4459uaW4ZLnsLENE+xY6OEN
	oSyPIVAVU+d5lR5GYUR9qNTuykNLStxjd6WJGUEY2syHmioaB5jwqQjhG0pmTJiISw7WRlwxJgT
	KHDXPzkL35p20E1KFO1HOG47fNbXTO0m5gkjydi8TCkoC7KH9kVwOKLVyS8e1yQJSRXfFLIHclQ
	MZOPjQ/5qWn4i97uVxDjLe3o1XqYW95dbWurUndyFaI7m5zU5oyPhPlwCrRLziuiK4AsgOtCeii
	MIROk7dTWIm5xUm97uWUJRZk7jqffLfV1+Gqo6E7iuqFT7MJpY=
X-Received: by 2002:a05:6820:290d:b0:678:f8f3:d6dd with SMTP id 006d021491bc7-67bda98e367mr4712493eaf.8.1773519300803;
        Sat, 14 Mar 2026 13:15:00 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:15:00 -0700 (PDT)
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
Subject: [PATCH net-next v2 12/14] tun/selftests: add RX truesize injection for TCP window tests
Date: Sat, 14 Mar 2026 14:13:46 -0600
Message-ID: <20260314201348.1786972-13-atwellwea@gmail.com>
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

Add a test-only TUN ioctl that inflates RX skb->truesize, plus the
packetdrill-side helper needed to drive that ioctl through packetdrill's
own TUN queue file descriptor.

Use that plumbing to cover the receive-window regressions where
scaling_ratio drifts after advertisement, alongside the baseline too-big
packetdrill cases that exercise the same sender-visible rwnd accounting
from the non-injected path.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 drivers/net/tun.c                             |  65 ++++++++
 include/uapi/linux/if_tun.h                   |   4 +
 .../tcp_rcv_neg_window_truesize.pkt           | 143 ++++++++++++++++++
 .../net/packetdrill/tcp_rcv_toobig.pkt        |  35 +++++
 .../packetdrill/tcp_rcv_toobig_default.pkt    |  97 ++++++++++++
 .../tcp_rcv_toobig_default_truesize.pkt       | 118 +++++++++++++++
 .../tcp_rcv_wnd_shrink_allowed_truesize.pkt   |  49 ++++++
 tools/testing/selftests/net/tun.c             | 140 ++++++++++++++++-
 8 files changed, 650 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window_truesize.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default_truesize.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed_truesize.pkt

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index c492fda6fc15..2cef62cebe88 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -53,6 +53,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_tun.h>
 #include <linux/if_vlan.h>
+#include <linux/overflow.h>
 #include <linux/crc32.h>
 #include <linux/math.h>
 #include <linux/nsproxy.h>
@@ -85,8 +86,13 @@
 
 #include "tun_vnet.h"
 
+struct tun_file;
+
+#define TUNSETTRUESIZE_OLD _IOW('T', 228, unsigned int)
+
 static void tun_default_link_ksettings(struct net_device *dev,
 				       struct ethtool_link_ksettings *cmd);
+static void tun_rx_update_truesize(struct tun_file *tfile, struct sk_buff *skb);
 
 #define TUN_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
 
@@ -138,6 +144,7 @@ struct tun_file {
 		u16 queue_index;
 		unsigned int ifindex;
 	};
+	u32 rx_extra_truesize;
 	struct napi_struct napi;
 	bool napi_enabled;
 	bool napi_frags_enabled;
@@ -1817,6 +1824,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		goto free_skb;
 	}
 
+	tun_rx_update_truesize(tfile, skb);
 	switch (tun->flags & TUN_TYPE_MASK) {
 	case IFF_TUN:
 		if (tun->flags & IFF_NO_PI) {
@@ -2373,6 +2381,25 @@ static void tun_put_page(struct tun_page *tpage)
 		__page_frag_cache_drain(tpage->page, tpage->count);
 }
 
+/* Tests can inflate skb->truesize on ingress to exercise receive-memory
+ * accounting against a scaling_ratio that drifts after a window was
+ * advertised. The knob is per queue file, defaults to zero, and only changes
+ * behavior when explicitly enabled through the TUN fd.
+ */
+static void tun_rx_update_truesize(struct tun_file *tfile, struct sk_buff *skb)
+{
+	u32 extra = READ_ONCE(tfile->rx_extra_truesize);
+	unsigned int truesize;
+
+	if (!extra)
+		return;
+
+	if (check_add_overflow(skb->truesize, extra, &truesize))
+		truesize = UINT_MAX;
+
+	skb->truesize = truesize;
+}
+
 static int tun_xdp_one(struct tun_struct *tun,
 		       struct tun_file *tfile,
 		       struct xdp_buff *xdp, int *flush,
@@ -2459,6 +2486,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 		goto out;
 	}
 
+	tun_rx_update_truesize(tfile, skb);
 	skb->protocol = eth_type_trans(skb, tun->dev);
 	skb_reset_network_header(skb);
 	skb_probe_transport_header(skb);
@@ -3045,6 +3073,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	struct tun_struct *tun;
 	void __user* argp = (void __user*)arg;
 	unsigned int carrier;
+	unsigned int extra_truesize;
 	struct ifreq ifr;
 	kuid_t owner;
 	kgid_t group;
@@ -3309,6 +3338,40 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = tun_net_change_carrier(tun->dev, (bool)carrier);
 		break;
 
+	/* Support both the legacy pointer-payload form and the scalar form
+	 * used by the selftest helper when injecting truesize from
+	 * packetdrill shell commands.
+	 */
+	case TUNSETTRUESIZE:
+	case TUNSETTRUESIZE_OLD:
+		ret = -EPERM;
+		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+			goto unlock;
+
+		if (cmd == TUNSETTRUESIZE_OLD) {
+			ret = -EFAULT;
+			if (copy_from_user(&extra_truesize, argp,
+					   sizeof(extra_truesize))) {
+				ret = -EINVAL;
+				if (arg > U32_MAX)
+					goto unlock;
+
+				extra_truesize = arg;
+			}
+		} else {
+			ret = -EINVAL;
+			if (arg > U32_MAX)
+				goto unlock;
+
+			extra_truesize = arg;
+		}
+
+		WRITE_ONCE(tfile->rx_extra_truesize, extra_truesize);
+		netif_info(tun, drv, tun->dev,
+			   "rx extra truesize set to %u\n", extra_truesize);
+		ret = 0;
+		break;
+
 	case TUNGETDEVNETNS:
 		ret = -EPERM;
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
@@ -3348,6 +3411,7 @@ static long tun_chr_compat_ioctl(struct file *file,
 	case TUNGETSNDBUF:
 	case TUNSETSNDBUF:
 	case SIOCGIFHWADDR:
+	case TUNSETTRUESIZE_OLD:
 	case SIOCSIFHWADDR:
 		arg = (unsigned long)compat_ptr(arg);
 		break;
@@ -3408,6 +3472,7 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 	RCU_INIT_POINTER(tfile->tun, NULL);
 	tfile->flags = 0;
 	tfile->ifindex = 0;
+	tfile->rx_extra_truesize = 0;
 
 	init_waitqueue_head(&tfile->socket.wq.wait);
 
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 79d53c7a1ebd..4be63efe6540 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -61,6 +61,10 @@
 #define TUNSETFILTEREBPF _IOR('T', 225, int)
 #define TUNSETCARRIER _IOW('T', 226, int)
 #define TUNGETDEVNETNS _IO('T', 227)
+/* Test-only: add scalar bytes to skb->truesize on RX after TUN allocates
+ * an skb.
+ */
+#define TUNSETTRUESIZE _IO('T', 228)
 
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window_truesize.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window_truesize.pkt
new file mode 100644
index 000000000000..1c5550fff509
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window_truesize.pkt
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+// Run the negative-window / max-advertised-window regression with inflated
+// TUN skb->truesize so scaling_ratio drifts throughout the flow. The sequence
+// checks and drop counters should remain identical to the uninflated case.
+
+--mss=1000
+
+`./defaults.sh`
+
+    0 `nstat -n`
+
+// Establish a connection.
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1000000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,nop,sackOK,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 4>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+// Put 1040000 bytes into the receive buffer.
+   +0 < P. 1:65001(65000) ack 1 win 257
+    * > .  1:1(0) ack 65001
+   +0 < P. 65001:130001(65000) ack 1 win 257
+    * > .  1:1(0) ack 130001
+   +0 < P. 130001:195001(65000) ack 1 win 257
+    * > .  1:1(0) ack 195001
+   +0 < P. 195001:260001(65000) ack 1 win 257
+    * > .  1:1(0) ack 260001
+   +0 < P. 260001:325001(65000) ack 1 win 257
+    * > .  1:1(0) ack 325001
+   +0 < P. 325001:390001(65000) ack 1 win 257
+    * > .  1:1(0) ack 390001
+   +0 < P. 390001:455001(65000) ack 1 win 257
+    * > .  1:1(0) ack 455001
+   +0 < P. 455001:520001(65000) ack 1 win 257
+    * > .  1:1(0) ack 520001
+   +0 < P. 520001:585001(65000) ack 1 win 257
+    * > .  1:1(0) ack 585001
+   +0 < P. 585001:650001(65000) ack 1 win 257
+    * > .  1:1(0) ack 650001
+   +0 < P. 650001:715001(65000) ack 1 win 257
+    * > .  1:1(0) ack 715001
+   +0 < P. 715001:780001(65000) ack 1 win 257
+    * > .  1:1(0) ack 780001
+   +0 < P. 780001:845001(65000) ack 1 win 257
+    * > .  1:1(0) ack 845001
+   +0 < P. 845001:910001(65000) ack 1 win 257
+    * > .  1:1(0) ack 910001
+   +0 < P. 910001:975001(65000) ack 1 win 257
+    * > .  1:1(0) ack 975001
+   +0 < P. 975001:1040001(65000) ack 1 win 257
+    * > .  1:1(0) ack 1040001
+
+// Start inflating future TUN skbs only after the baseline sender-visible
+// window has been established, so the negative-window checks below exercise
+// ratio drift without changing the initial max advertised window.
+   +0 `../tun --set-rx-truesize tun0 65536`
+
+// Trigger an extreme memory squeeze by shrinking SO_RCVBUF.
+   +0 setsockopt(4, SOL_SOCKET, SO_RCVBUF, [16000], 4) = 0
+
+   +0 < P. 1040001:1105001(65000) ack 1 win 257
+    * > .  1:1(0) ack 1040001 win 0
+// Check LINUX_MIB_TCPRCVQDROP has been incremented.
+   +0 `nstat -s | grep TcpExtTCPRcvQDrop | grep -q " 1 "`
+
+// RWIN == 0: rcv_wup = 1040001, rcv_wnd = 0, rcv_mwnd_seq > 1105001.
+
+// Accept pure ack with seq in max adv. window.
+   +0 write(4, ..., 1000) = 1000
+   +0 > P. 1:1001(1000) ack 1040001 win 0
+   +0 < .  1105001:1105001(0) ack 1001 win 257
+
+// In order segment, in max adv. window -> drop (SKB_DROP_REASON_TCP_ZEROWINDOW).
+   +0 < P. 1040001:1041001(1000) ack 1001 win 257
+   +0 > .  1001:1001(0) ack 1040001 win 0
+// Ooo partial segment, in max adv. window -> drop (SKB_DROP_REASON_TCP_ZEROWINDOW).
+   +0 < P. 1039001:1041001(2000) ack 1001 win 257
+   +0 > .  1001:1001(0) ack 1040001 win 0 <nop,nop,sack 1039001:1040001>
+// Check LINUX_MIB_TCPZEROWINDOWDROP has been incremented twice.
+   +0 `nstat -s | grep TcpExtTCPZeroWindowDrop | grep -q " 2 "`
+
+// Ooo segment, in max adv. window -> drop (SKB_DROP_REASON_TCP_OVERWINDOW).
+   +0 < P. 1105001:1106001(1000) ack 1001 win 257
+   +0 > .  1001:1001(0) ack 1040001 win 0
+// Ooo segment, beyond max adv. window -> drop (SKB_DROP_REASON_TCP_INVALID_SEQUENCE).
+   +0 < P. 2000001:2001001(1000) ack 1001 win 257
+   +0 > .  1001:1001(0) ack 1040001 win 0
+// Check LINUX_MIB_BEYOND_WINDOW has been incremented twice.
+   +0 `nstat -s | grep TcpExtBeyondWindow | grep -q " 2 "`
+
+// Read all data.
+   +0 read(4, ..., 2000000) = 1040000
+    * > .  1001:1001(0) ack 1040001
+
+// RWIN > 0: rcv_wup = 1040001, 0 < rcv_wnd < 32000, rcv_mwnd_seq > 1105001.
+
+// Accept pure ack with seq in max adv. window, beyond adv. window.
+   +0 write(4, ..., 1000) = 1000
+   +0 > P.  1001:2001(1000) ack 1040001
+   +0 < . 1105001:1105001(0) ack 2001 win 257
+
+// In order segment, in max adv. window, in adv. window -> accept.
+   +0 < P. 1040001:1041001(1000) ack 2001 win 257
+    * > .  2001:2001(0) ack 1041001
+
+// Ooo partial segment, in adv. window -> accept.
+   +0 < P. 1040001:1042001(2000) ack 2001 win 257
+    * > .  2001:2001(0) ack 1042001 <nop,nop,sack 1040001:1041001>
+
+// Ooo segment, in max adv. window, beyond adv. window -> drop.
+   +0 < P. 1105001:1106001(1000) ack 2001 win 257
+   +0 > .  2001:2001(0) ack 1042001
+// Ooo segment, beyond max adv. window, beyond adv. window -> drop.
+   +0 < P. 2000001:2001001(1000) ack 2001 win 257
+   +0 > .  2001:2001(0) ack 1042001
+// Check LINUX_MIB_BEYOND_WINDOW has been incremented twice more.
+   +0 `nstat -s | grep TcpExtBeyondWindow | grep -q " 4 "`
+
+// We are allowed to go beyond the window and buffer with one packet.
+   +0 < P. 1042001:1062001(20000) ack 2001 win 257
+    * > .  2001:2001(0) ack 1062001
+   +0 < P. 1062001:1082001(20000) ack 2001 win 257
+    * > .  2001:2001(0) ack 1082001 win 0
+
+// But not more: in-order segment, in max adv. window -> drop.
+   +0 < P. 1082001:1083001(1000) ack 2001 win 257
+    * > .  2001:2001(0) ack 1082001
+// Check LINUX_MIB_TCPZEROWINDOWDROP has been incremented again.
+   +0 `nstat -s | grep TcpExtTCPZeroWindowDrop | grep -q " 3 "`
+
+// Another ratio drop must not change the final zero-window decision.
+   +0 `../tun --set-rx-truesize tun0 131072`
+
+   +0 < P. 1082001:1083001(1000) ack 2001 win 257
+    * > .  2001:2001(0) ack 1082001
+// Check LINUX_MIB_TCPZEROWINDOWDROP has been incremented once more.
+   +0 `nstat -s | grep TcpExtTCPZeroWindowDrop | grep -q " 4 "`
diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt
new file mode 100644
index 000000000000..837ba3633752
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh`
+
+    0 `nstat -n`
+
+// Establish a connection.
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
+  +.1 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 < P. 1:20001(20000) ack 1 win 257
+ +.04 > .  1:1(0) ack 20001 win 18000
+
+   +0 setsockopt(4, SOL_SOCKET, SO_RCVBUF, [12000], 4) = 0
+   +0 < P. 20001:80001(60000) ack 1 win 257
+   +0 > .  1:1(0) ack 20001 win 18000
+
+   +0 read(4, ..., 20000) = 20000
+
+// A too big packet is accepted if the receive queue is empty, but the
+// stronger admission path must not zero the receive buffer while doing so.
+   +0 < P. 20001:80001(60000) ack 1 win 257
+    * > .  1:1(0) ack 80001 win 0
+   +0 %{ assert SK_MEMINFO_RCVBUF > 0, SK_MEMINFO_RCVBUF }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default.pkt
new file mode 100644
index 000000000000..b2e4950e0b83
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default.pkt
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_moderate_rcvbuf=0`
+
+// Establish a connection on the default receive buffer. Leave a large skb in
+// the queue, then deliver another one which still fits the remaining rwnd.
+// We should grow sk_rcvbuf to honor the already-advertised window instead of
+// dropping the packet.
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 65535 <mss 1000,nop,nop,sackOK,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <...>
+  +.1 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+// Exchange enough data to get past the completely fresh-socket case while
+// still keeping the receive buffer at its 128kB default.
+   +0 < P. 1:65001(65000) ack 1 win 257
+   * > .  1:1(0) ack 65001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 65001:130001(65000) ack 1 win 257
+   * > .  1:1(0) ack 130001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 130001:195001(65000) ack 1 win 257
+   * > .  1:1(0) ack 195001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 195001:260001(65000) ack 1 win 257
+   * > .  1:1(0) ack 260001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 260001:325001(65000) ack 1 win 257
+   * > .  1:1(0) ack 325001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 325001:390001(65000) ack 1 win 257
+   * > .  1:1(0) ack 390001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 390001:455001(65000) ack 1 win 257
+   * > .  1:1(0) ack 455001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 455001:520001(65000) ack 1 win 257
+   * > .  1:1(0) ack 520001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 520001:585001(65000) ack 1 win 257
+   * > .  1:1(0) ack 585001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 585001:650001(65000) ack 1 win 257
+   * > .  1:1(0) ack 650001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 650001:715001(65000) ack 1 win 257
+   * > .  1:1(0) ack 715001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 715001:780001(65000) ack 1 win 257
+   * > .  1:1(0) ack 780001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 780001:845001(65000) ack 1 win 257
+   * > .  1:1(0) ack 845001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 845001:910001(65000) ack 1 win 257
+   * > .  1:1(0) ack 910001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 910001:975001(65000) ack 1 win 257
+   * > .  1:1(0) ack 975001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 975001:1040001(65000) ack 1 win 257
+   * > .  1:1(0) ack 1040001
+   +0 read(4, ..., 65000) = 65000
+
+// Leave about 60kB queued, then accept another large skb which still fits
+// the rwnd we already exposed to the peer. The regression is the drop; the
+// exact sk_rcvbuf growth path is an implementation detail.
+   +0 < P. 1040001:1102001(62000) ack 1 win 257
+   * > .  1:1(0) ack 1102001
+
+   +0 < P. 1102001:1167001(65000) ack 1 win 257
+   * > .  1:1(0) ack 1167001
+   +0 read(4, ..., 127000) = 127000
diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default_truesize.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default_truesize.pkt
new file mode 100644
index 000000000000..c2ebe11d75f7
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default_truesize.pkt
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_moderate_rcvbuf=0`
+
+// Establish a connection on the default receive buffer. The warmup traffic
+// keeps the socket in the normal data path without changing its default
+// sk_rcvbuf. Then inflate skb->truesize on future TUN RX packets so the live
+// scaling_ratio drops after we already exposed a larger rwnd to the peer.
+// The follow-up packet should still be admitted, and tcp_clamp_window() should
+// grow sk_rcvbuf to honor the sender-visible window instead of dropping data.
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 65535 <mss 1000,nop,nop,sackOK,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <...>
+  +.1 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+// Exchange enough data to get past the completely fresh-socket case while
+// still keeping the receive buffer at its initial default.
+   +0 < P. 1:65001(65000) ack 1 win 257
+   * > .  1:1(0) ack 65001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 65001:130001(65000) ack 1 win 257
+   * > .  1:1(0) ack 130001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 130001:195001(65000) ack 1 win 257
+   * > .  1:1(0) ack 195001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 195001:260001(65000) ack 1 win 257
+   * > .  1:1(0) ack 260001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 260001:325001(65000) ack 1 win 257
+   * > .  1:1(0) ack 325001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 325001:390001(65000) ack 1 win 257
+   * > .  1:1(0) ack 390001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 390001:455001(65000) ack 1 win 257
+   * > .  1:1(0) ack 455001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 455001:520001(65000) ack 1 win 257
+   * > .  1:1(0) ack 520001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 520001:585001(65000) ack 1 win 257
+   * > .  1:1(0) ack 585001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 585001:650001(65000) ack 1 win 257
+   * > .  1:1(0) ack 650001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 650001:715001(65000) ack 1 win 257
+   * > .  1:1(0) ack 715001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 715001:780001(65000) ack 1 win 257
+   * > .  1:1(0) ack 780001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 780001:845001(65000) ack 1 win 257
+   * > .  1:1(0) ack 845001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 845001:910001(65000) ack 1 win 257
+   * > .  1:1(0) ack 910001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 910001:975001(65000) ack 1 win 257
+   * > .  1:1(0) ack 975001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 < P. 975001:1040001(65000) ack 1 win 257
+   * > .  1:1(0) ack 1040001
+   +0 read(4, ..., 65000) = 65000
+
+   +0 %{ base_rcvbuf = SK_MEMINFO_RCVBUF }%
+
+// Leave about 60kB queued, then make future TUN skbs look more expensive in
+// two steps. Both inflated skbs still fit the already-advertised window and
+// must be admitted, and sk_rcvbuf should keep growing as the live
+// scaling_ratio drops further.
+   +0 < P. 1040001:1102001(62000) ack 1 win 257
+   * > .  1:1(0) ack 1102001
+
+   +0 `../tun --set-rx-truesize tun0 4096`
+
+   +0 < P. 1102001:1167001(65000) ack 1 win 257
+   * > .  1:1(0) ack 1167001
+   +0 %{ assert SK_MEMINFO_RCVBUF > base_rcvbuf, (base_rcvbuf, SK_MEMINFO_RCVBUF) }%
+   +0 %{ small_rcvbuf = SK_MEMINFO_RCVBUF }%
+
+   +0 < P. 1167001:1229001(62000) ack 1 win 257
+   * > .  1:1(0) ack 1229001
+
+   +0 `../tun --set-rx-truesize tun0 65536`
+
+   +0 < P. 1229001:1294001(65000) ack 1 win 257
+   * > .  1:1(0) ack 1294001
+   +0 %{ assert SK_MEMINFO_RCVBUF > small_rcvbuf, (base_rcvbuf, small_rcvbuf, SK_MEMINFO_RCVBUF) }%
+
+   +0 < P. 1294001:1356001(62000) ack 1 win 257
+   * > .  1:1(0) ack 1356001
+   +0 read(4, ..., 254000) = 254000
diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed_truesize.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed_truesize.pkt
new file mode 100644
index 000000000000..08da5fddaa12
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed_truesize.pkt
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_shrink_window=1
+sysctl -q net.ipv4.tcp_rmem="4096 32768 $((32*1024*1024))"`
+
+   0 `nstat -n`
+
+// Establish a connection. After the first payload we know the peer has seen a
+// scaled receive window reaching sequence 25361. Inflate later TUN skbs in two
+// steps so the live scaling_ratio drops more than once, then verify that:
+//   1) a segment one byte beyond the max advertised window is still dropped,
+//   2) a segment exactly using the previously advertised max window is still
+//      accepted even though the current live ratio no longer matches that
+//      original advertisement basis.
+  +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+  +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+  +0 bind(3, ..., ...) = 0
+  +0 listen(3, 1) = 0
+
+  +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+  +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 10>
+  +0 < . 1:1(0) ack 1 win 257
+
+  +0 accept(3, ..., ...) = 4
+
+  +0 < P. 1:10001(10000) ack 1 win 257
+   * > .  1:1(0) ack 10001 win 15
+
+// Max window seq advertised here is 10001 + 15*1024 = 25361.
+  +0 `../tun --set-rx-truesize tun0 4096`
+
+  +0 < P. 10001:11024(1023) ack 1 win 257
+   * > .  1:1(0) ack 11024
+
+  +0 `../tun --set-rx-truesize tun0 65536`
+
+// Segment beyond the max window stays invalid even after ratio drift.
+  +0 < P. 11024:25362(14338) ack 1 win 257
+   * > .  1:1(0) ack 11024
+
+// Segment exactly using the max window must still be accepted.
+  +0 < P. 11024:25361(14337) ack 1 win 257
+   * > .  1:1(0) ack 25361
+
+// Check LINUX_MIB_BEYOND_WINDOW has been incremented once.
+  +0 `nstat | grep TcpExtBeyondWindow | grep -q " 1 "`
diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index cf106a49b55e..473992b3784d 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -2,14 +2,17 @@
 
 #define _GNU_SOURCE
 
+#include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <linux/if_tun.h>
 #include <sys/ioctl.h>
+#include <sys/syscall.h>
 #include <sys/socket.h>
 
 #include "kselftest_harness.h"
@@ -174,6 +177,135 @@ static int tun_delete(char *dev)
 	return ip_link_del(dev);
 }
 
+static bool is_numeric_name(const char *name)
+{
+	for (; *name; name++) {
+		if (*name < '0' || *name > '9')
+			return false;
+	}
+
+	return true;
+}
+
+static int packetdrill_dup_fd(int pidfd, const char *fd_name)
+{
+	char *end;
+	unsigned long tmp;
+
+	errno = 0;
+	tmp = strtoul(fd_name, &end, 10);
+	if (errno || *end || tmp > INT_MAX) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	return syscall(SYS_pidfd_getfd, pidfd, (int)tmp, 0);
+}
+
+static int open_packetdrill_tunfd(pid_t pid, const char *ifname)
+{
+	char fd_dir[PATH_MAX];
+	struct dirent *dent;
+	struct ifreq ifr = {};
+	int pidfd;
+	int saved_errno = ENOENT;
+	DIR *dir;
+
+	snprintf(fd_dir, sizeof(fd_dir), "/proc/%ld/fd", (long)pid);
+
+	pidfd = syscall(SYS_pidfd_open, pid, 0);
+	if (pidfd < 0)
+		return -1;
+
+	dir = opendir(fd_dir);
+	if (!dir) {
+		close(pidfd);
+		return -1;
+	}
+
+	while ((dent = readdir(dir))) {
+		int fd;
+
+		if (!is_numeric_name(dent->d_name))
+			continue;
+
+		/* Reopen via pidfd_getfd() so we duplicate packetdrill's attached
+		 * queue file, instead of opening a fresh /dev/net/tun instance.
+		 */
+		fd = packetdrill_dup_fd(pidfd, dent->d_name);
+		if (fd < 0) {
+			saved_errno = errno;
+			continue;
+		}
+
+		memset(&ifr, 0, sizeof(ifr));
+		if (!ioctl(fd, TUNGETIFF, &ifr) &&
+		    !strncmp(ifr.ifr_name, ifname, IFNAMSIZ)) {
+			close(pidfd);
+			closedir(dir);
+			return fd;
+		}
+
+		if (errno)
+			saved_errno = errno;
+		close(fd);
+	}
+
+	close(pidfd);
+	closedir(dir);
+	errno = saved_errno;
+	return -1;
+}
+
+/* Packetdrill owns the TUN queue fd, so drive the test ioctl through that
+ * exact file descriptor found under /proc/$PACKETDRILL_PID/fd.
+ */
+static int packetdrill_set_rx_truesize(const char *ifname, const char *value)
+{
+	char *packetdrill_pid, *end;
+	unsigned long long tmp;
+	unsigned int extra;
+	pid_t pid;
+	int fd;
+
+	packetdrill_pid = getenv("PACKETDRILL_PID");
+	if (!packetdrill_pid || !*packetdrill_pid) {
+		fprintf(stderr, "PACKETDRILL_PID is not set\n");
+		return 1;
+	}
+
+	errno = 0;
+	tmp = strtoull(packetdrill_pid, &end, 10);
+	if (errno || *end || !tmp || tmp > INT_MAX) {
+		fprintf(stderr, "invalid PACKETDRILL_PID: %s\n", packetdrill_pid);
+		return 1;
+	}
+	pid = (pid_t)tmp;
+
+	errno = 0;
+	tmp = strtoull(value, &end, 0);
+	if (errno || *end || tmp > UINT_MAX) {
+		fprintf(stderr, "invalid truesize value: %s\n", value);
+		return 1;
+	}
+	extra = (unsigned int)tmp;
+
+	fd = open_packetdrill_tunfd(pid, ifname);
+	if (fd < 0) {
+		perror("open_packetdrill_tunfd");
+		return 1;
+	}
+
+	if (ioctl(fd, TUNSETTRUESIZE, (unsigned long)extra)) {
+		perror("ioctl(TUNSETTRUESIZE)");
+		close(fd);
+		return 1;
+	}
+
+	close(fd);
+	return 0;
+}
+
 static int tun_open(char *dev, const int flags, const int hdrlen,
 		    const int features, const unsigned char *mac_addr)
 {
@@ -985,4 +1117,10 @@ XFAIL_ADD(tun_vnet_udptnl, 6in4_over_maxbytes, recv_gso_packet);
 XFAIL_ADD(tun_vnet_udptnl, 4in6_over_maxbytes, recv_gso_packet);
 XFAIL_ADD(tun_vnet_udptnl, 6in6_over_maxbytes, recv_gso_packet);
 
-TEST_HARNESS_MAIN
+int main(int argc, char **argv)
+{
+	if (argc == 4 && !strcmp(argv[1], "--set-rx-truesize"))
+		return packetdrill_set_rx_truesize(argv[2], argv[3]);
+
+	return test_harness_run(argc, argv);
+}
-- 
2.43.0

