Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190276;
	b=Wmvx1hX5bYrTe1zWTgaXxxyOdC9Hzi4tyqwVxzWyk/P1jNYtFpt7g79QNs3NJota02pA
	 NQYWbpkFFpcHkvpxch7AwQSFAABydE+Z2RZiLoWCWqi7RmAVRa29vxmbmKqkPBVNatt6m
	 vTmG7+M2SfhigV6nz5Loo4iMLy82vTpBHP4P/hr0NQ9rqTIqre7FAe8lKcq06L1ZNEuEO
	 S41M/sq0n2rGyaS0F0N4AR3juAi6FJxBq2MSEdbk5WKWWyzWfCPgr/BHqPjThW2p10fHy
	 pJlIH4p80h+Qi8MpCIahLsiY5ra34zxW6uoluYFFGMwOCTi+gWqBlvJmzPuNJNqnl5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=urC+CS7MPExPNZ2vKoMLm7ACVOU23T9k7Y2ABY/ir+U=;
	b=ZqAJiCx2e9aM/6CFxrNj7GiAZIFNo1iOjYr106LsGIZjTJsQI+S3S+MwWFHsmK7up/kb
	 g6UbAfRIw8MBfmqfj4WxJ7FhxlCu6Gusf12sazl3/zn34elw56oyKCSHw5TvcC5Lkm4PQ
	 WmOK+yJ3WJezlHekEtcyZpbwiWqOnq6n2tJGNGUm05iaVOivKcKsOAkzDjeorYw8IgwG3
	 s1iQQ8Fs9t3pGHxkcYNhmdBAyQE9yDI1FzEYDWQybn6GFJ915+oCxZ6ofPXNLYHOk9OZV
	 kZhLDBHN4CX95Gov6MPYLs1SkIACQaqzzcGQDws51K1ctT1+CSLSzezxVvWluubDRDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bS6pvTsx;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF46606A325
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 15:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EF46606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bS6pvTsx
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38692f62b22so492972eec.0
        for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 07:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190275; x=1795795075; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=urC+CS7MPExPNZ2vKoMLm7ACVOU23T9k7Y2ABY/ir+U=;
        b=bS6pvTsxVNEhh5k2u6pfT9+H+VaLaf6g4IqfktKhwVgBPQuLWGWAIGchE9uiEkXz0t
         c5sfs3Z705vCrzoeZhvIS5ZXcqRf4hYOSD5m2kLW3WQVqFYYmSwyDSzR+0Rhu71kMPY4
         mdgr+wYBRZy/A5ir7AYqF0ExNJbMJ9VHSoXLJjIzYK2tFC97rX8tB4WPfGBklBVhdgm3
         AUVuDJG+RekRxJy+RKedeQje9i0UYE9ZOqd2IEOVtWzB8thFKiLw9MoXuwYOpRBd1K68
         pl/3Mpqxn8B9HqRrdM66oNSzxgTQowLnEYhfhhvY6GxSMHJ7VPF/3EcF7iOLE7hjTHMI
         oJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190275; x=1795795075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=urC+CS7MPExPNZ2vKoMLm7ACVOU23T9k7Y2ABY/ir+U=;
        b=WejcRXVMdzIOl3VBzsJrsdLE0JpbVTRrOBJjFDHKCDmuxJ+nrwtvZJ/6fFEl2VW1Yy
         3ADN5LnxZqUXAU+DUyJosN6oJ9b3LZ5vgXE/fl3r7DAWmXu44WSKi5Adg1VjZeAyFALk
         k5Lyd1cJOBEo/fdyY3XHVUDZwgom6YcEeW4Atlbr3GmpIF1XZaRILK10zjvqxlpR7sZ/
         9AJcRW3WT5Ju/NpddfkFoyOUmoI0iSrcudAVeI8CWRTD3Yyiz8WqYmr4x/Ldff9gz355
         WpOnu/KuFwF6fTikZBaUvQuTrideSAcxNnlS90xRKvl7N4cl8JpFtfcboJ9f2Fnu2NjL
         NGfg==
X-Gm-Message-State: APuU4Z/lDf5Bq+ajjF0O3+e9Aznx/343mRRYZRi30mYKKefARjOJBRuO
	ScVs5F37a0mHi6nHrnnmmBS/ToHKLPDrSdvFbIn2aA/hpzyhbKWa2Ctc0JGLmg==
X-Gm-Gg: AZFdTZc7UpBwro0aFBzmB9oOhXyyGqMgKF3ul7sSxrOTZOwYtgxsAr4G8tnr4WTUcWR
	BJXrHxelo628j1Amy9eHacilHdFagDCd3NeZ3kJI204+MEBnj0uhNlbI4W9zKVYRdxesASGqqy+
	Fqk90m0L7YL+mNuWotdR/KGnWBceUaSa1Rugs+5Jx2KcsRZRRQOeOAbK74p+YQMqJv5TZiWGGHF
	w3Dl87KSjKmdD/ey7I0vpX4w+SEF6VKw+2G7rpbCeA/0QKHr53/uVQUPH0U5l7WYFzggqe6n9ow
	FJFQy0I34AsFCeJuWAm9kx9kKtqppB+pfFSHXhdzhbfH4n7a4aGxqm7Xb20p4b42tKQvSPq9c5d
	2UhU0gZtyR2+Y3eQRquYGYkH4ohURG/Bv7Cl9oKVPs/ucKfvnrk0d6bgBKpkMag+YCwtWCfx/3V
	Hv8EQXS9369jHja4PeGydLHSFHMtfc5WMLKabamu1gt6RimD0ZHqwRt9N4id9jzN1BnBuvGvVhc
	nY4fgmxcrxCZAgk7f8xDtGWiM3v2i9GGOMgl2WY/KetsayUzmu0oaYUXBySDlZUlLXQ5Sf18Wpn
	McB0Q8XrNdmMKc0iH/vez5MGeoAOOjeNSg84j3GwLbOnPFp2lWKagGC0B+7A2oJY9r2Tc3cdaax
	ZkcApXzwLwy3YNLTqmjRPpJY7omJQr6QKS/+99qP2JjcLCk/56hpoFpL/WiHeBhK4Yu23S49/cT
	jbteHLG/9p10h8WfKOD2k=
X-Received: by 2002:a05:7301:f02:b0:384:ce59:5e21 with SMTP id 5a478bee46e88-3856f6503d8mr3096635eec.32.1795190275035;
        Fri, 20 Nov 2026 07:57:55 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm8866592eec.7.2026.11.20.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:57:54 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH iproute2-mptcp v2 1/3] uapi: mptcp: add the subflow-retries limit
Date: Fri, 20 Nov 2026 15:57:47 +0000
Message-Id: <20261120155749.2126268-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261120155749.2126268-1-anilkaushikwireless@gmail.com>
References: <20261120155749.2126268-1-anilkaushikwireless@gmail.com>
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

Add the new netlink attribute and the new mptcp_info field from the
kernel series adding the subflow-retries limit to the in-kernel path
manager. They are used by patches 2 and 3.

This should be replaced by the usual header update from the iproute2
maintainers once the kernel part is merged.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 include/uapi/linux/mptcp.h    | 2 +-
 include/uapi/linux/mptcp_pm.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 5cf86857..4347f175 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -70,7 +70,7 @@ struct mptcp_info {
 	__u8	mptcpi_subflows_total;
 	__u8	mptcpi_endp_laminar_max;
 	__u8	mptcpi_endp_fullmesh_max;
-	__u8	reserved;
+	__u8	mptcpi_limit_subflow_retries;
 	__u32	mptcpi_last_data_sent;
 	__u32	mptcpi_last_data_recv;
 	__u32	mptcpi_last_ack_recv;
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 6e38dfc9..2837bfaf 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -102,6 +102,7 @@ enum {
 	MPTCP_PM_ATTR_TOKEN,
 	MPTCP_PM_ATTR_LOC_ID,
 	MPTCP_PM_ATTR_ADDR_REMOTE,
+	MPTCP_PM_ATTR_SUBFLOW_RETRIES,
 
 	__MPTCP_ATTR_AFTER_LAST
 };

base-commit: 87cb3f4198507331b9308689d4a726d17db63dd3
-- 
2.25.1

