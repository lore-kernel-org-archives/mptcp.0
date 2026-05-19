Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926FC31AA9B
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225914; cv=none; b=pb0SbL/6/svmavY4dW6So0VpHKs18FOMn8sIVkF9J2rgGwXCEUQ4EsRBkLCQwUyAq5TXOTKQBlk7oURAPz0seIEV4Nma9YSanaFuCzZjzaz8nr5Jw4SjxSgIHhL38GEtrhcEm4fg3vNNB0AiO55b0NEiVkHfnyCUuZWE43IKSyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225914; c=relaxed/simple;
	bh=n0oeInmvUqxzi35ob/wRV8iDHdeP/2MJDK/iuxrNQt0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=YvR9ImjQ9Y1dVeO0BDRfs3KSKdMM7VV4VTBsyoRXHpbGfK557SBlPpSByiOyLROdXK74KP6J3TRtjvvtkMVVb5sGyfUZ2NnhIMWExaSZLGyXOeOGki4SWftjZaCsQHpxhX6wiu7WxmCaTBWiarev+OZTvKzMM0mqL77GTL+dMi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hhyd1NBb; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhyd1NBb"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-90d13fa59e8so425041585a.2
        for <mptcp@lists.linux.dev>; Tue, 19 May 2026 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779225911; x=1779830711; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZWq8+39RDJi9RxWyllFCUILmi3eauxdQbXrz4qdP+A=;
        b=Hhyd1NBbneiIZgCP50HVZjw7Og7zFDZ/Gin/EFPNkXLQVsKHUYggddKgbSJmxYMkkF
         OmiqFwhLS9ByeEYxXR/ghW9BDuzPdMqirQKu2ib2nBGa2K+t23yMnw5ANxEUz0Aw/fR/
         wBi4L9aGafFAu5wVv1OFVynAkRboHz1kCuPfW85v5HGLnQMmq4+E9LP/ruBQpFL6XMKb
         OwE0fleyvr1HlYtp9cdEypwMBd3sNa6sgGvM44NK+zLKc3sTvm3SJjLoKASCIkZzuKl9
         smvGKzIHWv8WY3PJEgOENVYuRmqVMvEE5eqtIYPm1Sds/uxktOfnWN67tsqCRmhiJZLq
         WDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779225911; x=1779830711;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZWq8+39RDJi9RxWyllFCUILmi3eauxdQbXrz4qdP+A=;
        b=WsJdw1gu4bz6Dht6g5/gXcRHZWiR/3VxBPh+W0xbjdcpmLVJx8pHGWyF8hyDAqJRjs
         m0BPECsrgQtk+NrwtkYwX4jIMmy8EV9Cd1oHXCrNNELCy7MXCTkUhWfCcnCJkKIVJD8Q
         GoS1MyoVVsqNbYU9xSg28/sHBsA08xhbQnyclosPSWUulql58DApF8LqVERNzzD7Y3t7
         mF0Q8Dh+nmXQli35FyqY4dBJj40vJaFxzqM8dG4rdKaxwkCvVIybxhxXLCGSIChnFSdf
         Sob6kFM0Txylb6/avT4nH6KzpMN3BdD0k0/ypK6N/pruuwtc1IApqHLcWkgXtc8lP6QX
         Q/Ew==
X-Gm-Message-State: AOJu0YwDr8JiZmTWiY0kJsLCH+dQJIsFjO38bgftzC3fA16Y3+rwsM0w
	ILrkX+Damy+WDu0wX3QxjTe1FbZAW3wY1llre680uob5cWwsa3vTHjaTOPpSjn4=
X-Gm-Gg: Acq92OEW/F2LMFy9HvhyflYGVzQ3PUcaAvB43grmNGC1569ovLroJmrEPIoElks4wgQ
	EbpOPLGstdsAdek9wZpieDLgkeR1BoJ23lbd9OR+BcaE+6HMAT0r435Y8uBX/DFsyAqdHzl+HUT
	xc9m4zcNAZsMK0Y6Qh2rOl8BzVxr2QBam27u25wkJppGp2MN8M084yN6CeTCqMSZnSFN+1MeJBJ
	mSqzFa/RZCS3Oof5T7/+tlpuFAhAI/i5UX+vRkmrvDFXh1NDQOPKU7yCqur9dIOjZNHktLXOvX+
	bhPsfNy95/74BBR8me7+SzW2+wxsLxCjhpRrcyJidkW2yXwzXnHmeMkjXTLN99ozquif4mrLA5h
	beG1uM6noSzcFpBA0zjsFTW+Fi4AMP5At5JVsAcPf3UPIuCEaOL2+IbH5x5f28GFCS7U4yx5tpN
	us+pIteemjvxfjGjBUIeh4hbYyP+iScjQ5FkLRIg==
X-Received: by 2002:a05:620a:3188:b0:8da:dc5d:acf5 with SMTP id af79cd13be357-911cca9de08mr3135818685a.12.1779225911213;
        Tue, 19 May 2026 14:25:11 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.127.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd620fbcsm1997321285a.42.2026.05.19.14.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:25:10 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779159524.git.tanggeliang@kylinos.cn>
References: <cover.1779159524.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v14 00/10] NVME over MPTCP
Message-ID: <d745a6df-ef6a-b395-20f2-83f22024ba7b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 21:25:10 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/26123437144

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c19be69b7661
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1097007


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
