Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429696;
	b=qHOwIlGPfkjFKk7QtxPH2ob5tGrVCw16r/9at7Qq5kG0aBZmhIKbzsIES9faZdCAcKoL
	 RvhtZtjCE3UbQWaPXrDGDQ1TNtaO1hikSzcOz+eQqZHFfXe1nTsUQeL+zj6d1ZbQ3dVbq
	 8jXcmAlIBtTgDzqnn+tq6z+Hc8pAdHkUR86seALOpfH7rAk6b4n1TXBilOMiO+NN0RDBG
	 NN7mPwVC8nSozEg2H2WnG2A8hoVy8uG1lyfp5ztdGRkFmxLtPgsTtR+3s4cW8QkknmqXL
	 w91xSlrlkpW4ckqXFLOtdXgSAQT5hjqYziEHUcEOfx0QMHZFO9vAYpPIZxyqMneTdrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3z36krrHxFbBA0vLySUPeNHdYTb/OoCUAxpD0sDq89s=;
	b=wUh2yXlp3AYqpIhYaYZHIeT8CzzqdU14Pxnu8S110z8NUNRLY2e1sIuv1wobDLPXGyg6
	 DRbiTDg1GzEm7cZXUqzWKjNHEHs3mHAlVoD2zrh+AoAwWCvTq7x2zRm6XSZvtYIfT0PK8
	 YyuJsbIv93+BGDhE8IVuV49hqO4q1Hmpq1u6Oyn1R7u//hLJQGqKibkazbNlL7YLW/eZ9
	 BMvFMn8WFuwDBNgwTx3LvEfc/SzPiTx4l3bSTcEL+sbvg5GFPm3XLLGey8emygWo5io6n
	 Ym5UmrVFMRqv/vXCMmjIP9sK0KWl1XSpEwUH3BCEzTvJkn3pzdvbMfXLoXB6DXnGEuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X1wHbdHh;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94840606A329
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 17:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94840606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X1wHbdHh
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-353804b591eso4498178eec.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429695; x=1793034495; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3z36krrHxFbBA0vLySUPeNHdYTb/OoCUAxpD0sDq89s=;
        b=X1wHbdHh54B1FUshFG1h40rYjlrSB7wRJERR4AzDaf/VrNYmR2laYPY8grWLk4+/u1
         5HfemHC6Z3Qce7nioDAYOKqTIMXin2GxwbNu6CSXOc21bY1lWu35f//w4i2EiyA76dAT
         iUr9EfgqEjiY8Bw47i5PRWgNyqU7+33Kf3z2WKlfRB+5DnrJOt1Mc/KvTyOkyW1bn+B2
         av0rBzvovyI65V5bCbQxRkdxRjI+o0LH1MFi2d1WRtD6hvq1lCwSo1lyT6hLodz7kA8F
         LMYT9FeTg3055TKXEaIlcq2PGFKM/gsJV8+tYnRyTb57piC+XINvo3z+CWXuZf/sw2aV
         30YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429695; x=1793034495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3z36krrHxFbBA0vLySUPeNHdYTb/OoCUAxpD0sDq89s=;
        b=2iyzrXTinzKc33dP9sjHr2VxXtNNGchug9anAY2HADa9s9bqXMZduH/xb8YtDb1AA+
         8/OAO5SY5ugsVsoo2wVS5v9xfhmZ2mwiCLJM0zOrbq1XVHOpoOPIXcAoiCKKO2Hv+TG2
         AjcJNZMB7t9Zvzjx+IeOw+wMZYB4sx8Q9sTewloCEGEz3eLLyCzi6LNOHATGByaCVGno
         sQFC5IBJhcKi6N5dMZrBGKmYYlxRRFZ0JtBf7kJC62ESC63tGDDvTf1b2haLlZozd8gi
         NTYl0uC56CDalarwA1PFbHZlIgHpjXB7muPcGPnISP30fS4JGiZKeD39G9IOfJ5wjlpA
         9Jig==
X-Gm-Message-State: AFq9FYJ4tvyzz9BLObUUrGEHocOrmU/r4yfCUcabflW8VpF1/hJ13jI/
	rQ2bo1QUOGspIQqzbsPuRIpdGLGiE++JpsPB+4pZ9h4IeyjXCLNjDviTibayVA==
X-Gm-Gg: AYBFou20/LgHhxoi/WvkeavoGrdK5SJZ/yPKKtbDmV4tJnYFTYH7Z4YItqD6L+tmRN2
	2vAFzNxzBoWQ0KmJkNKiZdP18ig8N6TaP13yIvIzrc7tiVqBggjnbcVNmPvTM13+UtjYoWiJLFJ
	BmqDE1WYR2/5T1lFSTpgePg7bafChhrIk/26uO90BdOi/f5kydX+Wc7ld5v9fu7M75IQuzLoakN
	HvDkED9cg4Ply1XA8Do2J0I0BCQf6aHh8i+lZL0My2ao58+IMRPI3pVXQq6c3b32DAqCdK6CFbj
	fRGqT+vuDcMLnca5oUN+K2brFoN2JECRmIwpwL8ukHdqX9u7NOcXRXDXv8lVCOwReo4oE9KvyGb
	Ar86UBsGeZdarpSJWn69zF558vF/nMBNjNNWn4JIAHoibbgPkffuSBeDUZZztAGJSP3Bw2iC7Qw
	3O8psfJddtYK0M7vBr5/x8kk2zeMVEGGv3bDMfICp6O/We1kChWSCN+2eybXElS9KrAVZ4oSJU4
	kyLZ5g=
X-Received: by 2002:a05:7023:a56:20b0:166:3e26:c4b5 with SMTP id a92af1059eb24-18512296a15mr11257108c88.18.1792429694452;
        Mon, 19 Oct 2026 10:08:14 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm29247207c88.5.2026.10.19.10.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:08:14 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Mon, 19 Oct 2026 17:07:51 +0000
Message-ID: <20261019170751.200446-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019170751.200446-1-w453y.me@gmail.com>
References: <20261019170751.200446-1-w453y.me@gmail.com>
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

Do the same with the fullmesh flag: without the previous patch, no new
subflow is created after the re-addition.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaed..4fcae963a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4424,6 +4424,36 @@ endpoint_tests()
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
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-- 
2.43.0

