Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19AA302163
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656874; cv=none; b=FCEcyeRKyei+sQT8glzkTXobxInG+u4Ger1+EsxPF5ck7iqkM39aTIKrT2V6dsh9qm8MUdZ5bzj99ZzKAqJvxuHBNyTcppfhOymxLD5up6umkuaj/Swsoc8VPhw/VhMP9Ucyv/KyO+BSqnl6BdokU0s7DjrEWcJ8iIhks1jG9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656874; c=relaxed/simple;
	bh=jYzPrGeM09MXeyUxBMHNpofT2o9kRhGrXCTcHCD34jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJkr8Q/5LERezeefEP1iUs0TscVtpDRtvuxNukzzIV3OO2RdmfIcN1o4h6+h55Cf9O9QRTV1kV9rRffDZkHU8CI3JkZ+sUWQex5ioEvKlpQVRqL/7SMUsPQWhE05OUCETwqFQ7vJ3EU7mT6rFioHwPbPS5LWkexvx+eRSN/dovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+jz2jia; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+jz2jia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22805C2BCB4;
	Fri,  1 May 2026 17:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777656873;
	bh=jYzPrGeM09MXeyUxBMHNpofT2o9kRhGrXCTcHCD34jk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a+jz2jiaGaIrulKe4RDO4rBV0aOMan/i5xTkENbpALpYe0DWlvomF2N52ooLM8O6d
	 IK4WSMGTH/60t2DIl3TbLoEtJPU4p+j6fZvJjivwgGql60MGJvV6OF/uoFEy8wjTS1
	 PlJ8osUG+xkeH16zBTPaHvDej0wzCVqRmQ1rCKLEq6fuR3qxwcEk0gB1aHOjvYEjr3
	 /26J/gwKP+3KrgY3yitdmvq2KwP6sYpmcNbeJgYXg5pZtYrsO8Lr7YbU/lSLRdPjJY
	 Sbd0P8X7NCEMiow7OKRdgUgOeiTQRPpEbMY9qzVaEL45sYU5A1eorF4ECsGQYYRxox
	 UjGdWLW70IBtQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 May 2026 19:34:22 +0200
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: pcap: drop most of the
 payload
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-mptcp-sft-pcap-prefix-v1-3-27affca69415@kernel.org>
References: <20260501-mptcp-sft-pcap-prefix-v1-0-27affca69415@kernel.org>
In-Reply-To: <20260501-mptcp-sft-pcap-prefix-v1-0-27affca69415@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2713; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jYzPrGeM09MXeyUxBMHNpofT2o9kRhGrXCTcHCD34jk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK/PFF7WxahK+5Tt3P9utelZ6yEi7Zd5mUTsWgxlj2q6
 PrssEZCRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETM1jEyLHvTcu3vhcMHdG5k
 7/v27uoTUdFdt2K1zrFFb5N6tm7NpHSGX0zv94cvnS/CsJeVTYD/YMkllxMKOz+z72VUKT944vy
 ZKwwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Limit the size of each captured packet to 108B (IPv4 only) or 128B (a
mix of v4 and v6): this should drop most of the payload that is
generally not needed when debugging an issue.

8 bytes are left in this payload, to be able to inspect the beginning,
just in case.

Please also note that generally, this payload is usually mostly filled
with 0, except at the end. This reduces the .pcap sizes, and reduce IO
usage, which helps debugging issues.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 091edee9a7bf..321cef29e288 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -373,7 +373,7 @@ do_transfer()
 		fi
 
 		local capfile="${capprefix}-${connector_ns:0:3}-${listener_ns:0:3}-${cl_proto}-${srv_proto}-${connect_addr}-${port}"
-		local capopt="-i any -s 65535 -B 32768 ${capuser}"
+		local capopt="-i any -s 128 -B 32768 ${capuser}"
 
 		ip netns exec ${listener_ns} tcpdump ${capopt} \
 			-w "${capfile}-listener.pcap" >> "${capout}" 2>&1 &
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c6bb345d056b..85d24f8929db 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -967,7 +967,7 @@ cond_start_capture()
 		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "$ns")
 
 		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
-		ip netns exec "$ns" tcpdump -i any -s 65535 -B 32768 $capuser -w "$capfile" > "$capout" 2>&1 &
+		ip netns exec "$ns" tcpdump -i any -s 128 -B 32768 $capuser -w "$capfile" > "$capout" 2>&1 &
 		cappid=$!
 
 		sleep 1
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 2d26d09009f1..3c0b28878619 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -149,7 +149,7 @@ do_transfer()
 		fi
 
 		local capfile="${capprefix}-${port}"
-		local capopt="-i any -s 65535 -B 32768 ${capuser}"
+		local capopt="-i any -s 108 -B 32768 ${capuser}"
 
 		ip netns exec ${ns3}  tcpdump ${capopt} -w "${capfile}-listener.pcap"  >> "${capout}" 2>&1 &
 		local cappid_listener=$!

-- 
2.53.0

