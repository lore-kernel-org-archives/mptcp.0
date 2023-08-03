Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154692417D
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 16:27:50 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-317c11517a0so661341f8f.0
        for <mptcp@lists.linux.dev>; Thu, 03 Aug 2023 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691080069; x=1691684869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBnIPaLpUBQo0kIbt1VtWMaNdY6vXScOGJHuxsyxb80=;
        b=Tl1CBteXvZksZc6XFPE19x//hK3eTgSZXpehyGdVUlUYc1c4XhbKbtTvV/MadlUO2K
         EU0UhkI31jFrxkQX8As3FeXlFlTbvnYiX3pVV3oz45CYY3HlEcFZJTBYiiLvWVBRl3mr
         hYVdN91cO+c77JOi5iIzRLzuJHMphc8pYEzzlshs+8NrjHR6NNCTM9rGm9930shPvAlb
         CAETCrou+xDeZ3aYdgwFCJUHVMZq9lbsCssev2CHU8WxKPa7ss1HbAf2+Tqlb2ExPM+A
         8ZRMPNbSaEA5nbq8ERxGJu+9mUSOX3jmN6A/saWzGCdWdxLY1gA19wBBbJpnd+b0FxnJ
         Cf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080069; x=1691684869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBnIPaLpUBQo0kIbt1VtWMaNdY6vXScOGJHuxsyxb80=;
        b=IEuYs/UTdkIm+35B7KKGijz9KJvLDx45sHYbv80S4MwLhLroWGf6c1JVgWzaQ4RKzP
         30SgZmm81MC+eilBMyjbXWnsRNJ1BEROgcPES4oNqCKhBz6jg9E3tSq/kDSTWxcE9JYQ
         6qDV+PWtXC6DoGpv8G0AFDHwJ5FyBCWgiKAwURmWTWPV048PWBj99NLaMBFZXsANtFl1
         v1eZ64N3UCzCe1vlTasrW19UqbBi3bJMwjp+wLFXlkY1fztty9Yw2h4h6SvNkQhjOCRJ
         F7sMpOFk+4z22MqZ2kFXyUf40cYqvMXvwAm3rJ7ZmTQvrKodyltyt6Uiq6zmChOpzEt9
         xQbw==
X-Gm-Message-State: ABy/qLZJuEofG9EJwnHIKSkXZpuBT2LP96a26NWdmy7knmH60zNirkc8
	eyM/hqf9SHqh5RkebAmcfLyjYg==
X-Google-Smtp-Source: APBJJlFrCTmGtUyj8DEzG5dbqfh/5TPifKxWOHdkGuYEm0EErlHgwew30hIE5BgUjIpCwVkn5w5guQ==
X-Received: by 2002:a05:6000:1a47:b0:317:5efa:c46a with SMTP id t7-20020a0560001a4700b003175efac46amr8097820wry.27.1691080069077;
        Thu, 03 Aug 2023 09:27:49 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b003141a3c4353sm253167wrs.30.2023.08.03.09.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:27:48 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 03 Aug 2023 18:27:27 +0200
Subject: [PATCH net 1/4] selftests: mptcp: join: fix 'delete and re-add'
 test
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-1-6671b1ab11cc@tessares.net>
References: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
In-Reply-To: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Geliang Tang <geliang.tang@suse.com>
Cc: Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=hfqRzKxGyaUEWgzy2QiBCH3NjrZO3p7pR4iRluGjJ+E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBky9WCVBTSFtFVA9hiSUR5uWKhdSZZFB+b8F8YM
 07eJUfLXiaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMvVggAKCRD2t4JPQmmg
 c8IUEACLIP5dcRWU20s4Av9wjL/rYYWQRKsTzptp5p2mVJHQaDU8N8op/BVmDAKBqt/pxA8y9X2
 VdFWG08EVnJjZuHIj1asuj8ETOas4S/tTWAVgGjyHFuVIJdtR1xVZ+EO2u/sWnZ/pfe/Zn3ri2D
 BQbvLMPx/R8EVN1XTmqGZSs+Dg7Qi41bzi89gzRx01cvs9LjVUrbTnknKtALHMueq1U2YpNJ45c
 Jw8u7HTCod1UvlD8jadC8MNomMme66rAn8+8ahuPR0gnNShHrwFcfFhkVfZvV9AiwkENEcaEH/u
 psGioGwajZwJAdcFFcJa01OhDVhBPLWQSLsFGOK/uhR4bnU7oJSKm++znAatjb2q+o9PceG06yU
 8nR672vgkXXyO8M/UpHKIczRcrSJF8whkgbKQVU3TxPVYxb68cjnz9+YFiQV2jyj2UY+3vTXIxB
 YshS3lHT5S9MEUNT8YLCAlk7rwocVMAH2Mbpt46xVPbHmTLD5VxseqJqc4wcXYxTCKV/P0bwWOQ
 mvm0+M+ngNK4B3uhSLuecyfgP06r5ay2imfu2du2L8vgjoTblFI1t6ODh57SZQuHhrCycGUujN3
 k0+MbKFpIrvp3Nkij1jENsbyGVZJ5ajuhmDfiskNpdTZTK/ciVUyJB0y6ULrt2JGgAssB6nZtU6
 uRagsMcCbX2XFwg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Andrea Claudi <aclaudi@redhat.com>

mptcp_join 'delete and re-add' test fails when using ip mptcp:

  $ ./mptcp_join.sh -iI
  <snip>
  002 delete and re-add                    before delete[ ok ]
                                           mptcp_info subflows=1         [ ok ]
  Error: argument "ADDRESS" is wrong: invalid for non-zero id address
                                           after delete[fail] got 2:2 subflows expected 1

This happens because endpoint delete includes an ip address while id is
not 0, contrary to what is indicated in the ip mptcp man page:

"When used with the delete id operation, an IFADDR is only included when
the ID is 0."

This fixes the issue using the $addr variable in pm_nl_del_endpoint()
only when id is 0.

Fixes: 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp wrappers")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3c2096ac97ef..067fabc401f1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -705,6 +705,7 @@ pm_nl_del_endpoint()
 	local addr=$3
 
 	if [ $ip_mptcp -eq 1 ]; then
+		[ $id -ne 0 ] && addr=''
 		ip -n $ns mptcp endpoint delete id $id $addr
 	else
 		ip netns exec $ns ./pm_nl_ctl del $id $addr

-- 
2.40.1

