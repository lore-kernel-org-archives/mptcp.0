Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD6BA53
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754765; cv=none; b=R7UTmgQKOPc95YOQ4GC2afEInyuP2in7woC5I3Uovnid/hI195WlSM1F9OVhMiR7viH7BJ917CHHF8TKtO+UnFxTqTiop3jwU/hmFEtBeOd2dC+/lgJ8e0+sR+7jdy1cvf+xJTHCYqSX87YOMB0Jpp+23igZff0orLyshmdqQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754765; c=relaxed/simple;
	bh=PiTzOMgVE1dFUlDrqVvyhkaMMO3fp8l4gkC9UWV1y1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfkNmv+pqwxqNbTE8xf4xJfd9d8ZokR4xJUChsW+nkvOn6gtee22IWws2fzvIjpqE2t0LgALPC26/ARhWvI7tl9J6CEYf1YH2s0LWtDgz9rFjsDQcoW3VtFj2GxIUAd+7hGuTME4yuwxNt2e5oc8LRmIDK5rdwpWOw7N6Wqm/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giNjweZt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giNjweZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB764C4DE0B;
	Thu, 15 Aug 2024 20:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754765;
	bh=PiTzOMgVE1dFUlDrqVvyhkaMMO3fp8l4gkC9UWV1y1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=giNjweZtcU/37QVwIFdbaOL3AZjTw7PK0ySjDsfG3YLAP089hbdKAJk4Gdh+n2RGm
	 0mhuHMLfk95wnfdj1xSCCav/LRnxNTIMD4k/QQepYx3Q9lkLV3j4qGOmZdwld+vDEA
	 e2fHwlySbAKh2AfcgHiXrE53ydtGc2n2k5JaOWdn45XlyRPrljmcPq9ly6Y5XUsiOb
	 pBXUWJRuPwmbSj1PaA8cr2kJlpMR7mLcrYN5ZRXj4IjaVYVr0B8x5YWVQxpau2kIdX
	 3awmwnsMfW2nU8ptxTnObse4dn2bfsJ/bSCeQTTjklVEhqhpxGicZvP28jwZPt5foK
	 DJ7Y9kr0XL2eg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Aug 2024 22:45:43 +0200
Subject: [PATCH mptcp-net 02/10] Squash to "selftests: mptcp: join: check
 removing ID 0 endpoint"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-mptcp-dup-close-evt-v1-2-5a551d3a66cc@kernel.org>
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2822; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PiTzOMgVE1dFUlDrqVvyhkaMMO3fp8l4gkC9UWV1y1A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvmkJvjhIhcq022l/HVmMyl2YWVyWtBUqKduzL
 sCPlThDphqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr5pCQAKCRD2t4JPQmmg
 c4MpD/46NwwErrPE8c3YZ3GUzKD1lF9FtRxUilOMn7yfMupFRZF3lHpIC2ZV+VwfYqqP0PFxRc+
 PzEwA0Otqm4GKMGySKnn9y41ifUmBTFtOwJRX8+w/DVX1oLswFXQnjbSLbJjrw774UXWntJQlXY
 hs3mnkFgKW5/E/0ZtNDjDeqpUV9QaE6pqFPPoDmZDS1kYcMuzGH4STdMjuw/fT/nEsYx5gnz/AT
 CUUyVg9bZ7J4nhKh3JsTjThNibysQU+cSIkz9TWtPq09iFm946pTN3DaWQAyg/v8L708VlKOoD0
 KNuDuyZIan+ulNNT3HGLhxhmpgMGZh/o6fzvU0bJoWAP/GJVVVxI/sK97IcpoNONI9Wn0DkPcXI
 VUVvFGgLW4aMpmo96AqXTH5PNoLaEb96Sfk23/stfREhAsXg8p7WnMOfkNO41AnIIFApU1+3xTx
 2l3+qQVzhVgdhdS1Ks8oXIGQ3r6SQMgqZ/7DyDiRRIc1JSak1Ad0nRC4nFbQtUsAqjLAVXSKLJc
 zUJOmsXMoiAyY9Zhdtek9EmnkSuBo2cGgjf8FH1sk5gTypX/vRUDSJxzt8ryBp4q/hkqKU0M0V7
 9+WgPPq1M/YyiPrZcoo/PuiYUKrb2TUQ9Zidz8U1/7rB/VhZSL6gaKqw1Tcab7ZxbyxDeySQSe5
 VK8OVKrCu/Y+JmQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The original commit was replacing the recreation of an endpoint used by
an additional subflow, by the one used by the initial subflow. Except
that it reduced the code coverage, as shown by the previous patch fixing
a bug no longer visible with the modification of "selftests: mptcp:
join: check removing ID 0 endpoint".

Instead of replacing the endpoint 2 by 1, here an additional del/add is
done on the endpoint used by the initial subflow. So the two cases are
now covered.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 32 ++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 77b3a68bd8f7..0494610694df 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3659,36 +3659,46 @@ endpoint_tests()
 		wait_mpj $ns2
 		pm_nl_check_endpoint "creation" \
 			$ns2 10.0.2.2 id 2 flags subflow dev ns2eth2
-		chk_subflow_nr "before delete" 2
+		chk_subflow_nr "before delete id 2" 2
 		chk_mptcp_info subflows 1 subflows 1
 
-		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
-		chk_subflow_nr "after delete" 1
-		chk_mptcp_info subflows 1 subflows 1
+		chk_subflow_nr "after delete id 2" 1
+		chk_mptcp_info subflows 0 subflows 0
 
-		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 2
-		chk_mptcp_info subflows 2 subflows 2
+		chk_subflow_nr "after re-add id 2" 2
+		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		wait_attempt_fail $ns2
 		chk_subflow_nr "after new reject" 2
-		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info subflows 1 subflows 1
 
 		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
 		pm_nl_del_endpoint $ns2 3 10.0.3.2
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "after no reject" 3
+		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		sleep 0.5
+		chk_subflow_nr "after delete id 0" 2
+		chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
+
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "after re-add id 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 
 		mptcp_lib_kill_wait $tests_pid
 
-		join_syn_tx=4 \
-			chk_join_nr 3 3 3
-		chk_rm_nr 1 1
+		join_syn_tx=5 \
+			chk_join_nr 4 4 4
+		chk_rm_nr 2 2
 	fi
 
 	# remove and re-add

-- 
2.45.2

