Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753419;
	b=qmziwP830XS265IFQjI4+7NGfOTXXzOSlxN6s7Oadd0vlYL5T9V+ujNrYFieuzZZwVsQ
	 qUV6qkWEUdKxbku6DutdeTaKaSDIX/fSu6DhNAUMYQyARHhuZ3gucxsv+2pHq+Sbx+3aJ
	 ko8IpqPHwR64QQYERiTCW3i+TXjh0IIQ92y9GfFY31dOYljTJverHJulYde08t6lj0aNW
	 qLuSmYs0WgDTzk349YoqWbAVx2JYuXaOW6Hp/Ezz2EIAJL1sjGm6Ga204ufnX+0aj/9DW
	 FmOKGeZR6QG/oiREsyHK1ectyFGvgLg85edQyyUoyKc1XuVKVdXXkBYgiMSYNNxJ/3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D8WSvsqYPXwHzuflPXXQhy6iU9YbbeyU05E1t9Ks6co=;
	b=T6lAb5A9Q22SvFTjY2F42GSQwuwFcWD+Ef4dKsPQO2rNw+Uihuls6TlM6fTXYBKQJK1R
	 eKw43penKlSlxX72lEQU0g7/pmbNKHELxBSGQm0UiG/KlI0xKmvoWvyrGTpuELXhxo4FX
	 zaeVBEYf6366Gq9lK6iCK8Q7gWJWhsADIvyQjqSx4YN8PGv7G7pD0HSE7wkbVySYjIB3H
	 EIZOzuIFb9BU4rGFNm/ZBwxPO9rE05pyJLpOnmhtzioaTvp2g6F72g49GAdVhLY8gfDyb
	 J14Wy7XGCwWvRr7QDjJ6fVr8sXp/q2bhmY5tSVvL+2OQGVHE6R4lQmvumn1Ul9o23Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m0zdv92b;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE1606A31D
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 11:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADCE1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m0zdv92b
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3514b90bb89so1711607eec.1
        for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 04:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792753418; x=1793358218; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D8WSvsqYPXwHzuflPXXQhy6iU9YbbeyU05E1t9Ks6co=;
        b=m0zdv92bLYwiqOuj6Bt16IwSpVKejACNHHwuon5pxR8tfenih9rumkR3Yx3tSzpf8J
         8ThkXZN+CENeiMD1IJxqFsvB4BGjJ7NCyzgI6aMgyODT6Nb0G+fHbGcLt3VljDC46lvY
         ALHwdneroqF7blWLEavsOhsYKuqc35qtUcddvqK8GnrhV0naQ9BX7+OtFlwkVEQn0AfO
         vqVqa2o04gWq+3dRjlvf2dghIZje5NXoOGcL/2lpSGZeLhfFFeYRwNlIpj6yPWNEONXT
         TgMjvGJFIVit5khS3ICLX9KqR8y5NSPk1rl47Itt7lOYtCZrLRsxrZxcDnnNd/hLMkoI
         wCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792753418; x=1793358218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D8WSvsqYPXwHzuflPXXQhy6iU9YbbeyU05E1t9Ks6co=;
        b=UdYEiV7lr0hlF+qCCTxAhfswgnuanPtHXYjIpeYC1RAKSEAdXbeojAWKB7fahD3qNj
         4eGOnL8Rvh7OJGwJ4zoKxVbk6v92a1ipLN19HXL3N8cuKnazoPtty+3e8rip5y16enm7
         8De1u8xhPD/YqIAI5mDOgXoTQVE/b1S8ka8rFAGQw0nuWDMXr2CWBg+G8/KFlaUA+t2j
         YbtqX9gUF75aZF9FKR6+kzHCS3HDfNWP7zY57R8MAa/aF8I8OpR6JokGsbf3xWG3OQIe
         /iHBFMT1jGj9cDwwbOZxcDGxHOVyJFWyD3YtjOTdi6x83vY8A/wh0gzqwT3cOqp1qZgS
         F8Bw==
X-Gm-Message-State: AFq9FYKaKDMoLxqv2hdmddmduEBRFrZRdbNI8l9eUbO7XldDq8tebU2x
	0TPpqKA9wsd5lJS934SmUZ4t+dHpOh1E7DTA/bNFIQWAIRbBznF2IBwNzb+npA==
X-Gm-Gg: AYBFou2xuqBUPs2zGx6dNA7miWN5sioNKjU1HuiyngIxLEixpNSfgNPNPzPHYR3URZE
	JRUxZbKbcZRty5t5bKbsXCwhHLE/kpmlBhgaz1FS8CXRl1JHiI2PoGsG2uCquxnQHNXnIODj39h
	VxGsyQKckzSRFH4WkKQTwUBVAbyFO4ShI3xJycSUB9bZdHokDaAMhDIjuZaXp8EuK79uXYNapKw
	1J4k0yfXWXWT7fHqgyhUtzb92+YdglVQuXY28TWn05lMtHVC3dD9ksBWAbrG1Kf2owVm/GwdSiE
	9jBDnginBxtZu1WzX77dWCVt/SvBbDBAgbUVYWY6XwqF0APWxAywbP9h/MBqQ/tcDyc/I/ZW9yp
	wWPZPYOFwyDbh0bxDxZCZ7+h5l6HLN3bFYw7Xd92GaFTT2TcHvZf9xYN7wXPRKXrpx7+GwrxPNz
	8sInvGL0utghhSW3hw2pNw5Y+oNxF6CKjbB61fpVVdpD++LGLhKxFEuOC5PWX6ZuGdOqOUm23b8
	Nmqc98+K/aztbcNhbDZAQB1ZS1XkuRRhZyCxxkwzEyahVuHyMV5hM0uZ7li
X-Received: by 2002:a05:7301:c011:b0:353:5908:36fc with SMTP id 5a478bee46e88-369d980d5a6mr2342769eec.17.1792753417585;
        Fri, 23 Oct 2026 04:03:37 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9defcdcsm12695186eec.23.2026.10.23.04.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:03:37 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	Abdul Wasey <w453y.me@gmail.com>
Subject: [PATCH mptcp-net v7 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Fri, 23 Oct 2026 11:03:21 +0000
Message-ID: <20261023110321.403874-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023110321.403874-1-w453y.me@gmail.com>
References: <20261023110321.403874-1-w453y.me@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "delete and re-add" test validates the removal and the re-addition
of the endpoint used by the initial subflow, but without the fullmesh
flag.

Do the same with the fullmesh flag: with a second subflow, after a reset
of the initial subflow, and with the initial subflow only, then re-adding
its endpoint or adding another one. Without the previous patch, no new
subflow is created, except when adding another endpoint.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18ce7136a..4cb3a546b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4445,6 +4445,135 @@ endpoint_tests()
 		chk_rm_nr 4 4
 	fi
 
+	# remove and re-add the endpoint of the initial subflow, with fullmesh
+	if reset_with_events "delete and re-add, fullmesh" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullmesh
+		{ timeout_test=120 test_linkfail=128 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		wait_mpj 1
+		chk_subflow_nr "before delete id 0" 2
+
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		sleep 0.5
+		chk_subflow_nr "after delete id 0" 1
+
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		wait_mpj 2
+		chk_subflow_nr "after re-add id 0" 2
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 2 2 2
+		chk_rm_nr 1 1
+	fi
+
+	# same, but the initial subflow is reset before removing its endpoint
+	if reset_with_events "delete and re-add, fullmesh, after reset" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullmesh
+		{ timeout_test=120 test_linkfail=128 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		wait_mpj 1
+		chk_subflow_nr "before reset" 2
+
+		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
+		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset; then
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			ip netns exec "${ns1}" ${iptables} -F INPUT
+			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
+
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+			wait_mpj 2
+			chk_mptcp_info subflows 2 subflows 2
+			chk_join_nr 2 2 2
+		else
+			mark_as_skipped "unable to set the filter rules"
+		fi
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+	fi
+
+	# only the initial subflow: once its endpoint is removed, no live subflow
+	# is left to take the remote address from
+	if reset_with_events "delete and re-add, fullmesh, single subflow" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		{ timeout_test=120 test_linkfail=128 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		# the PM worker accounts the initial subflow endpoint after the
+		# ESTABLISHED event, in the same run where it creates the subflows:
+		# a join on another endpoint shows it is done, then remove it
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 dev ns2eth3 flags subflow
+		wait_mpj 1
+		pm_nl_del_endpoint $ns2 3 10.0.3.2
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		sleep 0.5
+		chk_subflow_nr "after delete" 0
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		wait_mpj 2
+		chk_mptcp_info subflows 1 subflows 1
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 2 2 2
+	fi
+
+	# same, but another endpoint is added after the removal
+	if reset_with_events "delete and add another, fullmesh, single subflow" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		{ timeout_test=120 test_linkfail=128 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		# the PM worker accounts the initial subflow endpoint after the
+		# ESTABLISHED event, in the same run where it creates the subflows:
+		# a join on another endpoint shows it is done, then remove it
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 dev ns2eth3 flags subflow
+		wait_mpj 1
+		pm_nl_del_endpoint $ns2 3 10.0.3.2
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		sleep 0.5
+		chk_subflow_nr "after delete" 0
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullmesh
+		wait_mpj 2
+		chk_mptcp_info subflows 1 subflows 1
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 2 2 2
+	fi
+
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-- 
2.43.0

