Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3B39DBD6
	for <mptcp@lists.linux.dev>; Tue, 23 Jun 2026 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187654; cv=none; b=uSbqVM3BAcT+MJMUVFY2ksSLqGZjHRjoyrtaEeyQDRsLll4iSBuq0H2ag2GYo1wcWvy/P5BTm9ObMf5qaliE9uxxJB3zCMNHLUnD9nMXs0DXuQimYtYgmS0x++bxDBwLhIsrAZXdhPcaPqQKp3738ekonD0T8PJhIZACyPnEPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187654; c=relaxed/simple;
	bh=NwUlfljdhIP9pICE0SWwwxSYnVmSlPOHaRptjeyI81Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=O65S+fhtGaKYl6I/YN9pwIrWVVXGPLduHkAyspM0+af7ValktMa8n14RLVpQ4/gTMD3+dwkO5y7IdX5jofWUTQs0FUqU48G4Lm9rgrBqAgb0VK0HFIvnoqH132PLDNXHTGFf2ulubNpwsxu5hZqIBkqscG2reWfL47UCBu4arKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpfFwNTN; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpfFwNTN"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1390f75d8bbso5023011c88.0
        for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 21:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782187652; x=1782792452; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyDhq0PUhasyfrjo9nuavJPnubuIdlMbpZxDxdz8RiI=;
        b=XpfFwNTNZAh1JKUhyDO8ntx68YDdI5OSQt+u5Z4wYzKiv34Ou44giTlb9AAdMGtETg
         4WdaXgQ6Y4KuuruDckKmjGPqDLoImQBdyrCnBB3YQrhSz+FCiLqs0XeV2ii5IBZfE+VK
         5wJ/CdeN+hMkQqBv5p0428SNpXdwX1igp/iYW5asTfEb/bQP3/c8zmAxuyO47vxTYtEW
         mT6H0q2BmQFgOBEY/+LVoZ1Q5lPeK/jTA8e3gilauSyebXEgfWgyQYB00F4AvUWAxsWD
         CG3uvWXuzzWZhPL92u+RXpm7SYB5NhF7Gs05d+WdXe+ipShueSGm48H/XMGNMvAlJKGD
         CRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782187652; x=1782792452;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyDhq0PUhasyfrjo9nuavJPnubuIdlMbpZxDxdz8RiI=;
        b=SbPgv8WQQ+ydp9oxnFhl20a5B8Y78Xqf+wR1PI9Ptib3vb3YgR9YV1nUEey1Ckj1YW
         QviZNO1hdyO8oZJPaLa1DmQ6DvOCIta/C33utAUqT7Cf26iJWfk/Pog0JY3QTGmPhIfu
         HAXOS97in2EVFv6QCVgb2oI+MSrKO6yjCEPwg0y5JKqe5PP+P/HzuQvbrJsrMoAdYwql
         J5B1RJ+Umsai4kXXS4/5IS3AWkz6v4wJ01krUPV33yjOc7O8ceWnJ7Taw8B08pTgbDim
         P2BAGD5Feqb5bhQSygKtQuRK0GqFSJfkFRrr+K73eVu6/VdnB4nbtsshp0/0ctGpK4+Z
         I1PA==
X-Gm-Message-State: AOJu0YzbTaHUZqD5NALfb1KubpI6cmavtwncI+v8ryAFCdzImuDyGMFk
	a8xdk1yjvAQJvSvT/uMNPPJw2Up3q1ugzM95tA/DpNj/gt3HvHL+TyOzBTWxoAE=
X-Gm-Gg: AfdE7ck4cfLtU0QgDzBxCjdynj6062+9QDMrfnqB0emIwH9dtVDtLZe1C6T1KjRvWLh
	8TGioEqSocS+DPaKq3TWBrOKo9aMYVUwdBk80aqoK8MJgUa828+/pe7VHwZewZe1O70aTLONmL+
	ZqKsqin3uhorJWiFHa/4vYkDQa731ITb8B0mwVMFkIRunRcqMiTzeeASguvzrGM5HkCax9tB8Gl
	UE73OzD9uOs3xMuc8dqAGRiRiAbkc2ZBFiXkfFivPfO1Xf5sDz4iN0YbTy/1O5n+9QRDMlFR8kD
	g+74guSYwTyOrIHcn2Ut7HlpdrDSqcjIApfn1g6VOGxY1TC8RxO9mMAWn1ma9RqXK1KBy7dAZ3H
	Afu7e9o9+A3JkzZgYHX08Z8Tai1jH5+XF0xvtz5aKV9BuVMiEMPKci410CKjFsYcsdG25FCuh5H
	Gwn7FulaWkSkZcMAut0A9C2RRJOw==
X-Received: by 2002:a05:7300:72cb:b0:30c:19fe:3c99 with SMTP id 5a478bee46e88-30c58c27de3mr1201819eec.28.1782187652208;
        Mon, 22 Jun 2026 21:07:32 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.56.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bdffa83sm16797614eec.23.2026.06.22.21.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:07:31 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1782183266.git.tanggeliang@kylinos.cn>
References: <cover.1782183266.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] remove bpf_mptcp_subflow_queues_empty
Message-ID: <b865ae51-eca3-ac48-75a7-c97c37920f76@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 04:07:31 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/279995=
07296

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e3ba60653a81
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1115037


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
