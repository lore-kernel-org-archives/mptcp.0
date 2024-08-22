Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0815A249F9
	for <mptcp@lists.linux.dev>; Thu, 22 Aug 2024 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308801; cv=none; b=dCFK6IwyvnGoA64omfDl5zf7lDi4NaETUzzfs/P7jz1805Rv/swsKc4k4u0iQbJmp9LJBPPewh2EpHLd07Zp2RiMF/wUKp/CRLuOwVyNLTACKC2rR+2A4oBXJoAQO1C2YPl5wA4Zgf1Ke/6+kVCHhsjd47IOybL2OVYeQFs0pno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308801; c=relaxed/simple;
	bh=LvpruJaiuL9l1drJGrad7RBXTJfvC2uBameED2SUgo4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jqvMkMZHIH877/WjK7a3/3O2lqtS4ujPws4bqSajQMKokiAqc92JsIZ91kKP5BtCeNJG3VLpUKbZI2hCaA+v9pDs4fu9oja6r1IJnE9XBxY2DWkHbIie3k0o0wHoeAbsjBM04B1p+wSaz46xcUlg2kj5JwXlVlTyy4tNO8VsXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdJHb+Er; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdJHb+Er"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1dea79e1aso30724285a.1
        for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 23:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724308799; x=1724913599; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzUddk1Rk4REE/sHCTLMNJGPh1VyXpJkdQQEaABWEbo=;
        b=NdJHb+ErIzbcT7ZUlnsFZRNlSjZeWraWrNg24qoqPpxnqQIv4f3eGxE82NwHToRMP/
         cQVgyzLgO6RHtSCW8zcqRenJiWvtvr2jZkow95TzJByAvG/0s91XOcoSObODk6YwrtYE
         kM4YTtUSOeBzG0/+mFuxauuukVI7nQIYQuUQOYmrgiNdob6MatG/SN2UYltBJouSrhjU
         IXCTUFeVVLRJ+xvMPbGNcHD+faEBVGxu52zymocejWETPafEypl8YcAwgu74FYKl3rlZ
         +oQmXQyHQ7YTb5mP6POG6E4YAzPJqJynhU7HiEXjD7z/S6MkEHD4C4GpFpoBT5/kO0E8
         Dkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724308799; x=1724913599;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AzUddk1Rk4REE/sHCTLMNJGPh1VyXpJkdQQEaABWEbo=;
        b=rU8xrhutADbEifSAEvSIO5VKxezhB76UfxBSzc//EdhA1Zko5nePgNe1GuNlWaFhzg
         C7tGy9MmF94rdxEEDIB1vVs79uF+SNdfyuhLlkaW90TyGEW7WRglg65JBo2mnx7eekYe
         9A1PhK0UjsZIHPNNE/7ytijtKgjQ0sYyzXCpY3bjEjzwHpD0nFrs+tfU87sjF1JbW0gB
         DWtHhV9VjfARI89CWpvAPx1hkWotieACwg6AF+AneOhkEDCPb8+SqsXNA3u1lyjy6J9F
         kVNZGcU08J6eywP+O5J0fBpRTWyPDqOB64rJ0JrJf+1adKgR45WQ4xFHTFO2LZHVZrQJ
         MIUw==
X-Gm-Message-State: AOJu0Yx/qFoqVqXaOfRHahM4DF7lxNtZhlnHkazAhCK1Su6IiUOTRJdP
	QfhnXbQjrIaUNWUVxMUoIDYAruYsDsJoLqSNN4xxZxkEzPjtiEQ4C8Hn
X-Google-Smtp-Source: AGHT+IEFuEDteU65T9GBi0QNI8A5y0nnE6mVeQjJBaNtbIAMLcytTOzi/ljhCAhj48w/0ZveyG0l2A==
X-Received: by 2002:a05:6214:590a:b0:6b7:a3f1:3251 with SMTP id 6a1803df08f44-6c15686848cmr53169966d6.51.1724308798787;
        Wed, 21 Aug 2024 23:39:58 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.61.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcdd81sm4427056d6.125.2024.08.21.23.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 23:39:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <tencent_CD94B9310E4F3464B4D83B0942EA0EA28409@qq.com>
References: <tencent_CD94B9310E4F3464B4D83B0942EA0EA28409@qq.com>
Subject: Re: [PATCH bpf-next] bpf: Allow error injection for
 update_socket_protocol
Message-ID: <5f6e0f34-6a1a-8ff8-e608-f725a5bcc1cf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Aug 2024 06:39:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): mptcp_connect_mmap =
=F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/105025=
83505

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/889545cfdd86
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D881988


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
