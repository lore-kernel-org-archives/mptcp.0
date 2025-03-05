Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C6193073
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203924; cv=none; b=mLgRKwRf9JpKlugYSakzzdSBYLMoCcCKOenp/zOj10be+XohtuvV73SOPkZ73hiMjpr8hsPBaWhob6iUH5/lwHlkdvCN+RbaDY51XE4CIDhXX1WhEMAm2lQh5VtTLvvHFN4QRLkUSTHLGHik0ta7RkAWpQBqjhycgE2J02D6log=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203924; c=relaxed/simple;
	bh=FTGXXsVvWoQwxuqy0onBwS+hze8WaezYyM5muBiLR0M=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=pswO3T7rHUp8zKC6JTfNry6clO+dCYajrA773Hfj8vhIDsfWMEohxrv3qgZRf8jO8VQX9Q0qOXie/Kw6LXDHPv7ibdiL4KrvwlrGhIcbHvW76xRdIu1EOJ2sYGLw0Cn3MiwEzYMzYFuiJlgztMKgvpAOivdR0Txba1+BMuBLXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7F/Pxip; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7F/Pxip"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0155af484so974948285a.0
        for <mptcp@lists.linux.dev>; Wed, 05 Mar 2025 11:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741203922; x=1741808722; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmuQfwymnB83zKd/qd5XO9TrdJ87uZGCf+/MpIbOwsM=;
        b=Z7F/Pxiphp6wDMFXE2qzbfJkGfdR+u2JK8g2/UGARgsQ9pBwPTURvXzOPRuykkk0LY
         fNhUr1vrCZbFGwPDh3zoM+n3fnmN4+ZiQeKrgRciL/t+gR6nkALvuMhQ3irvgl0WcYoj
         M6nlIXeVL9B9xGzLKYaBHKoAtofjygqRxNGSk+r3Aphti/bEy6q0comZSyP/6ybosKH1
         7GBSrIkzNDDqBdZymmK+PXY8xlXAMvDBVZt4K40zumMwCR6zyaP5C0hZIYYlfBYt1Oj4
         u0YNK/5b9mP1RPX7DjDpfTDAf+wCkAev0Sm2MiKJv4SS+4CvjGX7BJ1rwz3CmX0rGymy
         ZbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203922; x=1741808722;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XmuQfwymnB83zKd/qd5XO9TrdJ87uZGCf+/MpIbOwsM=;
        b=gViHXOWlDqPOOQbBCNhEjy8N30TkOAf/w1GNs58crIjl3DRdWVAYN1z38XAEd0mpE8
         INpBba2AbYpP62merQ+sAHDq7rkM0d4no85/PFaUfn9hsdaRSqdyYqr1H8Wnq2swwh1y
         Peq8Owpaotkbv4d7qx7AffYvy8Gp3LfhGe3PRbUdEXqOMHsEVVachoS+6dUqKixRPdYL
         IY0M9P7i5WyG3qci5ejSxcij37sxrwCNfTTJp4k4ftQhW25Y895ueoKWEu7scKLqwctJ
         ifAvf5+V4U0CchmARuX6Ot0ySoSZw5HXIQs692UhzyZysVXP1sLy3MKoYHOedPctzdBA
         tmWg==
X-Gm-Message-State: AOJu0Yy+mjBhOWIooxcPKOwHiHRoK47VrRi/GP/x8cZeFGwNUVv3+Fxr
	4+An7flvu1HqFbHszOersQPKMaJg08m6r+0K++dIWWFX6JG8L7UQQuii
X-Gm-Gg: ASbGncuIajSX4VHGU1DHDpuqEr/nETlsLJnawy214bFY8Vh6caCJv+8l8n1WH+jg5yT
	fgEuHeDOMFli8L3xdrfpZKH90UeAsoTIqYpWtmXRXlyXsOONriMvFdcGFp5+ubxJzfP71ohDAbe
	3H8QzHREWMI8m+mzd2YORalUPf1f7UXjS0nQQyeEDm88CXMkr9AjqGgfHnFMQ9hUOIIiP+UqsQb
	ac8UU/kwTeNzJxY8LInUKv6t/YS3KZSTa7fz4PL28MUWLWpbjQQ1vtjVSODjBfipKNttFvV3DeA
	Sd88Xp01/q6QJxtaS/DewgAPwMVlImMr9XhtX86IiFaMfonhmhY/0JeLlxvY
X-Google-Smtp-Source: AGHT+IEUfzXDXTP6pl7biHUhoKEEdnlP/QcMmjueD+vA8xtDEwgcLK6NzWP1uKd3BqhIJK2E8LFqcA==
X-Received: by 2002:a05:620a:2705:b0:7c3:cc32:2c50 with SMTP id af79cd13be357-7c3d8e89d50mr626834685a.34.1741203922095;
        Wed, 05 Mar 2025 11:45:22 -0800 (PST)
Received: from [127.0.0.1] ([172.200.199.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c880f022sm340441285a.3.2025.03.05.11.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:45:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250305-mptcp-tcp-ulp-diag-cap-v2-0-d53fd80748eb@kernel.org>
References: <20250305-mptcp-tcp-ulp-diag-cap-v2-0-d53fd80748eb@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/2] tcp: ulp: diag: remove net admin
 restriction
Message-ID: <3a7dd66a-af40-bf56-4fe9-f576d1a7b39e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Mar 2025 19:45:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

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
uns/13683325743

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1ef9eed1fd7c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D940679


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
