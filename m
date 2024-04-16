Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDEA129A93
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268879; cv=none; b=EhC1UAyTf4Gwgfsywk/31pu94OaRwwU7OXZcXTBlK1cTkSp8kfgXIt2HY7Zld0bc+1yO0c0PLdyUPxDSyvPtC7vpCZPJ3rbjgS0ih+6PMQpIcDhpqLXOqemGws4IG1Yd2l58raGujAnE9L6tEiBFS+/8d2H12g6hC6FNQnP3yzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268879; c=relaxed/simple;
	bh=P/4TidhxCKj+nPoFhG7Jly0Al7PGCpB6qBIlZVO5Xpc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=srTS2SeyIzkpR7iSXOY5uNeoMdfNrDZF4hhGvwQqC8xmWwbTGp+qKrxqKY+rk+4/klCAx9a+G2F3k1WiWnxzs7JDux4bGWLQpjd0kvodfGKTcJB/RB6a4J6fkHtUdqgzRJ5QG6mLwLJNgGwkUBsOKw2Sm0k0DcbEN2vmkZm1Nkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3pcbbqQ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3pcbbqQ"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-699320fcbc1so22614776d6.3
        for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713268877; x=1713873677; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vb2kPWpFmxdghMQEoLrc9pAxdyrVsllhI6Oz2DDf/E=;
        b=I3pcbbqQVrk6upgPaQvIEsHjC9STQYxv+Kbm8EK1rNJYtZfitntJqfwehbGxsTAZpj
         gxwjcu9Ut5UTU2sgloLrVGGfBwhUMztFPHGs/xRiuUklGK2JuLzppw7hYuhF57KeyodO
         tDNJ2L9TYXt4gA3F8nRmjG9XgygvPOCjEesN8raEJPOPHirhjpdzk9IY0V7ZLzKZzLyl
         dxgCM0tRW+1XdEdPlL2IIaJf+1tywgGWdofpijz3WXnFqeoEBSKdbX+dhgX+spMxKC8C
         S6OsoO0VZL/j/7YSJ38CAzHvZse6YZG9aSz0MMAgaVG5Mbno4GoUpBM6Xz1sMeA8zhra
         vryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713268877; x=1713873677;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vb2kPWpFmxdghMQEoLrc9pAxdyrVsllhI6Oz2DDf/E=;
        b=mW6fSbSBpyI5jw6EJgowEGScFhVrPOrpupkchp3tLy2eshj+n2EP61WXUJypjH6guN
         Jyf7qu4Ft0f8PCX33G0ZhNVDdYAw/09i6+7IZ9zz0Gu43EFgmKM3Jf5JrxoU8FJvBGw2
         hkWOWguzhoy0zvspCiYg9mtAWSWlkz6duVYTZ9HiBawpeKMy+w+3kH1H7XJwT/iLW/fJ
         wwH8YWpr+vtAaPIyd1I6deWY1QENoRBEYgalXMGKSRvRPK1bc2aqxWgicifc9khMhN+k
         TVi4aLBUID845JOc6ZPrST8wwvchwRNr4EM8nK06OjOQZb8043KdbcNEFme4UdIlBzJd
         gKNQ==
X-Gm-Message-State: AOJu0YwUi2JxeXFzvoTK3rwqSRm03RbWFc+dqz5tr8qcC8YPf/8a36ci
	5xd4+4/7H9Ll4HNBIu/gu2ZJA7wtX5zVtLz3OXLPbbJvJXwy/kg/z1wU
X-Google-Smtp-Source: AGHT+IGPRfVCfL8MTYz5ttMT9dnMdid8ei11stsOQv09QoTqj+A6Btt+4x60+qIqKymdLqK491yajA==
X-Received: by 2002:a05:6214:5983:b0:69b:5475:8b03 with SMTP id qp3-20020a056214598300b0069b54758b03mr20192322qvb.14.1713268877088;
        Tue, 16 Apr 2024 05:01:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.126.32])
        by smtp.gmail.com with ESMTPSA id e15-20020a0cf74f000000b00690c77505bdsm7341231qvo.37.2024.04.16.05.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:01:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240416114003.62110-1-kerneljasonxing@gmail.com>
References: <20240416114003.62110-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v5 0/7] Implement reset reason mechanism to
 detect
Message-ID: <4a731ece-df3a-ed3d-76c1-5be2c86ac84a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2024 12:01:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Script error! =E2=9D=93
- KVM Validation: debug: =
Script error! =E2=9D=93
- KVM Validation: btf (only bpftest_all): Script =
error! =E2=9D=93
- Task: https://github.com/multipath-tcp/mptcp_net-next/ac=
tions/runs/8705084721

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/83268a9f6efd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D845019


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
