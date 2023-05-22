Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7334F14267
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:32 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f6077660c6so6715525e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773512; x=1687365512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfHOGX6yin+V5DfX+tprmxqVKaR5xWpMRGje/k0hoOo=;
        b=QVD1QCICpDGmTnvZdkoCaD/MmpHpjyAGYtkpNjJDtjFRJ8Lxr3X1xFm/Ai3KN8TSWg
         s38GjIiMJPVVvVX0fYo9rCduSNFilzaNcbHCt8GWoSaRCtmIV8J8nlaU0jm8GkkoZF4M
         7L2eUEc30tYnGezRmonW8xQRu3Sah/BUL17ySfrOtIzV9IMkbCCiXEw+Frv5FbAu5Y2I
         kn56279zAKYCT89h++kxQoYWVlmUCY+Hswxf3Cf4QZd8Z0jvSfTsGdAKP6HkkBvh7Zry
         D+0JKTFZK2CHk3afs7KC8eS7ufWCxeWp4nEHwmSAA//dAFWRVouPnshhJNgIxLRL2oCn
         qwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773512; x=1687365512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfHOGX6yin+V5DfX+tprmxqVKaR5xWpMRGje/k0hoOo=;
        b=kvIItoYyCq4OFfTEqL/S148kdZ6j1L0CCcUwAm+FoiefGbuPLHmj/OwXhyOjgKei4l
         AOYv0ViFYLoEcHYYQ7RCxmUug+5lmtpC0ANTm38tl/KAFPectkCOqP7qZDlpIpT4nZoa
         a4LaZHONiCXpvf3KVuIpaBupbckIPQCbDI/J+iq3UYAm2v5nazGkers3BJNkSzGArze3
         CWLRP9etDGWpFZpwQ1Kl0Vn8ozfkWCxzeE/1XT121sNuRNF1KeVcu5rGz0EQMb8yH4Co
         8eUFe+9M/nOkpKzVmG2HZKSzpPoup11Mb1EBAZaoYjJagK5TcR4B64Bat0MR6yZpqAHT
         NVxg==
X-Gm-Message-State: AC+VfDz2skQHuYBKCi7Lfs4IKrDDgouLnZPY4WkSemlqKn+L5GQXIiME
	glckElXHCBX4z+M3+DMeICl1Yd4d5EKrcJPM5NL9tQ==
X-Google-Smtp-Source: ACHHUZ4OvlZb7WXmAGFKqEqJcVCB2/MPuS/4EO1mEjqjBzgf/0rPdLB4F3NxIpeuexXPrFMWDyxVeg==
X-Received: by 2002:a1c:741a:0:b0:3f4:2158:289b with SMTP id p26-20020a1c741a000000b003f42158289bmr7581427wmc.18.1684773511792;
        Mon, 22 May 2023 09:38:31 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:31 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:38:02 +0200
Subject: [PATCH mptcp-net v2 30/37] selftests: mptcp: join: skip implicit
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-30-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1807;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=Bfa1QDotDtKeVa4E2vrmx7bLrQKN0+fxLcFIhsvDNCQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pxD8l+AKBJIPEDF6m+Gf6cLMsiQBH+ry5kJ
 FRQgGYwmZOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacQAKCRD2t4JPQmmg
 c843D/0bedEjMDWtVKJUniE/tq7iMYilF4lh8jDB2GaoWsBKswUDS9HNlNccVImnEF4BorJ8k8Y
 OqxfxG2tHOg//HU2DckOYKigwZbyKqTecK/JmyZp5z2Q5RGZrs93C/BbvZG5lbGyTmJMW5qYQ/F
 gt2yFu+we65q8M/dzPGTX8WSWlZVv0VlZQZLp9SEqutamDUG04u07dWayL91Th6udCjs5LhH4xT
 Hs3COKHShDz/0Y+4zhVmbBCrlOin5HkBAfj/vLix5GhMdNlVlRTUJqWeU6ij4i1m697CzJt5ptr
 IP4x2Tq7RVU4SrsnN8YdE9OundgNlWQ2Ilo9e88TcjvEYS17F6MO9kVi+qMpNaavoIpj8fFosbD
 AFxPg/J9SFkJVrqNFtxIAgoapBPSdBS9K/UQrEzd43AI53vr5sd6TB9ME11xC+k0veCXyhMJhgG
 kWNl4aBnHtAjjardO4XH2BflgpUg6fs8UwCHewK75AiTe41XFUg8TnK8+6TIqFyJaz9zy4aAwS2
 s7bX//0I4o+zFhwaOXrkgqTPMN39sJ439e9zBN5w61yFeoDoJeUGmFHpZu1tAHoE4gW4U0swgnO
 XfVA/JVww9lYbq6KI3n1JuDwPmbUqQHfS7tCK14OHeGDcu7Nue5Vim9duSZZ3q0+W/GtS7OLWqM
 tDPOFEajgsyl8yg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of the implicit endpoints introduced by
commit d045b9eb95a9 ("mptcp: introduce implicit endpoints").

It is possible to look for "mptcp_subflow_send_ack" in kallsyms because
it was needed to introduce the mentioned feature. So we can know in
advance if the feature is supported instead of trying and accepting any
results.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fd0e3c6fa147..c19a1d0ce738 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3330,8 +3330,10 @@ userspace_tests()
 
 endpoint_tests()
 {
+	# subflow_rebuild_header is needed to support the implicit flag
 	# userspace pm type prevents add_addr
-	if reset "implicit EP"; then
+	if reset "implicit EP" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -3351,7 +3353,8 @@ endpoint_tests()
 		kill_tests_wait
 	fi
 
-	if reset "delete and re-add"; then
+	if reset "delete and re-add" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow

-- 
2.39.2

