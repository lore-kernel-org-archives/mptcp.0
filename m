Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FEF13AFB
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:36 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-307d20548adso4034059f8f.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773514; x=1687365514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umM81SEY7jXI9nj/9WnMvBMexWowJP+wozPO94Hih1o=;
        b=Kfilp3IJAIu4lxCIiwAYagAkjHot8V72jtII5vhvBJh+PRcJuP9eCX6RZEN/dKnlXr
         i8ls7X51SVnSiGaKj3OmqHo89FdA6lOr4+0Fd3eH+BopStG77sF44mJNo9ZwBh5E+BFD
         j2SMyJFRqdIi3P9StQlYST2EJVhOukPwqRth9JoDYYak5Z8upjHzrDAkBr9Olawq7aSM
         4/79qJnp3wL3bho1NJO0w4L0f05EFZycG5ZheaQJhIGmELQMHapIzOqp+d8DCb6q+4J1
         mlhYEwLWy1tXBmAmQOi/2wx2lg3/eSKHPiex7PF7TBHquOHaK3nNdeZPNIZttXjGiUsl
         ZDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773514; x=1687365514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umM81SEY7jXI9nj/9WnMvBMexWowJP+wozPO94Hih1o=;
        b=loQ0D/ANg4yuwpXPRgw05XoGJu0Ww1Fv8TNlGOhcECDRHxzDNxOjkXvBH6ss93ZmRS
         1hkgHx9R7dUM2vB31NdSH7z8jHgDR5ppz2JnI9EGvV1nb2xEtwO4PLKtNTe+oHmJh1wO
         xGR/aee1yxg5WiRKmT+bxhdDGA6bQzsUYIANnCoLj7VFYgU/oUoD1PCUoLIKQ8coASD2
         NopjfvtVSWWx78PJD6OSV4A7/zmu6rGEVM7yC8T+wBBH+7yi/IGhkrknzlaEFV3cUSCL
         je/yIRkhIOziLihQk81ik5c+l57LNR8CiU8dZE2osXU5iZqaS/Txik1vFMexUR+nijkS
         KeLA==
X-Gm-Message-State: AC+VfDzLUn+uPhEeT7vqdJjX7sf7J6fRTWAHPeSm7qEGiHaCgs56CPnA
	SJHTy3+t4MOtt1WRpHPQtBR0E9f3TbU1GIoWmvIeew==
X-Google-Smtp-Source: ACHHUZ4ciDzgUyDDXAes2Zq9khv9ygI6bgb2DUh4T/Ayjbdp0LjucDdmNvUF5wRSC3/21IPYSqR2hw==
X-Received: by 2002:adf:f108:0:b0:309:3a83:cf3a with SMTP id r8-20020adff108000000b003093a83cf3amr8091222wro.0.1684773514607;
        Mon, 22 May 2023 09:38:34 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:34 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:38:06 +0200
Subject: [PATCH mptcp-net v2 34/37] selftests: mptcp: join: skip fail tests
 if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-34-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=WRuaIoCV8Ano39TLUxSYZWYCFsdtK27Z8raXhn0tTWg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5px1bU1os8yn3lGboKY9KzYc92Uwmi+93/dF
 KNmdlh/dWuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacQAKCRD2t4JPQmmg
 cw41EADYf1ShqlYPoWVTYHLFk2HsR+6Ro6yNhZHagHLr+TSSgEzKu7r4YQTmvRNQ5Yzo3iYBn6X
 e5dPcJhxG/UNUpCk9fC/3JK/w8DKxIoUdZCalXa0wGop5LjVNJdyUrKuLhEgcdfzEOUtJR2/LlX
 Ha+fNx3vb8EZGYVYgzbtwLLZHpTqFo4T1oMXHe4TN427n8pZZY0X0uF1stD0ZBWROHHHOqY5e/u
 ie0YqP2jUpyixqvrkk8i1jaXu9qtuyGKODuMmjerIjB7UY8Yp6L3TNlYXnTe12oPPWWt4I39nB5
 k1mZuUPZ64kmxydZTdJOpNfnRcQmVyxoEV2eNbNGmSwSl2j90gSNmDFEhQ+uN5/uO/NDidvBmdA
 dxTeOyiYenKMNYYx27sRFr3FlGssNvsueTiz5AR/t/Q2VJWaYEsINGH9L3rdQMnCJB+0g3BhUi2
 TC4NB1eKXR0XVvfDNaG5XVjzEzvyPPEebfY+hRa+N4dgibybbmMJvmbtl73N+ma5W6k7m8AVyK6
 Ymmwi4A/tn1aSoSwhMu5cte5D7Jk5DlSONPzubV8wO82MN2RRd4Zs2/MJHoKoKC8+T1iCQ/eJop
 TUnTKhAessd3EQCGrx+hWBIvPahlghL4K/f494zKoL7PzWLsJacglPS4qrOXd4/9qcXWbfVfeVZ
 v5Qxr35xWW8Xt4g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of the MP_FAIL / infinite mapping introduced
by commit 1e39e5a32ad7 ("mptcp: infinite mapping sending") and the
following ones.

It is possible to look for one of the infinite mapping counters to know
in advance if the this feature is available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b6e074e171bc ("selftests: mptcp: add infinite map testcase")
Fixes: 2ba18161d407 ("selftests: mptcp: add MP_FAIL reset testcase")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2783a3c59aca..37554287eb89 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -386,7 +386,7 @@ setup_fail_rules()
 
 reset_with_fail()
 {
-	reset "${1}" || return 1
+	reset_check_counter "${1}" "MPTcpExtInfiniteMapTx" || return 1
 	shift
 
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1

-- 
2.39.2

