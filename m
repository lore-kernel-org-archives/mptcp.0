Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577FE2EA484
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792977; cv=none; b=MyB8MdXsT+6peFr2UrdwTIO08yTe87vVbc/g1b8zoO6cYc4rUiJo2V/N0ZvBy0rjV99KfabJ22B0AYCbpfan5BJYEMV6oWj44qPw/iU8fKaP/bQVwt29BgwZLRqiEhpZKU2EaWhms7/H3QMnBo89nIZzUo/3f54vgkybC7VnCS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792977; c=relaxed/simple;
	bh=kGgcaZ5dSflruy84oMfsVc6mcKHnV9Yn/tYcBzKlk6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOmY1y0mO2gGt/G4RGSzwWo9a1riI2AVWctSyEln/A/u4ehP6vMI0dRWAP1Al5jo7JegFSYgCEOJVTYL3cviPeQIvfn46AzxWDL63e2bTUuEdHJ9BgAFp9vDAsOkhznhDMU4bgMufwDehGOD8erMW/Us4I7VdAiJRAu0sINs4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0MYihKH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0MYihKH"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fd95ede45so143561a12.1
        for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758792974; x=1759397774; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYrzRC+Mc8HpR/NxS7zdVfXYo8jUCkc291LCyvTTrB8=;
        b=J0MYihKHyUUOmNfrvfhhX1U0DMHQKUxugplxo5Nzlj/Fkynu89+kOYO2S+/T8ai84w
         UtoQW6HzQzDO9jDOg+Qx3lu/4EZnp7/jGphElJII17/8IU2UtCSnUB44+Iz1fRhgh6CG
         IzohLSThNPLSa8Xgp7Wj4dO6jP90AS6jbgvl1/88a08RKH4yNqxi51C/rsqCaXiByHQt
         v18q3xqGPd+13B87a6mUjhXoEPicMjE2Et+L37W1i8YZAuh1hjLHrdjxXTet9uZ7xScr
         nsATAfRNfHTqfD1m88xOqMozGX6hGuL2DkFvDxFv+TXGFcAIkaumqdI7hytmrELERI6j
         1xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792974; x=1759397774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYrzRC+Mc8HpR/NxS7zdVfXYo8jUCkc291LCyvTTrB8=;
        b=laXKkGxcCfXSwpHSfzM/Pk+s1Zj8eIun5Nz+66vgg0ZVzZCX5nRuvHJIbA+8YEJADi
         X4ZlEFRaDmczFU9/WYwvCGgjiqFXRvG5B2To4BBra7Uuuz2ZQkePbpQ6Ifzb+oLdogGx
         ZZOSEsSgm8OQ8/QXnWOIe63HNpK6DwRwRO7P9eG4H9+/At1qrGrP/N8w17KGJ3fhEN/P
         zBgCOxTUFwS6aJmbVzBAELD6xImuXcMqHbfsyAwGPIM3Rj8Vs7yOnqDsfJtVg9igOv/3
         mlTwSlD3EzKtIKdD5SoKmZKzT8kwT21EGv6+noa7yhJfOvOqc7gGkTiNJY08/oZ1phOL
         3Tqg==
X-Forwarded-Encrypted: i=1; AJvYcCXlQBwXOsTPsT5LaXT5psle51KbVdxWGs6www3mUsf8RcRRp4IN5sMBTPlhou1TqDSFm2EEAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkksCngIPWNBpr1l82emJHr9Lw+ikPSouwjYmTKK0Y4UVAFEba
	qiOsPJyTJHMhXn38bj3PQ9p3M3aMlCeZqlwBGtsh+3Fs/kc0gIpRqOsO
X-Gm-Gg: ASbGnctDnlVTbkfGKkEoLkgGLetfEpuHxV1qq+9SmK4TziEWlDdhfH5y7yA2PTb6TK8
	FvReXoVfm0pOMGO5rzOVT7Dmze/LDSFzktgHaNYZIFQrnDvqatDxUfMf7N/ckrvXNFzSL2g4D8t
	uA8s9bXPQ5KD7qdUgWaPYDnhOFa34JNy4bSMjVXpMPD0h64Zu7iyCh3C5XwLpB2YlTTk64mw/XJ
	fh5r4loJw/TMLsjb/MCJ+DBUiT3WgHk2QLqttbzk3zqosxXrpyKZ9A85SDzenn3f34vUDEkxlD/
	zfbGIlaPGkmOD7DOUjpcOVHbATurQVTSYWpblgKyiXqbt887kR0OGbd6u/NXan3FXnWDrqxS7Jg
	JIWziD4sj+EoU2g49GXYpzwwfdrlIr6eKHvu4YA==
X-Google-Smtp-Source: AGHT+IEneqUbInPckHU+/2ODBYNyktvBg1Q4FEg/iNx5A55j1JRc7HsQFyzgpGys7+XvMH0c6D/9kA==
X-Received: by 2002:a50:8d89:0:b0:62c:dfae:ab96 with SMTP id 4fb4d7f45d1cf-6349fac9c10mr931863a12.7.1758792973580;
        Thu, 25 Sep 2025 02:36:13 -0700 (PDT)
Received: from bhk ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae321csm941225a12.24.2025.09.25.02.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:36:13 -0700 (PDT)
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
Subject: [PATCH v3 1/3] selftests/bpf: Prepare to add -Wsign-compare for bpf tests
Date: Thu, 25 Sep 2025 11:35:39 +0100
Message-ID: <20250925103559.14876-2-mehdi.benhadjkhelifa@gmail.com>
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
 tools/testing/selftests/bpf/progs/test_global_func11.c     | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func12.c     | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func13.c     | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func9.c      | 2 +-
 tools/testing/selftests/bpf/progs/test_map_init.c          | 2 +-
 tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_global_func11.c b/tools/testing/selftests/bpf/progs/test_global_func11.c
index 283e036dc401..2ad72bf0e07b 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func11.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func11.c
@@ -5,7 +5,7 @@
 #include "bpf_misc.h"
 
 struct S {
-	int x;
+	__u32 x;
 };
 
 __noinline int foo(const struct S *s)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func12.c b/tools/testing/selftests/bpf/progs/test_global_func12.c
index 6e03d42519a6..53eab8ec6772 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func12.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func12.c
@@ -5,7 +5,7 @@
 #include "bpf_misc.h"
 
 struct S {
-	int x;
+	__u32 x;
 };
 
 __noinline int foo(const struct S *s)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func13.c b/tools/testing/selftests/bpf/progs/test_global_func13.c
index 02ea80da75b5..c4afdfc9d92e 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func13.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func13.c
@@ -5,7 +5,7 @@
 #include "bpf_misc.h"
 
 struct S {
-	int x;
+	__u32 x;
 };
 
 __noinline int foo(const struct S *s)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func9.c b/tools/testing/selftests/bpf/progs/test_global_func9.c
index 1f2cb0159b8d..9138d9bd08fc 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func9.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func9.c
@@ -5,7 +5,7 @@
 #include "bpf_misc.h"
 
 struct S {
-	int x;
+	__u32 x;
 };
 
 struct C {
diff --git a/tools/testing/selftests/bpf/progs/test_map_init.c b/tools/testing/selftests/bpf/progs/test_map_init.c
index c89d28ead673..311e6ac64588 100644
--- a/tools/testing/selftests/bpf/progs/test_map_init.c
+++ b/tools/testing/selftests/bpf/progs/test_map_init.c
@@ -22,7 +22,7 @@ int sysenter_getpgid(const void *ctx)
 	/* Just do it for once, when called from our own test prog. This
 	 * ensures the map value is only updated for a single CPU.
 	 */
-	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+	__u32 cur_pid = bpf_get_current_pid_tgid() >> 32;
 
 	if (cur_pid == inPid)
 		bpf_map_update_elem(&hashmap1, &inKey, &inValue, BPF_NOEXIST);
diff --git a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c
index d9b2ba7ac340..4b8ab8716246 100644
--- a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c
+++ b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c
@@ -102,7 +102,7 @@ int xdp_ingress_v6(struct xdp_md *xdp)
 	opt_state.byte_offset = sizeof(struct tcphdr) + tcp_offset;
 
 	/* max number of bytes of options in tcp header is 40 bytes */
-	for (int i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
+	for (__u32 i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
 		err = parse_hdr_opt(xdp, &opt_state);
 
 		if (err || !opt_state.hdr_bytes_remaining)
-- 
2.51.0

