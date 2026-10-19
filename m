Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436118;
	b=BNyFgACfsnY58+l16jX2cc4kjOkdUmSfgoCJvfZsxXtmIAMUBfuzME2IbMzNf5MEgP2u
	 zTTd6YM7acRTn6VzySdZZCTwdS2TtMvzKHpdR0DsyrtJ1Oqh30tJaT0haMiNQxmSeo6r2
	 toJXZ3woNxEAXyL3NsEFLMVShOodzGl4+9TMxHDKiPHCiOkoIbcLyGevek4aYBsU7DO5e
	 OxW8REvnVrqSowQe1P2GfO/lC9qnMrZaEJ+63SAKLVqrn8AjpG7Ldta7V8zhdL6E5i0ZX
	 PSnMVtFV5l1HbuL1D9+hmwazOOo7ZIDm+MDkM/6WaW/1IPwHfqsFQo7hQnNVcDPDe4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=55aYtziNtRasZnnYlsOGQo/NyVj4VJ+7z+6Z8y/a7pg=;
	b=1XR+6MPjVK36LgxGbEsERcW1KoLhMzf2P2dud5TC8WuH7gDa0X4dXHSEBr32CMCbU5Sy
	 yTO0cy0xZGayp9E2ntNSwaqrbtrSGeYNea58rGC1+avrLIXmxua9uSRot5mJqYGLf1tpy
	 J8lbfRRZKXZmT7kzYsuLzGtZXrA0H0oDoIkRGcYDwYWtfAFr3Ku3zs9oQppBbjiV0Dzmz
	 ecZhOY07b1v4Nmh7e3W6xmRlPSU3FmjteXBpEMI2go4qs7tc4z/JY39Jb+hUDZXRG2IDx
	 ogssPwgCL5w4UDP9u8jqnRlIzA+2Id/DMO4ZGiPFg0zGVQkMDQa9P3EntP/ZYjX3gfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QoixJbzm;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131BC606A319
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 18:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 131BC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QoixJbzm
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35ef6b49813so4642308eec.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792436117; x=1793040917; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=55aYtziNtRasZnnYlsOGQo/NyVj4VJ+7z+6Z8y/a7pg=;
        b=QoixJbzm9CLdcEUIBMCnARbC8DuOGsKm4g0H40THPu/JrM6rrjLrS/f01Wb0TYoZeW
         MOx9VlqlH77VD9FJSO1KYC24jEsmY2X0A6LZRumUpBQr3K/VLNwa98UHmC4L8OeroLCq
         UHf9lYyXfkFvs+aWMgQ307vjiUYoBLouDXQ+jUgWJ11WrDr7N6O7PdcXg/wm6vAlGJmW
         NnTHSjI6iqneQIv8zyXPRKeuioWakd4zLh5+Oh3zkU1gN5e5C9Pb9oUiKcKBu4op/cUy
         C1SETaGuXlM03kbAwkVGvG5DH9U5NPm5okPgN+Qh/BvWscu/O7i7QAS7y/FO+aUXFa2V
         Vhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436117; x=1793040917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=55aYtziNtRasZnnYlsOGQo/NyVj4VJ+7z+6Z8y/a7pg=;
        b=m7Rwlli9N9h5E5CCl8L+lewk32fxR/5KyXSoS0OEA+wl8LEGfC0YDOuguFcFXeEKgT
         CuQQaCyPSdIUFr+8e7INt17mIYluufxF3/MTIH+6C7qmQA9Y0eiR34NPJ8XE2Ds0J2Nw
         EhmFH/RHbHNBin14sHmiIoHBWOeVSKPni5xRBygPVAS0u412JKGB/Ssi7gLFNpEas427
         t29zZA3TgxhjJvgn8MDTaobHv2HEhrd+tO2tGOy9iAH9ysAfG/Swrz4KEPrmYMqY3La1
         Zijdg1mBXb0CTHvXfiwXUwyFlCVtltw85AmCKE2F6hf9EvKdyMJ55at8wOLWE24YVN3l
         sN3Q==
X-Gm-Message-State: AFq9FYIFqrzEnnwwovl5olrGphpsoDbWDIRftJyJbJTY8ISICM++qAXf
	849jOEmvltEdUEDNgl7S/2WGr6ObnUE1onv8DAy6zzAf+1Rb5CGrlwcf4rnbHA==
X-Gm-Gg: AYBFou0s5QiHralPeLvJAQlQlJPtaSCDMS8iZ+RoLf50AdPWVRuuZeEuHfWj4mAfUmI
	NEuOm813siH96ZqTyo5NQsuENc7M260iDMv4KSnXKBxvkySkcHLkyF/x9fmaAzAh+wx7M+5/7Ej
	WiOBklzNKLfO5FbzWnpbaFcgTX12sJIq4v6tOEX9bZdOFnu1IXvZqQLb/ZOjzYxVSy3vKgBiLdq
	jXL8ZrOu4BGeRvW3tzm6Ehh+rvzasZT0R8rWE3ODMC6JZwQ4RaEeePNnRWdpGcgRDnXNGKN3zOx
	TDUfpkQws6lEHDnYzNwFVPsh3EpGZPrsXQ6dNiYohiyfAKz2GzKMDvBseDurY/EZcWs5FTiY1BQ
	zPqTtan7zHisZcQkitQdE/LcqGvZQk1oxwSHZhFRtBfJ9e0vuUq//RXljmyncFmnNeFrmdXnb62
	rXiHs67VEPTdSr+3Q2aKz9KRQhYnWoo+gZMNO++CrKu9rmO3Cd8mUEIzVXGTJAFTsGyVQsHHi/m
	YXGFYq1Y2PKg9sQxA==
X-Received: by 2002:a05:693c:87d9:20b0:365:b147:b458 with SMTP id 5a478bee46e88-365b147b492mr906434eec.3.1792436117024;
        Mon, 19 Oct 2026 11:55:17 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm35749512eec.7.2026.10.19.11.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:55:16 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net v3 0/2] mptcp: pm: in-kernel: fullmesh: re-add of the initial subflow endp
Date: Mon, 19 Oct 2026 18:55:10 +0000
Message-ID: <20261019185512.458313-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
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

With fullmesh endpoints, removing and re-adding the endpoint used by the
initial subflow never creates a new subflow from it: the closed initial
subflow stays in the conn_list, and makes the PM think the remote ID 0
is already used, or picks its reset remote address.

Patch 1 fixes that, patch 2 adds tests for it.

Found with a router flapping one of its links: the link carrying the
initial subflow never rejoined the existing connections. Tested on top
of export-net: the new tests fail without patch 1, and the whole
mptcp_join.sh passes with it. Patch 2 uses iptables like the other tests
there: when merged with net-next, it will need the same conversion to
nftables as the others.

Changes in v3:
- Patch 2: use iptables instead of init_nftables(), which is only in
  net-next (Sashiko).
- v2: https://lore.kernel.org/mptcp/20261019180306.382039-1-w453y.me@gmail.com/

Changes in v2:
- Patch 1: also skip the subflows in TCP_CLOSE: the initial subflow can
  be disconnected and its context reset, clearing the 'closing' flag and
  zeroing its remote address (Sashiko).
- Patch 2: validate this case too, by resetting the initial subflow
  before removing its endpoint.
- v1: https://lore.kernel.org/mptcp/20261019170751.200446-1-w453y.me@gmail.com/

Abdul Wasey (2):
  mptcp: pm: in-kernel: fullmesh: skip closed subflows
  selftests: mptcp: join: re-add the initial subflow endp with fullmesh

 net/mptcp/pm_kernel.c                         | 19 +++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 62 +++++++++++++++++++
 2 files changed, 80 insertions(+), 1 deletion(-)

-- 
2.43.0

