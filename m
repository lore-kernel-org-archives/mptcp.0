Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB8390219
	for <mptcp@lists.linux.dev>; Sun, 31 May 2026 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780239608; cv=none; b=ZMFOcORYuiTh9X9AqJHeuecxKzAFUzrirQw1xrUkjEj40ddeC2tkHRiv3EwQ8lzoXXA5OpqIeDl9oMHdvELdP2DvzMuSD29ETl6qtDo07xPeAcRLtYNu6Ybx9i42MxQd9Xj21FkiZLo6hviMuDgpJ2KsFiDPaRxYih79ey1Nmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780239608; c=relaxed/simple;
	bh=QcNVzrHJDmzDhVBtHzMTu8HUGMD/QTYlMSpRK5EIoOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yc7Q7bhqXi1neI34fxk+rBMUE6rFCXMbEmcqL5YBhWDjT1NwqbJ0tpMhUQb6u5C8DR4k/MHnypmsf0ABrHT1F0t7sG0uDAdiIxUDGJ/HdVWr9uB+sz+338vpKFKENhZscWDiK4hJEU8M9o48MT7M8z/i1kas4PvuOO4UFvEPFiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpgYchbZ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpgYchbZ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso392585f8f.2
        for <mptcp@lists.linux.dev>; Sun, 31 May 2026 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780239604; x=1780844404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=kpgYchbZGLnb+9cHLzGLQQwMNCJ6ka4LbbSnYvfVXCc4wGpEorFJOVCHPZ3HSt/R7U
         rTEq4/fmNRjzhRXw3rXPup9iE67EE6FlQC3ZH0/YctKvQ/uThIN7tMx/Plp7rftS9Mwh
         E4kNVvtFDMXxv3MziuR0wLbwOtLxGIWo3Qi8GXBayVfFey15XddT1In1UPUcHAMLVhrV
         BAeor0byFkLI+baymIXLQ4fR4O6GvEasIsXw27VXhxLbph/7fi1i6WjPwStlpGvHNtzP
         Tpn3W58EQ4znz3s9oHHzwnZzOOLN4/EBdefn/SssOT3oQLSytg86MGub8taxAZw2AbRn
         sDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780239604; x=1780844404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=PovbyQRAGaOEuNkktlUJAEK9//6zWACVhVrT+kdi06RdLPDzhGHVNheS1SRRQdhcIe
         U+XTxTKhm6MKFvfk8Z+3lYdyi9tObkeXP6Yd+IinnOCgnhLA4Gs56KzAcQl0IDrSc7oQ
         xauRZ87IIpCApjTMNrjS45V/p7kfdk0tVl3DmdRk66yHQ6fuAO0Kst/fyKRsLX5uBYt/
         lwsYKJyFuDpIvuF9o8kdSre6r6fDgmVRTULxMHb5ilKfDtShj1CvzNEebM8H/qZT2MTx
         H2n1UXSVJdV/SV5sky9pvo18HnjiiLXl//CmZRLPfI1q+hFEq+MGcL9dZmT7gGfrT8qb
         oiuA==
X-Gm-Message-State: AOJu0YwyvrdMm2Ovv4DOE1kT/gA3x5Mdl8LLB8AcvEA0e8V68io35lMm
	ZoyjaVzZ4f6UaVHMTydQlnnZj8d88bOiVoEkrQEA/B9VD5hxWsCj+qDmx+sAEw==
X-Gm-Gg: Acq92OFWT8G274d7OSBLN8DUUG8ru9qdeGwHeAIRMjW/3Cggf31kt5eZcryLS3RZ7o4
	DQhV+hK1LjDeiUwy/zZKXA9zbsTmUicuAer22UbmYWexTKGRfP5vKwZTf3KFLPLQnhTPCdGdSpd
	r6e6hRd6wnpMijuP1L53K7q19UJpm7I8dd7AcFYaapU6biwYLaTAlhcPyLNrj2tQjGEmn3eZ7pz
	E8gsU/xoj8yhmA8qcDvTK2v6035iH7MGZfnp65a0ul5tbq7kBUH/dlhJFN/oJvGRPTDGSdk02oH
	RgUSX9H9gxETR5epCxgiMB+XUOrw72Aa5qSAI5svM3qeR9Wd0gJ3oxIcfLU/2cxUf2z7GDs/9dL
	C6Qi8UuliL3n7vEZuBXTf48O5dypALaJiQWxDHyAXYZ3/RjtLFBlTb+RjUD9NfOtZ/kUfwgmoFi
	mFGNmZTzsn0TdS/9vs7NyTg77eyTelloDWnx2S+rXN4fi0ipejLfosRVbIyIQsXRuH/CQPfocdp
	XwmBRfLjCQ2/5GNzMwN8A==
X-Received: by 2002:a05:600c:8b6c:b0:48f:e249:4094 with SMTP id 5b1f17b1804b1-490a292fba3mr140199185e9.18.1780239603569;
        Sun, 31 May 2026 08:00:03 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3587072sm19133545f8f.34.2026.05.31.08.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:00:02 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v11 4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation
Date: Sun, 31 May 2026 15:59:53 +0100
Message-ID: <20260531145955.322337-5-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531145955.322337-1-devnexen@gmail.com>
References: <20260531145955.322337-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise setsockopt/getsockopt of IP_RECVERR and IPV6_RECVERR on the
MPTCP parent socket, including the empty-errqueue EAGAIN contract on
MSG_ERRQUEUE|MSG_DONTWAIT.

End-to-end errqueue delivery (ICMP, TX timestamps, zerocopy) depends on
subflow-side producers that are out of scope for this series and will be
covered by follow-up work.

Assisted-by: Codex:gpt-5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..95bb2cc8e2ff 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -769,6 +769,60 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
+static void test_ip_recverr_sockopt(int fd)
+{
+	struct iovec iov = {
+		.iov_base = &(char){ 0 },
+		.iov_len = 1,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	int one = 1, zero = 0, val = -1;
+	socklen_t s = sizeof(val);
+	int level, optname, r;
+
+	switch (pf) {
+	case AF_INET:
+		level = SOL_IP;
+		optname = IP_RECVERR;
+		break;
+	case AF_INET6:
+		level = SOL_IPV6;
+		optname = IPV6_RECVERR;
+		break;
+	default:
+		xerror("Unknown pf %d\n", pf);
+	}
+
+	r = setsockopt(fd, level, optname, &one, sizeof(one));
+	if (r)
+		die_perror("setsockopt recverr on");
+
+	r = getsockopt(fd, level, optname, &val, &s);
+	if (r)
+		die_perror("getsockopt recverr on");
+	if (s != sizeof(val) || val != one)
+		xerror("recverr on mismatch val=%d len=%u", val, s);
+
+	r = recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
+	if (r != -1 || errno != EAGAIN)
+		xerror("expected empty errqueue to return EAGAIN, ret=%d errno=%d", r, errno);
+
+	r = setsockopt(fd, level, optname, &zero, sizeof(zero));
+	if (r)
+		die_perror("setsockopt recverr off");
+
+	val = -1;
+	s = sizeof(val);
+	r = getsockopt(fd, level, optname, &val, &s);
+	if (r)
+		die_perror("getsockopt recverr off");
+	if (s != sizeof(val) || val != zero)
+		xerror("recverr off mismatch val=%d len=%u", val, s);
+}
+
 static int client(int pipefd)
 {
 	int fd = -1;
@@ -787,6 +841,7 @@ static int client(int pipefd)
 	}
 
 	test_ip_tos_sockopt(fd);
+	test_ip_recverr_sockopt(fd);
 
 	connect_one_server(fd, pipefd);
 
-- 
2.53.0

