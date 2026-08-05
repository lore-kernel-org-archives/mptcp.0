Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29A3DFC84
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912476; cv=pass; b=lCG+HGzJy4I1HFvxbGUssLhfUUPpBxqiJuG+0vi4pScIL+0CSC8vqpOsCKWRuqFOmxw6eQht7MK5NOjPZXI+amI/LG23hmZGqz8GCrYgBjxhq5ao3G39RZ5wTwZmCPUs0jwwaeEIvmhOSm2Cac2K4VOUjwZ8ALUHEtKU3XR0gG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912476; c=relaxed/simple;
	bh=26/zj5boyQ76hpVDc3RlmQODxl49xj/jn3Tx8fdduA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3eHPC2XjiN8TKuHxVXKIqEhJG3JHCD5HN3YSL/3njcOUDa8cLMjYtVdJynqoTK2L303cd1LBj7e+7svxhgcuDqYoki79Wd/BUc2Uvmo1UFFIU4wIqrz2ylEzx70dzg9QtbLIftk4tux4GoXquDqwn8QMXIH1q/Apn+fDPI6/X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=re+/HOVm reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="re+/HOVm"
ARC-Seal: i=1; a=rsa-sha256; t=1785912469; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bLPdKvegE+FJ4S/wOF+NMi4K7eBlGiNqyfwLNci4A0R4juFmoY16ufAjwRciFfPE77JzpSeQqru2QjMjMM0Qm1+Id5cZgnu+oxhl/kHyH2YtAaxnG52obRHK4Eu01msHDUfJImVheF2lPY971UYFASlR1+B4akGhFmtFckD66aU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785912469; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=45/ae3Q6oKp2JT0M3Bd2/n68YRHe7yRDpkR61NvtOZU=; 
	b=IeiuukAVdj/4mCzMdsgvjcOu/62EKy5BZXmEXXwRVfsW3jNG8sLAWMGMZmgNxdofdCVQp1QT7dVVfdQitF4MWtXeeHiOGuPNXRt40fb1J2+WjxekuQn9lFaNw84nGqWA5daJ+6kNZbEgcDPh2vElAJb0zTgMX7RBtEjuDoZD+hs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785912469;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=45/ae3Q6oKp2JT0M3Bd2/n68YRHe7yRDpkR61NvtOZU=;
	b=re+/HOVmCPiMXoi70BrwcPZCL0vx79g2YQVGC/8ndzoMnL6pqhzfviFxZ9RSdc/P
	zXkjULIdz17SD+oZRwlgbU7XG0cBkYLutwyvhPjDf0shFV+CI7PziamIie8tpzxUQUb
	PTviIQe0kJCJ/edllpWlIKcfXN0SMkOIVycqIndw=
Received: by mx.zohomail.com with SMTPS id 1785912467061901.4234296992599;
	Tue, 4 Aug 2026 23:47:47 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH packetdrill] mptcp: dss: validate tcp_rto_max_ms on DATA_FIN retransmissions
Date: Wed,  5 Aug 2026 12:17:39 +0530
Message-ID: <20260805064739.3087314-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The kernel patch "mptcp: honour configured min/max RTO in retransmit
paths" makes the MPTCP-level DATA_FIN retransmission backoff follow
the tcp_rto_min_us / tcp_rto_max_ms sysctls instead of the hard-coded
TCP_RTO_MIN / TCP_RTO_MAX constants.

Validate it in dss_fin_retrans_established.pkt: set tcp_rto_max_ms to
its minimum (1000ms). With the default 200ms rto_min, the backoff
shift is then capped at ilog2(1000 / 200) = 2, so the retransmission
intervals stop doubling at 200ms << 2 = 800ms. Add two more expected
DATA_FIN retransmissions at that capped interval.

Without the kernel change, the backoff keeps doubling and the 5th
retransmission arrives after ~1.6s instead of ~800ms, making the test
fail.

Link: https://lore.kernel.org/all/20260805063956.3052563-1-kalpan.jani@mpiricsoftware.com/
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Notes:
- This depends on the kernel patch linked above: the test fails on
  kernels without it (5th DATA_FIN retransmission at ~1.6s instead
  of ~800ms).
- Validated with the mptcp-upstream-virtme-docker environment:
  passes on a patched kernel (ipv4/ipv6/ipv4-mapped-v6), fails
  without the patch as described.

 gtests/net/mptcp/dss/dss_fin_retrans_established.pkt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/gtests/net/mptcp/dss/dss_fin_retrans_established.pkt b/gtests/net/mptcp/dss/dss_fin_retrans_established.pkt
index d394775..73f3647 100644
--- a/gtests/net/mptcp/dss/dss_fin_retrans_established.pkt
+++ b/gtests/net/mptcp/dss/dss_fin_retrans_established.pkt
@@ -2,6 +2,10 @@
 --tolerance_usecs=200000
 `../common/defaults.sh`
 
+// tcp_rto_max_ms (set to its minimum) caps the MPTCP-level backoff at
+// rto_min << ilog2(rto_max / rto_min) = 200ms << 2 = 800ms
++0     `sysctl -wq net.ipv4.tcp_rto_max_ms=1000`
+
 +0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
 +0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
 
@@ -16,10 +20,12 @@
 +0     close(4) = 0
 +0       >   .  1:1(0)  ack 1             <dss dack4=1 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>
 
-// wait for retransmissions
+// wait for retransmissions: the interval stops doubling at 800ms
 +0.2~+0.3 >  .  1:1(0)  ack 1             <dss dack4=1 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>
 +0.2~+0.3 >  .  1:1(0)  ack 1             <dss dack4=1 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>
 +0.4~+0.5 >  .  1:1(0)  ack 1             <dss dack4=1 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>
++0.8~+0.9 >  .  1:1(0)  ack 1             <dss dack4=1 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>
++0.8~+0.9 >  .  1:1(0)  ack 1             <dss dack4=1 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>
 
 // ACK the data_fin
 +0       <   .  2:2(0)  ack 1  win 450    <dss dack4=2 dsn8=1 ssn=0 dll=1 nocs fin, nop, nop>
-- 
2.43.0

