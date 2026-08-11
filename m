Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A642F0C62
	for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459412; cv=none; b=AnrqjEV7n2aU3WNSdPqIwd1al/plqbvkGBfwJprAAkcRR0LbYGbfvfHJvq9SznLJojPkKtp0MxhMlQ7I+zspI7Magad3QHGTeW8tZGasuA4L3U9vLXsckV42UWE164NedRv5lYLEVHDab7hi5NZVkYmgq6wmmtxQaoINwy29z1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459412; c=relaxed/simple;
	bh=H9e47jSfdvIVv172LYK84Lz9zZ29UqfvdZIq66Ox+sM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=j7SmA9D3gNnCqUVkV9iHHYuH38xaFvmqHwFfK8JwGOxXt7mdYcN/DpsZvimAwEsEX39GOVjjbad2Ota8OHVPtmzGsycGoZNg6dMJ91EQiVRedroQHNx0+Fh0kJNngvKy8MbljCfF0oJf+GBv8Pfx+h/znb9g3r123gI1ddozLW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5OroPY8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5OroPY8"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-821106b5b64so20201877b3.1
        for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786459410; x=1787064210; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qHdsA7jQy/FeFZOEJUzcdQHf4kSWcmftyRy/tVCTCD8=;
        b=c5OroPY8NHxjyBpMV4hJ9F5AahEPqOnXbtuJkq3x1e/sazffOil+2y4Q9JpATxLj9I
         UpbkSsdotbAasUYaGceN39i1ySHu1Xrt7hYDU3JaplBGEvXHNk0yUEGwYNv8S3UseY3F
         TUgbA31pe6txiz2k820BGb3Mt2aLbuTirjDcaAjifM3p1U/P4R3tCCuIRDz18rR1v6mn
         h6SI8ccU0wmaqKyxx0cljHWvvm6sxTe+AN1i/MA1AF8xsJwR+8u18CH6hhtJ0Qj8GO+i
         YyLTdivF9TTLyRUjO8WU1OGWPbNl749ieXBRUh443m99WqMm2+E+C0CU7OkAoKoub2xP
         eUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459410; x=1787064210;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qHdsA7jQy/FeFZOEJUzcdQHf4kSWcmftyRy/tVCTCD8=;
        b=HVJ9awxMpBsmi3FGBvwpMDyDHY9rk+C0F0P9pHguXEUahM0WqS+s2rBHr84OzmyfUc
         o6yqhmtjQdNx1BuY8qxGIDYrarG5SKSPzIew4PBFXKzrXbCmsYvF3H+g2DEw7+r7y4pk
         a64oQHXo6RSl8UPL8B6RicORnmc9lzem2xJdYY9ffdyluD/pACEIWm7gZzE3AblClWjT
         8Q8dhRIXcg0se8ga7yff/T8nPL6e+yxNZNCRbIGIgetMGKJtcv0GQitz8K0rYJ6m/xR2
         ekVJgofUSKP07uW3NsSLcFlVn3QEWO4tIL2Uerv5nMNeLq0v2pljSA1U0KqDApCojS9Q
         KNRw==
X-Gm-Message-State: AOJu0Yx0F5Zb4RY2OPEYblb7iBpOcKTr3NxQtvDsKZUw1Qhr+5OSSApV
	59oWMv2mLKGBPbopY7vivFs62Gx4+R4fexXPrvk3DtV4JydIynIVOfc=
X-Gm-Gg: AR+sD12jiLNOR2osuZmsYy/dHDaCvKgmjbJM6FEMApJ4az1W9fBqh9yJHSc+VDJC056
	xIzXO05Bh68TwTX5tfBBJMgGhodFeOYM4uJ3Oin5Rq+ojZglgaKv2v47rue49d/DPWW+TP5is3z
	K0ArRsRDK3rucqX6Hzj0f08IAvFYYDt+4aNF6Wc4IaKN8BZLLnLLLQQTZEZ6ibAJBYU/Q7TtjP0
	vRZuxnMXKUubX/AoUWuZFcmSErXMajctYpUtBxPAF/SUgb1S4htX73SZszWJheUWcZD1JR7oEt3
	jy27GIzYxI3BxbgUcFQhNpXn7mpYApx0VYZm/gqoWv0aOb3fIAtLHoRAxrQZIsSjfMiyq8F9vY9
	9SPLDcr0BIte00j1Ap9kEZMc1HI4It5UqrJbgoJ209Iox0zq6ssTQsn8ZS1SmoRpxNs6es/UMx2
	wqZctQIi0Vr5BN0qz7wTcUaTxJGcjJQ+J007fycmb7/Lr9GnEoTV2gYvxzX0ijRlrfvfcYdQXPe
	V8=
X-Received: by 2002:a05:690c:c355:b0:81e:4acb:c0a with SMTP id 00721157ae682-8304dd1e34dmr3710247b3.2.1786459409677;
        Tue, 11 Aug 2026 07:43:29 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.166])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82eb5fb7a22sm11870427b3.0.2026.08.11.07.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:43:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1786445142.git.tanggeliang@kylinos.cn>
References: <cover.1786445142.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/7] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <94bbd3cb-4ca8-1002-5456-81fcae695484@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 14:43:27 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/314985=
91634

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8f859f4196fb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1144100


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
