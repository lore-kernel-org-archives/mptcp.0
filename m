Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC9C33E2
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 16:39:07 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-30c55d2b9f3so655523f8f.2
        for <mptcp@lists.linux.dev>; Thu, 08 Jun 2023 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686242346; x=1688834346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25ZaF3JsFYErEFoIbwPYOVDqmdE5+qzB+30gx62T0y8=;
        b=bLE4kzr1bCQ0rzhbxY0Bt2OGLWYWKUZUwOYk/Uv3yrqZC4kbVx5rg5DiQzYVWyZa+R
         FaZQ+3Ucbvs9Q0kYkMlU6FkvzDbO9YKspfiklSDL8M/PjPOtuK4VmxEMue8L5L4sNjwK
         Elfr4IyYglh1HPIsBF/Jo76xv6l0n6yddU7X1jLX83bevK1ZGiERRZK1v9Tb27hbH0RJ
         Jei0rFxsjerhn+sFbdi6juWAKH9iQTNQ/FTCBq3RDDe9A/2lRyL3hp+ILbQAQ5yyUQ1a
         YJjCWU888tmCtXnPr6UdXbQGkhdeKubc4ZTxnKqeLDqE33HltjLTZpa1jfJlTrtm7OVR
         TVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242346; x=1688834346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25ZaF3JsFYErEFoIbwPYOVDqmdE5+qzB+30gx62T0y8=;
        b=M6K98S0eRzugi3hUV4vo/ScfZOgT0p3Ah/AnJgSKvuO5p8/aSOkYq1YUXBfYhcyZpM
         o65N0X+owILyJxrFtjgxepusNTi1vyJPASnWmHcnDZhYUSSBbLOLNBoYNbuuNL++XSQ5
         U7UHMqxer8q4zfqij4m9AKQyb4KMp/H9YJosgmvz0TP5CLNTAItV6nRlnLZfRUJAfqWU
         B/5B/L77WadEl0VS4uMtGPM6knWaqlKhTZaJuS4MHZ2RBJBeyWbIYr937Xxa+ijxyqsz
         CZeC9+L1ZLMdIghT/Hyvd3eWfTKVzFIClE4BNXifdzg9wBnn2RVli3zk1LgC76DNrJdH
         uSdA==
X-Gm-Message-State: AC+VfDyyQGd++AgFroTGM1LDgpnIYhOBxXVpBejuYkBUdmBn00AnB4ib
	eMAut4TITvZxeHf4d4kZUZtR+A==
X-Google-Smtp-Source: ACHHUZ65wUtjJyqPFNvZuE1f6WBvIeZZIadiu1Pgy4n7Ffa7OL1OMBN55r1OPGcfegL0pNfZ2vA9Ww==
X-Received: by 2002:a5d:5915:0:b0:30e:438f:8ceb with SMTP id v21-20020a5d5915000000b0030e438f8cebmr7199002wrd.59.1686242346219;
        Thu, 08 Jun 2023 09:39:06 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm2038215wro.98.2023.06.08.09.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:39:05 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 08 Jun 2023 18:38:53 +0200
Subject: [PATCH net 11/14] selftests: mptcp: sockopt: skip TCP_INQ checks
 if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-11-20997a6fd841@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=1OsCicu/3vbKAvtKytrt0z0ywt61KRKpMc3STXoQXA8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkggQawz6TxWhaJHOCzsoj7Dunv2uUMLzRPPKj2
 W1VAUZNjaiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIIEGgAKCRD2t4JPQmmg
 c+JJD/4nMV96ft2RW4sWQl2h5V60vSuGvtu8Fj57RT4rjI8alspOTImfQDSHV2VT0jvyK73a2NN
 JcBwh0n2KlCAcqU3yRL5Yxe36fHk2ZMJMUi4WUnc1KhOauu9GbtXDgKqgLjk50w69a2msxXrB1/
 BzP0Ih1mfkVrKPnsUwbORN+wUjE5jqy+9rP78316DlCkrihfSV9o5yXiwOJJ6qfSbqSKCSt2vMR
 vdwYxKtLLh137dUTEzaIymzu8z6ZeFw8FXUmGwXXuHHqy7tmr04vFFtP5+Pe0dwZr/1eCP4sOKy
 +bBIkjQAaz0hzN09loIChJYeJIziWtfxC8KDkpIWl/Voqdfnye2MfE7q4PLN16+Xro81sf8WhQJ
 rzq0VzRkLDWcXAeiUAgLUw0DfCZsJy33gLTuAMfLqDLW9waL/rbJLF46zo2GBmRTBDPHexcgwHj
 ht4DgOE/Mgl5XUWbcH36p2TPiR8jK8JIt7Q8+OVNlU9HUTnB1KwzF59WViYddFICF4NxK3+5s99
 I3psrh50vH4op27pQiGJkm0wibIQAqED5A8ezAJJ8XAyG3Kplv8RTlQKz4bURFrv0QEWEBKVprp
 y4qGrl3N5S/nGIe9cptNKHf0m+gS8irTTywG5VbZkeronyhJu2GKkAKYH9Ty8YAwO66aIYObQkN
 /bhqNwA09G2k+EA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is TCP_INQ cmsg support introduced in commit 2c9e77659a0c
("mptcp: add TCP_INQ cmsg support").

It is possible to look for "mptcp_ioctl" in kallsyms because it was
needed to introduce the mentioned feature. We can skip these tests and
not set TCPINQ option if the feature is not supported.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 5cbd886ce2a9 ("selftests: mptcp: add TCP_INQ support")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 1d4ae8792227..f295a371ff14 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -187,9 +187,14 @@ do_transfer()
 		local_addr="0.0.0.0"
 	fi
 
+	cmsg="TIMESTAMPNS"
+	if mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		cmsg+=",TCPINQ"
+	fi
+
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
-			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
 				${local_addr} < "$sin" > "$sout" &
 	local spid=$!
 
@@ -197,7 +202,7 @@ do_transfer()
 
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
-			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c "${cmsg}" \
 				$connect_addr < "$cin" > "$cout" &
 
 	local cpid=$!
@@ -313,6 +318,11 @@ do_tcpinq_tests()
 {
 	local lret=0
 
+	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		echo "INFO: TCP_INQ not supported: SKIP"
+		return
+	fi
+
 	local args
 	for args in "-t tcp" "-r tcp"; do
 		do_tcpinq_test $args

-- 
2.40.1

