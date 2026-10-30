Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331975;
	b=zFhf4dCm+boX98vqd9n5ZGxcGMzRUxt1BybYL6hWe03PjZNjkUfwsnFi1BvGvYQbE6lt
	 zTWRiuYiDjpre7p9yY3BeGmzWw+9pS5BptY+SxQDRJam5DlNn805hwnCTbXk3viTVr9iS
	 DEW6jNFNPMx86Uh79u2weMzbI3q0x1XTKaSMPlicy8E6nTSxP2vPSYZNdZAI7oVJrltOM
	 dBvJtOypXgv4U6pLUGvWDVP0c8Ak0wt9ZLC8jK2ZKzW/ViDJSs5SwA7FOGsNWVZYn9fhr
	 HFWmQ+5a6ELEoshx3Bc9GalOuXe08zQvjieFHWqZCeK1EjbpQDSbkrZSi+Z0RScaWnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=NLws2gmLYZlbgbcqNhNCmy4VAr5vX03BF+CKmE7UvTw=;
	b=vy/L7/npR9qanI9p5G+k9R33fNypjKdcUUsme48GmNM0DWbs5I1z4CpOUBnTEMH0agaU
	 /wQsbK4EU7VEfmf53jbIqnpoVBqNRPEkGAZnMIeh1qIp5V41t+yp9PjTwvr8Q60qhVIn8
	 eJLlzInzXGPWtT6pvHZN9SJ0wha9f+j5FjaUpxvL20CxQXDjFVy1icKf/N887k5tXHt3Q
	 Z/JdO/K7vEOYQqysv/wHkchFFKhVBBGDmmCmHBeCN3WbxbuQebowz7O8SbAAfzyuyjrI6
	 b8COutcmKRKsx3bwIZpXYeqL6wAzRetYA03FNzs2CMSVLlK5czFxMKp7UJViB7nofFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FgVrZ8y1;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A3606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 03:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC5A3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FgVrZ8y1
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso662218eec.0
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 20:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793331974; x=1793936774; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NLws2gmLYZlbgbcqNhNCmy4VAr5vX03BF+CKmE7UvTw=;
        b=FgVrZ8y1xsxTDsmsVHT5rvF1oP7hjPK3d6BZE0+nNxSxxUJfv8FD/jp0BAAGIfBZTu
         lNKCUr8YtB40taftWXR9LaB7M/42OLXSX9Rac4/yXtWAb0qu9FRzdNNYYo5u84Yh+xSV
         ayBr+Ja/xB2+sY/RNyM6NwRyRbrLMxikYVwduDk8MXpXB5Z9qX8bZFfAWImtImkIQBTS
         nuzxcd2HgciZmAovDK0GnZGzbGkpNvSh3cv5zAOlZ0Ntdcc8SuCkUSJTyCcVqIdZrouf
         cgNJQ8qYcYNiUQW+fvyx4mCSbYgx/2uyp/fjn76+7oxDRP8bkIwYXWHoK/QiFuIjNxmB
         Fp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793331974; x=1793936774;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NLws2gmLYZlbgbcqNhNCmy4VAr5vX03BF+CKmE7UvTw=;
        b=GWABlUbPruXkAt3X1ZdE7wLXk64r5K8Ll6NgmeNtxbUAU7GeecvOii5PYQOzmSwhyv
         duRo+t8k5+GraA4HsM7Lux/Dxlx4XmWQCA2UwgbyZQvOWm3bQj1qi7ikf/CtR2jhNYbg
         hdy6TVQe2VAK0rh+298LDVN79NfoLGBJq6VeHwMqoM1NgGVVnf4OR6WXZEv9Zaxjj/WR
         6Ig45OUuA+c+PoWfM+CXPwjiLINfuNsH8hQdQ6fSOldrDqkMG7AhXeg5YFT1hZLOZW5V
         u5Dn3lmZf2FvWF5FkICQ7W/h7kbBm6cpMQNNou9yx1FyET2cxfagSAl1HNRPnI+qvaqY
         N4Lw==
X-Gm-Message-State: AFq9FYLAd2tf5CCviHpBWB33tcBPy52vU+8g37vIhobSndPKa8qh4gHk
	60vnVHw4UdT+Xh8Tf2YSGtsVLtixvzU7E25cakfBvDC/j0xUTsBethJeAOFp
X-Gm-Gg: AYBFou3BKVnBowBsIVTWDrVk9mtHiQsnMRhV98YIsX+7Qrxv5KRNrorXq2+cc2FSvSP
	JKx5AMYobsbbexOBVmNjufzj6H8H+aVfz96+Dqr/EY/5kt9oxdJtNKoBLlqzGTqvbE8LWJPf8gn
	d897MQTfC+h3r9hFOnAL6/J6wcdSSYu1JZ5c+UNKwgpL2aBhmWDvw5xHQP45faz6Tx1tEMluKui
	Yt5cPR1nAl0BDSDQuS+MzJR0zigi8XhIQNIINPNjL4fzVZkpYqOoSWn4JF/aJwnRLGfF0BN05np
	KLNk7wP0GUGC13Z5+qJ2KuCgl46e0xd9uf/XlNUJCH2suD6g/ffPGmMZPTnI876CqYYCrhascAG
	yIKNyPLCfPI5/VONae5oMzbBALi2B3rK9CdpudcJ37A1lLL4I2F1LfASksqlzl+MrujnKjZU1hH
	3RCQyu+GNDaLhZWf5+KHthgYZxj4yjg/lj4xQrvCiAS56JB0TUPkv1E+2gk94g0wrnR4I5BJuOQ
	vL2c/p/+tQYFOpMd5ynjz4OuIo/POl4GUKJn1DXEhHqviO9Gk5IsoV7LoOTXe21LuwesqsakV+W
	G9SpHVVV4N8VG6+SqErH+p2b09R9xwyVCE+OXl5T
X-Received: by 2002:a05:7300:3b1a:b0:351:52ec:60ee with SMTP id 5a478bee46e88-36a423f04b7mr2738540eec.28.1793331973751;
        Thu, 29 Oct 2026 20:46:13 -0700 (PDT)
Received: from github.com ([13.78.166.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm3354911eec.15.2026.10.29.20.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:46:13 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793324316.git.tanggeliang@kylinos.cn>
References: <cover.1793324316.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/5] prepare interfaces for kTLS and
 sockmap support
Message-ID: <a36445a5-6cd9-7419-18fb-49d3c082c80b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:46:11 +0000
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

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): validation:sched-weak-secondary =
=E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/40989995090

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/5281b205a3=
82
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1196738


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
