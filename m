Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4F192D84
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329536; cv=none; b=P4Mef1oVNoU0FIa7XLKqKQ3YzKME40oq7sDSOwZvJ5/pBRhyl1jsseD60nlJTVvWIqHtSa2KobWlj2v2tAUvJxbP8/k3sEkj/yEZ6pH7emEBOT2Qzr7LgaG/OXDavxX+ss/DAY9LUUGSVgwWcDn4rtp7at/577BrxN/tLQd3VlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329536; c=relaxed/simple;
	bh=slTfLmVIhpcq+Bs/GzOqA//LtJsDJ0h3uvPJoFQCUoQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=LRzBBVlSet8CVXODiandFM/l9/hiLAhwQ97Jksar+6DvvvvxMYzsy+KhJxGLMKpooHRDxZFGS5EtxrVX0TLBo8OLNIJdtPvwD2+UO+9J3jxE3gDctcPB/c8MpKs9MpRp6RUQaat+eOl+RyiF9/IF+zBwgwSt8Li6VCVjrda9rNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdFyYHZH; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdFyYHZH"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd15d03eacso6309126d6.0
        for <mptcp@lists.linux.dev>; Wed, 08 Jan 2025 01:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736329534; x=1736934334; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrfxZVlWT3+YFZOAINE3lQ48Ifu2GJ6f+D6+UVbpL9I=;
        b=YdFyYHZHNu0SrgDXWyKcmnZ6ceEcAmeKaMp9nGILFrm/qiqOxGB16P0ubr3l1qtPda
         gQoj/fvXaRURwnN0SjWhPo61eIEjROD8obWvSnce1U1Wga9u21LaFyopNSBw41lwv6Xu
         ZBr5sPBKq+V2l+AAMyvpd/vKoMlVAMzJgnMJtsOxmeSAwSQiEEVAx51bPDF/C8Gjo5zW
         w4b+vL4Si+yp5NmWnTo6ZBK7K7Qm68rB2TtMdN+TqJl3XyH8Bre0XOEz4Ubr8PZrakFf
         opeuSIP6AQUA+bN3FVuj8Lf9Yber3nglM9/ELbcsMchQvvakPJ4mk3+inMBpBCR82sKL
         7+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736329534; x=1736934334;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NrfxZVlWT3+YFZOAINE3lQ48Ifu2GJ6f+D6+UVbpL9I=;
        b=OzBdBu4zSj3Tg+a8y3bmh3uTB1ZsnFoKZZ8FO/amtdqWh1IjHqF3csHNOIbT301TaE
         cSYz+rXPoDF+S3Kv5e0d1JoPNRWMnO1mXcc/eIYdRr4E9OI961Zotwmaja6ywRtYy27G
         SQ4MVXv0Eob0VyCU3JR1cDMNLC/X2O/JYF3eYkUrFUluKcqJFawFLUkVH/UYuew58vwW
         UgmsNQVBCDNeJUHGulFFSRJkI2e1R1Ks3utSqPKciGrHiCJLvMX0WttnFOHas3IMA79T
         qTQHXKvaNLOqiy6mYm4cyUy20J89p/ucHibnDHfC6KGvslCnL8SpSLF1LiQreqYNpovp
         Vhlw==
X-Gm-Message-State: AOJu0YyJwJTj6hdXoOhO8l+yDi9iXMMzIfHe9LgomfNYyOOHrvwT/We9
	7asg991GD++egUHIFQwD1xdeLsG3ik3QleslnyBK/gvL4R/oosOEVc7vxug=
X-Gm-Gg: ASbGncvtBB9WZJocAoeSb62sVgZZ+QtewHZyatZAZTzB30ziusJsZQvK+/MivGURhHh
	Mk0/qzxVbwl39MliFRTygr2fVA8LnnT0h+M06r3ftGB6SVrUzIwuAXYn1+ncSl/3iJfnYHnAivL
	R6m2TuTQBbKaWqPrgKaX6gw/bT6lk31z4DOdclM9Myuhx8EHq9BtMK0TMsfwVXylcA8q8C3Wfo4
	kDYVGPZsTd1teFDfFoghGpyWaMmuX3VcheGVljgolzSkak3CukvbRij9lizpUB8QPY=
X-Google-Smtp-Source: AGHT+IFl6qFAJiTtIrHDgCKAf6Qpvh/J40jJHedDfPGDPvf6BJNxMvxbeWBYQ8Hb3l6NrXBST37i2A==
X-Received: by 2002:a05:6214:3bc2:b0:6d8:94f4:d2a8 with SMTP id 6a1803df08f44-6df9add7c17mr37124446d6.9.1736329533927;
        Wed, 08 Jan 2025 01:45:33 -0800 (PST)
Received: from [127.0.0.1] ([20.55.47.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181bb4b1sm189457306d6.78.2025.01.08.01.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:45:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1736325184.git.tanggeliang@kylinos.cn>
References: <cover.1736325184.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/5] add mptcp_address bpf_iter
Message-ID: <057f8ccb-f68b-b8d5-3d18-f219fe8bb01e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jan 2025 09:45:31 +0000
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
uns/12667197782

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c04bc714ff88
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D923265


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
