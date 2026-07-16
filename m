Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3FA3596E1
	for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192798; cv=none; b=uoLKvPOx5Mv4T0uT8h4rYYLqKwpQ4QHET0p+OkvHpl/+72kFNXPQEdunBoEA5HvQ+QJc2X5pXyvYvdIuAsmXDXhPOiQBieEby5tfe0eCf2eiaE6ivl0MEX9AVDgUrj+WC4iqevIueFMqsf7gBie0lqu6Bm+LowBm4omhHdmsNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192798; c=relaxed/simple;
	bh=MZSk0QD4fv5N0FGMc+6CokHCxGToFU05AbSGVf9ISPs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Xe6kIl7mz/lcXETbEINwZGXe01nQCyroApkoiVWz/kifqAuXPe4/7AdoP9q5Fx5nk8zl0HvbSlIi7C+X6eHgYkhzeKb+ZhkyegFLH9LtO1AFEam+al1qBH0Vwsq0J1i69NDPcbLIL+PPq8AsfIz4PG0OQNOd3ce3GVYPLll7gco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ+cWwSw; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ+cWwSw"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ee6912d86dso23002696d6.1
        for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 02:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192796; x=1784797596; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ubVXod3zq1kUZPqas3xHRIETPWhBKW0tzXd/R9+PxGU=;
        b=DZ+cWwSwj6xlPGpaUN6Ee5PD4avWj6e+2XFEnnwx634CYNTQj7Z9IyA4bzmfjSr0EQ
         gwqCjuUUIpR02cb8o423YBJaUDBY5Ql9NbVCcZIeKyu1x5hRLA5vphDIwohnnoc1e4KH
         9+JHDDZ4XuneKgr6Xwtmz7DPHhifhYJ9jKAxmxNKdKY80QEcpLkL5lwGmXGcoaWaFpgv
         AjqZzMaBZpRsm7VnPcWUNi3I9zYjGUjSgOtMZ5sUU72FAX0AiAPu+2sy8w9yH7cOpOre
         /IpHwDgtSU7o+pN+GLlLeBj/nTLbEgggEV+mHeJojRhta68kEkBgfdju7Yij6QwEYQV2
         f1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192796; x=1784797596;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ubVXod3zq1kUZPqas3xHRIETPWhBKW0tzXd/R9+PxGU=;
        b=TtIuhfnJ+aN+DxMbdXvErkJmBdzWkX8CeIFPP33vuYtlWiKcjb8vJfb3I305VaP8km
         9nGzZAMC3tpSNYvoX2wqgr8IwqFdrb9ZwDYcPbXtGbaZ5ziec5bHWcvWzpAYzheCjO1W
         Ycm4y0oNetCjcdWYMxr/Mr5QKcpIzHGw3jnDxG97Fsat+ArYL/1QrXQE1flSMp03WWw7
         KN2rtB97/i6H5M3NmCiQlwdbX3Fct1XNuBDmOpBgT3BkQh99pwxB2A/OlbpfQ8FlR/KO
         ParT83FZ+fe3OXF2FUMN4HuVDOmudxSSjDE56NEwZ3wBjOyxBYq8p/Hs/oEkgeaQGj5E
         ZpQA==
X-Gm-Message-State: AOJu0YzCzIJRMcdBX4JHvBY8S7kgbk1p++Vl8Q2kcROKRqWuBH54uv6M
	2Wa4+IQEv8I45dEk0Hu3W/DmUhj2SWxCryZRjKWb5eaLth2YnXWUZvhhVWFX
X-Gm-Gg: AfdE7cmAgbGu88snm6b86BSibfem1FcWX00qMXDiUPDFt5rA918IhgJECbpmSuLZv0n
	HOccE487zlYQkiuvBdBX5JJyx3FgXF/dMO3zpdirSGgxN6v9E13tZFDkbAvSOXl0tSiTu7K+m2b
	csZXnscy/IHZE5uMpUQVUGHxQX+BYmUb7JlAM5+yiPwaYA/4za7FcYuRMNUA89HirxyFcVOs7Wx
	P/9e5Kl7yqmPcuw8R2SA0nmDEfNJ2bREU5kQZtcYXwm3DEXSBgJKtZd9JJ4LD+BK7EV2qOcU61Q
	+6yAaKFTls2K8O4RsPYVgS89j8I55mPfT2ptL1TPwkhRvTsw8CIkhO3V3Ldtmh24GrTOpK0PnVM
	55rogZyTblvxmmI4kB85As+WxjnnJekIrPvGQiVmuwsqW1NX+UJMh9WE3TP8F8cMVDL8EofgbDl
	I3/DxEGMvidp9V54Me
X-Received: by 2002:a05:6214:4e16:b0:8ef:5103:df9e with SMTP id 6a1803df08f44-903fe54570fmr228526146d6.8.1784192795944;
        Thu, 16 Jul 2026 02:06:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.156.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90313c322c7sm185098946d6.26.2026.07.16.02.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:06:35 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1784188064.git.tanggeliang@kylinos.cn>
References: <cover.1784188064.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 00/10] mptcp: add MSG_ZEROCOPY support
Message-ID: <f5afe964-8346-c6a2-5f72-fc969713fa00@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:06:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/294828=
90291

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6890940ec099
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1128612


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
