Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF721D596
	for <mptcp@lists.linux.dev>; Thu,  8 May 2025 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692376; cv=none; b=GIQc+aQcwDxB0gZMBUzy5Fx25ZR7Pd4LJu6HClug/i3pHrUuws8375w01IsW8Rqmal2FEtj44b9JuTSvdDu9g4Sf0lvyBVZBzfsBuA6HopUHR0nIkuHETwMzG1kL3vSFT8MA4CErP62PSLvjAQwq38OAIaPUyCk+Lg8Ne6Px9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692376; c=relaxed/simple;
	bh=hQhbhaO8Zx7OtDKFPagfIJ00HDVkDQ+YZmYffxnythM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8gUkUSeqF/5WE2OHHKF3L2yzvO2PUfJXoMqAV/m6MtOOYM3NzhkVt4uPiCvORfLLwEyq2iVXDdv4RaAACAF25IWdj9fxXnZt2Bb7zGC9XbgEKF0D5y/jlDIm1Bpr/qs7IDUIDjI+vsxHnV0rzVi+uQ/NpVkIYE3ShW/qgY+l9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJQAh4v0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJQAh4v0"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so786101b3a.1
        for <mptcp@lists.linux.dev>; Thu, 08 May 2025 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746692374; x=1747297174; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRGCVJPfcsr/8TB6R+WZ33LOVsNeuFhXBOzLDfmrdJU=;
        b=bJQAh4v0pO4YJ606fFrx7WQqxOEehlKLWAbkORje6qfjWkftyq5UmOI3bojU1lu6zZ
         mjyWvkp9V70fUfS5/+vA9Ng1/2nNXhW4YHmkmqf6nmmDZTBvlccNzEJDJWkTuPnXyPtD
         z1BpJVCBIN22VhlOYm+vPwf8f+rBDIGhrApOW1zb5f4ADNoTROaR/izKdiMkNW6IEgXr
         BkGKgqnRhU7EFsfNU6+kBEzB6pBculrdxogVjKnjY0wpKEelkoZfzlmDAFabjEV0tqkp
         cxK7b+PTpwzL1zgLScsbo73QKxZ9Nr5RDtwOHDm3hQcr80xXmuJdYAdO2r95h6tO+ghn
         GJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692374; x=1747297174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRGCVJPfcsr/8TB6R+WZ33LOVsNeuFhXBOzLDfmrdJU=;
        b=WfY//fCZvzn4PQ6/yzJ/Q6xW2Lp+YbqWXzg525xYZYBu/MaIXi/1KAXdflEgpTMhfU
         z3MIk5Gf3xVc8yodR/DndFbodlMti6jdS4a0nEoIChlKmXFIwMB8XcnPBHpo81Vsm4Qp
         mbxLAt7Fj4xNgRhNM3z9yqgB8wrJ76v8wsiAFIyrCLH6Grj70K0HMNRWA80i1XURyody
         zGC1SNKDaNZUWdqNd4H+Q/MKVDjTMeqxpOxl+BQlOu1h6iCUcsLDV+J8K//XG2Rg1Wgb
         Xb3AMNlp0ZRfU6w/DChp9g4OAbnauslC3OynX61t6UugNIjM5Qxghh6vaaW+fmfFlZ8x
         Lkiw==
X-Forwarded-Encrypted: i=1; AJvYcCVfmzoPllMzEckD99Ur9vJx1poqz0PJPGW9SpneQWrg4hP1C4dKdflhGgDGFYJ46KMrlCLk4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWzkjwjPrvgPXDRTZY5Vpu00GMjFy+GYEgkkRDxrDGAr968U4z
	lABQLnHrZFHKUqsut32Cw0C6yn1LemVXvvSarzdgp1dYMtRd2esz
X-Gm-Gg: ASbGncsW8aAy4P5aDFEao0x+A5M0todSq3/ojtqIRzDn5bqhbhGsFZ6jY44LBEdXCd4
	UDTKqGtdcxihc0g4pFw+kI4Y1mmIKZxyOelGP44veqdoF4kS84YJtPJCp1L47ZpZMIXcUBTRd2P
	J17Ig9aL6KwMFEhxq/rE3mC0ttvKkEltrg8I4Vxn4X7afwwGk8mChibqqoycJGAPbzDOKrNdRYm
	gZb/t8/L+dmL+Yt/1+HErVGm2kIY5xkorHxUFMKOaIzR8DCdGa4Lp3iECY9namSFNPkmZClWCcc
	UkrBfFklwVaTch8/hWHsB40kyXS6T4Z1wzsvZOPUF0uIPdCasxFVsu1t6rH3
X-Google-Smtp-Source: AGHT+IGROvk3mF2EKqBAktUKZTpWeSfkmo/9ElGFt+56fmbYp3o8/RWNmiaSxns3kTtet6H1mg65xQ==
X-Received: by 2002:a05:6a20:d524:b0:1f5:8678:183d with SMTP id adf61e73a8af0-2148b81ef71mr9347845637.14.1746692373712;
        Thu, 08 May 2025 01:19:33 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7406a36c523sm10907408b3a.144.2025.05.08.01.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:19:33 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 1/6] selftests: net: disable rp_filter after namespace initialization
Date: Thu,  8 May 2025 08:19:05 +0000
Message-ID: <20250508081910.84216-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250508081910.84216-1-liuhangbin@gmail.com>
References: <20250508081910.84216-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some distributions enable rp_filter globally by default. To ensure consistent
behavior across environments, we explicitly disable it in several test cases.

This patch moves the rp_filter disabling logic to immediately after the
network namespace is initialized. With this change, individual test cases
with creating namespace via setup_ns no longer need to disable rp_filter
again.

This helps avoid redundancy and ensures test consistency.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 7e1e56318625..7962da06f816 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -217,6 +217,8 @@ setup_ns()
 			return $ksft_skip
 		fi
 		ip -n "${!ns_name}" link set lo up
+		ip netns exec "${!ns_name}" sysctl -wq net.ipv4.conf.all.rp_filter=0
+		ip netns exec "${!ns_name}" sysctl -wq net.ipv4.conf.default.rp_filter=0
 		ns_list+=("${!ns_name}")
 	done
 	NS_LIST+=("${ns_list[@]}")
-- 
2.46.0

