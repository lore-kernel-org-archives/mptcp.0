Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748674D486E
	for <mptcp@lists.linux.dev>; Tue, 22 Sep 2026 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061185; cv=pass; b=To5gGMIc6pmY7zraEiDeeCMLb139caDcLcGlYDdM4osXmtlZqtZpOmDe51tU28bK0cROgBJBC2sI2b3yj5Dr5oJup1E0tc0n+iACpDrlhjEJE5Ocp7bPBsOGGheKS2lY7b38yJNJRp5ooUZme/jWKRI9AIsl4oj+niSE6U4ciuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061185; c=relaxed/simple;
	bh=dFkah+y/7d2/GgLgTQ7X1ZQyo22vOoo//0o9y6hv4r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcOrEeeHROMOzI+u+YNQgfc+opF6ZOvxlmz1nmMLDOU8VdLVM58MR4PuvEDmlpR5ZGtRonxooZSuFw7KlabDZtoe7YyV+/MWOIUFTCP2xx3aqCNxMUyVpcQSEyfddrFlLaMseh483NwAHKUsHHppGKrH+r8yCC2ItIvdHr3uYTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=Z3U1Infz reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.180.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="Z3U1Infz"
ARC-Seal: i=1; a=rsa-sha256; t=1790061181; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IVKe/haT3h0p+MVznkUC1TeS6WRbE1TEbepIovIkLoMlySnkTN9d2FaOgi+83tpNl2f+LoD/diblJ4I5qN8moqs7ijExFeDpNFCrpxtiqdydAbpvtIBCuIXhYOeWms17qUBpu9eaual7UdjjhYGGq5IWqAsfxfcQHvY/gf22Zhg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790061181; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rUV4zsIGwKiS2dC2SwjhQkuCTYW6Y8xR+u97Vnny8W4=; 
	b=Uif+krcnSYYK9Hzdq+++5BEWC8sZjO0fYCdN9f0hhOvItci4k3VvvCEsFo6cGKYzwtGJRi/GU6OO8MM+bntcJUYMdu8NhUwiYrfMCLpyUyiXOLAHBexDlA1oB6F/vgEl3659ZHIVUirRHxoXEILSjWoQtEkyaeAEMLVotvTXQeM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790061181;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rUV4zsIGwKiS2dC2SwjhQkuCTYW6Y8xR+u97Vnny8W4=;
	b=Z3U1InfzYJ8GhLBTDysD0BeORjdZ4gkeKY/dDOaRaC973YpmGSc/fFGryCejDOY3
	l9pB2DoDIEzsXMMORJxF+OHromjyC3mAEA7rOtBp2khvbPiQE+HHjFCHlbib0WvnfHf
	gELcUaBEizPJrkbQ8JHMkgXjF/3RHLWKoVeLo60k=
Received: by smtp.zohomail.com with SMTPS id 179006117825813.751850144911486;
	Tue, 22 Sep 2026 00:12:58 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	akshit@mpiricsoftware.com,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next] mptcp: force a push after arming infinite map on MP_FAIL
Date: Tue, 22 Sep 2026 12:42:45 +0530
Message-ID: <20260922071245.1997430-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When MP_FAIL is received, the subflow sets send_infinite_map and
sends a bare ACK, but the infinite-map DSS mapping itself is only
emitted the next time mptcp_sendmsg_frag() runs with new data. If
the subflow has nothing new to send at that point, the flag stays
armed indefinitely and the connection stalls until unrelated data
arrives or the transfer times out.

Force a push right after arming the flag, the same way the
__mptcp_check_fallback() branch in mptcp_incoming_options() already
does.

Locally, this removes the "Infinite map" / "MP_FAIL MP_RST"
mptcp_join.sh flakiness seen at ~3-5% before this change, with no
failures observed across several hundred local runs, including under
a debug config (lockdep, spinlock/atomic-sleep debugging). Not yet
tested under concurrent system load, which the original report also
points to as a factor.

Reported-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/491
Fixes: a3038fe5d060 ("mptcp: add MP_FAIL response support")
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ba7c6f80a183..b65cbcfdb3e5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -891,6 +891,11 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 		subflow->send_mp_fail = 1;
 		subflow->send_infinite_map = 1;
 		tcp_send_ack(sk);
+
+		mptcp_data_lock(subflow->conn);
+		if (sk_stream_memory_free(sk))
+			__mptcp_check_push(subflow->conn, sk);
+		mptcp_data_unlock(subflow->conn);
 	} else {
 		pr_debug("MP_FAIL response received\n");
 		WRITE_ONCE(subflow->fail_tout, 0);
-- 
2.43.0

