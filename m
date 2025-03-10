Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B923A0
	for <mptcp@lists.linux.dev>; Mon, 10 Mar 2025 05:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741583538; cv=none; b=AUi8cHQe1hO7IVsnwYH7ORiCHhQqXgSKNSP1omSK8kZ8+AWh5aFucrx11iVean/mkRTuLRdi0XIdrwB7BiSEaL4KKnL4nif32PvyKsFvUMwbKJqfIB++pSCuvTpR38khbyXWWNs13Aa92YjObp/sLIrgAxmODiJBdoqDG5JOqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741583538; c=relaxed/simple;
	bh=QLTM8G22MnhRnH1G9PxTLTSROsNxAgmJHGEqxwdSkEw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=qjGdR1ruY2irpmE9jksdgntLQSC9zLVQ+NKFXBb1GM4oIYan0bjypZpqfZT0OzNNbHM1uNk+HPQ4ipklW0OLYe+1GEIpUz8INQeTgd7iPCr+8DVE6tSutg3oi6EjQ4q95EoOICOdn2Q40wJRXhEH0mHX2NsCIPvskFEvZHb4YGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqLiTyqW; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqLiTyqW"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c54b651310so132869785a.0
        for <mptcp@lists.linux.dev>; Sun, 09 Mar 2025 22:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741583535; x=1742188335; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDR9YxCci9JlNrV/DORDoHeebYvNUlJiw+V1AjJoKY0=;
        b=TqLiTyqWiNgNRLSpgreIlooykNIkpcPyLoNvVC7RRkDbSm4i8rwbWznYXDTYizOuiW
         s7ERz9/1VEQGLRvOKZwbxZG4dWga1KY6VgMZdxu9rUwhVhm9a77HYHk5FemuQmU2exGB
         OHHaHWzx7jp/tQPYe+7OW5ZqTIpNAFt7aYw5JxxEh1Y04Km1Ak3eNoSNDmTUYcCVk+tv
         n9kvrT9R0cOXH62Gnyw6uWZCbQ7Rjm5i8ccyF1dgH3h2yagVH7PgoEMXBL5ZTWEPTLS9
         tQe1BZYpPazv5edfGBSDEvRHEOxi4ylX3V1BDdNbeRnC/4uez9e4E80uYOrhOFOjwTNM
         hlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741583535; x=1742188335;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HDR9YxCci9JlNrV/DORDoHeebYvNUlJiw+V1AjJoKY0=;
        b=e/X0b/PLjSVDYCbxcVKYXzta9D5JRAxCW7Qim/qpYPNA5F1EyvFOAXiVtDw66VilXB
         n1pEbm/oKUjdsuxJ1bLDKpitcX6zAN6EbHSUktskJhGxoiDk2PEphp/L93+U9PqJutKt
         G3OR/kGzJAB0z43KDffsE874c56CyQ128/H914lOdlZ1S2gLjRcwypPBIUIRGHpzbyFi
         gvZLjnxt4CcmdJwyTuuha7WV8qzl36hN7tau8rJBrZhySBMHDdrJ7w7LKuIvIKY8r1wu
         3voZkjvKzw4tkNIGef8NySKKkWiGIdG1XHzxtNd0HRArecqSj3mVe9sCXxc/ttTq1bW1
         Dvaw==
X-Gm-Message-State: AOJu0Yzywf1Kg8q4aSmUABqP4uSSiM+BZ5NATMDOHh8OImdhR7roIcBZ
	CPu43pcsf+WqPPsKOzFq2HAwS8U52UXIWjRHyUg0tSA1CtXVRyDf+PHN
X-Gm-Gg: ASbGncvDq9/PyU0xuJceR500b3DHv+YGNhWSuq9OXq42wQl3BmpuEUBpjMZSUUInFHd
	eRDzqVpBWeTX8hgIQ9+x6Ucvd71clmuSSTd+wzNw9y6ddcWuv0vnaEYlBR3CvlSnxQlZAsksDFa
	WZa2HdxeCOKVWgyPXN7/qR5Ob0065sZhEMIkq6tNJsOdWQrAB6S9haruhrfQjWS/ifiH/gaxVQf
	+xzYU1Ka488C7UG/bZ64nb95YtezTUu89saFOpcjlVl+I01SZGuE+1iV0Vs2Vi9hnIBIggWPwNG
	zB2wylUw2lCkndJ21nVWEOGOvKCzSDZ1fAnNHAnKf/J/soJ9bAKZ8a3a
X-Google-Smtp-Source: AGHT+IGJ4URwEDab+x5Hx+zufLjpDAINEW9fwy4S2Lei4dWG9vAL1a7rzqeeWmkpro1okto4MgkUSw==
X-Received: by 2002:a05:620a:4892:b0:7c5:4c6d:7fa5 with SMTP id af79cd13be357-7c54c6d8251mr593827185a.48.1741583534720;
        Sun, 09 Mar 2025 22:12:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.246.78.63])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c555b74a32sm101564785a.19.2025.03.09.22.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 22:12:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1741577149.git.tanggeliang@kylinos.cn>
References: <cover.1741577149.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/2] add bpf_iter_task
Message-ID: <153893cb-2a8f-baad-8ea9-1ad35d440885@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Mar 2025 05:12:13 +0000
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
Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/13756425685

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ae5890ca8bfa
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D942077


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
