Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7017CE
	for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 06:13:55 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id u20so4502534pfm.7
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 22:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6LaMT+9/o80hxcj+tCYLFx1OmLwo/BfpzxRAXY8SmI=;
        b=Jww0d5IalT+o18Trpl2xOdKqmmNj7NE9uGuAVGP7ir1Tks2jEn8VMwxKuIOSr4sIW7
         2/tY4Qdq/mSSsQr+bCm+zBtcSgI3tnM6e3qAL3r6hT54EM2tyvTqREVTn0YzRXET6xdM
         imL6Qkq9+l4vH2W5vYCJt/NWVN9faibyZE7DrfnaPxBKmVwh8V1j9fN2nNQvYh/RZiI4
         I9M8nV5wIhXfICZ7RZfNjvsy16a72heDsx5HcIA6SLIUsWpXabP3dzm87DTRMs3LORED
         oxAPhzPJwjfvzB4pokXZx4RlwzlnGcyrrXxepgzG5CYi8wtusDbvgNNOrPtGZ2GeG1+g
         qxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6LaMT+9/o80hxcj+tCYLFx1OmLwo/BfpzxRAXY8SmI=;
        b=S/B8TarXiOvBqf74iv7eOU4nJJx2dnvHbxB+9tGfaAK2/fSEsTIXq/T22qLZuQ4GTd
         oJyamYrRfaK32Nl0gW+xk1HxSZcJYRycZg0WPqQOOS1lqNdmo8wO70lQQ5Xz1folwV+a
         CKMxa8Tm1Ol7t13ob6pyU/wImcagVAo3wtzQLgk4bd9ML2Eglvi6zFSEItyoOmBT6/J7
         4XzI0jllKzH+JwCYFQ1ArUI5g0IlM4ATVkQdSJ4dP4JwNE+kKSaCXHVvFlQo4Owr6PWM
         /vxd+ccmoRB8xlHYB2uzgqDieG4S0gxuqzM3AfEXQQTYrnee7Bcdtb4tn8VqrXbHaDuJ
         vNSw==
X-Gm-Message-State: AO0yUKWqxAIqJuJ6DIiWQX9+UJd4jdz32CxDCQGfH82t0bCZDfflVcyL
	Ujux5Mfp/XGYAMEgrHAADUo=
X-Google-Smtp-Source: AK7set8B9/T7XeuNW3pQ7+SWnihOlyNtvcdFxqAnwnyIylIXs5kLVKs/Xv3XNdn0atna0w99QUBG1w==
X-Received: by 2002:a62:1aca:0:b0:5a8:d407:60f9 with SMTP id a193-20020a621aca000000b005a8d40760f9mr12094268pfa.29.1677219234924;
        Thu, 23 Feb 2023 22:13:54 -0800 (PST)
Received: from Laptop-X1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e24-20020aa78258000000b005afda149679sm2336071pfn.179.2023.02.23.22.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 22:13:54 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	mptcp@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 bpf-next 0/2] move SYS() macro to test_progs.h and run mptcp in a dedicated netns
Date: Fri, 24 Feb 2023 14:13:41 +0800
Message-Id: <20230224061343.506571-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Martin suggested, let's move the SYS() macro to test_progs.h since
a lot of programs are using it. After that, let's run mptcp in a dedicated
netns to avoid user config influence.

v3: fix fd redirect typo. Move SYS() macro into the test_progs.h
v2: remove unneed close_cgroup_fd goto label.

Hangbin Liu (2):
  selftests/bpf: move SYS() macro into the test_progs.h
  selftests/bpf: run mptcp in a dedicated netns

 .../selftests/bpf/prog_tests/decap_sanity.c   |  16 +--
 .../selftests/bpf/prog_tests/empty_skb.c      |  25 ++---
 .../selftests/bpf/prog_tests/fib_lookup.c     |  28 ++---
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  19 +++-
 .../selftests/bpf/prog_tests/tc_redirect.c    | 100 ++++++++----------
 .../selftests/bpf/prog_tests/test_tunnel.c    |  71 +++++--------
 .../selftests/bpf/prog_tests/xdp_bonding.c    |  40 +++----
 .../bpf/prog_tests/xdp_do_redirect.c          |  30 ++----
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  23 ++--
 .../selftests/bpf/prog_tests/xdp_synproxy.c   |  41 ++++---
 .../selftests/bpf/prog_tests/xfrm_info.c      |  67 +++++-------
 tools/testing/selftests/bpf/test_progs.h      |  15 +++
 12 files changed, 210 insertions(+), 265 deletions(-)

-- 
2.38.1

