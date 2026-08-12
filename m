Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341EB46EC72;
	Wed, 12 Aug 2026 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546596; cv=none; b=e/2J1C1sDSaivHlOXOm7OWZdO7wl33hJwUJe/wc/+cW3cymSCdmc2ueDRGOX9SRvvWsgOViupjKeO6p7IxZ6VfcC4tMVTa4CjHpnpNwhcNfzJGg5e2UaT9GFOB50EwhzZsa363GG5IJSVhMDaiBBcaPmeIkGLNqlKS2TxC/nQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546596; c=relaxed/simple;
	bh=49Ik8By8GbCNa5AsFN3C+453nDSqAI8MYhZCAvXgcjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJ/742dsf6uV1JkLzgiiNey6QlTY9uSXultBc8DMv6JGA6/N7EgYJ6gdmfloJkV/DMVDv082BbA5aclMfQiqVQSvHYC1GXR+0RJq+OUY3KEW5ZyyoOH4HAG5xpQqunEl9d6z00+FNwL49446dpH8nUiIkpk0TOVEA4V4I6wqX9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5K2AcKQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5K2AcKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99A71F00A3E;
	Wed, 12 Aug 2026 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786546579;
	bh=M8D9l0UyVadTJptn2fPji4IoFUm7G2/mRKx7CW8eWrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=i5K2AcKQi3NwCHqc4XslrROTawuTFkou+B32egz2Sy89RVDyZYkqfskExqhtBMjHL
	 OwdZ1SQzg9g4DKVAIR4KHh5vPhzAShFsrhYbbmp9iWAO0YYcl+kGMgfKHWWXsSw5hF
	 hUTIAN/8ZgH17x1wTdqpNPSSchVfeXvbrbpJEMGstZdSMmdZUhF6ozU3sJuSufG5de
	 Lz1Lw3qjSBmn0b/uy9OHG4d7vO5chgSZ+0HsEGv1dAH9V6SccnUjLB1KveefYeYs4U
	 kKea7HUS2oPGR+kOoIk996UiwMN3nNVImIbkxBmdXbEqzC+f6Gapx5TtYBTjZLIw9b
	 njXPi5Afs7ZYQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Aug 2026 16:55:44 +0200
Subject: [PATCH net-next 09/11] selftests: mptcp: pcap: drop most of the
 payload
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-net-next-mptcp-misc-feat-7-3-v1-9-1905a818f6cb@kernel.org>
References: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
In-Reply-To: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2841; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=49Ik8By8GbCNa5AsFN3C+453nDSqAI8MYhZCAvXgcjY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJqOiuUHO91hjLYM27UWh7z9lkxzyKP5oSGSmfd6MYC8
 Ue18j4dpSwMYlwMsmKKLNJtkfkzn1fxlnj5WcDMYWUCGcLAxSkAE/G3Yfhnu/7Pl89rPc9eOjHr
 r5JWwsl9M/mnvDFjyecWD00R7llby8gw2/BX5MI9thJcvs8DZ3W5SqrPWrUuI4W1amnRAd39dnc
 YAQ==
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

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5befd8584a4d..7a2a851fa0ad 100755
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
index 9b9fb3de9da3..18ce7136a2b0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -979,7 +979,7 @@ cond_start_capture()
 		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "$ns")
 
 		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
-		ip netns exec "$ns" tcpdump -i any -s 65535 -B 32768 $capuser -w "$capfile" > "$capout" 2>&1 &
+		ip netns exec "$ns" tcpdump -i any -s 128 -B 32768 $capuser -w "$capfile" > "$capout" 2>&1 &
 		cappid=$!
 
 		sleep 1
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index d723261bdc62..3ea3d1efe32e 100755
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

