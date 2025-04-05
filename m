Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648C46447
	for <mptcp@lists.linux.dev>; Sat,  5 Apr 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743868037; cv=none; b=EUTuuK7xPYcQ1iVMiPJdB3lARTpdLP6Mu807p7p2kAh9Bce7xifd32tCxpoP4KQehaXjy9uE4W/hPzOPSCV4hRUVhC+r4Zxwn5Bca+RT6qk3YLwKhnpKhUK0ilieFUoDkYDvm+8OC6x+B8fNxl2lAmw/U8YSb2MbGZbPJFRUpco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743868037; c=relaxed/simple;
	bh=VyG/qxhvhi0Uiq6KBmZfRJta8WY9oj+ZuUbpViLDkH4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=qM16TRT0UAjUrPqfcCzAGig53Key/3zN5L2aLu/5mLjJ2dNggHqhqMKtuXMd4isnMMiU/0MOnV08HrDg82Kk+SIX3egLkTlEFfbFbRIbikv1JjGrv8qINr8fTY9A2RfNVo5l7ObTkLy/LlFEl/7X2KDXqwHT8D2gaKlLcpmWc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVN6ZGu/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVN6ZGu/"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so497456d6.1
        for <mptcp@lists.linux.dev>; Sat, 05 Apr 2025 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743868035; x=1744472835; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZmRHzWRB5ycYV0M8K1DFEg++UMIFuyhRSxPN+UYFfQ=;
        b=KVN6ZGu/I+4+Ja7nKagzxdIDQZZ3rKGtf5vQiSrMC2Mr8tqwxwTjCiFVlJtk5+y/VM
         3nuxQ7Cq9Fsq3nmcK7sIoHGvflWSoxDbyNouLCx1hXrIR+wJz8RTqB3r1anOR1aMNuRI
         xVFuCpqjevtuntURLwm4rxZFuu8KZIUqyjAXpSAqQ+MFaDFDyNI8p3kowxvhcYiuV0ph
         HQx/9LIZXqE5xMK+HBIfvtgXF3F/2leQJYbZ1X4oQo32R5t4G7+6IrunevBtVeyYB4Er
         bhPwjMwSKYBIeHvHiWSnnOLrJ/8M1xcWs/TPqyaGwQh9xyHD6B9JRYIlT2vPKw+FNvMK
         CZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743868035; x=1744472835;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZmRHzWRB5ycYV0M8K1DFEg++UMIFuyhRSxPN+UYFfQ=;
        b=VqOYV7BVkqPIH3J9fpXm9VLVSC7C2jfVBXJ5hNDQ2HDyFyX/3yXETwthi5yTnQ1mFv
         X9hEDuWtCefb1P2PcTIJNu3xrn6uppVMm/8q5YTPZcbNxB6qAZqGwS52VpkhB1BLClRZ
         svdm3oZE4DNXWfVac3PCXm36YAs/UZ5OXXuF5VcGTqpT13fcv7kIZ1CfLpyTRL6hxXU0
         Xdz6LLo+ehootQK7cpJlfg8dO8y8i9M93Y1gb0NnGQrAs9rKeriYkAvC+EfDfIIQDovD
         Ro04sdBscgiks8y5XFfpJE5dg4wTfSMiw6oYQsloVqZMuK2Qjq/IkAKP2qKDcxRzWIl3
         29qQ==
X-Gm-Message-State: AOJu0Yz0g46cMQ2dL547tn6DSfI3wURc/A1bPaKfes1HQ9Ryk13b/i6L
	oecJK3OGc/wn4m9tpx1hhYH5gtzOO6h83lX627l+31jPMikQbAYuJshA
X-Gm-Gg: ASbGncv/OSEbcWIswHQfOH0y9mIADbZu9OxsuRkYvRtGBQYVX1SGAEfpKieZ6SGKyyi
	GfDp5c8rRw/IYf2pzTEf8TjSIMTHzEIBzODw6tCw75bFOinQPmR4Hs+lROhL6fZ4gU4ytVnuwB2
	/dKv7n2CmhJvcpgfxfdSfTZlaHzv0ua2j5bpyE5qciKCv+dNo0ev034l5PaT8KWQTO8ZlxA35rO
	Xhd8xbXngMT9TaKfEdNi9jjPzXL5hbTonpg4UmYnQewxb92FiU8LpUKYI4et4dKNZ6cSitBhe7d
	kvEH9TdGtzyrulOm+cr5b46Aehgi22Ur1KKYvpRkidXXXl1h+tjVTArBDA==
X-Google-Smtp-Source: AGHT+IGWHXiC0XWXRLhLDuZXgmAdDLiUCCJw8i2x5j9gV31eu8lhfxgMpUXQDyhiq4n7Ec+gpYYStQ==
X-Received: by 2002:ad4:5f4a:0:b0:6ef:3de:5ff7 with SMTP id 6a1803df08f44-6f00deb6471mr119582066d6.15.1743868034933;
        Sat, 05 Apr 2025 08:47:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.199.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f16586dsm34451206d6.125.2025.04.05.08.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 08:47:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <539ce4556220df3d2ea4826c311c5bc4e306f9a2.1743863553.git.tanggeliang@kylinos.cn>
References:
 <539ce4556220df3d2ea4826c311c5bc4e306f9a2.1743863553.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] mptcp: pm: drop redundant mptcp_pm_send_ack
Message-ID: <fc748f76-679f-2ea7-bf8d-7dfea1244e46@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Apr 2025 15:47:13 +0000
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
uns/14282993422

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7673e997429f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D950175


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
