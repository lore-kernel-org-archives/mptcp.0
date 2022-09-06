Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556FA29A5
	for <mptcp@lists.linux.dev>; Tue,  6 Sep 2022 20:56:39 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id c11so13026320wrp.11
        for <mptcp@lists.linux.dev>; Tue, 06 Sep 2022 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uWCP10+KdM1mM0Umgl1CW1tpnCShY3VRv2KhK/s50Pc=;
        b=hA0aVCFd6I916GvNfIBOiPT70SlSP/gKustpzyybixkWURvyjrKTmq6eVMPCH14/fc
         H0bbFN1BzpqTyiFaiU6KRqcAEDSiUuBDEUIq6q4hRuYD8SgrlH5pfhn5TIUOO3h3u0kQ
         0N8vEq5S3qpKVzCwXaBJpLgjsPineUBdGmDRjTOmtS/D9rW0VTf5JR/6GeN0UyA9XT+R
         SqNG70Nvxe9rSZw+BFmszsL/1XhVh5OvkmbGBY/sBk0okhFoVxY1fy0RYqdsdl3lTVot
         JRpRfM/CdLZtyoFcJUKWx2Rgqch1n5Z60hSkS3YN8l3Bh93KxIpuDGnzi/TF/VL5uUj/
         mmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uWCP10+KdM1mM0Umgl1CW1tpnCShY3VRv2KhK/s50Pc=;
        b=kQRvnjOK+tJ7VXaKXXt/wlpggO6rgtlCpJzG0Bn2eMCyFNNeenpTwWsi/5BWEYTUJ5
         P5fkhb9w6bqDTsvwDT6Qz184lfRBExzvk44I/Bm7685wCv9ywCV79cY3RtrjPn3KuzrO
         T0A7cDGY29W32TlfX/4CXZICgcE4DG2iHhRIqAE5AtsOlsij7E5Cbd01GVpTOisG69sZ
         l4Ek/JpJ4javh3YcusHjDAnlKZqhgUEH41M3GKvarwGCvTHvmeRPOtlFe0TRukjVTtnt
         YKCRnu0FQ9wPK518c0j7lKYZf9GsjxGtOxWfNkZN8eMABTGaHY68xey2z640Dr7dD8oD
         MwOw==
X-Gm-Message-State: ACgBeo31Um/L5nUVNI6GzFSNfRI4Rt12nF5iingj3Ltex4aQHwZFBvCU
	UmQ7PNdVY8Z0Vl+GhzLaQPCAEQ==
X-Google-Smtp-Source: AA6agR6Lfe6OBXP3Eps5pfPITiEd+qNhxZ6EK0SqcI3KEQv6VlAWlrpqoXbHVugNSGgqRY4080WywQ==
X-Received: by 2002:a5d:5312:0:b0:228:cc9e:b70f with SMTP id e18-20020a5d5312000000b00228cc9eb70fmr163892wrv.11.1662497797565;
        Tue, 06 Sep 2022 13:56:37 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id n24-20020a1c7218000000b003a317ee3036sm15735887wmc.2.2022.09.06.13.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:56:35 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <geliang.tang@suse.com>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] selftests: mptcp: move prefix tests of addr_nr_ns2 together
Date: Tue,  6 Sep 2022 22:55:40 +0200
Message-Id: <20220906205545.1623193-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220906205545.1623193-1-matthieu.baerts@tessares.net>
References: <20220906205545.1623193-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=yUhUy0ygZaIKGg/DCAYpwAsfqZXiS1Iioh7QiRlCzI8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjF7O5XYAZvCDzDsZTKMXAqDaby25FIJ6aR+JYa7Jc
 Ihvfp4WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCYxezuQAKCRD2t4JPQmmgc4fYD/
 9tVps4gMGcGcuZq6GiLT1IUNS3czrpayKljF1dvYaofmEc8O45T+Ovey42AGosrXSta3l/hghtQue/
 3c56h0DdEJAX9wtcAqbiZF9vuLSst2af0aKAZO/0nxMq9y6D6eNTl0vbT3VG04Pm2W45+wo0S2dr3+
 B2O6qpteWsu0lca2BF2SrVVUMXGcLvvaVEWxxnTDFbjnuNXqZCoBVfcQeeycR80BlFW1b7n4Jba4FN
 35qaba07wM1L1zAKRPitFr/6/FNyF/4AoK7vvFsGIMwOl9MnKrVtnwvX2WyrWgD7eu7bjyXmsGwVbJ
 zWE3keai1HrMpJOBSnJe6MzAZOO+R8r9Tz+93kdPlJkNnumGcKfdnpUY358rsWn9UBeTZ7I2SWBLXS
 +7kmlA0NNmzLjWSaB1bGEay88It/5LO0dPAsXApReACPNjgPs7RnhfLWzAz/9LlrgUlszBFhGpFr8X
 8vhePUDTbYfBhB41MSB41oBumCpG0WezKZMcOx2zSA2TKyDChwEfkNj3UbKTVpu8DfKtug9/3hyqho
 bYHnByPY+gbawDib80omMF+8CineZtAsSE7IBQ2ZKjz1H6EUTkaG4Z03gnD3qwrQSxK9j2S0FlCD2m
 wSh/CesmSQ1xh9Pq2xhmAwGtH04Cp+VUJGpoJZTc1K3iYQ7B74eRJcWGRuBA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Move the fullmesh prefix test of addr_nr_ns2 together with its other
prefix tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ff83ef426df5..2957fe414639 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -706,6 +706,7 @@ do_transfer()
 		addr_nr_ns1=${addr_nr_ns1:10}
 	fi
 
+	local flags="subflow"
 	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
 		# disconnect
 		extra_args="$extra_args -I ${addr_nr_ns2:10}"
@@ -713,6 +714,9 @@ do_transfer()
 	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
 		userspace_pm=1
 		addr_nr_ns2=${addr_nr_ns2:10}
+	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		flags="${flags},fullmesh"
+		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
 	if [ $userspace_pm -eq 1 ]; then
@@ -832,12 +836,6 @@ do_transfer()
 		fi
 	fi
 
-	local flags="subflow"
-	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
-		flags="${flags},fullmesh"
-		addr_nr_ns2=${addr_nr_ns2:9}
-	fi
-
 	# if newly added endpoints must be deleted, give the background msk
 	# some time to created them
 	[ $addr_nr_ns1 -gt 0 ] && [ $addr_nr_ns2 -lt 0 ] && sleep 1
-- 
2.37.2

