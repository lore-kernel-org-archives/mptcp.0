Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D570443E54
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804394; cv=none; b=p7vI/gAknGdcDHtCrsDKCGLGnn+XMLaxgVxRPYJhdgGGvSz/XYEr6qAn29F7BrTJ/cTQOsmroVUu+WVPDK/FLAH16PYcIxpfHwcbIvKmjY0kDPoCa89OX75NepbKWCom9P73f6fCk1RHFhbBydqscC/qdKuzH9YWnm/puyH+n6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804394; c=relaxed/simple;
	bh=HIav41YoC8Qy3k+616c/g3Z2Y+es0XmbDdjZNzW4238=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SmWCrW+VlJ8vK7obF6B7zpM9ZCErQtmaT6HFy3N3vu/EkZ6MzxaheDqUWR39r5zEGht/FluAbyWxiIhA+4Rc0zwTjO7QHPLzcIh84oL6452/eOB4oO0S2jaUjg/JNbGTZNbTzLCB0FI+wD/DtUz796SB2DJcu/DWhELZM/m1jUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDDHHN9z; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDDHHN9z"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-359d729379fso1121578eec.0
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791804392; x=1792409192; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nlPEEGcRSVzMH56Rs8d3D9xGabNuwIGFjD7IKFfxZ+I=;
        b=QDDHHN9zTFiRtpqToS3x6zwq/WCp0PivXObZXheRIEpKUHK5Vx81MnHjvUlOYrogp+
         IlJnuHfBZ8H5nFzMBTnspJGxDrufkc9EV7+z8eupTZL98bUxkrx2yA5N5P2Nv6oT/p0n
         vXx6T9/sYhl7CVmsX3Aan/NLj03mafF2wDGdMb67CG1vDrkPiDCS9YYgZh3MaTXOiUUE
         3oiCtCnDd5uPp4G5LrKE9oy6bA4b/txK8K9TKF/DOfBnEwbA+uj5drgFNrBibSPWCeZ2
         yfgoGwRNBUUlSJB74MV4fuFdUjO1Ue+pGz4G9Ls5oKQHJ7jj5AocbQaHfHaXZiDX2Eeg
         Upbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791804392; x=1792409192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nlPEEGcRSVzMH56Rs8d3D9xGabNuwIGFjD7IKFfxZ+I=;
        b=nDtq/w4So3TBEHGJvk1Yxocd5J3VtYGT8yofhZIc1MN4KN2bxsgwse/6+kbGFmCf86
         Cxh1KCqqRuFmflIUzYxJDlRNZFLoq/R9qnHH/ObhIs3rxPuS2aHlE6aNCO76ByjcT2tb
         0AMbtgIsTbI/4oZ8xnKJeNxSDtkX8nv7MQImZg/U/LZBEUFSgMQSIHO08uxWmHTfDsX5
         SZ7tnNf3MyPPDdBqELJGlWL3BHCT7JhENEgXRfvij1ANWeFQKPcEc4rXWJ6NvsHYvPa0
         RrJ2qGG8zI/em5B+aYpboPsZ3mT/XOveZSVY0ETdfj5JOhhAjxCjfiS+DYePVFh3Zts+
         +WSQ==
X-Gm-Message-State: AFq9FYJ+OsDHe5ZCXWMT6zUWXiTXZUF6TpConQn/5sTX34LDmTwMW2a/
	5KFHiMngSo23C/6fyKjmNIhS1xWiWjt1Y3VhHfawL2TurY7e9wmOPnp2a4lQ91fb
X-Gm-Gg: AYBFou1aEiQU1bewPLPgTToPFbm0clETJmiNs+F99VcqMQsp36argqEGeUoiLTlS2lB
	J4SpLJUmc2uo9f01AGvPKEsxzC5A4MImHIJ9V6HeGvf5Xae76Qlpj6R2MjV+bis/FOKOu+sVFpl
	UseC/ZT2kkyQO/xDMVY8c4MbRTLPph8ixi8UP5kP7aoqUpzWFcpYAxakAb9EorxCTpgIyyORto4
	5qpPTBjkNzwkGpB/IbqmwIgGwzOerSl1mvdq1e8e9rr77utbSS7ngqwwLqymKYiU22vOnNqlw7S
	o/DiWzbhdnRXbzGJWwv/mH4Xrr/xXNxD6FEKLGty4kDNqd1LBpH/HbCyuvR124v6atTgjHxPQoE
	s9i+A2u9ANzTUaVGI6/MiigSNCJhGe06OopOSKo8oG2f9j6xBu1b/y4zNMZzWzg1cCCEY682uVL
	sfQQhaTUb5xHyTwSo99/7oYYCF5NXrPHZ7+2/tX6JT0X7I/u69hFudARVI6Nr74d53mGuh1Pk4U
	Q4/Tzql
X-Received: by 2002:a05:693c:88c9:20b0:34c:79d4:ba0d with SMTP id 5a478bee46e88-3537dffd5b2mr14877809eec.14.1791804392249;
        Mon, 12 Oct 2026 04:26:32 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1ba7esm32154379eec.7.2026.10.12.04.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:26:31 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Subject: [PATCH mptcp-net] mptcp: reset MP_JOIN subflows on missing or invalid DSS options
Date: Mon, 12 Oct 2026 16:56:25 +0530
Message-Id: <20261012112625.578911-1-rameshkumar.t@phytecembedded.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per RFC 8684 Section 3.7, fallback to regular TCP is only permitted
on the initial subflow. Additional subflows established via MP_JOIN
MUST NOT fall back to regular TCP, and if an additional subflow
encounters missing DSS mappings, corrupted mappings, or unmapped data,
it MUST be closed with a reset.

Currently, in subflow_check_data_avail(), when an MP_JOIN subflow
receives data without DSS mapping or with invalid mappings, it branches
to the fallback label. If fallback was already performed or allowed on
the connection, the subflow bypasses reset and incorrectly accepts
plain TCP data, synthesizing a fake fallback mapping.

Fix this by explicitly checking if the subflow is a joined subflow
(subflow->mp_join || ssk != READ_ONCE(msk->first)) under the fallback
label. If so, immediately set the appropriate reset reason
(MPTCP_RST_EMIDDLEBOX on MAPPING_NODSS, MPTCP_RST_EMPTCP otherwise),
increment MPTCP_MIB_DSSRESET, and jump to reset.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/544
Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
---
 net/mptcp/subflow.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 78e886b20..5faab6ffd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1446,7 +1446,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	return false;
 
 fallback:
-	if (!__mptcp_check_fallback(msk)) {
+	if (subflow->mp_join || ssk != READ_ONCE(msk->first)) {
 		/* RFC 8684 section 3.7. */
 		if (status == MAPPING_BAD_CSUM &&
 		    (subflow->mp_join || subflow->valid_csum_seen)) {
@@ -1461,6 +1461,28 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
+		subflow->reset_transient = 0;
+		subflow->reset_reason = status == MAPPING_NODSS ?
+					MPTCP_RST_EMIDDLEBOX :
+					MPTCP_RST_EMPTCP;
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSRESET);
+		goto reset;
+	}
+
+	if (!__mptcp_check_fallback(msk)) {
+		/* RFC 8684 section 3.7. */
+		if (status == MAPPING_BAD_CSUM && subflow->valid_csum_seen) {
+			subflow->send_mp_fail = 1;
+
+			if (!mptcp_subflow_fail(msk, ssk)) {
+				subflow->reset_transient = 0;
+				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+				goto reset;
+			}
+			WRITE_ONCE(subflow->data_avail, true);
+			return true;
+		}
+
 		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
-- 
2.34.1

