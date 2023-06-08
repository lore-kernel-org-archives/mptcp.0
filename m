Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DF512B8D
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 16:39:01 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-30ae4ec1ac7so612130f8f.2
        for <mptcp@lists.linux.dev>; Thu, 08 Jun 2023 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686242340; x=1688834340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czHHBif6b3JNPCEfCU3p0DvzKEkPWI28pRVwFLD3TEk=;
        b=75gqNSzuYINuHY5SCr+DHhdj+MkqUn5K3pmF8985c8b8Qmgt1IHJAZJbh3f+fzNMY+
         JUtij/ifnHZ1Px7qoQ1wFDKBOqJToPqBdYBS2zGOInSX45sAZYmn2sOZQ7zd17InT0O2
         AIAlryytQH9DnHpTSrMJF3xqZe9oT0H0DDff/9wWNrftjM751OclCeRqvFH2bTLCcEbF
         mWkV7W28ySKLRml85f2ryhONR1gaaW1AniH5+dVoNnB8yUMbjwJ+VRh+2xa/K0HfBncg
         dQN8umCqv6aPBowj7IRydRJYCEj1ITGy9KeepeK0zmgrV1BdIYcCye4Mav0dmWcqYw8Q
         axYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242340; x=1688834340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czHHBif6b3JNPCEfCU3p0DvzKEkPWI28pRVwFLD3TEk=;
        b=gFrkSquy865OsNbAi+dHm1/k0qIgarhee74Xx4TPInwuqe+UctSnMbGhjsdAQBb02X
         RrxdrrH6kyACV8IfG7j640Ij3zprZsPrQlJ9x6tibi/+483FPuS8ICIi1jqyq6ct3lYM
         RS1BcwgVP8tRJRVtoKg6x/n+qgmLPVZzrcaeFBIpPqYBN0vtjhjTbHRfELFBhC8SjEAm
         fsD2RuqnyYA48GWCO5KANyH8KVrdLWdmDi9BhRuIMEuiMv/M2Mc1ZLtw2lXmLtvEpMs8
         2OJbNgp5s964wzuuJ7CKUTO4Y2mOvp27NiLI0zhGORj0zfWESjn4cn1Km8z8H/Xjfpkb
         9C2Q==
X-Gm-Message-State: AC+VfDxmBy+WA25RdVEHdJckOUVgSxP2ZpktdyN7Xz2lODmxZp88KPFn
	rGG7LAreQl2p9St2C+jD2R9h1w==
X-Google-Smtp-Source: ACHHUZ5ejWfNPCf5kv9xyszkDUXkBmsLNfy8THTCbjUhm65isOwsiOMKIa209E2ordVxlqcTIstceg==
X-Received: by 2002:adf:f1d1:0:b0:30a:e70d:9e73 with SMTP id z17-20020adff1d1000000b0030ae70d9e73mr7766087wro.33.1686242339908;
        Thu, 08 Jun 2023 09:38:59 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm2038215wro.98.2023.06.08.09.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:38:59 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 08 Jun 2023 18:38:48 +0200
Subject: [PATCH net 06/14] selftests: mptcp: diag: skip inuse tests if not
 supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-6-20997a6fd841@tessares.net>
References: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
In-Reply-To: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Davide Caratti <dcaratti@redhat.com>, 
 Dmytro Shytyi <dmytro@shytyi.net>, Menglong Dong <imagedong@tencent.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=GFhSqu6crxevOWFlUMLP/NWLyXtLoglclQ/BPatDiGs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkggQZ1TJ6RZ82IXZNGMBvvYLfKUyHoJAZyLbq5
 B+55fJO15WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIIEGQAKCRD2t4JPQmmg
 c0ogEAC5De1Wak4W2bPErgQJAQgZ7UQe8hoKJnfOsYDzE3i3Q+MZg/KnWX27LHbm+JZ/40ustCj
 P8Dxhkwbsoi/Y7tLwvwo7IJJ6r8qyHalenDoNywL1J3txjNY7Alj2gXfdaDWB7UoLAsZeqVMlRt
 7iMOXgrPaSmP7a5XcfkbZnHoY4LMK11R0pM/VCdorceRiIXRjR7YoQmeX9uS+Kb5439K8HYMkIw
 wwmNkxywerdfOWOxfhbP/DM+8gp+We9hiEsD5/H4LtjARq3ECjQKniSTYOuSjZ4VlXLxbFNBtZI
 xyfoP2+Apk14eu85zmXtjIIr3OSkdqtRpatmXGX75Wn9iuR/UI1We3FnK8tTS51boHjruxs94OM
 YimNcl6q8o+xw5Y/vbUqLv5HZRRl8rG0FXPpE1vujcuW/eL2sHPNxXMvxhqGGcv+08arFHDl9Fi
 enKjaOXsuArKdRkUK9wB59EFxKRKhkaC6G2c9B3yz0pppGsJAcxSHmx5kpatXekr8xcfSPQv/Rp
 nOE1oA29xr27XV68cb7o+Whh/4XmNufUM3n8Wp6uympepL4bfuq9l0Nk7woP7MLlgtegmC9HlPc
 CVL/eGOdPukWMIzEInRCSn7lqYTZ4op2YZUtxsFBE1w8lC9ByYufMkvni19TPmhMiQFtDIUeDFU
 cLNweqj49lEMGHw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the reporting of the MPTCP sockets being used, introduced
by commit c558246ee73e ("mptcp: add statistics for mptcp socket in use").

Similar to the parent commit, it looks like there is no good pre-check
to do here, i.e. dedicated function available in kallsyms. Instead, we
try to get info and if nothing is returned, the test is marked as
skipped.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: e04a30f78809 ("selftest: mptcp: add test for mptcp socket in use")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4a6165389b74..fa9e09ad97d9 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -173,7 +173,7 @@ chk_msk_inuse()
 		sleep 0.1
 	done
 
-	__chk_nr get_msk_inuse $expected "$msg"
+	__chk_nr get_msk_inuse $expected "$msg" 0
 }
 
 # $1: ns, $2: port

-- 
2.40.1

