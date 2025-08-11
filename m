Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E72D877B
	for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942724; cv=none; b=fvhD2QvHor13btYpqREteEzUaSm1tPCDmTNTzcVyn61fChj3sxd6XyKcMPFY2k0LtncI7wRgWcYzHk4UikmaSZZIouFrME3oZmhnzBb/xWUdJmJCASJmosUXwcplT6YEfjvVgK3RPfyCYv3z+ylfSAdO4lLlg4P2NYVYK3qX4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942724; c=relaxed/simple;
	bh=RUK3Bht6Kxkdn4nEJnzf1Kpm77iRAeFSZfn/fzG40BM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=DnqHRTYz/ucif7hc+hOuLRnTwMUvBYKXNb4VD/nsPmz14S2rx15+rFIJjg/4r9Ga54PmkaqEdLuGf87iGqwBY70hOt04aBuUIs5wWozLdMI9LIGsl7ULALX1umQnw66xm9LZZigOIinnDZnvmkgTfvU07g1tneNpLgXwJzDKTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTw7iVbC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTw7iVbC"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-769a21bd4d5so4458285b3a.0
        for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 13:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754942722; x=1755547522; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5SOBA5cRBzTWwljWt3gRJo2nnNwtZkMn7In7P1HLfg=;
        b=MTw7iVbC/cbuPSgiSXvnW6dY7gfBeccknfZyEn3Zu1pHw2nuKbGinXP7EhyjvJrMl2
         1qOnIbuBgHmRhAc4a9/zR5t1H7Hqjywufjav6PYe5Srd2bH7il5wEVXKoKQPVo7vrm9r
         EtznAOmQN9Iv8qO9OALvb1His3KORvpNpMXaQQdk4/XmgsBauBxNtZorWRAWZEfy0ZgT
         5ANGMf2w01LrjMbTopabG/gGYWXbqqrwAZzaLeT4y/lMluMYhv/ZyV2nJAd5UT7/uY6A
         RdnWm/yves/afzH3shwY0Kn/akXPpgds9CrCnLLeQUZUiN92E3fr9hDSxjOjc+IGAQsc
         LBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942722; x=1755547522;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b5SOBA5cRBzTWwljWt3gRJo2nnNwtZkMn7In7P1HLfg=;
        b=b3GFl3tluLltEQN72bIag5XXHaGekcbblTukHARGaMt0k6HocV0jGpoX4hvxCEs1VM
         6jCclZRKc6JkakfTdMSnteWdR6dbn3IdrnS4D4jkNgimkX5/FcNDfY0x2hmlTf3TteQR
         vRpyLnqHm/B0WaphDquoc6X1QdwoABIHeSTwCCtUfDQ8CIR4KmHGfn01iWnLMeVf9Ixq
         y43kEk3FcDMvfbWOHHY2JmVlyeB8OeQ/fW7Yip4SLksW8DRitm5yzxa0lU6N/UbTar5i
         zAW+FeuCffl6rCWhNl5WCssOHlxmsrL9fLBLmmMzoVQy74Gk2AzEZ7VljMzFTkKPVVVL
         dVAw==
X-Gm-Message-State: AOJu0YyUp3rZesP/oR1RX6nIIgGZMhr+GfuuJ+yeuXJz5S9K7yeh0/Oq
	iAUa/Knd/AQCvBP8KYlIOjiuaT9FjV/Mv04FkJIGQwPqG+ZF6ZLzGw+dZdfi
X-Gm-Gg: ASbGnctxk++Q0MiPT1KUuIdCy60g0CFgwW5S+SHbiXyEs0KoEeutQZP7m6THBNYwtnr
	m1DKHfnI89IMl2MnyPLdImzQxDz0Fd6YKmcoA1iO5FNNC3i0kixOjARHP8f/jcWL+g9kjApRm4S
	TAx2jDHEb2Df9xc4RVpHd+TKuyaVbXWR8U4qaqbDosovxHD0zgJEGQmefGBODMKX7WV4+vDLVMq
	dFa0k5/M1uWNfQ7biZi1gyO+PzNm3FaGGeoLEzFtQBA2pVGGT4pYy0emIegVBQhnG3nedjeGmT/
	ya/XUnB1TNpXSJEVajaYOLLORJNZr14D1zHLd5gVCT4lyLuFkSv0fVzpwuzguhLi00Wx1BCJ/NS
	kSAnlkCioa7/3FB5RGM1ko1TLyH0cEN5UUzIbjHAIdBeIHSfC
X-Google-Smtp-Source: AGHT+IFhYpYe4yDNwrAzt8Av8wgZQS8eaGWsxStkPiIBRYKGdeD3eNYImQNzPZ7JpUVg5eGtGs9VCw==
X-Received: by 2002:a05:6a20:a10b:b0:240:9929:d8e6 with SMTP id adf61e73a8af0-2409a8e9a6amr1078338637.19.1754942722401;
        Mon, 11 Aug 2025 13:05:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd6aacc4fsm26393665b3a.118.2025.08.11.13.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:05:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
References: <20250811173116.2829786-1-kuniyu@google.com>
Subject: Re: [PATCH v2 net-next 00/12] net-memcg: Decouple controlled memcg
 from sk->sk_prot->memory_allocated.
Message-ID: <0ba13037-1272-6508-6b4d-8631aa3239d0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Aug 2025 20:05:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): selftest_mptcp_connect_checksum =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/168879=
00670

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cdda85bb77ee
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D990160


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
