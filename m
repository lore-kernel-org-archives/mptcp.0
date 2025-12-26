Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CB21DB356
	for <mptcp@lists.linux.dev>; Fri, 26 Dec 2025 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766735479; cv=none; b=TefvhF385GME7lTMTL99N114UXGhq5P0oMfz4/va0huUvwIIvnibkMZCnv5cNf8z2bOHk+DgIe8TGmZo3PQOKxONcPDKbUsr6KuOTTh5ZyfnvF6DbGzJRTRX0ZHM8fmwt/S2jxhEntDwQmRET97hDETgLrfZRUzBCfYj0ydYCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766735479; c=relaxed/simple;
	bh=bSq5s6Ug0HyFfQS6DgatC0td4yJrdZXIOtbHPJta1gQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XZ/cEHFPE2UtlQXO3lqh7qIM/uFJ/jIINIqepzEHQP2nbhhrpzGudqdni2ZXelAbDo/ELne633cqtVcwOqMpRgxn8MfxD6tZBQYbJlXDB3rQlBCnJl6RqTLIPV4+YZi5yqvcD47NkYp76Cw0cO9K4lXyy8Kb4oPz5a+VrAxfTMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJIhvOAf; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJIhvOAf"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34b75fba315so7900680a91.3
        for <mptcp@lists.linux.dev>; Thu, 25 Dec 2025 23:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766735477; x=1767340277; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRvM7F79LFLV7sDEveYTHXh8wxIrnegim3tDxfUzc/g=;
        b=EJIhvOAf2TpyyP+cyVR92BwYdUk6C2J+YKZ+ODJIAD5Llk7wp7kBlUA4hfZRtDVI47
         jQGd7ouRGu8PMiffE2xT4qX5c0hbNo8mv/F7v3Ce/0/qWhKbDgou0ht4bUoInV86PB5U
         JxYLFdj3J50G0JUvFI5UKz/gW1gIPlqMQcZ/4hg1OhossYFqC2Fe5EU4Ci3LJtCubvOg
         5ZUFWWuPhriU87eMqj2AGxkKXQztpuNBo6TcL64FgR73iT1zeqH3r5tC1NWDagpnUbZ5
         an7kxVri4pA8hBDD+H+7zR2sR88ajUy0JgDfA8kAAqZATn+w932L5JrukzI0U8bm1dlu
         wohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766735477; x=1767340277;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRvM7F79LFLV7sDEveYTHXh8wxIrnegim3tDxfUzc/g=;
        b=KAls0iKPv4/TDRcx2mAo6PYQYx3f6hkGWv5RIu+u0sAofIt9Yp/jw3G7BCXBuEGIPU
         TFVn322mtxMjySHM1UuX/t/qmlCspn466h3QAGTTBtRUheb7ADgeS4SzBlvc0KXxrUr3
         zpKGyIEwZrxTc5D4IY4yRkFtLgr7Z7y6t4wyeBEm6kIhxTMkdbZN/dNyJytOwlJCCYP0
         70uh/nwBPOxrrxAM+WNMbt3icGRz4j+AmXt5Z+NJkg5YOOZltUNzM/ri+uCt/QIXaznM
         RbHLPTKTtAUCDIMihGir2yCuuOWgITjzUaJcJRQBqerziXBsj/VQYed1TqM3WuOUOiMN
         /YsA==
X-Gm-Message-State: AOJu0YwQkK2Fmb1TwbbmWcwYzyWsDajm31xCAtnRxfQSd2sI3wrl/s8r
	7/yb+UixH1coeYn7UBFTCxLqrDree+TUbRzLNfZU3ZAQyyin5vXzIHm/fkxPBcw=
X-Gm-Gg: AY/fxX6r/qyt2DdAnNQtOvRvHO9A3SlemZUAUSIuPMlr/2qD4DwOuSo28/L2mbh3TND
	QOyCu4C9+BboUDfbn6p1dCesxT75tXrzQ3Wi3s8XmAAOXp32VSzAASxKUDVXWUDOGUx9gHFfJT5
	qF7GBDFeCk+xGBH6vJmSJwBA3RE7JC93qZoEYO3Bd7zU7wL2ioUVfhPuzDRIaXUqU3yxWWbzNsR
	ibKdBucIXYe9rO9jm5Dw46ZDb4Vw9m996Y73AE2T5Q26jVL04wvpNLitqZe23Cs+iTC9L6p5RBO
	UMKALbctcxREb6MUUrxH4P8J2i2IpMNBxNmNQaiSxyeP/E0Z8EM8CyG1rxf1PMi0Ulh7h1R1Ew4
	/I2hFVkQbXIzlHJV1xEtprUIJ03hRRUIB07zoedPA4Lrh/42fPHZSFq6JXNHYZtpwof/PlZ39Yk
	8sQEBXnKV0a5f3rHnbL/D0yKhY
X-Google-Smtp-Source: AGHT+IEBCv+RUSbaj6jBPeKw50y20Dh7RoJ12lKkcGRPQIsKhTTOLS6P3GRNvOs1VpQxKw7X2ZPD7w==
X-Received: by 2002:a05:7022:984:b0:11e:163:be60 with SMTP id a92af1059eb24-121722ea15bmr25277478c88.31.1766735477278;
        Thu, 25 Dec 2025 23:51:17 -0800 (PST)
Received: from [127.0.0.1] ([172.182.226.67])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254ce49sm83231957c88.15.2025.12.25.23.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 23:51:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
Subject: Re: [PATCH mptcp-next 00/11] mptcp: avoid dup events + error +
 misc.
Message-ID: <bb7d906f-b19e-12de-1091-53cd9049e023@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Dec 2025 07:51:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/205179=
13570

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3f8a1954c920
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1036645


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
