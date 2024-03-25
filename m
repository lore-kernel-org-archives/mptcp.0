Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34013152189
	for <mptcp@lists.linux.dev>; Mon, 25 Mar 2024 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355159; cv=none; b=MtaUJHSjmNmNP1QLQIu6LWBAxxGBOslG+87ZIM04QSh0EgNM01v7AAky2KOrFUo68xQNGrKoJUbT+mUmMUWKjMPrF+kurAuyhBsn5lQVuwxLEglREt6+38P38HmG4R2kb/QdWnlJ+1CjPiHYUz6Ku6asphHFTq6jIy4rcSpNjto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355159; c=relaxed/simple;
	bh=HhdsTFOBvefzygHTROgUKa6/X7obuR11zhbyKAYuBqU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FckunTlnenZfXKc9d3Db68N41yOc58lMenbzhTceCRIrI+1WsJ4Odhcuo9TQwBXoNmr5nzuUlBQssU+qd44sGQnX/qbixHtiRFLH6gKkq2t9724XSjA4yYf7me2sxSJxo7IZCRp4cyIA9O4zaoUuVu/AQPXNWWSgI9O1ctdsrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/88e9L6; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/88e9L6"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78a4708a557so121590485a.0
        for <mptcp@lists.linux.dev>; Mon, 25 Mar 2024 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711355157; x=1711959957; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++oUxKJtwUoyob6Z1SsYPSkGGU4PvPFdTKHoWvuKwcY=;
        b=G/88e9L62Sir2PcROk3jh2oDG/s9CNRkf90GNFm7PKl0r6HY0YZDaq8HJgVfnEiNmt
         0pW/ZQEcR01R+GUJUvHNDNGbuYaw2k9V2kXYRAFyzVOcqDzgXCKft8EXU4zn0SS2GN4g
         4Yge6GiY/zZlI/5d/az6ih8F5B/kW6zok9UHq7//atl8YEiUnLXPucvSm0yFRaLIddsH
         DUCj/HmDs26ZUN3njO9Sf1H1lnV//XSHCJXxvVwJqEYkO5AjVESJAmVn+HT4WfLlVtOo
         zTXCJ+gmTQVlzS9V6cfsS8Hj9oHSyxPE9Bqlyf2swwZwh4ah5lw1BlMbg5SScLYivigj
         o5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711355157; x=1711959957;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=++oUxKJtwUoyob6Z1SsYPSkGGU4PvPFdTKHoWvuKwcY=;
        b=Iz1Vld/3jMFm+zBMdQLojuBVjcNDCn+n9Z6CQNXIJj8yJ2Uv84urTmZYp7CtWBWkmF
         CARuSdawAsZJCseAkouwRl5UmuMYOsScOV9CEZWesrVeJnU8Y9iJrY6VFNTrpKsK1I4M
         7chUOwUlCBKfrfL48XS7ZQ3PvpRIlE7I+inZJJGfQzqjEYJUyUauspY/XpsLFqe2Nttl
         rP3AIYEHt6rwp3y2WkOgItXdQlroBwXqtZerpTL6dmtcL88GhtFVwQtGL+bhItcBubeN
         AolYiQrlZUytgxShr5KkTFIencZ1ice2aNNf88sfMqwH7IEf5BguOMBUV49JgK9xtzgL
         l2MQ==
X-Gm-Message-State: AOJu0YzolnuoC1k98VtudSqFImRxrk94Co6qycigTyDjvGOUk57m6R4A
	AyGCG1BhH+IK0boIqRvkK4Uo8l1RSFfdbx9vABk01mWr9TInLPLVwY0/NWI=
X-Google-Smtp-Source: AGHT+IEDHKxbeZOT3PS76b9j3OyaQgJ1PuhK5SmYKZ8Uw+xIhnWUQeWYZ57MPMlnRh9ZFP5RV44HlA==
X-Received: by 2002:a05:6214:138f:b0:696:7b17:4428 with SMTP id pp15-20020a056214138f00b006967b174428mr6586896qvb.29.1711355157069;
        Mon, 25 Mar 2024 01:25:57 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.199.99])
        by smtp.gmail.com with ESMTPSA id a9-20020a0562140c2900b0069693f5cd04sm192307qvd.97.2024.03.25.01.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 01:25:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <686400b5c4eefdb930048df57cc513dbd6e94fa1.1711343483.git.tanggeliang@kylinos.cn>
References:
 <686400b5c4eefdb930048df57cc513dbd6e94fa1.1711343483.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Use start_server and
 connect_fd_to_fd
Message-ID: <84d362bb-ddbd-74c6-3d91-793b3bd73512@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Mar 2024 08:25:55 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8416733760

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e915c7ba3c37
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D837728


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
