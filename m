Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190274;
	b=n/oC5dcF3DK1ymOPwdim9kfU7RoXWHGjsc2nwcyptEYFXqJ88KswtdlKLW3zuSl4INqH
	 T0ZHSE8ayNnK6QSqQB6Ge4iR8htF/bDkirIA2tHU16CTBao6nc7JcIk+wjc1/xFcZt5Uh
	 onf8H1SsADVMwBRpn7QYhXT70wgerg7RQsmOPfDsxhztHBkd8TRpI9ZujD1bNNyem2IjR
	 ZmPhOZTgB1yOEJyUquFeqFHGb8dpHPFu1/N1rMQxkA3FLYwfJ0pZM6tdIzg8b5qTM457T
	 SmDYx4+bUgOToSh3Ne6ft75tEhtMqLwuOhqyk3JgsbQPMkuAPcCfhBtLpH5LDd5f1mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=w/hyUQbokcBUKqbKNc1jK2+jMoQVrGtIDHE3iXIGqbU=;
	b=nXvPlvusyXH6XhaFukZWQcVVH0cLCOVNkZbjJ3VEruST8l7wLRYV7efMLkglB/XWwHl3
	 U5H6UZFzxAg7hTRxiwi70b3HjXPas5mS+5d5UwpumIwmYODuzflCfzTgvbV660el/dFs+
	 jC51/FOVaxj1PLC6bxqWTspm4bGeZknnBYKC55QwJQumLehZv1AQXu3H547Qxy3jq4r86
	 445SrtgdH2aVzrDRXVbJHZskgOVtfn88WiPN1Ru6/bm1Xyq1z1QL9+YWU51NQIv5zjnzJ
	 HJ8TZRqmuRTFnck+9ee+Lhf7G3YAmQJnxVKyoICFKv3cXRwLv1V3w1mvKtpXBU5lzlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l/XEXC3h";
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EEB606A320
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 15:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63EEB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/XEXC3h
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b244fb7fffso1089347c88.1
        for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 07:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190273; x=1795795073; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w/hyUQbokcBUKqbKNc1jK2+jMoQVrGtIDHE3iXIGqbU=;
        b=l/XEXC3h/rPaMQxZyVIqRQpnI3Y9Sv9pCcLNdq8eTI760HtArI2c+nuD2MQFTASlxi
         WRMvR6I13io+rkZX/m4cYE4PCkxBC5u3sJUm9os8NYldCnWEUkIhacFGvJLOaL/rH08O
         Ucc9hGLETyDP2C/WW2dc2P13guUFpbT9zpiCmUHa88+xnZwulcLdgi/B099aJa93J6kk
         g89d8vYncjl7R8qHVxmJpizaJVo1i5aBpkNVFqoN5iG8AcE1yEcI4rQkrnBdkLnPq4XY
         L+vRPFc+2poet8CXgFBvVc0DIs+nC418At3q17gE8KxchmI+FrAn3bDa29K2KaOIVgu1
         qZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190273; x=1795795073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w/hyUQbokcBUKqbKNc1jK2+jMoQVrGtIDHE3iXIGqbU=;
        b=HunVxH/K9aQurWDGumEl0sHfed1RrraFfRe4IZ4uiCbU60JMr5FMsQpYTfmAj7GJgd
         jXCL1M+daGU7ipEDf3M4/9i7erYFva7zo3sGbiML5Cm0W+6nlyC8Puh1UBZYOipKuaox
         DJ8xf8BL8Tp1TGGMxtkkPCjxpnupom4qEjmef83wxc/ns0VPOG4r4h5bHYS6nSrmh9PS
         dwO1CixkIgh696prTbq/COi4EgbcJDf/oH8xYfvQSOp6BlDh/LCz+qFo29SkGgoRUlvM
         UFq722d3FZ0QHbQs4ycjb0w0nzE9XA5mtnuWc1E/OBIFgi6Jb0lpcGSUqZ+Ea545Lri6
         500Q==
X-Gm-Message-State: APuU4Z+vJfV5MPOmfWiaq04pbl4fNQMqu5nQvRg8q0LgMBL8mZcpxFyA
	QJVNtTZHTjbBWXF/ixkFUz1vXEDR0GD0/wypWQGurIMtoxpiJGliPFinpEsAJg==
X-Gm-Gg: AYBFou39FS/L2UVn1jou1y46StgYZT7NOjFWGKgTEQWqLqCeK1F0JCxMUEPKsWEVmhQ
	BAozsB8CaKax3ZLAyJElSWkyxhfs3WOhgIY3axWhD0paPwpZ2bflEP2ZxZ3CfWL4TluF5JQ8sOt
	o4IUNLJkhgwsHRnRtJS8GYlu99XDABGjR6fCwC5T1ZQ9OI6WyEUZO47IR4wAGX+8pDWggM9povN
	QiwWTKX0YQH2N4sQN9AbYQ4YU3N6BqfEWiCaVx883telEdbRSeEaX50jAg9CXwwabYwtLjtejpA
	x8OvA96OJr+2UKKcWbsKRrngxFk7dr7iS9yenWFnFQ5SvBKAAA9SE+smQ2X4soJoibVm5dlP8Pa
	XVfxve8/1aF0AgZ2PYWdSHX4Xq97FGua2Rc0IzE70ukRM6Rs/kSE8gHfl2n62Diq3gfIe/xaPA4
	qhoIlkFs9YYmVtpSvvH2r0an2hP+/qGmrxxynWjIn3rb6QuPxon76lV/3wgh9LSvyzkXzcFAjxo
	lcYfbxqPDgca1+t1bJxqMBGaZzhliofPUlj7pNYR2lBK9cBZgGRe8XrWLposwNwDk1N9/mhMTfQ
	y5BWo4kMiN2oEWKhCTVfJmHQfNitMK8f3SIhuK6+slEL6m0kzrxzbuobx5eFtsDSLKVCYq2pJJD
	p9Zds36wvUgKRsZM5hHYQLSgDKIKp5XHJgjbJCXGNypK9h82kbq3Svshv7F3Rxw3/ElXRWzcl4Q
	==
X-Received: by 2002:a05:7022:e80a:b0:1b5:4b48:b9fb with SMTP id a92af1059eb24-1b5567c0ea6mr3336617c88.5.1795190273146;
        Fri, 20 Nov 2026 07:57:53 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm8866592eec.7.2026.11.20.07.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:57:52 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH iproute2-mptcp v2 0/3] mptcp: add the subflow-retries limit
Date: Fri, 20 Nov 2026 15:57:46 +0000
Message-Id: <20261120155749.2126268-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This adds the new subflow-retries limit of the in-kernel path manager to
"ip mptcp limits", and shows it in "ss -Mi", as Matt suggested on the
kernel series:

https://lore.kernel.org/mptcp/20261103085244.23064-1-anilkaushikwireless@gmail.com/

Patch 1 adds the new attribute and the new mptcp_info field to the
copied uapi headers. It is only needed until the iproute2 maintainers
update the headers, once the kernel part is merged.

Patch 2 adds "subflow_retries" to "ip mptcp limits set" and "show", and
to the man page.

Patch 3 shows the limit in "ss -Mi". If the split of ss.c lands first,
I will rebase it:

https://lore.kernel.org/20261119024049.3109143-1-stephen@networkplumber.org

Tested in a VM with the kernel series applied: show, set, a partial set
keeping the other limits, JSON output, the maximum (127 accepted, 128
refused by the kernel), and "ss -Mi" with the limit at 127, 5 and 0.
With an older kernel, nothing new is shown, and setting the limit is
accepted but ignored by the kernel.

The fix for "pm_netlink.sh -i" with this ip will be in v16 of the kernel
series.

Changes in v2: show the limit in ss, as Matt asked, with the new
mptcp_info field in patch 1; and the iproute2-mptcp prefix.

v1: https://lore.kernel.org/mptcp/20261119184507.1954726-1-anilkaushikwireless@gmail.com/

I used an LLM to help write and review these patches. I checked and
tested every change myself.

Anil Kaushik (3):
  uapi: mptcp: add the subflow-retries limit
  mptcp: limits: add subflow_retries
  ss: mptcp: show the subflow-retries limit

 include/uapi/linux/mptcp.h    |  2 +-
 include/uapi/linux/mptcp_pm.h |  1 +
 ip/ipmptcp.c                  | 21 ++++++++++++++++++++-
 man/man8/ip-mptcp.8           | 10 ++++++++++
 misc/ss.c                     |  3 +++
 5 files changed, 35 insertions(+), 2 deletions(-)


base-commit: 87cb3f4198507331b9308689d4a726d17db63dd3
-- 
2.25.1

