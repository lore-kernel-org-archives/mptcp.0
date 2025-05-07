Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CCF288C0D
	for <mptcp@lists.linux.dev>; Wed,  7 May 2025 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623958; cv=none; b=FQNweWdxib0KrNaEw6/0dF+4WNSbjBJguA0Ash3RG8kZYk6YmvpxBPEHZz56jrd7/X466QwRd47aySudS8i0fWXpQ2KYqavu3j2flQHpwkj5KyOiYUwo4ohwoAJ6Q6qMhuouxmAS5U0ej44X+6HVKHmO0V6ocwMldakLfeX0sA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623958; c=relaxed/simple;
	bh=hQhbhaO8Zx7OtDKFPagfIJ00HDVkDQ+YZmYffxnythM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4WIaZmZLU/kf4ncKh8yVF95HTjndWijrRem5HDwLzL7SxQ1D3WsLc8a0gewsojV1NDRuX9JwNIs0FMxh0gaYI/HD+8ElBt24OARpT8KXC7TyWMMI7l6QsCtdt3uZ6ND3r7R9UibQBI5LVktdCu4Kyko1SvrgocJqTeeL4jnUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkiXSJoh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkiXSJoh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33677183so79983475ad.2
        for <mptcp@lists.linux.dev>; Wed, 07 May 2025 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746623956; x=1747228756; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRGCVJPfcsr/8TB6R+WZ33LOVsNeuFhXBOzLDfmrdJU=;
        b=mkiXSJohHFUeTsAuTfgcM4OOrSSDYa2KkYWlKgL3XFlvTDPWsA1oqSwkutXQSBcw5q
         xGxqAYI4Q7Eq0S46JjxGp3Sq/BtZBiSeElKWs2oV3tpM3xhbdFN/p5h646i5LtGNT3WQ
         H9SS87IFmqeWzrVWPtDiR9H6dWF4RiMivV3kr56f5OA6zNH2yh8twJHKdv7Qg5arEU1B
         a1ABSeZ366nsKmaBvuRmcQtXxwPafxt2eCoix1TJs+j43x8xY/OPnrt8Or+wIEJSPxAq
         3RsYQdXRBqam72AFnaM8D8icqbS4uDvvtZHhz+OVQDwi4FGm2/VSiJIBjcAyGUp0s0HM
         domA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623956; x=1747228756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRGCVJPfcsr/8TB6R+WZ33LOVsNeuFhXBOzLDfmrdJU=;
        b=SXDUI9Pcu5zO2bDRU9nXWxjA06yBkcMxjynuGO53sHRki047bo0TaRvQBMa/Io9aN0
         aa9lZaRA/pSK7KNX4Ny3gJ8hCcJPVKPUSMR71cSvyMfrq/9gRuiOy28ZZx7JhwqwlmCL
         /BYR8g9DCuwjU8bLcwmVO2jLAXQdJKl/hI4x7xnNI1yWHr4JBRTYv9fys9vrePp0O42t
         piCR5FzXbcQb9wnA24ABDxtLKNmdS8Xukn6r6jdQkUzg7yhanalLfzGLQ3TE+8S/VJHT
         8JTMi9Cx4J2n1b4y2wLxmY5qyj1UezHbxtDgCfUEnAIJA1KQCJ5xduCCIg6Hwmyplzkp
         shhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCYxdOQts7qVe6ljRdHmkIR3/zzDOsfqfu6lfwM1v7E5Dw3VhZ1BrHtGU5wg17u4cdMeXHnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkuB5q718dF69wO5UChLkVLk8ugbZobmZelPfIGdU2l6Ff1Nsc
	n/70Uy5dWmzEpZM9/OsIxWZEV+IQeIT00kcGxbWGEz1iF38P4cZv
X-Gm-Gg: ASbGncuytAKYDAIwvtsOsoC3P+NI9PZnq3oP8i6YWT1DnPzDfOG4gm3sbKbG+2iMilF
	SmtJDtkeocWFiflpsEU1YeSSp7+ajdJkpk32reU2hGd/TuW2DsFt5Z9enzDxlCp/OYm1+rjpOoX
	5FkmJr+THs+ZXMJF5oeNwxHDk/KgRt8uG3tuV3ayUbbgHrbjlfBCayFUxVc4TWbnojLnSNHiuNg
	F8J34zTmp1DU9yE9O12Lxr5TEMS1IGufLhBpTpDKXrsxd7FwzMzGJ2rBtHYzjl0+ht0iBic+nwh
	7NgxRe0IDuSH4wBxuPr0TOaULkvdtwV8U8+8Uh0kEDx7cGjmYd2IGjSuXSYrjsJlsFgU0LA=
X-Google-Smtp-Source: AGHT+IEmSA/X/ltq+9bYqidRcUx+l1yCtCkXp79+kBle4WIzaMF62NW5u2ryRDoKpCzRQfwyr1fwDw==
X-Received: by 2002:a17:902:e950:b0:224:194c:694c with SMTP id d9443c01a7336-22e5ea88891mr49968655ad.28.1746623956382;
        Wed, 07 May 2025 06:19:16 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e5e93ee88sm17414765ad.86.2025.05.07.06.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:19:15 -0700 (PDT)
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
Subject: [PATCH net-next 1/6] selftests: net: disable rp_filter after namespace initialization
Date: Wed,  7 May 2025 13:18:51 +0000
Message-ID: <20250507131856.78393-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250507131856.78393-1-liuhangbin@gmail.com>
References: <20250507131856.78393-1-liuhangbin@gmail.com>
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

