Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795113915;
	b=SekG4G9Akg6sJutZm4IgxBSRsWwD++49f2g4y8CjV3voYkw0hHirsbJcR8Q5gnpMcBOW
	 nL2Z8TBy0+3ZWD32tTX1xdlGg8BFoqO9+Q0utIzGu8exDNT8KSAxMGgaCakbchjAunCqD
	 J8eGThtCBDLhrxPXsMibpqvfYrADUxWfS9sG0zLzGTGguCemsGJGIbK4dE3wLjz2WkQkK
	 UMgW/3g1AP7sdQZy/HWTrk5viyfolah0FIcmFecrhUlmMScMsfXUOn5Aep/oEQIoco/jC
	 oKw0u/6riacTnSN1HoWABcxs/A2OLuT1383WfeczStxXjY3as8LBFZ1O7QfB7TwQB9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=feWoHi1kE1wBz5z83w7EbRwG4lVKHxYIAuxfEXgJYrY=;
	b=n5L7kY+lapzs5LPWWLXMw153BX1Re2psunomJhJWN2LdHxykxp2polBwGNSEfsw678O1
	 GYkUmTokpAnDqaHObbMFJ/FfrIDMsgNkWr1c5GAgziTjjqSniHgGtGfvoNSE5+Zn1UmVc
	 7ednm+5fV1hkzBaYwH/+zKyzn8z3NROglyEqvnGeoyt3Nu2VxkgrWXzXS3/BiRqzfR/sk
	 5I5l6DzXQEgtFgLCXNdElUA1x402apODwTtNJpVgc7EvMzX8wTPg7RCk0DTouUecN3y4H
	 Zy2tI4a35Tsn5/dyR6eejLOFbjbeAYsjvXmxrhGo1+N+64jYbJZa/3nj9xk9VUbOlPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zboo6Uhc;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80912606A324
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 18:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80912606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zboo6Uhc
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3acec6677so72645c88.1
        for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 10:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795113914; x=1795718714; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=feWoHi1kE1wBz5z83w7EbRwG4lVKHxYIAuxfEXgJYrY=;
        b=zboo6UhcJp+KCF4jkvLeEV2KPE8/W/bDXGiiJTjXSITvZBTQZWpRW3Z0vLw8ObN0GN
         qRzowE4aTfw4tLnLOOM6uw59MaW/1AK3zWUH9lwg49mG4lpum+qFHQraIIvwwVcAjDxn
         VcXWMPZYhIXx0FyGKaBsBUeLujBSYQTXCj3FwLnlwBqVraPEHDeG2WGIwqom3pMbadAB
         CUck0JcxCNA5+Masg2OhmCuKL7WPfxS7hnBE1a5BXzSAWPgcBYasGVIMazLEB4sUK9XN
         hH2DWAec38HkaSFeHCRenYeOtv5G9eOHPB7934YdoWNXFITBjJ4ZTlMOc50NmxvWNzkY
         xfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795113914; x=1795718714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=feWoHi1kE1wBz5z83w7EbRwG4lVKHxYIAuxfEXgJYrY=;
        b=eH8abM33xPJUoqmDxMscAknKG+Of+6jtBu0+8SkOdcitcPAwYoq5OmM+b+RGh3v2jb
         DnbsAA3GsPr53Yx7P0IvAIr/xrk/GhFHYDxtK8419k70rPrkYLbY83Sen3sZHX7WV/D0
         I+wLRniSYk0+z7yO90qUTHqIGDofI2LS1j+PDjD3Uyh7qtLvpqkQOdphnpwYru1C8nqo
         dfCqXMZ2BlxdBOqiKxmJwNUezw/EzYGQ9ywBDU56GjtN8cin5c0TRj941cfQ2g1UOiFz
         Cafs1W4HE5+oGvwPvrbIf+LAuWLxti5bXSKafV+9vXDXNcVqGFMIQ6z8HDDAW2gLna1U
         pXkA==
X-Gm-Message-State: APuU4Z+uFAeVUFNM+nj8xum36ltHg3Qswf70ka/drytMNwPmC+vj8+fZ
	frTjQpvpY+8NHQ9CdxHUdKPLNG+pWFGBx5MQO+uhEHCyL8mKsgHnGwsEoLlg6Q==
X-Gm-Gg: AZFdTZcUrgbEbnFPb/sDStfvVcvdULh9wXExOLJovxRxtqcIDHnpYq+UwB2hucuZP2Q
	JwuvoZRE0Z0IPe+3OtSCYt+SOMnL7/lyTqqRqYaR1wpQsuLfOkIwnenIPhI6RoHZFFI7yPgDRor
	GdIi2GZCpT6E1Ekwo2BIq2pvnr+itYbdJruCMAfvLP3IO6XD+QEPUJgzRPDYgBChtA6fnpizTJ1
	YLw0Ts0pA2kl/hwVCmshOjb1pK6nmfldPeQCbr+9vv3vfO79NUwnT9MiEC9iM1dkL/mh9Ypf0UO
	sPz/YqoIBYw95J0/DYwYhusRJiGZJ7SvBSnfQ9fO5TI2Cl9ffsEol7ELLoHdKAOWxPIZhhOyEuv
	axjR7zc4yZ5DKuAtYN7OOXL782T0q2x7Y2rF+Mci/mdz7+XZD2+kb1AvJMTcVDg1Q3BUsMdeI9Y
	Q8ZOWxL0D6ScJAeJ5EU9bsM4WiinJoltq11nTkUZ0yxDzN0N9hWGDoOXFrz7okke4BG68x0LRbW
	4tLX0xq++hLSXgyWNDPA/a3L3Yz6jiqnAuu0hEVKYa7B6POZYg/AOck4N3s+oVR+e9OQDnceFkG
	873kw479xIA8lZBTi9kabEsi4Fk/62t1cQvM6IqoDkXIV61ZqRwR/WKEXASwRTSnrdYddqeWXdF
	LiVch7G1rHjR73f13CijkkLWj7t3i4HkP4N1cwQVDghtCPHYq4NnmIXyoemc8k2DRMUrsmLjZZw
	==
X-Received: by 2002:a05:7300:1909:b0:383:f646:9feb with SMTP id 5a478bee46e88-3856c4b8304mr337409eec.2.1795113913425;
        Thu, 19 Nov 2026 10:45:13 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm542607eec.25.2026.11.19.10.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 10:45:12 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH iproute2-next 1/2] uapi: mptcp: add MPTCP_PM_ATTR_SUBFLOW_RETRIES
Date: Thu, 19 Nov 2026 18:45:06 +0000
Message-Id: <20261119184507.1954726-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261119184507.1954726-1-anilkaushikwireless@gmail.com>
References: <20261119184507.1954726-1-anilkaushikwireless@gmail.com>
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

Add the new attribute from the kernel series adding the subflow-retries
limit to the in-kernel path manager. It is used by the next patch.

This should be replaced by the usual header update from the iproute2
maintainers once the kernel part is merged.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 include/uapi/linux/mptcp_pm.h | 1 +
 1 file changed, 1 insertion(+)

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

