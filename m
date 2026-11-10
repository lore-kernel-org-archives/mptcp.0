Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332553;
	b=ms9rn5MPh13QJt1s8ShlTb38XW7zA71A79/cvpmajcJEGKYBNx9olA8TviXwFNkQkzW8
	 5V61v9q2+JJ/xE66Zbvy9nggX7NVXdVyhz4+V1/zB2Hwj075NeNu/lorYXvSOMkHS9auB
	 ldCuQDYr7D+f4VaTLO3CfQy/5kUEdGUXlzJAg7KdS+dglzdu73F6KTd2RLJIb2jU89WUc
	 bP2zmK55Rwu09PyLJxzL4gxeZLhFABjBdYwx+f/wZnj1Y1aJcqi3RHD6keUrS4/n1OrvO
	 Be3MURN459Va7Oii2R0d44PxFthHTp/44Xqj4UfVJCPeTFweBJ+QmXfv8sAIKv1m8vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=H20M/pURwriJoIpNGx9Zfy0c987wJiDreOyhtD/Lnu8=;
	b=XZu4P8woRzVmeii9+8lpk9LFC6ifbhnFYjWd8MiTmt5d6PKavBxD0+51yDHGkjfG4XKy
	 fbiLTC6LJC4xTswQXYZOVB9ArBWFmCJCRzQrtk1hGvJPPKqoMFNl/7BVHFBa5Ljvao4bl
	 WLYL2KGDJLroGD3sF2OgOv4ZEavah5ekGuStMdUa6PBULw6ss2QxSEhvkcQDH1/M6rcv/
	 QgBui27F9JezzupoW30ryfM++0NpL6NcpNblm7ZZhq4xNMbJEQ/ROHlqlcBxKTDpiLDFL
	 X2b7/xsENBJreZr/4kW2LBqP5Fcy9FQuT/Dr9IWRpkM1QI9tf2TXWD+i7DD2F2Yfrkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Eq2nEbxT;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AF60A262B
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 17:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 100AF60A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Eq2nEbxT
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3282db206d3so1376368eec.0
        for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794332552; x=1794937352; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H20M/pURwriJoIpNGx9Zfy0c987wJiDreOyhtD/Lnu8=;
        b=Eq2nEbxTjn9ZfyMD/Yfdj/CeIKP4kq0vcedjH+ZU8mYB1QYYsLbbvxeB2bsA9IdiEc
         s+WrNBzVb9oGJHuGF1v/LnmEvVaBeRt02EpU9+sbmaYMTtbDqc+DaJx7q/pHc4eSeRx7
         ZnuOfwJSilKQ+LlVWip/ALZi5NntHlSakXvhi1Xa2Dj7NFNb9bGfALDEFlW4BpwtOD5M
         fcswBTebIlTBC9HqZvHqGv526RSk8yBY18rzLllEKoY3AEfYxnq8WTORbZ+xQ0/xcp0O
         +qd/vAyCLCyNCkqi+aaKv/eF5HcBn/ot68SfE4Md8As4BaEL0ZAADfPLNJ9pgV1J8anl
         xgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794332552; x=1794937352;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H20M/pURwriJoIpNGx9Zfy0c987wJiDreOyhtD/Lnu8=;
        b=GHXC6sdA5folKsoy9L0mdEKecNZsLsGqxFRhR2DY672kWhVVlrHRmN/glKWa/vMeNF
         1bn8+BJEKxi1RI459/zKQI+rsGobthlqGCB1AZrzUYtM6v1nAghIWZ1e9I63GA/zUnIU
         Pk0HhrfTpF82JA0UhqH++HKhb+E3ZdF1sRzBOPrfdTwEvesrn7j+7vDX8NUR1kDeB2Xd
         BWbiZbQGE0clhb5Me2jrp+9Jy6xP4iYOTnqaumiST2rc9JX69wHIIVhuBwegl6xhPDLd
         kpAyiOxd/8WdK5Cb5pZW1GTw4UNR1g/O1qQrz02EPsYu3e2EF7ky025Av+ocVZ66woLk
         QGfw==
X-Gm-Message-State: APuU4Z+LtjDlPfoUhDDVwHsfVFyK1b/RNPubvmGul3DLiscSxiBi6fc7
	uYEORpYR/G5wnWzHQJpzp94InqNRC6D9+Cqv3nvMKjLCxIqgTuw39gY=
X-Gm-Gg: AYBFou3SQOmV40RwsBYNzzMZUO/sb1ehOSvwTzmkHh0cZGgH8LhX6bKbCdmn3EjlRoe
	WE33/MuhzsM1IMukrozQNXOeMjJdyix3i88Zn2GxDxoPUCbl8azIFIHVuA/5d0q2ccyqG83Pucd
	BU9J0QXT0H1nnKSkyMPTJ0p7YVfbKHwJ7T7HGNU8TvrCizMXukR/wzD7DELk7qFFQjtnUXBUjHk
	wwA0ULVuzfvlThy5aXFQ3K5b+Chp7VgQ5v0d1C5E/kv8MbVGHo4w4YRbd14TitUthtwTsafhNNt
	Z/lbCvmNc4Azt/mZDmGkY3El295WHhvrsGwUbqvNUX12d2Xp3WLceMMdxpawKZxfiNQcrZ2YB+n
	SpkwqKP+t0FvZuHP0PQOIWfb4zsCzEFmhb8ftFP2lrrTm8XQR2NlV3aOdVuqDOYliZZmmLiKlqp
	l3WxRP5acMwNgbw1UipmlNhgAWlOoJ//I/tmPuzyOhgY5AufBvSTEg2UYieb2+NGeSzaP0x+eAQ
	0FEpkjfNZsPQr2DmXqwI4K82PEVPueml52NCMeqOVY5r+8smzMvU9p5IDiJTN/ZmuWnptLagLlW
	2iaDaltyBR2yOS5TyHDj5ACGmQwRNrKWyQhzF1oI
X-Received: by 2002:a05:7301:a01:b0:36d:a466:9d0b with SMTP id 5a478bee46e88-3751ef7c90emr4339398eec.19.1794332551928;
        Tue, 10 Nov 2026 09:42:31 -0800 (PST)
Received: from github.com ([20.169.78.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060dc0csm9800224eec.14.2026.11.10.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:42:31 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Yingjie Wang <x-professor@outlook.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1794325665.git.x-professor@outlook.com>
References: <cover.1794325665.git.x-professor@outlook.com>
Subject: Re: [PATCH net 0/2] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
Message-ID: <688195ef-0cba-78f8-c4d8-34ecb5dd93ef@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 17:42:30 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Yingjie,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_diag =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/428510=
62713

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4e0f336c0083
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1207430


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
