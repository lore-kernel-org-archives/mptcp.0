Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3B2EBB9B
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792982; cv=none; b=PCuzGvwXDNhFTR5W6uttixT6B5YRhbS21++h0M6p9+mt9XXa6iQi13ihZomQ9t6YojxgCjDfISqTF+5ubOe1CdM80H5tL0L9JNI8zcWR47KiAXZ/R4XZj1wpt1nQJSpvSvj6waj+MrH5TzVpPNOumOr4pgm2A9zylSG5EIBvuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792982; c=relaxed/simple;
	bh=2mG7qJ2Y78I9Q0KSuXQ2NjcyY7f58p+CSBWSScj2RH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGUWEU5gPsDGHTQgdWjSlykYFaf3jZBqHS5uvNS4ybfh4tKcHYR8HJBnOMK0Pj8tStFHaYhDMQo/V+J7zlQj8HB3a6pWiMjJ2AXg89R47i1Z45dI3KPSwIUW6goLywqU+e3c2ko4dmn6LD2YfKvkn+ZOx1Iv3CRP9/yzrAlZ+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQakuiBK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQakuiBK"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6317d75ccc9so72333a12.1
        for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 02:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758792979; x=1759397779; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO0ayIYXnbf5RnG1Y4914ZaMA9kHmb//RoVl9SUlrOU=;
        b=jQakuiBK1zX9xDlz54XGnXGNNAEymsYmeVic+Rjka2tplosvRjP2m7XP5rucV1FnRe
         n8dJivlPxQjvhaI4E8vBhUgpRxyWsh4Af7FGGbKbX4FPkbRug1PgPouzlMlwXGeBpFSe
         +XWm5vVvnpg1P7PodorMva3auuj+hmyZ06W9mshiP2KWx6YByiNi0uVRoC9cx+s/T9co
         UVpOUAwxVLYlH5c3sWSLIkWN3Imhl2f1wQgvPKw82RW6Nne01P9jnU3e02tmgpxhwq7J
         THBNVoycA6KL1FBMrzmB/0BvW6WmtS06MIHLMQ2lAQjHMZub8PAnxUbsFiLggdW+EYQT
         tcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792979; x=1759397779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NO0ayIYXnbf5RnG1Y4914ZaMA9kHmb//RoVl9SUlrOU=;
        b=oWiZUZWBX20DUCqCSfRD/EApQv+VJ2+Wxt0gcoPSCehZ3WReVNybVes7yHvzM0pQXk
         X86dcTOTmBXJswE9yS7jRtscx7uEfg9G0E42633v2FPwCE9Q8RQbMoxg3DUDj9M+jUB9
         59h5xH/XfsBPqfGZPZ8YRsBHK1aLCJ5VjbsA9J2Ln3vNwwCFlICNOb5q+2IeBZA5VmSY
         8mJBH/R/joGoWQDSAermA+Xp7qb6V47LpUCKpsTUzJw089KkF8xf7WEhhJ5gm/ImTuAa
         HeYNwv55gKdM373mLHcoOa5CFqxmWof4ZatzEyo+Bc90z4StPrWFW4Vv1H08Urqt2wvF
         6gaw==
X-Forwarded-Encrypted: i=1; AJvYcCUN16FcYQjfXGKaoDNVeNgl5mZ1U74ccWMKNU4FWsjCEdObrjzd73jtj4a3BX1k5415C4B8YA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfJYuWC5myLoveH8X/ZqeHX/3so2HRJ54aVGrXiYIB8DeThuKj
	wW4ddBDZJnpxBYRWJTVVqOZdnV6aO8Nd8dBE9koQttNZufO8i+3kLi/q
X-Gm-Gg: ASbGncu44Or9Es9l0ph8zSnvrvkjfPaUyqbN/vHCCH3eWcchmm3ymTSMlN4Ltikntqz
	PZk+vSDL9c+n/vus3sYnQ1rJxeZhs1Slngt0gBpso4tld3lUhPg9utoS58x9z21u90Hb2+7pKia
	pAp66echmJAf+Gn6HDiXrdg6mepPnhJwyEx7CopfBKu9bNxymQ0LCoz9VdAbjLOYF4nad+XNUW5
	BaEFCVbL/DGOIgKYfpRgKIzMEAejNLua0I5r93SQ3wl10a0l9TxuIxN2IzcxoeJ6/5ozrbgUGKP
	WOka2SrPVXMyV+uH8KboX+W6RV+Q1ijqF+ZOAHfZ9pck70STL1ilrh64uTI/l65/GegN0qjTZKl
	7xfP+jS8cKZ+9WfvIXHu2nb37Nn4=
X-Google-Smtp-Source: AGHT+IFkTu6BAV9MTy9Y6rsh5K7Jn/6CmW5NkfDaEMgjEkpbreaY6/Rf17vMqmExro0hPJr0iXu7CA==
X-Received: by 2002:a50:cc47:0:b0:62f:a79a:f61f with SMTP id 4fb4d7f45d1cf-6349f6d3d08mr947935a12.0.1758792978630;
        Thu, 25 Sep 2025 02:36:18 -0700 (PDT)
Received: from bhk ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae321csm941225a12.24.2025.09.25.02.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:36:17 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	linux@jordanrome.com,
	ameryhung@gmail.com,
	toke@redhat.com,
	houtao1@huawei.com,
	emil@etsalapatis.com,
	yatsenko@meta.com,
	isolodrai@meta.com,
	a.s.protopopov@gmail.com,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	vmalik@redhat.com,
	bigeasy@linutronix.de,
	tj@kernel.org,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	mrpre@163.com,
	jakub@cloudflare.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v3 2/3] selftests/bpf: Prepare to add -Wsign-compare for bpf tests
Date: Thu, 25 Sep 2025 11:35:40 +0100
Message-ID: <20250925103559.14876-3-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-Change only variable types for correct sign comparisons

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 .../testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c | 2 +-
 tools/testing/selftests/bpf/progs/test_skb_ctx.c                | 2 +-
 tools/testing/selftests/bpf/progs/test_snprintf.c               | 2 +-
 tools/testing/selftests/bpf/progs/test_sockmap_strp.c           | 2 +-
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c              | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp.c                    | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c
index dc6e43bc6a62..bf3ac5c2938c 100644
--- a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c
@@ -100,7 +100,7 @@ int xdp_ingress_v6(struct xdp_md *xdp)
 	off += sizeof(struct tcphdr);
 
 	/* max number of bytes of options in tcp header is 40 bytes */
-	for (int i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
+	for (__u32 i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
 		err = parse_hdr_opt(&ptr, &off, &hdr_bytes_remaining, &server_id);
 
 		if (err || !hdr_bytes_remaining)
diff --git a/tools/testing/selftests/bpf/progs/test_skb_ctx.c b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
index a724a70c6700..7939a2edc414 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_ctx.c
+++ b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
@@ -11,7 +11,7 @@ SEC("tc")
 int process(struct __sk_buff *skb)
 {
 	__pragma_loop_unroll_full
-	for (int i = 0; i < 5; i++) {
+	for (__u32 i = 0; i < 5; i++) {
 		if (skb->cb[i] != i + 1)
 			return 1;
 		skb->cb[i]++;
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
index 8fda07544023..1aa4835da71a 100644
--- a/tools/testing/selftests/bpf/progs/test_snprintf.c
+++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
@@ -4,7 +4,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
-__u32 pid = 0;
+int pid = 0;
 
 char num_out[64] = {};
 long num_ret = 0;
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
index dde3d5bec515..e9675c45d8ef 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
@@ -2,7 +2,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-int verdict_max_size = 10000;
+__u32 verdict_max_size = 10000;
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
 	__uint(max_entries, 20);
diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index 404124a93892..c7e2d4571a2b 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -80,7 +80,7 @@ static __always_inline void set_ipv4_csum(struct iphdr *iph)
 {
 	__u16 *iph16 = (__u16 *)iph;
 	__u32 csum;
-	int i;
+	size_t i;
 
 	iph->check = 0;
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp.c b/tools/testing/selftests/bpf/progs/test_xdp.c
index 8caf58be5818..ce2a9ae26088 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp.c
@@ -89,7 +89,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
 	struct vip vip = {};
 	int dport;
 	__u32 csum = 0;
-	int i;
+	size_t i;
 
 	if (iph + 1 > data_end)
 		return XDP_DROP;
-- 
2.51.0

