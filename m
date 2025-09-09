Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B7C274B5D
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408407; cv=none; b=DEyjEvyuHdwBvHWJuJGIYv5mjHzewnATKCIJgk+yFjIQZmpSbtvYxXlyQdcDnSZQZe7iKEwbqmIXatFRbQtMOsnf1IYZC29sg7T+3jwlcrny0VDKa1XJOeWGiKIr20ZFW6tpAbGXTAoansldBsxw3/BJk+WNtaVmpGAa5+lxTOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408407; c=relaxed/simple;
	bh=aFSUmCti6MLTcqlgBbhF05M3cBauzcyYGq99VlvOS14=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=PPDCQbChNV7L2DMgSttq3tX5D0wZdnxvgk4w0JYijFxMddXwFjdNXIVhfJ+/y1Dtz74DpKjQN4WrDXLO3Kc1RoE2tkdpnPEW/WcUBaRiY4OeegN6CBz0j00ebZz4FHoHof5Uw16MD4buzcb2ij9sydsasRcTTuglN9hFDRUcD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlPxcQuB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlPxcQuB"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de6ab6ce7so11725285e9.1
        for <mptcp@lists.linux.dev>; Tue, 09 Sep 2025 02:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408404; x=1758013204; darn=lists.linux.dev;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2iATGGckum8OfAaFEr19Bj8rW51tZDxYm72q6WM1MEA=;
        b=PlPxcQuBiZtJFXgto7v7+ZDjahezUfjXGR3d4BZvPpcQVhD0G9HnxKgYZ/ff3VkPa7
         ChgfrNUODKttbHaAdjexk+NCCY382TK5qGEynnpY2dyC0/SVAvcMJEFiFzOkdYvQQweV
         lMzAcRbSXDYsC7XGsXU4IRNWX0t0NSfjJ1gki+InIuarHTgFM8MmO5AhR0wihbJZfuUP
         P4A4S3lPUJqQ28yKTqsHKGqHCnKj4rMmNGri3J3ProLmJad3Z7x2bPNtLb64ZVa1w1yS
         200X9C+7jRf/zt5R4qIyLXQlthv4ogl4g12glgmVD1SVe1wtjABSXzQ3W+4b+lWAPJ0l
         Yr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408404; x=1758013204;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iATGGckum8OfAaFEr19Bj8rW51tZDxYm72q6WM1MEA=;
        b=o05PvriKao0MDNfieh8CLxXzzTiHf+4RFJ5ZZu8DIzoIYXBKz3b5xt5wng5DQ5sAQC
         Mw6PDCVUwt5McLeNVhqQtsDglENpKiZfr4DDb/33HlnqOVkZ7h8dfirdaBrRBWTGm4by
         M6eyHwJO8n6FfcsymfQtzev3U4CnjhZ57ndSnQmFFUZNs4oEspjAodI13oRIQ77DQHLo
         +nIhm+QAZ92skBX7/2jUSzc0PbpqvcQABM+ItCn6Q9TP/Pkh98c7p+a0gqREzcZK4yqa
         /e7U1ozjmiNTC7EOdE+tqwNA56RGRwuapGQHjK7Zo5qJq1GFHa1C9FinKYlPLzx/U3Bb
         km5w==
X-Forwarded-Encrypted: i=1; AJvYcCXOhSc1JNnBzSR82K0zbwPSTTuLyHe+5pSOOSQ0oGUrRXwV+bgJD81/ERQrtI2sqbPq925E3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaTKJPGpUDQPuo0wZgdFO2YL5HKk2C8lO7AApeFZywDv8fXtwk
	lVkclK0d1AfO8D0fH8UK+u3gPr1briZneLbDP+Rr2Jz6JQon+yewRRH0CUyEo+4ZV9M=
X-Gm-Gg: ASbGncsZBDURjE+3cnZ+q97ZP2ppxV409kBptsP5UIn+/kJR6UlO05nO8mufFA/FpTp
	xG8gf3UdbNKP6hhCCp4P/CcGLx1BST1YrckrRQcxX87po4CKygbsRDohvV+iT/XS0ZfFlts7Ugs
	SNsEV+2iIVbe97dz/yxJsg5epbpYakWVNRpeDRZew+EoJH/Ou5toJ6nLMj6JUMjb0zeyomSqDfy
	iS1cUyu0emhNRvsJcdGYq5jF+x76dsmw+aQcqOIyf9DEGZbwAUFS/im3ED+rWxsAf66/HjeOBLa
	RlyYQ9wCXczxrcByozg0OXsg2SQgYUiV4Jcs7XEKZlsElsDiV2n1/RZfy6Af9QPQC85ZIuLcMIg
	hJFROkwa9Yy2SSSfB3wFjJ8V7DYiLeiLJ3A==
X-Google-Smtp-Source: AGHT+IHi9nXrfKJGYALDvRRmSRzYypfCt5Kl/21MQbCCiY/bILW7ZiySngyv35dAVzFjI0zhrcNddA==
X-Received: by 2002:a05:600c:1389:b0:45c:b580:f795 with SMTP id 5b1f17b1804b1-45dddedf80fmr83035805e9.34.1757408403794;
        Tue, 09 Sep 2025 02:00:03 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:837:bf58:2f3c:aa2c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e92a42asm477565115e9.20.2025.09.09.02.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:00:03 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>,  Geliang Tang
 <geliang@kernel.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Davide
 Caratti <dcaratti@redhat.com>,  Jonathan Corbet <corbet@lwn.net>,  Shuah
 Khan <shuah@kernel.org>,  netdev@vger.kernel.org,  mptcp@lists.linux.dev,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] netlink: specs: mptcp: fix if-idx attribute type
In-Reply-To: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-1-5f2168a66079@kernel.org>
Date: Tue, 09 Sep 2025 09:44:40 +0100
Message-ID: <m2plc0ui9z.fsf@gmail.com>
References: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
	<20250908-net-mptcp-misc-fixes-6-17-rc5-v1-1-5f2168a66079@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Matthieu Baerts (NGI0)" <matttbe@kernel.org> writes:

> This attribute is used as a signed number in the code in pm_netlink.c:
>
>   nla_put_s32(skb, MPTCP_ATTR_IF_IDX, ssk->sk_bound_dev_if))
>
> The specs should then reflect that. Note that other 'if-idx' attributes
> from the same .yaml file use a signed number as well.

Note that mptcp_pm_parse_entry has this, which should maybe be fixed at
the same time:

	u32 val = nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);


https://elixir.bootlin.com/linux/v6.16.5/source/net/mptcp/pm_netlink.c#L116

>
> Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
> Cc: stable@vger.kernel.org
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  Documentation/netlink/specs/mptcp_pm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
> index 02f1ddcfbf1cfd81a398dd03c52bb9f281c1aa08..d15335684ec3d6256505f2b3887ce5818eb57462 100644
> --- a/Documentation/netlink/specs/mptcp_pm.yaml
> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> @@ -256,7 +256,7 @@ attribute-sets:
>          type: u32
>        -
>          name: if-idx
> -        type: u32
> +        type: s32
>        -
>          name: reset-reason
>          type: u32
