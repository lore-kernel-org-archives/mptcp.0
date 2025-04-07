Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13064233120
	for <mptcp@lists.linux.dev>; Mon,  7 Apr 2025 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017238; cv=none; b=pytOGuzwF6D9TRNbzizSdUVByk+Ke602u6DNQ8piVKKdrgSlR8bvGz1C6EIkCCUV9VIIkmffCzYWpJmyyMMaM4GpbsghadblU/WQcFwi92VheIT2FGFt7QACGyAUqlsVgvduN6HTypGbG30Qq4fyQJg8PfD13nLpyOTJlZ7szxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017238; c=relaxed/simple;
	bh=vYoAQQ+OYl8nPeUkg3dRn4Ys7Gq86w8ST0p0FAMPXRE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bfTyolJTwhvqR9HjM5h0gf1bxhrXWZOZuszCkJJPKuQeq5Kf7B/OG/p0RZZ3NRJeNHONvej22a4s4ecWpZIg3HhRVOhnlSdU7vvhbcY6DtQUUCqluN3NhJQGuplyEVebrbBgox88+t9z9qvlxOQ4hoOYeeu73mIAYHOxkyX8UG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBKtlw9U; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBKtlw9U"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af590aea813so3706428a12.0
        for <mptcp@lists.linux.dev>; Mon, 07 Apr 2025 02:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744017236; x=1744622036; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNLddNFr/sOsSiH4GQqMYoHJqq54RH23frvqIV/Vzmc=;
        b=lBKtlw9UQlogqfYUHFwdtYj7Y6sHt4hggd9JrGXabC/Xo1LdUBOrL1fKKcfWggcmUl
         WRlOhQ3bM+GUfLj4qrRLWq1IXJ7Jee7SnWXyEDxiVeso0TR0VqM0x4/FA6U8cd5hV6xF
         ZDpyOdK8RecAqJ1vNrmv5ZDROIBmq0eSrV/cLlTTHnZwMKngf30CBRxc5f5dAMD9fnsS
         rqwJfIcDYoP3EFdMVJ+aH7QwDYRcGv74hG/H5RfPh76lm5TH4igAYhhMkbD9eTQsFgR+
         1gBWtTyI3+pYuBT9NOpiTUUaQgVUvMWdR6t0U/AeXCMTCHUyJTjpbyB0ZYlB4M8LUAtx
         /C7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744017236; x=1744622036;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fNLddNFr/sOsSiH4GQqMYoHJqq54RH23frvqIV/Vzmc=;
        b=RXA3+Dp2RifrbQJFKbATdTOT4zb8Z/bQI99gCrOAmv11gM7pxuVYEtbPGUdwy6aUvC
         PeM/qvi7Gf8HA9WkAkxNzn/1FiBmVYf3TBY83idcCEvXIL1xywIF85XeP4w78AYWK/++
         1yfafzfndqJlpHJP4jEffPfm1iyh8jE0AMRZERyBAfUDPadqD6lqXZHqH+g7J5kJFcMx
         7BjXICyLMZX0ONYIJOO46daTfKxLcOteFNEYAQ/7aoFWAp2jyr1NrwLjUvNYe5hiLJ+R
         2unFiC3LRjHwKqyBmxX6jmbzrGPz1439irAgGzYx2oPo7G4hpf9JVXChZJSxIAcbSoQy
         e0gQ==
X-Gm-Message-State: AOJu0Yxl7PmBG+FMv/IYP/dJGChFnfQ2l2LIaTfmYr+IFTRkYhaiIi1+
	1IlX7Mb5uDtJkwdAb9CQLHOowxXRCZDqT8Ir5Jvi5bnzrkcOusV2K8QD
X-Gm-Gg: ASbGncvKEOrzxxxm83a2rR/KkgPUH4AsgQMYbYSB0PVtNObt1nQGV8PQHQ7u0QOUELF
	dRFYWDjErxmv1J2Lytd10ml8T8SEmHjWe4Hb6QuOVNczizJ179pzeXKYJEPlWFHVW1aUPyzlsKL
	ItDcxVYUZ6IaqLST2PgN+1RVe5idKksW/sk2i3p/wYxcB9LSgZzdXWZnXJUpXcuJGLGvPL5nAOy
	KFv131vz6TzzWg/UC68cl4ShS8yR2TkLQV53fGXVI1jeao4h/zmWPO8s3MZjB5YS1RWmGJOwo+v
	TbEhu53L9VpuKnb8REzebtFGDgMlWnb+PKIPrJHhbCHt7oARlnFoY0uOKE9JsaAvErbJ
X-Google-Smtp-Source: AGHT+IF2DgSs2rBG7e8/9fnZiYZ4xVhBmTi2hnE+3fIWTIZf3muXfBdDmP8bCWWZWW0N5clrIGgCeA==
X-Received: by 2002:a17:902:ef02:b0:223:3394:3a2e with SMTP id d9443c01a7336-22a89b8dfc9mr151782925ad.18.1744017236183;
        Mon, 07 Apr 2025 02:13:56 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.33.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978777d3bsm76478125ad.252.2025.04.07.02.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 02:13:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0a7cb982ea5886c2f00e69703feb92c3934dcd63.1744012385.git.tanggeliang@kylinos.cn>
References:
 <0a7cb982ea5886c2f00e69703feb92c3934dcd63.1744012385.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: diag: drop nlh parameter
 of recv_nlmsg
Message-ID: <e42e4adb-7b29-c8af-237f-ca0d7e3de7c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Apr 2025 09:13:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/14304160762

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/aead1761a001
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D950398


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
