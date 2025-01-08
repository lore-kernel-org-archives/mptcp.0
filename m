Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B8A201262
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361651; cv=none; b=uXaDwaNK3Z+TL0fpu/+rOfXfYVprHstO7zCvR1fkmWb+REPx5b5TPP5HKv32v07X6XFmn7J40sPyKB1B/32tM+VJVcYDLo13d/KImh/6Vcfqbqmxt6FEYSiU1GuzcyoG4vK9jWlvXk0T+ip8Wl6qvsezFFlOv3QP9ci5CS6KIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361651; c=relaxed/simple;
	bh=b3PI71NHstCMhsZXMoP+IwTs9UVTtOoekjnzXfP9sQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c9cBBx9h2lO73Y42yZyYuPkaR1RruGmDVxCTrrT/CX3G9ERo3JMEzh32lCqRjedrfy4tvQhRAP9xIztHwvRX1Q8I3IfAUP6P50zrblwfDZxAP4eQzmX6sycE5lPELBZmvin45t77XET0eDHQ9vGfvl6U9IGYbzL2BRk5fEXWpPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX+Svqo/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX+Svqo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91E8C4CEDF;
	Wed,  8 Jan 2025 18:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736361650;
	bh=b3PI71NHstCMhsZXMoP+IwTs9UVTtOoekjnzXfP9sQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BX+Svqo/sL59QbqXVLh5ou8p3HyiTEoEN8LhXy58P1R1l8N575eX4GdiqmzLAR763
	 biRQPS32XqkAscyua4rhTMOgguGNV3rkgTI+B772iiSBZq+aZr7G6/XZ0ZPk1g3D9x
	 Yu5G10FwskTN6qbj2oyEHx5ySz+HdKRmzLEfnZ2zKq2pTf1m7R5zHnpDiUUXJabzjS
	 809YrnoEL/ey3seGR7cO4Gy4DOa/OaWjWJ8U3G0Xlt2lKCoiWBnjiKh7G6Mk6zSlS1
	 ZoELcYsDATU/u938TSPVbyqPu8kjm0Z36Zx2MzbPLoXn8AQ50uw0AXm6DjrtNVBdxU
	 mBxh+K3ub/P3A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 19:40:37 +0100
Subject: [PATCH mptcp-next 1/5] selftests: mptcp: simult_flows: unify
 errors msgs
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-slft-mptcp-conn-misc-impr-v1-1-bdfbdba48a1f@kernel.org>
References: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
In-Reply-To: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2627; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=b3PI71NHstCMhsZXMoP+IwTs9UVTtOoekjnzXfP9sQk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfsawOZzVDzL++OVvJ4jXqgOhMECTeGAL0epwE
 Ewfu60LjzuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ37GsAAKCRD2t4JPQmmg
 cw7qEADpRWgixFKXShqt4WQvxN2wRXm3Ctf9k+RJzuSUjWtrAM9qXZCoRZOG1hI7TogashbxoQn
 KeSwlJaMjyBRfIySopfxVV4KtnoYlhTaAujlmwRKePYBSt7a05qNLqsGt6CpKvxE4isen+tO2cF
 N9rerrUFmv3i7bttQAhtJnaBwX9UiTONr7e0a48FW5vlgRfug2dJ+aceulHjXi0NsV5551C6hHq
 B5OGcMqEWrkhS9fVkaHa9s43vnWF1rxpUjsDvmFGunAy+SalLu1hUwMIhXmRGvyu0L17GPmG3MV
 T9vQzNZoJsBtNIt9nUVvtE/TaXTerFpVK3iX14XZ5H4rG/MEM/KziXorkgo+pn8UO3zEkPpazDF
 evuk5iP31aM25rYMorPEGWaw7cPoYKpEY2wVDpDdF9YfmA7iRqh3rVbS6sNUhuSAGVLlR6ZAZ6z
 B1pLLkFZ+mfqgtgMRRLGglybZ33lUA+c4YJyRov0DCmCKQVGg7zFqO2uF8T8ArWl6w6HBpH/TE+
 aM+Ko+WifSHG5XHHwIBh3t7x9Q51d/oj23k5TTsSSZkCf4c+SSIZYLhGszeDCt4WnsDrEc1y9QX
 YawlxqA6zVaApw2N0LPd1QdFcJCmGjU5GLOCsjxDZvfMoCxoBMmxTWFP4UY+JwSnKI5AfreLiDF
 nTo/WnSss4DGgWw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In order to unify what is printed in case of error, similar to what is
done in mptcp_connect.sh and mptcp_join.sh, it is interesting to do the
following modifications in simult_flows.sh:

- Print the rc errors at the end of the line.

- Print the MIB counters.

- Use the same ss options: add -M (MPTCP sockets) and -e (detailed
  socket information).

While at it, also print of the 'max' time only in case of success,
because 'mptcp_connect.c' will already print this info in case of error,
e.g.:

  transfer slower than expected! runtime 11948 ms, expected 11921 ms

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 8fa77c8e9b651171a34c89bfd5c9ded0288a5bde..e98e5907d52c2d0e9c0152efda82176861905cf1 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -155,6 +155,11 @@ do_transfer()
 		sleep 1
 	fi
 
+	NSTAT_HISTORY=/tmp/${ns3}.nstat ip netns exec ${ns3} \
+		nstat -n
+	NSTAT_HISTORY=/tmp/${ns1}.nstat ip netns exec ${ns1} \
+		nstat -n
+
 	timeout ${timeout_test} \
 		ip netns exec ${ns3} \
 			./mptcp_connect -jt ${timeout_poll} -l -p $port -T $max_time \
@@ -180,25 +185,31 @@ do_transfer()
 		kill ${cappid_connector}
 	fi
 
+	NSTAT_HISTORY=/tmp/${ns3}.nstat ip netns exec ${ns3} \
+		nstat | grep Tcp > /tmp/${ns3}.out
+	NSTAT_HISTORY=/tmp/${ns1}.nstat ip netns exec ${ns1} \
+		nstat | grep Tcp > /tmp/${ns1}.out
+
 	cmp $sin $cout > /dev/null 2>&1
 	local cmps=$?
 	cmp $cin $sout > /dev/null 2>&1
 	local cmpc=$?
 
-	printf "%-16s" " max $max_time "
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
 	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
+		printf "%-16s" " max $max_time "
 		mptcp_lib_pr_ok
 		cat "$capout"
 		return 0
 	fi
 
-	mptcp_lib_pr_fail
-	echo "client exit code $retc, server $rets" 1>&2
+	mptcp_lib_pr_fail "client exit code $retc, server $rets"
 	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
-	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
+	ip netns exec ${ns3} ss -Menita 1>&2 -o "sport = :$port"
+	cat /tmp/${ns3}.out
 	echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
-	ip netns exec ${ns1} ss -nita 1>&2 -o "dport = :$port"
+	ip netns exec ${ns1} ss -Menita 1>&2 -o "dport = :$port"
+	cat /tmp/${ns1}.out
 	ls -l $sin $cout
 	ls -l $cin $sout
 

-- 
2.47.1

