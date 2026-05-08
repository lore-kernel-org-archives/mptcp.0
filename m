Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10FE36B06A
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273356; cv=none; b=PHZqWm6PSDRVmmr5Rc5K0qNll6jqdRTqFAu0MQohVXJ6vj/k7kNEj+ztkduInGpbFfGBesC8B06jS/FkQcjdrFU2suyVgihdi1Xq/O0OFObybBcc5CnUe5ex3E4ds9dny6Cveh7r6ZrcS78jfCMfwvqyMn5V3qNUNnsnjymPsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273356; c=relaxed/simple;
	bh=RxgsS6wc7ZYtVJuxGm6kg2yhzNprjXyeoc0PNqte0JY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=nNTM1p3WR1N4CpX49heVFa9LwY5CQdYECQfucwB2K9e2PNKN+CYwHhQe25Cirq5dUD93l3ZYd3Uz4/RxcXOwDrwuE/hWiRjKNQh8vcMm5L08J0Jok6IwgKex1Tvjd/zkvmfyqJ7lAVijbkaXn+Qffnlx/lZBMbtKr2LN7MZy6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/gRDfJY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/gRDfJY"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50e97863425so21983311cf.0
        for <mptcp@lists.linux.dev>; Fri, 08 May 2026 13:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778273354; x=1778878154; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFq56XK1x9K1zfCOkf6gK1UhVulZnpAdDQerdIs4/tI=;
        b=Z/gRDfJYvhiHfJ6UW09GDkjJo5CiyC6X5tdhKTmpxM+dsFDDf0AEdLndp/UgGZASCA
         xSi1mVgD35LWB+O1WgRyeqxmZDj5b9GzdlZfNAX/17orpKJPVdMW85bqS4yt6el3f+86
         58aomCQOu3yVVI2QKf3zLdEN4eqk7HrTS6u/FoFPAjssaSMXGzZuIB040w/4CEttUrNH
         TVvueQtHGYrNtJ6grTcUp+eXv7Y90lqGYyV4KxBYuuoumdCtV8L07xjjHX6XrtG/N1R+
         8Acu6ZSkGyHWKC3n9xRXkDhVM5pY+VN09gcrcpF+Cef4IVuD0Gn9mFBRr7Y4G+rx8QtK
         kQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778273354; x=1778878154;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFq56XK1x9K1zfCOkf6gK1UhVulZnpAdDQerdIs4/tI=;
        b=qJ6yCn3r03UC+jFM/acTfKOe91VA7m4jYubdQZQVroTGwJzSHlMgesElpmwbx0VKH3
         FnfdB5k/zOrs36C008izEDNDk5QQiCLAHUzfm5Z+/LqG3qpF1gzMwN8EzuXLQD3mfGph
         87k0uoBSp/sVK2r66avuzch43tXAqhNYOliTHFtgXbn1DEcJkCRxi/JdpfvFeH6D5BDQ
         jYf8E79RyUDE44d8tR26A8xW5zr44qVeu38IMvwTgqooG0LrcT6vMpkHfOvdbLDiwNio
         JHL/XAn9DmIvcVzPrEnp3VqR8eaOutu+JG3zPq7J61fsyXhlQsLImh84TGmO1jadYHVQ
         HTNg==
X-Gm-Message-State: AOJu0Ywu+MFJ2FL+BjgRGPWXxKZfZ4pDp0s/y9MKbM1VGUk4XwrBVh0N
	FxHp3nYXzzuV/+8tLdG/Rgx2lZ1BFtXNa7KbCseVe2Tb+9VOjKU9Nlo=
X-Gm-Gg: AeBDieuhrBvbaiwaDepb3Jcij3nLjSaZkBdlV/tIoIoig4BxZGqS92KEMKkBq0yQVRR
	vxAM/Q9XTHe2tP9ktWFMsNUiDeCUgezT8eZTUOOiKF6zi0DWHLYsb2/d9hPXMomOyCE7Qn5RKJz
	yond+JSfxTsukFVCdHf9RKt8ocwDz19gRJx1pRfJLA0Gc/AOnlYU8/3mOdVz/SFquKId0w3rDNv
	GdwXJDFAjXzaRi87bG9Gl3rdXZzlbS7a/tWBZTgQfbjoCKciKPvXRpK0UQoIXS9JnYwUZdDu0qX
	tgUaKvKzilMYv372IL6bd9Ho9Hbs1lBbuBaJ7/gF56IfHhAvCojVTwz9CMvT6GTh9fwEt7gx/Ik
	+2ew7xP9Dc8GBBI+VSmAX/W/Q+SfP+FLL9zZs0twm474pMw7CQcqWS3lZ1ccSl7W65N1wXMv9Ah
	6KCQGeOA5Ir8ISTYliikR80/cexUZVea56C+MOsfDZEp9UPA==
X-Received: by 2002:ac8:5cc9:0:b0:50b:4778:ac60 with SMTP id d75a77b69052e-514619dddedmr192114641cf.10.1778273353758;
        Fri, 08 May 2026 13:49:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.13.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83dd35sm25799471cf.29.2026.05.08.13.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 13:49:13 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
References:
 <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
Subject: Re: [PATCH mptcp-net 0/3] selftests: mptcp: simult_flows: reduce
 bufferbloat
Message-ID: <b4dca8c0-df91-3cb9-a6f3-68733158f01a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 20:49:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/255713=
80159

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2bbcbfb2925e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1091768


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
