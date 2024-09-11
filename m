Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF98842052
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726032106; cv=none; b=kEx5JwkYsghsFpcdBahirFhJ506b6yHVweH1dxFbQRXrv70APaOYiIPzCEAviB4w9YzsWuSQ86dOQAA2slEVqoH21BpjEVhU/W/nmsipXvYE31FxUxMi+D08VA0JYWdVbD7C3iqBy4c0/BgUf8L8eZIrOQNjF1gn297Swy9YV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726032106; c=relaxed/simple;
	bh=finov8MeHCCIJWE/bgg1uHZDS32BmmSwoc/bJpvBlzw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=dye3AY2Dv3edaz1ugztGlxxHcHvh9BesxhgzS5N3+I98xKfThhzUjDwFce2G8F0lvbFc6mBeNFJTE/FdP/D+wdkfPG3AAjCH45Dexs59WyvIlwFDXK/G3Oqt6P3elyh760lDNEq7y6igq1j1fOwzKoeFvYJfJZWyOmXqzCg1lMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvDDJdBe; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvDDJdBe"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45812fdcd0aso4879611cf.0
        for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 22:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726032104; x=1726636904; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6Lt59DhJDrXYKWlDxB3Vcej5YYBPvYMTBYISzqoZkA=;
        b=OvDDJdBed+JxCVS6L3j9WcyWDuBdBA114cf+XsqZuMHW6V9rOozcQ7YEznpcZvLfcN
         vgiqzM4J/cI0/2PyFEaOMH8ObbMVztJWXFEvqyBp18vRY8r1YVMRxdUIG1EQRyHarnpz
         pekIk/enyTwC6kS6m8FwfLRNr09JodrATW3XV5gn96PFx6aCytq+rp78KVoP3YYulFiB
         fLZhVwzxx/mWZiDMEKeMDQANjhXaoLL70o875+eSYdHulk/4wsywuxagtaX8SOM8qjKd
         aYgKDtIjMikN1U+bPdthg+cCWnzzCZOgrMFe+E8hTmTQufsQVljreXuqCS9mleTq7ERP
         3krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726032104; x=1726636904;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y6Lt59DhJDrXYKWlDxB3Vcej5YYBPvYMTBYISzqoZkA=;
        b=Ijy4Svnwjg8hZVQ1wC8TyWtq0IF7tMotEeMKITtvDIv6GkGQkQBVRLL1EosAVcvq2x
         OJnRfq3V/CL0o7VskCURu8sY9nN0mbNbioRDrYTudy7/ngFPPvOWGVI5RBpzP4YItYGY
         yN1TSMTtBKcDHtoMLSCPabujE98zSrgtzHKKrjAtOydch/9eG+LWZAimomAY4+YXW8HJ
         849Ng8RQJfdQH3VNU9ffar0KYEmva3Bcln0dGjXQ3twbtXZcdg6lFY2yjZE76ChYy6Be
         4VOJ7uxi+0BxR3MgRwXb9URdiPoKvfQD7W8RLLrul6srpr8jFR8/W74S8eBwvt0F98Se
         TEVA==
X-Gm-Message-State: AOJu0Yzk/4yO2+P6e0uP9gRz5cuYzzSfuJBi+V06GZwsKq/i0KiYkpE2
	9Aqmb96VwLB3zP+d6kvds4DQwZzV3oxNHsCY+GZzZHdLK8h3Wqs=
X-Google-Smtp-Source: AGHT+IFAwtW4akDv1qkeASwnlC6BGVoIXwQZ1BTGHYPxit7GgaHMBbE4jfDHV0iWZdhWf7rJdRpQ1Q==
X-Received: by 2002:a05:622a:145:b0:44f:fb6d:4b2f with SMTP id d75a77b69052e-4583c7ad871mr93790461cf.23.1726032103525;
        Tue, 10 Sep 2024 22:21:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.79.247.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4583033b42csm25577561cf.90.2024.09.10.22.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 22:21:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Cong Wang <cong.wang@bytedance.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240911042425.978665-1-xiyou.wangcong@gmail.com>
References: <20240911042425.978665-1-xiyou.wangcong@gmail.com>
Subject: Re: [Patch net v2] mptcp: initialize sock lock with its own
 lockdep keys
Message-ID: <51442a3a-d7c4-1890-f7a3-c573c867faa9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Sep 2024 05:21:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Cong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10805076657

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cff8cdcc8f33
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D889140


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
