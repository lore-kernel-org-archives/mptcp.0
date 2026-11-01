Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793519789;
	b=SwO+YMEe+mNZPjiojDLaZQiI4dlZWHQIdb1FnntDRWbOcYm2lkPWeV6XnpokgAPTlUsR
	 6Z2tpdF8/+BEa9IFljFyPZvmIHVTH6m4wAOFxTqLUYMiXB/NUj4Ip5eCJCiEn3wo53p+e
	 m2OiP6ZkRe1Udv9LXAji52nVtEP2oDL312ahrsNZpkp679qfjU6GrvaV3oA8LcLQT8OKV
	 EuUlMrnJ/x3qR5xYl3gOEd2M9PPDZha1qoc0HsOIu+9f8XgnBp016KtmVLQYtdvLYwTFM
	 qEurVm6ZaR4uBMmbTY8o8w46/WeHX5AIOXIOx0WeYfkZQBt2GjzhVpnJK/VdEFK7qAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793519789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=soJbSWPGz3hD9oO0i2TSPXuImiR3LESbYcMOdHFrLG4=;
	b=C4JHc6T7UVq+7K8+BY8ab7852HUhouqBoZtV2WqHtJ/3rUrRWjDLg6FcLjIuIH3BrxDA
	 2lnCLHhzlXfBL5Hnf032jLkogIJFJYI52QteCXygjyd+GiEQVWhzsb6ArHjggTbo9Jjr8
	 o+VVz7KhMiBH5TlpuPnnId6U+Cru7cyG/AO/jD35z15teeUizJCXqxO0/SrzhiHo0tkse
	 jggNY1gpF641XuHroARGU1GYy56g1/xZMvypZeCbIT1SoUby1/EALqojRZvZorRLFE34g
	 ojRYN11+e8gKtN5risHOyN2s9tCzFG2VyAo31okyuAW51/hrceKBQ2qQWcGY9NKu0hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rb0GyBX8;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A60606A325
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 07:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7A60606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rb0GyBX8
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a1947498bso475221eec.1
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793519788; x=1794124588; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=soJbSWPGz3hD9oO0i2TSPXuImiR3LESbYcMOdHFrLG4=;
        b=Rb0GyBX84iaOIE1H4OzKj97L2fEmQRZAl5t4N4udr0nNDxwApoD0U8n3a8taBtIz5O
         OtcAh7TuGnZUUFIFkdql3X8ZnSPNuzQkz/PLwAH43TpfH3OL5GZ1oJgB1hT3kFBVkZ1J
         oKRblyH/Hx4y6un125/LGdhduZgMJuZyA5P5EeDuof5WV3vtyiKrS7J3CNXhI9Wtcuv/
         X5qvjLr6y2DrqsnLh5UVGmr3sa99SrtHvN0GU9raa+5mSx6809xkAIu62moPSv8ElOJA
         asLfckIoyN5Z4CU9rzsTta39e1AGwRwbzBdhrNADITslzg2tHHABPXbLZxMZ8lUj7OJv
         L3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793519788; x=1794124588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=soJbSWPGz3hD9oO0i2TSPXuImiR3LESbYcMOdHFrLG4=;
        b=uxZ7o1yad1rwIbmAkAd2qDsomfOIi130lAInwMo1jqfEPnGT/amwgOPEUnA0ZAwS8R
         8dzdSnVcRVLOQA7D0EbojT1zu3b4BBmN6csb53Q8VQ8eUS9iAYhj1Q2dUGqgSeg2nwAs
         1/rw14FyFckK6zUpLzkcH1YZuF8GSjMZm5l4zfSoyE8606XTmIXqGPc4Nb8Lcsl0/QXJ
         AFqYFn3JzdO+SkykBY6xpnMd4S6YQVDsZIDuXrxuZ0G/ebYSWlTCp2u7pjAPraba+ZT7
         3+XzgMZkmou5CBibD6cldstL8avcLPtuC7x38CDOvsku6BLPcFrfGykw6rLixTFvMakz
         Ddzw==
X-Gm-Message-State: APuU4Z+tMLPze01PlKfmQ75S3+/2K47MoxjCsXEvaiozG8AtEZrU29rt
	4CnXo68tJgjIGCeveFOAXmjS1rhCuHqD9ss31hSXUxL9S/S7Qw/LbbpIQW2MTg==
X-Gm-Gg: AYBFou2xdPpx6LTEx4AhthmnVQx09TiWVysaC4qi5vrO6W+jyFjbjK4KZhf57y6bgEe
	cx8OgaUSe3dROFBbt2tkwxDSpHHjRVWAhfHsoadYkpc1FA8+hZni6cUgN0nIf4sh/13io47cLtx
	3DL3ZMuWw3WUygVCxShwSmUUxemo0zfWvl2MVoGYQ1DJTmQFm2w1RmqlWWG2Skrsc2PgGcCfGe1
	eEe8ALNx99Ve1XMR/cGz7vXgYknoE/R5MDAGYK9GU0bwvrNbLBpwjWCncJNrAh7apgIAO7ULxWH
	QQt7+H4gZI27toa9x7/CCoKv8vnjXn9kGSqYnUmQpwpF53N8ELRQnHLRJDNZUtoqceh8futsdRq
	ZK2bDQ7n4uJUhWnjAMgOle93vANqPbYJ5QznYHIdxUEt95XAZwFBmian9stazce6mIi1DslCNNA
	NbC23NGiUZ7z0+blBxQs1/lq3INgOkG4uUe+FMCMxtBr7nolPM7gnj8U9EnDCK8TlhKYePe9Lju
	2hHI8UumQmPA1bUTdNm3DXZYxC3C05d6+1LY+8CBbMWPjwiB+USauu+kCUEVIoB9HqVuaj8/aX7
	J+xaK6G656UWpEUrU+i1a4ViLqIL9monHuB/H8rcAVTedChMvg9gEO5TibBuD+14ON/mP/WigAx
	VTu6JKJdk4PLNpoK/IYYPJd/HC+yUmBwgkCTJTNerIM945O1qHjsQosE0UH9QGFflOIXUFBFbgO
	eAs5ByyD8NZJucWCPz+BJx
X-Received: by 2002:a05:693c:8806:10b0:369:f97f:72c1 with SMTP id 5a478bee46e88-36a4241bbd5mr11068041eec.36.1793519787593;
        Sun, 01 Nov 2026 00:56:27 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429018casm21751145eec.14.2026.11.01.00.56.26
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 00:56:27 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 4/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Sun,  1 Nov 2026 07:56:23 +0000
Message-Id: <20261101075623.3891159-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <sashiko-outbox-192315@kernel.org>
References: <sashiko-outbox-192315@kernel.org>
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

On Sun, Nov 01, 2026, Sashiko wrote:
> Should the MPTCP_CF_RETRY path in __mptcp_close_ssk() only release the
> subflow slot (or avoid scheduling MPTCP_PM_SUBFLOW_ESTABLISHED when no
> subflow can send data) instead of calling mptcp_pm_subflow_check_next()?

No, this is done on purpose. Without this series, the closed subflow 1
goes through mptcp_close_ssk(), which calls mptcp_pm_subflow_check_next()
too: the PM then tries endpoint 2 the same way, also when no other
subflow can send data, and __mptcp_subflow_connect() stops the close
timeout the same way. Here, the stale re-created subflow gives back its
slot, and the PM moves on to the next endpoint, as it would have done
without the retry.

The new subflow is a normal one. Its SYNs are limited by tcp_syn_retries,
and waiting for the 4th ACK is the same as for any other join.

Anil
