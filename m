Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190280;
	b=zjgwH+WpVg9ydNWAhzLuADqvuxXPJtPOr/D3DZo4yF7xt1JgRLLempxiuERvf2Kca4rz
	 YoxEGfCZMnLZR/hzqKAQHC1qD0aLuYqvxGMmboY69LMrsMYzyAFCx0MECwfz00HAhjkKR
	 G6YPbdTB3kWNk2dS92Z31Z+N/wXnj6Ai+fH6ot8RytbEVVbKW0x8VG7cU7u1+Z5mROVO3
	 x+wVG1wgUXYF+r/RrGZfY5xQ94+HxF7R1hva/6N+xeOsnpR9dxN0pWnDdE5oyiqnhStm8
	 NhhtlQcMb9Gv2lXdh/K8vhDTRC0loiP/ZZXARYoHOnHE6mZGck2PlLTLinBWs5wfKjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6z6DILYrLicAimO/lUGiMqlwMpCE5ihvcnI/K8VKD98=;
	b=fspdgjBqa8mNq+8X1WW4rt55ld1xjx5+pBiV/E9VNLlPSPq3qK2cioAGSmN8b3PgPGEw
	 dRrjt8fO3uV80/q+ZIxFHMzPQx8AdgOnDzn8lYGzLrF9205jx3c2Z+dmuML9ggI3eQjMD
	 dj4CDtJNvAPxWK3nNWAa84LkD/wZudrgLmgojxyFVukXj8ImMeyaa5PetCiKyM4J81TGK
	 5IBBOnw2OqWKjj3HiB6KO+kZrylvoEba+z8/JlFoGIzmCPaX7Zv4aI7+7oSjWs1udJSRN
	 3IeQKIs3XxeJbC5Q1VdkQqfD3yqsZRSPugEvE+sUC9sefftFOSlBxDCIqYQlceGr84A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Cf/dxSOH";
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE2C606A330
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 15:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDE2C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cf/dxSOH
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38587f3de36so1224962eec.0
        for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 07:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190279; x=1795795079; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6z6DILYrLicAimO/lUGiMqlwMpCE5ihvcnI/K8VKD98=;
        b=Cf/dxSOHLxKJKLzjLbXFvCG1EnIEfszqxA/ReQqRbw86UkPpnJrV0uZYxRXgUm03EJ
         laabmmV8yVFni6My2QT08d6BBlNBeBjq6RwXBrOpLXEsZ+oMe1ZlLBvSuiDhUq5WIM5G
         n99fZSJGIeSYPVLKg0uwiFPHNczBcszr0rAeIHn4LrdUhFdMARwOUmWviRilyiJ/Io7I
         war3wunzAafwW8lbmhr86Hjz5JDxChcPIGsTksNr9Dk/F5h6IJuf494yT0LZrUf3bSsE
         aS7V9lGZ0Z1ioVlLh4D2UDh+Etg9LKRmc9bMKVw851QeaUCfE8PcuqErkdzK56Sh/Rfe
         BXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190279; x=1795795079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6z6DILYrLicAimO/lUGiMqlwMpCE5ihvcnI/K8VKD98=;
        b=0itQ3EceSA0xC/64uqq3aLzwEUe3/hC2/iELQJLdvwbUuyIWOQ8HJL01zOczeoSwbD
         cUP3MdvztqMmmIWRMrrh7QgLp60KvkMaTRbwoKh78cKFWdbHgEoSIoo/WvWsPMC/TtbY
         AhQTJmHSpcfyZ6+iH1H4MkGvChUdjL8UgP3ddEjmYs8RRcBPIu93+075gY4B6MZaNtak
         qlgv2ft7VYD6nvGYj5lx+tUxWonmNI9KBCUjs8j8uTFnxy5Jd/clKgeTI7ixeR7WSDJS
         Rcp9GQzOe28AiZgI1HmwMRY0pEhDinlUUKCUmIDpKvF2AZ6H7mRIltsU6porxP+jx6Xd
         U4jQ==
X-Gm-Message-State: APuU4Z8w4pRrDQ8tmK5upFD41niKDMk4BmWV0rtW10OGXP3r/NlebPkW
	iSLOlWnLoVjAnIzCZ3zFkRVjVK8u8kchps7ohpLyBcaG/eUlnaVv2GzxO+i2sw==
X-Gm-Gg: AZFdTZe3dQakt2RlEhJeISW7XenDPAWnS/24PRdDU2+t/kVYA3nYqcgS/QbpvbC89iX
	JgEOhEkPeEN9LzN1v+Dt7kNVGfFhhN3kHM5qO/+2h3stZDEudix6OnloNir7rpH6dZ6bJRtWzX9
	P4qlYSJBJ23wqM/zHWJZX5/F2U9LKmgopDsguJNjxAbdh6Z5o5ZNFI58ct8i85OIwNcJ8045fqQ
	7JiSbz/HggZvKlbWGTDCdW4Z4JzELBichMTUAqfhLb99+jv/ILwxPa9OTvUPqU0D4XAh0kCi5bY
	D3kLD9d9+8mLNqtNPe3N6HBFLrxJ9AWxNT9N9lq7NFWgDg2rGWkxopxqNNC7XYGW99OJvtZ+gr9
	5NPR5Z01GQ1QI3u3AT2nxK8R5Lu1vGyqNYUeRXg/bBTvKcpDmWPZIoNUmW13G26pPXGX1lroH8i
	TIpj1ATbRxwq+KSxp9ar51xjZxn53/Xq4KPBbbFgWlgAgsBLD9i4mx4zckszWNHBpaq/l3jBceI
	QutIoiTgiWLO3Z1to3iERAQBfuSl+cC3MlgQkHW9cPLreQO+Jy6Lq2tr/5QaZE3ZEXN6maJJo/l
	sgDAwNrwWc1kC6q5/nbfhUJ2T2XvHYLOn0R2pFpOt4umg7+lsj+thkHCWNiswskU92DBgx5kGyY
	eY106bNXMpRzg/T/JeVn0NKy9Wwc65FonsYdC1jsbAIP8llaxvvqggIMzA1+B6lPBtDngDB+6a/
	wbCmEom0Pm41NwatuXmPE=
X-Received: by 2002:a05:693c:4001:b0:370:d6e4:e8aa with SMTP id 5a478bee46e88-38570b34fecmr3406487eec.41.1795190278754;
        Fri, 20 Nov 2026 07:57:58 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm8866592eec.7.2026.11.20.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:57:58 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH iproute2-mptcp v2 3/3] ss: mptcp: show the subflow-retries limit
Date: Fri, 20 Nov 2026 15:57:49 +0000
Message-Id: <20261120155749.2126268-4-anilkaushikwireless@gmail.com>
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

The kernel series adding the subflow-retries limit to the in-kernel path
manager also reports it in mptcp_info, in a byte that was reserved
before. Show it in "ss -Mi" when it is set, like the other fields:

  # ss -Mi
  ESTAB  0  0  127.0.0.1:33586  127.0.0.1:10000
	 subflows_max:2 ... subflows_total:1 limit_subflow_retries:127 ...

Older kernels leave this byte at 0, so nothing more is shown with them,
as when the retry is disabled.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 misc/ss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/misc/ss.c b/misc/ss.c
index f4160f59..dd162638 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3203,6 +3203,9 @@ static void mptcp_stats_print(struct mptcp_info *s)
 		out(" subflows_total:%u", s->mptcpi_subflows_total);
 	if (s->mptcpi_endp_laminar_max)
 		out(" endp_laminar_max:%u", s->mptcpi_endp_laminar_max);
+	if (s->mptcpi_limit_subflow_retries)
+		out(" limit_subflow_retries:%u",
+		    s->mptcpi_limit_subflow_retries);
 	if (s->mptcpi_last_data_sent)
 		out(" last_data_sent:%u", s->mptcpi_last_data_sent);
 	if (s->mptcpi_last_data_recv)
-- 
2.25.1

