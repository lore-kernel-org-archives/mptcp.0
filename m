Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432999;
	b=AshplAUkTJKjvYmPmpsjsA012lrQ3flaSmxza7N2jU5PmtU2+jguCmM4U7zzg5l/sspw
	 X3+4OhYtD7C8IpOh8SF5+UxfOSxxQxjZ2RiSfpaD+4pKZdHxGwSmKfH1obKspeKwtPacn
	 RqJI3j6C4GPktNQ+PDIBrdzMYXjSNSAwV5exiOLaACIwS3hPODOVkhGo+wiLhvxUGRXfw
	 sVNQfwaRSY2VDxS3Ypj9QqaYnLp/8Hpqviwh9FFUD8qiNHpQYAqZeVrabcY1/MgW8r8TZ
	 qel2K2c9WLreFNs80AeXZvmAlZnml2p1cXgnQHW5lsj+HSYA7sc0aHwUbxH+D9tcppg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bGnOWkZ2yc/krwRLusPwIg3ZeTe70ZXarhoGMMBy+X8=;
	b=4ofqoUx6Ay4cL13d4Mv+vSuCxwjvmRFnMHUuoDCAKokmrMMn/YS9ZDYrvHpRfU9PszO2
	 XRNKg51TfhDTr+V9p0I2pLqQV4YFgkzQQWr2/Y68Z5e9S8AW1mbTuCqg4ageKjG8LypnV
	 OlLI48wd1WJYVQTOnbfFplQ9T6ASDVLxhOJ1toJ9kjw6cWoJI6+rfLIFnsPTma9Hvhw6i
	 lEiAepL3V+A2PXxdRx8D+x0TMU4erqBsylPbIhHqcrM7eXeYqSUcKdYuLD4+x2XJ/eZ0T
	 CLV62xjpvukQBu7DgnKhpfMSk13iYxluXBOE7lweW5TLrG1T6pQuSD1hgG6MfDTpzOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LZHDtFHV;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8964606A31B
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 18:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8964606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LZHDtFHV
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-14fd9dafb0dso424740c88.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792432998; x=1793037798; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bGnOWkZ2yc/krwRLusPwIg3ZeTe70ZXarhoGMMBy+X8=;
        b=LZHDtFHVS9WI5QTZ+BGsveY2LwQosKAF89TKlllfz3y3WI/9FzDXVEBNCdMKaSZ+LZ
         MsIewuhc9VEws4QSEnSLuJYFbgEPOVDt9FAZSFW7tFERe2+Q3EQHEViOLyB/CExipvRn
         X1O8BXkajteayZ6ZjMSvOkoJ0BkrnkfVje6ZrRhpu+ECrgoHIE75xIouK194FG90LTxb
         6FcIuo20IMTS32000iWCmKuafPakYJA5tLRBmN5j85l8aQnPvUBd6ytv0O/nqSKyQqSF
         fu3SH8kSXy+Q3PAb/mRymFm7teJIA9cxj4wD3zEOFD1ixlfi1fT9d2YfbvrMOFfd33NY
         8p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792432998; x=1793037798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bGnOWkZ2yc/krwRLusPwIg3ZeTe70ZXarhoGMMBy+X8=;
        b=MYwYgIOtg49xw+uD8qrsEl+rP3YnOnlN8DXfuc+IENhB4WesZRFoGnNkga4UxkAMc7
         plY8DrRUV6HJjHyIqqlD9Arc7GPir5/r/G8OPbHXn/gfYwv00DK5ffOXrRE1pV7I6Fw8
         7OSDBoHT7w9/vRB5gb1isyfAJ9+FgUi40HgwLJk31G2mmhS4rBClS6RMD9UO+EWSTaaG
         L1IvVfrzXlQmgMoPqENWih2cyFKh2T2QaWS9fXbj4ngJMWv53IKAcXmLNC5QRiQcBs4H
         wzNJlikBOjLvYP0hN4zKpflSVRBEPtEf8ehjprbTK7qwVrcIm8WlZqFf0uueAP1g0yL/
         U2hg==
X-Gm-Message-State: AFq9FYIwWkG2R+XWaQjOSzB7I6IjOEYN8O/aIJNeVOLQFdr09elNXuiM
	uVauvzdnc/dpGyPH6eHtO2zaTuK6K4QAtkncuBFCAan8NZPfH1AtE/MnTnicyg==
X-Gm-Gg: AYBFou2PVtzYlc6NBpFn//VF9B/wPbP0a519W2mhUnzXvfg1wapRlNnMII49WuaIoXs
	0SntpqdhyFMyIs8/uPsIECExzupIPzy/Qo+ZtNz2qwfL1qWGEVfCX6IacyuXYiYzx7UW1O6DRuj
	YYlfsTyILmLUKWpfU/hGEzhJIhUx6SHIE8Uu6Xu18OmTWFNVvhZ2exJqMv0k64+pFVMIOm2TMpQ
	zA7zcA5SLQ51Q93xGlrmDMJRSocTvf2ioJ44x3cZek0LyTVCr8sDXblYmq+k6QVru8X1KwRC73u
	NdoqFi7sZ6DJLWFNWO01srkp0TNzoGIqWM1CJHwPTx/OfZQQjIRa3gn5HORUJVjbEFpN/gbDo2F
	+ZtsKn9xJ0oKzNQ03B74tyhbMWa2PuiuqUVZfgIugHnMemf9jx9YgMkxb8jqOy2V/xNVXzfamyk
	zIorCjVLf2fKXBZE6gm2Vf+YvqDdXtS3uHSjNcytA6QW7bJEKMJWgUdfZlM+uQYZ/+7EoXCuDKn
	TmFUTY=
X-Received: by 2002:a05:701b:204f:20b0:14d:baf5:c40f with SMTP id a92af1059eb24-1851238b013mr13488897c88.14.1792432997792;
        Mon, 19 Oct 2026 11:03:17 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18319d3b880sm28400604c88.10.2026.10.19.11.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:03:17 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Mon, 19 Oct 2026 18:03:05 +0000
Message-ID: <20261019180306.382039-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019180306.382039-1-w453y.me@gmail.com>
References: <20261019180306.382039-1-w453y.me@gmail.com>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaed..884d635bc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4424,6 +4424,70 @@ endpoint_tests()
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
+		init_nftables
+		if ip netns exec "${ns1}" nft add rule ip filter INPUT \
+				ip saddr "10.0.1.2" meta l4proto tcp \
+				reject with tcp reset; then
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			ip netns exec "${ns1}" nft flush chain ip filter INPUT
+
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+			wait_mpj 2
+			chk_mptcp_info subflows 2 subflows 2
+		fi
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

