Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436771;
	b=y8AVCxAPr7cga6G5eOKxbVOanCCZ1Ai+grREV6VachGQqJGokWj5YNiGM/uKCpEXI009
	 MuNNoUUS/nKwsLPthtMvvRkEzKZdY+bfyVv5F/4fI552oA/pDFnmE+pmnlLOvHKsQQBxt
	 6ku3Ysd1lNXJuJ99hZ2BOWFN0In/iZQ/SffGAIyfhVK8J3FvuzEhVOsgYq/4zO1RN3g22
	 NFZGNWi8xdUFqJ1RDiYZJoN7F1xGxAwNNXqutLOkHe3eYJC8JyIcJ4tly9CGD4sFdsodn
	 Yq2KtK8EbQTu3NW+mJr5Mbq+P0LxGXR7Z93LUPjaVW32gLPAKPK5Ft9sgndi+W7OlGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=87YrPJQRW0ht/hlLWXKgy3RMFVyUxz+R3l3bADmTWwo=;
	b=zMy39uHXni1/Dx/Tv84WtfROpCs4OAUyEc/bUSWlhXbA/sb58Atg8mBw5jVUz34Bhcqv
	 vqYZmm39YiE2gASra211LRNoLdKxdKttxGrnyeZd2J/Rk5RQ84HlVcbCRrcI+MNVidzLl
	 WQF4V/2SpnYa/gl/oFQA8wQhdSxOl/+c4eoOKAgw0tR5o6ajjsmyH2Ej6F/LDp4g3MwE9
	 oSxfbUU9+IsbslVuQeJPyBSU8EBnwv6M9rJE11TtqkebjSDXZ/UIvN3cugKvmsnOx+oa7
	 aKx/iijuFG/KoFx/FfP19HM0raEOuZubRsNM7MtFGbvKDtrIuGXPGr1DjFmN+nsmMYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j7ah2TPY;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0177C606A325
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 19:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0177C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j7ah2TPY
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso883483eec.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792436770; x=1793041570; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87YrPJQRW0ht/hlLWXKgy3RMFVyUxz+R3l3bADmTWwo=;
        b=j7ah2TPY2v+oN3olPEVWWu3SHczG69hNrnWq0qSxg0YK1PI3/2Z93gMmacQmu3qYgu
         LbJu3IkN4JtbYgyoW1Y+8PsZ2jkWXl3vc9eCEIReuvrOGp2D/sAsjDUn3HY/WtQRqzkc
         bx8vkjfEbncMLXkAlQoTgu75z0CCbjA2MhvO6czjNMFq5t6wWb3lOBx89tnTeoSfJkup
         +TZeShDZSNvS+x90gcLpIqShzZ0wt1tIdE4j9Uf2iY9xy1Tm/8Fmt9Q9j1jDztwd02hq
         NSMpZiWBo6nq86VCpCpGiV7Trep1oMGO9o+vqokambHp6eKY+vjaVdLqobGxKzl9L2fm
         kw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436770; x=1793041570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=87YrPJQRW0ht/hlLWXKgy3RMFVyUxz+R3l3bADmTWwo=;
        b=AVv8ECkUsVUm4W6boh/2d/kB0h8s1zGGrW6oHLLbjKbKCN+gel49jNLIiZ+ROBW1x9
         sXtP0lyxVxGVRyAnh8+VoOcvg5tJ9D4vb4PVN6ymdvorb8ef0DA/l8vrmPcDLbhhnLdD
         H3Xq69MPnYHjerHaMcV3mEJPENhAVGQ7oTG9z2LNCIouSfEVtweKycGnn5jO3MIY8Xoq
         kDSOzSaVjZosw82jrt0KZ2oA1ER6fwzBVt1qF0rQHplWbF8J1QQ1Y+L7bKIUptjD4p1L
         Nqy/Hd6LsVKe72ueyqCHUbkrcB2Z2WNpZtZ4FR0eibRvOtWle59MVSAa81F8ggne1GxI
         z+8A==
X-Gm-Message-State: AFq9FYIDNGRzpDgpTw1IKUQY+YdwMSmoQ41lqL2GsItMkyvI+5l7zCPd
	WZjRjYznxnANgBvccO0bNQLxwRs0OhOD4JCtJfjnDrAqqIwFXSpAfwYVz7Y54g==
X-Gm-Gg: AYBFou14eljUj0j74uW4ttxDNF8Sk9XPAXnxEFlL+8wJkOtc2twdQDLRn1svOxces4l
	TNvDpfLU8aMW3xikUv/6o6u6/zAWKFv6aHXSpveuKvYQJvEujwrErXcbW2vqLl/pQ/Cjtj70Qkq
	N5vBswr1+ePCyUHm75IzF6CWh3alcJc8TkUaoqkPakUWK2mdB0DQ+tFis7PNCgtoeVj4BRIbvVa
	W9jZ8236Hubw59ZOUng4/dSFXgLTfkl7zIzv8y9pbIDYw968Y4qXtlpFbaXj6rSp57Qtx4I2ysQ
	YU8SovXUjgxA+797OMWKmujZ+lwiC0PmG/ftxaMKwcMQxRFFlWtGhXu/XjtmubvPFLmxaaOWpeU
	NRIMOxTQVCLlCcDLI/z6npzheXi7EiHZkdtWnUn1QNsuI5ykCOkcUkG/Os+fI0zTYnntnEOwkXd
	zhqde3sxeRq4P5rUM0pMOrWwoGrE/oDpHEURmb2eurCh2+fcvwuWdSkQ9ri815yztR4hSx/HzYf
	fAyxnI=
X-Received: by 2002:a05:7301:fd81:b0:35d:bd18:58a8 with SMTP id 5a478bee46e88-361a2b34f83mr11220056eec.37.1792436769914;
        Mon, 19 Oct 2026 12:06:09 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm62848024eec.24.2026.10.19.12.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:06:09 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v4 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Mon, 19 Oct 2026 19:05:58 +0000
Message-ID: <20261019190558.465270-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019190558.465270-1-w453y.me@gmail.com>
References: <20261019190558.465270-1-w453y.me@gmail.com>
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

Do the same with the fullmesh flag, and also after a reset of the
initial subflow, before the removal of its endpoint. Without the
previous patch, no new subflow is created after the re-addition.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18ce7136a..25fedf5b1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4445,6 +4445,67 @@ endpoint_tests()
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
+	fi
+
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-- 
2.43.0

