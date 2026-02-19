Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D77212F98
	for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771531927; cv=none; b=Mu0hA8O472lMekYlx9S1JThJ7or+fIn6zGmbHjh1hNnklN5Ei4Bzb6fuESXbSGEnp654j7nzsb0wwb3cvpY7PXnCHFoHtn/+C7cQP2jFV2M7IiyA+d4c9ghFIxl7YRQnIznxBRdRp7afQRzjgcTzcjspRGE22Y0QTOk7bXn87AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771531927; c=relaxed/simple;
	bh=+1pS8/hZglf544fcaNWi1xiTHd3IyhlnKcCikn1PI5k=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SN/oEQJZZX+2WJvG1yajFsJ1qT3VtPea5Z45pEEx4b9VK7whoJ8zbPCLliML/EWLN0ywAh5N3plyrksA7hyqL95r9eD7mw9iCDmR2xV2xD1N4AJxCh2+RrwpxLMxruzaeB6rXfao8MT5U8jWbTZOvoWS7yL/NxsBu+yEFMVSZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BELNNM+U; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BELNNM+U"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-506a747448dso10678401cf.0
        for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 12:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771531925; x=1772136725; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZI62dpbbLuZxvAvmmPce+eCRDL4oXjbtHY+dcTvDPE=;
        b=BELNNM+UzT3BKNpY+frpY/5vngXnxKWbNPpEBlMEQS+LdNlT0ggYO+jvVd8yDkfNrd
         fBIUQSyWN3nouaXVuaoAh2tLbEGzVViBxJGn8ICAjzrntRZ3X6/oG7ZAR1CqhBthMIzD
         +s3iiHcyLUU4hC2AkPlDUiLQWYdKAm4M93PXWfaSfDWsqLCMQ/Ns0fEDVIbyz+XWAK8+
         Du4gJlEALc3PyG5lshGaAgKqJwfCQKtC9OW/wEg7HEbdYm1yK1z1WPOuGV4exsdDYpzo
         0jvi7fgdMA3up+eIfdshFKvJekCUlGHxnge04i6j+dwDJo0FggdC8ol/DMSXNMapQDvg
         PWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771531925; x=1772136725;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZI62dpbbLuZxvAvmmPce+eCRDL4oXjbtHY+dcTvDPE=;
        b=t0BXgZAYRKSAqJlCjWFYuHwJm/GJX09232/HmTwrCMrEsnvtUG9keGhpWzlqfgZuS4
         pUsjBAFzXW3DJ0SLASmcaSPqInz5P3P15rcNAVan6/SuHA9cymQjHCBP8tcHmjGFDA8W
         NqmkPGZP8vwD1Npy/yMKfaH4LPMoqhOGQFAun4/9A0K8eHi7wraGQH3wlhYCk6WKWNQx
         3zVYTrnB7n4jJ7j93Z21J7ljaj6dQbpHUzMyiQV6gidngHJcMlaEQDl6pg2xkuwzf+HN
         xv+r3XSN9/CmnW8Nw9+GA3uh36e36flJS5RWRNDWascSxNsr0L1oRiuxiTAY6ByHhsL6
         DVcA==
X-Gm-Message-State: AOJu0Ywq8gHITExW/Vj6Gb69pnd5Nujf//xjtECq5i2Nl0LDIwkbcG3q
	OB04ftyZ5vD5C2Kfc26trZ5Up7wWb6cublgQONfXSpVT7cA/TPl+a+Y=
X-Gm-Gg: AZuq6aJXM9xVXTnlofxqwETFlvskVUOP6PeLAsTd18cfGXf6U/NeH1lWEJQB2b0ugsp
	R71jesW83LEsH13phO43gv4Ozy8oUxH0+mJXZRCTcBgxQ5iU05j20mmyKrzMsj28B3eXqvxC0iA
	GC1twfqV51RzY2/k8ZVCEiDo0XSGlEsMToVT22AuTqpiTw7L+yW/mbk7Xy4Mtk2u+1DVdxX0+nr
	PhCthFCA6EkEJbHN1mDxPZNcKisPbM2HPEjgBRMFUaGZpfG1NySHzIP2HMhW3VKQQw6hr8vIy5R
	n145df/Vwmvl6FPOBCK7ZITRXBJd0WKHxANF2WJJBH13Qnlh6JAgh+duIf9148Gk+IqADXuEMDN
	dPQSQx7rAja+sZjfjjuK3exhX1vKi1C/TJV1tX7hCrK45DviOdlpIJWqO+6evJyu0V8JnmAKcZ5
	jwAQzMsO2rbtuGolmfDewQAUl+NabQlodNBn0=
X-Received: by 2002:a05:622a:19a0:b0:502:f07e:8569 with SMTP id d75a77b69052e-506b3fbdae1mr239401521cf.35.1771531925394;
        Thu, 19 Feb 2026 12:12:05 -0800 (PST)
Received: from [127.0.0.1] ([20.102.235.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8972a23c824sm205238616d6.34.2026.02.19.12.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:12:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260219-mptcp-issue-612-v1-0-839e20d96fe7@kernel.org>
References: <20260219-mptcp-issue-612-v1-0-839e20d96fe7@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: pm: avoid sending RM_ADDR over
 the same subflow
Message-ID: <ce845320-2920-bd79-2924-8cca8de0ed23@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Feb 2026 20:12:03 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/221966=
01516

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b9e12177fa11
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1055636


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
