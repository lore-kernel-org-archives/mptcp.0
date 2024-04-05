Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735211CA89
	for <mptcp@lists.linux.dev>; Fri,  5 Apr 2024 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287623; cv=none; b=UfZi7K0X8RcnJMOTK5IricOJhM4ieqMvSjakR8Gn2fWzZKh3u32A+YifbQLTKB+7naI+ojTnbdrScErkvGZgqdQbrtbcQVQIvEcpeAAqZ1CNzqO+pMhuEM9jHKwyMYrmZTgkxFkigYSOt9haA6qMrNPIH6EktBGIjKFGGoxizFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287623; c=relaxed/simple;
	bh=m6zwqGxaI9ufNwq4A2Vg85kC0gkUjhHUH8LJVBL9pUE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=l9Mv6jgXvdqo03ybU+VY/OZpEwLEDmHYFkyJCD4m+wmV/xlsxAsnLYuAJjlcEkOdo29Ijlusm4gQfCS6mdOVbaHXV4qieg2mSc3QL1q3NbqOCz1V3vfW4ACfBVbrqdgWyiF8/fZJn9x4Fx4TGjszlsNbid2wGd0ngpWAhbPfEUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEDqVHL6; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEDqVHL6"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78d43f8451aso97438285a.0
        for <mptcp@lists.linux.dev>; Thu, 04 Apr 2024 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712287621; x=1712892421; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HnMLy3fqB7y8pkeqt1ZYsrGSrEzvYROqLpa6mgS6uc=;
        b=hEDqVHL6SEEsW0Y7yKkR5jKJ47GmICpQs2pNkeamU43YBItt2jeG2xqVdg0/vwUMKH
         MhQXVP5QIY7QtDZ5MxCWDqMWw926YiMg3yOjKFQoNyzAG6BrF2ZbVN+45rIcS9UTjcS2
         82w3see3J6qrQ3RbEASj77SI/w/Lfv9JTr+GKkSQRpUx8tPSUwDdCxhCiPWBgFwc/54S
         /78wQ/6frJpfOzBzJ8+W3JNhzf7xavnkDj7ng1iOIpajZZx8s1s8DODvel1qFSwooNjf
         OIKLLZQ2i7ACXFloSV8wjPcN3SP8pEBRigHXrx/iQUJfcIb8KBfCnsb/iadm9ksB8Bis
         HU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712287621; x=1712892421;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/HnMLy3fqB7y8pkeqt1ZYsrGSrEzvYROqLpa6mgS6uc=;
        b=kvn/qz7aSmfAvtSUDN3vFSnLpM80AHnnUx5qHEHJ7WN0Wh8V0KSjoM8m4rh1HL0s7M
         ObpZZZKtCo2bBG02CgeSqT15N3W4rH4cFN2VpPRL+pXkjpyX5Y3tSulAtlDYdAjLpndJ
         S+PTb2ruESjsynPXOZJyPdr8wtfplctVBrZCpWcBzcJdTAjw26PG9AcK/tlfcVWj2L8T
         jTbMHqV3rK8FXaQ9KB7zRz6VYGUtvlwE1baKs5JCx5VqlI1VA+qtJnm+Ir5lkC9Ym0JU
         3w9HtaHSM9XJAXRf+OwxQDqJOyaYzZXJrGpaPMfdVwcCYKpOgCClzn0/46xPvPuv6EBP
         mTAQ==
X-Gm-Message-State: AOJu0YzWtbtc6fwi/WOTRxt1oHo2Our0WsQ5jCBQWxsOnHikr2fj7rED
	xYw6ykPPVYdpH03cYwSTYuFOtAxhHdxxteE/ipVn9xWLr+orcAg=
X-Google-Smtp-Source: AGHT+IEENXDTxHw6FqYPuHJAOmlD30XClRPM2LpSqCcQ28IZDYsacJxUguDeoX81hJDIpTeGXLUVWA==
X-Received: by 2002:a05:620a:31a7:b0:78d:42d8:7123 with SMTP id bi39-20020a05620a31a700b0078d42d87123mr2179933qkb.21.1712287621228;
        Thu, 04 Apr 2024 20:27:01 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.37.220])
        by smtp.gmail.com with ESMTPSA id z13-20020a05620a100d00b0078812b73ea1sm296521qkj.28.2024.04.04.20.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 20:27:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240405023914.54872-1-kerneljasonxing@gmail.com>
References: <20240405023914.54872-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next 0/2] mptcp: add reset reasons in skb in more
 cases
Message-ID: <4c8e3418-48ed-5f5a-2c2d-bb488688036c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Apr 2024 03:27:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8564316916

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f85bdbdcfadc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D841648


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
