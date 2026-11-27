Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795815491;
	b=I+PNyCP0JNsFKH9EuAyrT+47mjwTQdpAipOTBrY5rigkT0WzB0p64UhXC1V4tMkdop7c
	 7TjGhDEuWpc9JPImTyNuJyMwSOXc9HY3MM/XTzk471jbGILO2iHwIGEBB8Y06mTeZX/f8
	 iwZ3uQj1CilOZPVZlkmRJ8aKlYXEiJ0KLW/JmIVQligPsv/13QNWZddcstrVO4Q9zEbP9
	 /2Zt1e3RDOze4DcfxZULUiALnkbqb7Hglel3MtHk4xkiiulD+mlR7VOsGv/3Vkw3v5ZRG
	 f8kbi9iftVsFhKExDKTB7e+B/kRhGT7Pm+cgQSlZNuOxLolmxmbnpdzIwLYlQRyr1SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KEy3cE2hk9xojmlHWE13kqd99is+7EkDwJwCTfWgSu8=;
	b=ILC6Cn/bA0elpXvq2UcEkEu6PwQXGDintPt0Xy44qmeoBj3SqYsMhKRLK/Ckk5qGjhMa
	 /h0T7Tn5Wn8zKeMnzEkZx3PWO6TMJCnX2+iRl8yqBXQfuWxThfNtA3nu4mk167qkyVoH2
	 KsRTa/tRdLWVHl68+z/OUHhMaZNbX8BeKS+NmfsjEZeDohKgWHlMpUHs+tyhF6MnRkTLZ
	 fq/W07+5p4OLBZNP9VhE2qCcn6Xa0FCNH2BwzBIPZsxZ+oIRknE8CdiQLHZZ/Sd1I/Q+L
	 rSFt9zsD3rWkXQpsD7puFBeYBXLL8zQ9KvOvgqIyYn7uHdlCB/rw4lMzTlKSbm1Mi8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DovxFeg6;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7A606A321
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 21:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AB7A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DovxFeg6
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b59dfe466bso887459c88.1
        for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 13:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795815490; x=1796420290; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KEy3cE2hk9xojmlHWE13kqd99is+7EkDwJwCTfWgSu8=;
        b=DovxFeg6NHjep/8S5zDETMY16wgeckERxSZOBaiNbOyRErNn+4OpXRD1KWT2+9teYA
         4scTEEtIqF3Gh//SbdrtgeTd/lZT1nxwiNHfjMResuV9sLU9HPT9X84cUhgq6cqfy7Lu
         vOn7ETpMnmGM3nFSbUtgQwSn5g638NBUwf/2TiQJs3qH2ynlacRFOT6zE3tUKEoigKgl
         jDhAUcJ1zS3+ZawO7DIK1fvXMEdGUJ6P+DU01rL+vVxpddAQXLBcYAsPE57sW5jRvCxu
         1u76dBM5o1v/CfPdNRiqhSHx2KszbCTD7Z6qQslhybmfWOq4kH9iuaSP8S48UoCrpTJ4
         +BNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795815490; x=1796420290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KEy3cE2hk9xojmlHWE13kqd99is+7EkDwJwCTfWgSu8=;
        b=T9pCdKXbd9Fme5fDifSpLie72aUxoI+TggOeTyeIpeoc1br/7nohOYeSoW82+5OaRv
         blyog0ZizI0xIZfPtHb1QD0IcdC/XZwXFWC+ueaE8SGo1Ur6Up7irLAzwr3CB5KGvBGc
         Oz8MDpxJzPNfHrQF7Qg+QZ379hQH1djFn0HxYT6Wk0sPoxSLW8eWZ3OjMKtBoKzoYQzF
         AwM90dUQEqxK6SMcuSMyfYNlOzRt17mBOryUrvr47gje60iPMy//ndWMqj5ppSBuYWzl
         Ny7ezOarE7KFBT8cV4NFr12bRyyf8cyam9/gcFYOqY+/XuUihuRmbSOZaQET1T8E2Ley
         O3nQ==
X-Gm-Message-State: APuU4Z/as7O9HTX4wJ+V8+P5YTr+eXRIaa5W1d8yxasj+6XxNV6OtCLP
	6hO1uDbWyIMn30cNgThfW/vZ7XzMVJVh37nTLKGfYzS0iYXr3waOSflyAK+rmA==
X-Gm-Gg: AZFdTZeUrDMOhLvkf7MFo3z5AORYf4HWwzD7EH70YG1VIx7184Y+34Z1WtKtTaAlp5A
	60E/048GOEij6iUYP9d2UoktB+yR6rP0MSVqpkel+eEV6XeRDrX0xRSVqeWaWdzLeEA7Eyc9MCx
	lOgjS+TzkvEq7jm/vseRMT1W5/eXUXkabCoJTAyUVsh5fH97nBHCwTGxzu1EHzImGW6d+N6bjY/
	INaKLB8VcuNELoZwOBkx4+AZ2tf8eQJCfhxfm6B2GEA+/TxxVzAM8i5i/Pu7829FCn30T3Olbwm
	3BJnCtdbA8cvGg/4MWLBtbZGQLXIDrLhHA2DARr7cQ6ggdSQowCCmh7SIFpa5ftrZ+3SeTt29Fx
	ZMOKqrhbKpTZn5FLmhO5L3ASpQIPjzwMK+Ce9/4heS1c3yAkL9ZzbmhHO9ImPW0m/vXlJZUDkdQ
	PcQjM95mVjAjv1eiLfExqFQ98XfO29y/bsLZofYMYdcfM1BUA5sbjFWNjJOoHYaNW22uQRDFHzt
	F/hfvf+H/orP6pzOra/1YdmSq4OS7pISnuudg1bH8gYH+tILugTghTrFxEuKUDVN8NQ4vUWwt/u
	bC7V5sRopKgXXNWp9KCGhczTA1K/aqYGA2M=
X-Received: by 2002:a05:7022:f509:b0:1b2:41af:c21c with SMTP id a92af1059eb24-1b55694689amr22796843c88.39.1795815490207;
        Fri, 27 Nov 2026 13:38:10 -0800 (PST)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm67825547c88.6.2026.11.27.13.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 13:38:09 -0800 (PST)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	Gang Yan <gang.yan@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v10 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Fri, 27 Nov 2026 21:37:56 +0000
Message-ID: <20261127213756.4154872-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127213756.4154872-1-w453y.me@gmail.com>
References: <20261127213756.4154872-1-w453y.me@gmail.com>
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

Do the same with the fullmesh flag: with a second subflow, then once no
subflow is left, and after a reset of the initial subflow. Without the
previous patch, no new subflow is created.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8c4eb17e5ed7..a9c106819b21 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4433,6 +4433,85 @@ endpoint_tests()
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
+		# no live subflow left to take the remote address from
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		wait_rm_addr $ns1 1
+		pm_nl_del_endpoint $ns2 2 10.0.2.2
+		sleep 0.5
+		chk_subflow_nr "after delete all" 0
+
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		wait_mpj 3
+		chk_subflow_nr "after re-add id 0 alone" 1
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 3 3 3
+		chk_rm_nr 3 3
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
+		local filtered=0
+		init_nftables
+		if ip netns exec "${ns1}" nft add rule ip filter INPUT \
+				ip saddr "10.0.1.2" meta l4proto tcp \
+				tcp option mptcp exists reject with tcp reset; then
+			filtered=1
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			ip netns exec "${ns1}" nft flush chain ip filter INPUT
+			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
+
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+			wait_mpj 2
+			chk_mptcp_info subflows 2 subflows 2
+			chk_join_nr 2 2 2
+		fi
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+		# after the cleanup: this exits when all features are expected
+		[ "${filtered}" = 1 ] || mark_as_skipped "unable to set the filter rules"
+	fi
+
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-- 
2.43.0

