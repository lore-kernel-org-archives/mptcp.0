Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566240;
	b=eYDx4+P2+ATYnXPpJfV1HeRrVCWs+KIqY4TaZyEcL1ap8XWHcSQxsSiHW7YXVi7UPP8K
	 Nops3UaVzuQbLh9FoQxRLZIEao7kaWj/uNBpKM+VPX8aqXQI/PVf4HLzmR6DrXhl7BSPb
	 aX+FYDv0q+FckrlPv4e9U98zWI1FaUbQN+5yUaVSujthz7s3Bj+qj6xCCZlIw8ssNi5a6
	 mSaUDYoCXlKf7Gd9r0Be2n7oxwx8d6w63YUVxcR1IvWT3M153350zgphryugo5ff0UWbK
	 IUAw1cr/A1cbmusH8qgFuu5rl5pm0XYhjzDFRC2n7/YZ+OO8/UloWIv9RqhiUwPfrKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2U3R5sF+UF/ThzqmsP+AbA8AsR1nfKMwT/Du2FLLvgE=;
	b=oIe503Xf3sMBD5RuJEZhs58sKlEc/kU/aKFSmndR2y1KDA2O2Qog6bWA6dpGVWT2AxQL
	 BbhNUC2cKB52FRp7L1eKj+z/x5MT2Hq8j+Jp2cKhv7Dnepj/gJuNocrMeYnHM9K1a2dyU
	 WsewHub7SXEi6xB6PkbB93yLuXEjCyL5fD+R5g5c6EtbhAf9/R8CY3PU2mYbaXwM9Cxi5
	 aK6TCSH7iaSr15pAzPbBTVtOhLL/jBDZ6B5xIGIj/pkYULCQaLFJJjP0qzEL/Uli2TyW1
	 YxKa78Ah+IDghZ9z7ZFqJrdRa+SWdK43D0mEkLFQDHMuY282vsGJgR05DMVCSWVjb0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U5u8L2J7;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2D606A31B
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 07:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69D2D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U5u8L2J7
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36661f953e4so800760eec.1
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566240; x=1793171040; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2U3R5sF+UF/ThzqmsP+AbA8AsR1nfKMwT/Du2FLLvgE=;
        b=U5u8L2J7YiHClM9PmdYUCXGQwJf97Lmy+qfPLtAld7SmkawTHQEpkLNzloMmwVuKPs
         4sxqvQNPCRRs/wUV+I6k1mpnizLR1rql9NdxVI1Qffkir7leK14vcPO9KMSw7lmENMiy
         C6Cz3qf4XhBMwBKp5hEzJuAkjeNHcldVTB7zli3QNfkdM1TNvg776tJI97L6GBgIUO1o
         gbY/BMSMz+ikdBDDqFvzbZMcBttzxKPMqv5Ut5/GyksypYv6SJCpSLiLXKOXcoyLPGys
         mVEGPB6KeSdFe2GtaauuEtQ9/ud4zAdjyAW4svA51+rmqoeQVPw436AWA2vhxqSv0jiQ
         dMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566240; x=1793171040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2U3R5sF+UF/ThzqmsP+AbA8AsR1nfKMwT/Du2FLLvgE=;
        b=QNbXs/Vwfx4IhIES4/o+U0vmbrW6EVzLX7PlVXtGq8Lx2waLNZ9qIQ9GITMekyUhNN
         Fd8wPF6q46hHozbMmCp9k4ocFzXqn5nSUgJ7U54b/A5YoL5iWkvpt2L0TikiOzp8QZyk
         R/KZAa59VxXFYD62w8hAhpn9QTWBO4+x7oBBgh5Z5STi4kBe8EkuKwOMULReakuJqQ4D
         sIFQDezJyWqrY17RvXb5Qq9N5zKva1gP+A7MiXecqlI1Nlx4fxXwO/T0sAQZohgGeo/5
         sNhnQbymf9NAGTqPsaunpQQF5ol99Xm7xvaZ/HGqB4RMwb0Gax7g6rKhZDtRpNU+YlyJ
         8vyw==
X-Gm-Message-State: AFq9FYIu0mecplLUJWyeeiwnuDCevpey8UXgZV2HiBX9S18KWcSpanEh
	Ye+VuCkYVE/W4MQKY1uvK+4JeLh4OgvR0R0Ly7nRkUYMKZkTT0EjuX3T
X-Gm-Gg: AYBFou1nztj7TVhMUBo+/U/acDBeklhPzOayHmRkIterhfsPRRLyb+Ue5ERVro/qdO/
	kwruFEwi1sbokmf1dlau3V9Qw/1xajK2QWnJv4dZEM38Si2Be/bQl2Jd5IINByloc7NJ6WxsOyx
	yjSgMXq2jNuTijT/AktjQV75D0eKxS60IW87zgIAZzuHdLScchXqD0EQQ3T/4sshWIvZt3MriUs
	gdI5dj7r+2Apa7YLH2XuO2gSwQ0aL4cXDdnrJSEmVE2EVUR/6yEwN1OhpCnwK+jyb/YEUQtzz4B
	/QUpUTwU09WnmPxXGRi4G3LUe9oVp1zR/FsvEXAMjZq1R9hcRZ8c9UyfGOcRtwRE0XAQN1LdNQj
	sxYTcXAZswON1vw+tqQh57UeG3HvL3DXLnx+ir6HsMzrY22Gsj7RStxp3Bc8jzVxI+MvsZMkV9p
	qhZPbxnBw1GdtpjMaC7vG3/J5fwyaYU8pUxnAE4earz3iK2cEb/OkvzLC5JkHsYWPg2jmaj0bi2
	qcklXRBrhAvv3GQc5WA6mahX7hn8rgNxjRsTJFrvhKmjvgwZ2OjmQXyXqZ+aVXOBtNaiYcgUNMI
	5jBxaYY=
X-Received: by 2002:a05:7300:cf96:b0:35c:6366:1d52 with SMTP id 5a478bee46e88-3674df52799mr2205316eec.21.1792566239253;
        Wed, 21 Oct 2026 00:03:59 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405edd7bsm4512649eec.6.2026.10.21.00.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:03:58 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH mptcp-net 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Wed, 21 Oct 2026 07:03:53 +0000
Message-ID: <20261021070353.50603-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179256281931.3133.3826869783117765302@kernel.org>
References: <20261019170751.200446-1-w453y.me@gmail.com> <20261019170751.200446-2-w453y.me@gmail.com> <179256281931.3133.3826869783117765302@kernel.org>
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

Thanks. The first issue was fixed in v2, which also skips subflows in
TCP_CLOSE. The second one is right: v4 left no remote ID 0 address when
the initial subflow was the only one, and broke adding another endpoint
in that case. v5 falls back to the msk's remote address, like
fill_remote_addr(), with tests for both cases:

https://lore.kernel.org/mptcp/20261021070324.50533-1-w453y.me@gmail.com/

pw-bot: cr

Abdul Wasey
