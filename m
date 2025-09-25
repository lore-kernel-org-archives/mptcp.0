Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331BB2EAB93
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792987; cv=none; b=iMmi9Dne03WXNZ5IesW70FIPe9OCJlkNn6mGbW8HkAcINV30FAnhpjmXpIkFIWM/WfmZ3NyUvpldOp3WIQvXjH5Gtf1isvMjEKMHfw5rf528tQ5UZeL8rVav/+VPMCrenrSYu1AdRSPHnMOZUdNx1KTB1fsQT2b8mMUnWfW6k3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792987; c=relaxed/simple;
	bh=rTyTIq2Gt2gZfhvU599hCfa9TalaA8vvAUh5cmEGHjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBIUKtmSelLfFQhQYHFMNTaU7njxybW4Wj9d9XF3usJt7uFshIXKtF1yGeJdlKDUYeL4y6f2ghDfRA3RNrj0K/8gp4n7WiK3hqN542RbyDj2D5MtuToe7LzgvW9ghy8yKVA39U7L/SEpfdvhkqngBQIYLTb6qozClzch9jePJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIlpbysJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIlpbysJ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aff17215facso12926366b.2
        for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 02:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758792983; x=1759397783; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5P9HAgv0spV6XAbBHSQmLkVBFZMqhz0/VJATkPbzJU=;
        b=cIlpbysJ52QcDqjJW/m4Z1qIR2fQDJxofvWLw2sPhbuVJ0yFbN3bbw2XF5rwqy7EoI
         biiH8H75Zg41Sdbaxaqp4qyNf4avBOdPc2vVvP0Humqvl1iosTE+gKtFMtG4Om1P9q2g
         A/bjr8mricn2gB52EbiwlpBiSAl3RNCeQhEqR1KJMMZDqaogO9FSq7uOwk+XL/xTXtID
         XGLHlg3eKrttrZlDyU6tEpIDSQ6xKZr5Uyp0QxN4rQz099kvWj+i+1FjGW4hWez9K/MF
         x/OfL1uT1pkekUk9dcHHAKkOAEVjEx44VgRWc3Jr4l+EWosRjiFEV81bw1PSFiIx43dI
         CaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792983; x=1759397783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5P9HAgv0spV6XAbBHSQmLkVBFZMqhz0/VJATkPbzJU=;
        b=XXqSESTanGTYwrpeIL2MfDeakeACtAq1gOILwMnVxl9hFPS1MRj99xHsu8gtnB0O/w
         Uyt5y9Prg5DsQnCAqA91oOfZK1lxgpiFOTUVI4XXn2U9FhPjB6/kL7t6OuhKfEBbIZZQ
         t9/zzzn6Pf03ZsZM4VxCLgkgSZuHVLCmjyFdBMDI+OuKYYZXpy2urLmTiI7Tn+mtODyO
         YhRJ69NeGlwlM0bZ+vyT0Pt2l0TbXy9hx4TYv6tcGoQUdjSa/hvVycmfBS40O6EPl1KH
         4Oxmn0S+ud9oujW2umckK268MF0E+9DYYVqdbXeltUyPKXvpyZE9vFs4NDZZZ26YHgLU
         wfFw==
X-Forwarded-Encrypted: i=1; AJvYcCVZvqWUBclUA/W1Xv/g3aCVhpeCj1nl/x9ZOFhAf4i2Wgbo2QtprMNkhhJBVm0pcBeW4BwbHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBzOGoyeboOlw6QgX4Ngrixa6l9wv2GwNTXedofukdHzNZM/q3
	BcVFP+pzAfinE4F3rcCF7RHE2hNAgJjQNg0+xlbShezkdcMj5Z2jGRmp
X-Gm-Gg: ASbGncuGNLSHpkbU0CokAAPbzt3ZxIS7pKlGzQemxUq3V3lruD/OHWS+eJs1Doxr/Y/
	gdhCEfhqE1LxBl5wI70x3n2w3AxdXFaV8OPL+kUE6BOszL6kAIngL3xfCBGULnu4TDaY1oE26IU
	AJwj9iY1YhUC456rh9EQhIHMGct9YUTjtXC0XK1UwnyaVWNi4X7N2u/K236xuM1JMEs0W2h9+xg
	s/OJHdfr28T+AitzdhyCTn1b1nu2LJvrRs35tzaA5L0BhSsBcpfDd6wmEM95n0XKkFj0v7JW40x
	Su7CzbCAf3Njm01GsANtLeu0lMbhCH75UtUe/FXa6r1F4kvMivYItI6991Z8uVYekq9QT/i8Go6
	EpnsVonvLEWSwbaLzeIr7TKWsmo4=
X-Google-Smtp-Source: AGHT+IHcM6qkfDyv/1e8fv53As/ulPyDAGJd3thgnBDOPvu2/mrkEMoViXuKAJywV6PNSzaebMjldQ==
X-Received: by 2002:a17:907:6d11:b0:b1e:cfab:834c with SMTP id a640c23a62f3a-b34b4be4f65mr163980066b.0.1758792983194;
        Thu, 25 Sep 2025 02:36:23 -0700 (PDT)
Received: from bhk ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae321csm941225a12.24.2025.09.25.02.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:36:22 -0700 (PDT)
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
Subject: [PATCH v3 3/3] selftests/bpf: Prepare to add -Wsign-compare for bpf tests
Date: Thu, 25 Sep 2025 11:35:41 +0100
Message-ID: <20250925103559.14876-4-mehdi.benhadjkhelifa@gmail.com>
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
 tools/testing/selftests/bpf/progs/test_xdp_dynptr.c          | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_loop.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_noinline.c        | 4 ++--
 tools/testing/selftests/bpf/progs/uprobe_multi.c             | 4 ++--
 .../selftests/bpf/progs/uprobe_multi_session_recursive.c     | 5 +++--
 .../selftests/bpf/progs/verifier_iterating_callbacks.c       | 2 +-
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
index 67a77944ef29..12ad0ec91021 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
@@ -89,7 +89,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp, struct bpf_dynptr *xd
 	struct vip vip = {};
 	int dport;
 	__u32 csum = 0;
-	int i;
+	size_t i;
 
 	__builtin_memset(eth_buffer, 0, sizeof(eth_buffer));
 	__builtin_memset(iph_buffer_tcp, 0, sizeof(iph_buffer_tcp));
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
index 93267a68825b..e9b7bbff5c23 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
@@ -85,7 +85,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
 	struct vip vip = {};
 	int dport;
 	__u32 csum = 0;
-	int i;
+	size_t i;
 
 	if (iph + 1 > data_end)
 		return XDP_DROP;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
index fad94e41cef9..85ef3c0a3e20 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
@@ -372,7 +372,7 @@ bool encap_v4(struct xdp_md *xdp, struct ctl_value *cval,
 
 	next_iph_u16 = (__u16 *) iph;
 	__pragma_loop_unroll_full
-	for (int i = 0; i < sizeof(struct iphdr) >> 1; i++)
+	for (size_t i = 0; i < sizeof(struct iphdr) >> 1; i++)
 		csum += *next_iph_u16++;
 	iph->check = ~((csum & 0xffff) + (csum >> 16));
 	if (bpf_xdp_adjust_head(xdp, (int)sizeof(struct iphdr)))
@@ -423,7 +423,7 @@ int send_icmp_reply(void *data, void *data_end)
 	iph->check = 0;
 	next_iph_u16 = (__u16 *) iph;
 	__pragma_loop_unroll_full
-	for (int i = 0; i < sizeof(struct iphdr) >> 1; i++)
+	for (size_t i = 0; i < sizeof(struct iphdr) >> 1; i++)
 		csum += *next_iph_u16++;
 	iph->check = ~((csum & 0xffff) + (csum >> 16));
 	return swap_mac_and_send(data, data_end);
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
index 44190efcdba2..f99957773c3a 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
@@ -20,13 +20,13 @@ __u64 uretprobe_multi_func_3_result = 0;
 
 __u64 uprobe_multi_sleep_result = 0;
 
-int pid = 0;
+__u32 pid = 0;
 int child_pid = 0;
 int child_tid = 0;
 int child_pid_usdt = 0;
 int child_tid_usdt = 0;
 
-int expect_pid = 0;
+__u32 expect_pid = 0;
 bool bad_pid_seen = false;
 bool bad_pid_seen_usdt = false;
 
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
index 8fbcd69fae22..017f1859ebe8 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
@@ -3,6 +3,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
+#include <stddef.h>
 #include "bpf_kfuncs.h"
 #include "bpf_misc.h"
 
@@ -10,8 +11,8 @@ char _license[] SEC("license") = "GPL";
 
 int pid = 0;
 
-int idx_entry = 0;
-int idx_return = 0;
+size_t idx_entry = 0;
+size_t idx_return = 0;
 
 __u64 test_uprobe_cookie_entry[6];
 __u64 test_uprobe_cookie_return[3];
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 75dd922e4e9f..72f9f8c23c93 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -593,7 +593,7 @@ int loop_inside_iter_volatile_limit(const void *ctx)
 {
 	struct bpf_iter_num it;
 	int *v, sum = 0;
-	__u64 i = 0;
+	__s32 i = 0;
 
 	bpf_iter_num_new(&it, 0, ARR2_SZ);
 	while ((v = bpf_iter_num_next(&it))) {
-- 
2.51.0

