Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C4619C54E
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148225; cv=none; b=RQQHZVenx40PJqmzo5qsdl4jXU2z/qABEznC8AxV7dL6DfJUdKS9rVt8TUsx/W+wxZJT3usq/wHHKvW1I2U6WdYW8/fVvByaZ1i7eS6g0qWgXTf4TLCtlJGJLQIx8WWWpdUCxR4IIWkIvaSpDM4rvGrd3B6ZM6fLos1Mk3Rv5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148225; c=relaxed/simple;
	bh=6K8v8hAGyLNvj1MxUXrpAgUg/NBPr+XzZ2jA3Oi+aSA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=BifbI06+3zhp7l8y1dmRa5BgzYnygvUZ5BGqUFqSxpl9g8WJtj2sHz0/KKW5XqYEeC3o/7fO5Z29kwJKTWfZ+ZW4Ucfxh/Lu8BBq21jSUrYlErsjDtXpLqhiqO7npaJEphX6rGFOxz0T4+YDxNw1NF5it+sUB9q41PECQFSDJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VI3sNNKh; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI3sNNKh"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so11812306d6.1
        for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 08:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761148222; x=1761753022; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moz+AxN9PaA371WJREy4nbyuN+47geB8NxhbXiwexZw=;
        b=VI3sNNKhAZf9prc8D7G26eDh82yGGTXdvyV6xuR9m5sGiwLEBOLNRmMAyfJxH9R3Dg
         yBeM9Q9s9IhLuA4cCIB/NBaZCqOL7PuHxApYwwDFH2cbdKjcUkgjPvRMRNwMahZG2G4V
         oCYylJmxqh7uDTw/asPDhpzdav0uuEcbobfkLKc7aGj2Hh51wuc1W5D/28DBbR2oLv7G
         Nr0u81ii04mkKZXykp59Etrg/TIfFe9/yJVN8BcLilH5DjAJhg9z6SbOpETasV6c2d1P
         BTQ7ywvUbvssRunDfKbdgRiBgqwM+uwTJM96eG6qzKfQNOJ0FL49wTCqNKxlNmH2SjWd
         B1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148222; x=1761753022;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=moz+AxN9PaA371WJREy4nbyuN+47geB8NxhbXiwexZw=;
        b=lb+2D2QuCVB7HoAG/BCOu5jHPwPGePdEuY5mrwqIKT5WSk+q7QoqtChUcAtWn53DOX
         rc2G+pKZ54UUAzGF6c7mq+yd6NacfZE4SfeQkWHTTZEArrn1O/tmrYnXNA+m+31WZsyq
         At+DB2xuBggL3gT/mLwPf5drgjhBgzrQr1hzqLYzF22tlLKm2UXJfY8ECxaXeCLN1Cyf
         G8D3idJqrCQ7eMuiUJ5R19096hJB2OVvRKxzbtHDIIQl1w9+G9JXdeaPiw0p3WC3BWZj
         +ohBQO5Z53IE7Suyxjk/msW6bOL/A06AL6F94HK21DzKLNmYOcqr6QxZjyR1+EzT9UXe
         LjWQ==
X-Gm-Message-State: AOJu0YyyCiYKBuA+ZuqL8s7sCrnpR83YM3MAV3On0FJHvFALwWnPG1Yt
	0ijyRt9Zu3oSYrsXnvVIewSI38U/09A0WiLQ/QRkbLOZzdJkXWGlgA2PrBFo
X-Gm-Gg: ASbGncuwjf8gv34h7n1NrE1suvlncFVAQV3gd/yV63O5TdrvdYhe4BRNzq19sbVJMIo
	GunAlV2DK0ZrP0bqf3SIKyrMBS3XWIpZZKIb7cm+lb4x4Dq9+vkiM2foSsyD90wtkxelgRhnGb3
	jOW7MRJoxLvVtSDA+avxRMX0MMdpaUS2iJnIoTcGti8goI9y9fjx/5OxMwuA+VQ1QnrJ/ItTGYa
	NhKOrqP9PLeTlWjwAWKoU0LkIKhnw7fgMQ6U5n0Mq308Psp/0eXSd98RF0MJza2jXnwnP4Hd2nE
	ld7TSPklxfqapG+nWBAVSl1Cm4tBuLOH7S22G7hNfSkVG7n62Sh2P+4ArRP6SNhc7yJhJ0hFPO1
	gJNXr/ndJ4OVAe6pNDhXWNj+eJhLP9WB27GZSJbWUFc7PRLhcmBwkEpzQjd1RV/3ciXoe66d6AM
	1sRJ9ALQt8MRNnE0w=
X-Google-Smtp-Source: AGHT+IHjo+vK3S90bD62+cdG3OCrwH3aDCuaKPSWLjD2oRK/3aTlxIOG7e+q0H2ODhPPgdbV2OQMLQ==
X-Received: by 2002:a05:6214:2407:b0:78d:592d:fd03 with SMTP id 6a1803df08f44-87df675872bmr52776066d6.25.1761148222113;
        Wed, 22 Oct 2025 08:50:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.125.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028ad4a0sm89787506d6.47.2025.10.22.08.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:50:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1761142784.git.pabeni@redhat.com>
References: <cover.1761142784.git.pabeni@redhat.com>
Subject: Re: [PATCH v6 mptcp-next 00/11] mptcp: introduce backlog
 processing
Message-ID: <13de9470-c354-c6b6-0780-69f4f659f1ca@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Oct 2025 15:50:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/187203=
65057

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/61d32775fca0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1014567


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
