Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001359;
	b=gf4zmV6AQcnzx2GH2Ql5LtujIMijHXvq32w+R3/ceMHuL4ZPFVGHCYc9xqsZAf4TIQx/
	 K0YWhb9iN8b5y1i65cJpnm5oqMvPsSw1SwlnrjXHyZfc7WMnjd1aurGwWIBjc5/NRQafA
	 JKFK3rCNUjdYVEOFZ1dt4Rh3hLmw80g3QeaBYk7StU0J9bH4frTEMesz9d1Ku5JbWEn0X
	 iO7wbGE/XL6ioI1093MxnYuv4V1MbUwS/vKGeR8hUQvYD2S18aFpbMJpI9RBOcAwVDfkT
	 ZMagNvvlpkzJr6g43zTodYGWn4rEkB95Z/yB3JiUA0gFvbDbP5Lch3rF4F8pftL/erA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=Gn6AhZc8xo0Bfogh6Zw6XwWQdnoZ5v0ha/fRQfO1A0Q=;
	b=LnhHzoMo+HSI8Ow2M8Fic3biAMBhYclBp06eaooDaQDvvT/8oc+CpfP6lyqFvUZutDez
	 faP8rB2fRyv0b/yfSgD8KZIrzxPo04pOxkNm98gxBOmFjpMHEtZPb5Crt2z/Vmy0ZB0Ye
	 iQU6/lJD2YGBfjrSm6HOpmmul/rxvbRPRrLXICeMRw1/foAcS0f+CUTSnrRFiBZR9QqNZ
	 G0BKiZCScm39lDwJC7aNktb/NccrAUG1xN10wioetPsTU7mwx8hSMXLcvuCpgum+NtdxH
	 DS1b2EZrHl19BwaUcilXAlRrEBBazf9y9OoLL2V+HX2Kf5gAyNN1xe4F0qq9n83XLiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C7wiPP0a;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B37606A31F
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 07:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71B37606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C7wiPP0a
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6faddda49e7so2330480eaf.3
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793001358; x=1793606158; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gn6AhZc8xo0Bfogh6Zw6XwWQdnoZ5v0ha/fRQfO1A0Q=;
        b=C7wiPP0a82U6bdEeAxaMoRqU8YRUpI/9Xp7VxBoGqjQ5562GlxzQPeVPzQ0kWPr2XA
         NzI4oOmKxBdKPyyepcwpo/QzWsOgPrwn2f6B2dSL301ZUp/ho6qLU2blLguiEdRZHhvm
         0EfznOFJKy0iwXtlasbzWKXQqCehKL8eHOk7Y0l3IJlE0paevTlvVfpH5oRAL+OLpgL5
         AELRXV+E3+RfNLzJSAROPIRryJcYoOzMkwZQN8CypDaEytf0f9mKlLV5drH89mh8wseu
         0kuJvXBDt4GtnrY4qLqi1ViMGgIhEFLhvDGPZS5dINEJezhjGRt1yJw/Z4ZRTwnWBR2t
         rMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793001358; x=1793606158;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gn6AhZc8xo0Bfogh6Zw6XwWQdnoZ5v0ha/fRQfO1A0Q=;
        b=qbsue2KyWNnNJOp3eXlsQrjnDTHgWbgw2GHVXuWmPMJtFwqzCrer1DRvnsDEJ4zMZW
         pO7uRu9TuIwdfqpyl+ZSH7+dV/u3dpk2oq2UiHp2EdY5Fw+H1EnmXyPFid0uLwMKSHPy
         nILvPjJU2rIVNajeSdpqJAKj1gYIoLb1NVwj7Jvq6FqWSWyQOe0YsgFXBnQLnrbEjcPb
         61qDTVn1lPmeNNpDyCXYhuoYnsTJVuplDn7vjNY7mlg/zk3TlFniEGDlaxkK01Gu45pM
         +wRMLh1rs022rdLRU30OprxO2tvLtKzafbPC8CTOyqfno0rk+VKoJfi9qxnWZiWiGg8K
         lBVQ==
X-Gm-Message-State: AFq9FYKMK13B7jgQMVF7dWkKO7OFSv20S8Ugj/4BnR0a37kRG+qGN+ha
	+GCqTT/xpvqkKFrPKx7lvSH28OJDr6j67r2X3w0MITRemC3eC4opSaQ=
X-Gm-Gg: AYBFou1XX+mpEs9i0iKKAJAvEifUwd9ikuLPaaxNGMteViETH73b0Im2zBjXO7ZbQCn
	/BA68sjcwPK3EnIBjzJzmKwhFCrD4/txxJgae+gcA0iOInlesFiA0gZFYGuG4Zla+HxsDW2MFUl
	mDOig0AWqbSH+Bcl0C2ofg/vso1kU2Q92YQmJvN95AVMP3PPFs6VHC7E4+FOfhIgO3CTMSFjlTO
	jhhDjeU6g5uPMXCSoBtYjuSKsqwTkWOgRjCb8OAi/bv7vtMZPXYNxVQw2Zj5Iw3sKgLzwVEx3Fx
	neu7RdEt6+ZTE9Nrh9eLNkEdXt35sBx+d9oS8l2Z+uVuyPnOS/BbI5DMFd0Ioz1ZOezmoBYVEpH
	kLJ3NsYxsqice26yt6gu1ogU+XlcNl9vXibRBGcXnYJYq+MK6BLIhC5NEJfCk7Oor226gLWiqWk
	vvEgCjSDa1P61fB2zRlpn0/WMBSxnHWJLoTSvEaN4uGsAmH7MOZRBs5jC7cwNT4/PzwmwlGPIy3
	44i9sOiOFEDuYlEmXnQmSFB0HY38xL9qKS94eDLfPQh2wyv1NnyVzE6Vkx7B6dJkA==
X-Received: by 2002:a05:6820:560b:b0:6e0:fd89:f011 with SMTP id 006d021491bc7-70ba0f61d54mr2047667eaf.65.1793001358370;
        Mon, 26 Oct 2026 00:55:58 -0700 (PDT)
Received: from github.com ([52.165.59.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0749dcsm6782981a34.11.2026.10.26.00.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:55:56 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261026063657.2955783-1-anilkaushikwireless@gmail.com>
References: <20261026063657.2955783-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH mptcp-next v10 0/6] mptcp: pm: in-kernel: retry
 subflows closed after an error
Message-ID: <6b1f6c26-f6d1-b705-7ef2-809d36df9f09@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 07:55:54 +0000
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

Hi Anil,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/40283088555

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/2501a10521=
1b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1193404


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
