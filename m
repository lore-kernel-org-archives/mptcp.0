Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322938529E
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543343; cv=none; b=f5mnyvuu+9Y+euz4N1NAYXnBBV6fhZ/QEYqH/smGcwSZME30BZK9TvWRw4YrxjajtqAkXWJGqk14iEg0FyEcQ+9rsOdB0XQZYnnUpYCUIJNMMAofPQW60OsmGsXGGp9n/qQMoSMSIVSzt7q6FEmCit/+Gzw245XBMPpEIx4AEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543343; c=relaxed/simple;
	bh=yXnd+fCy1vxITwPdrOE71u0eJJQ9/Id3FRuMljrMqMA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=g6Y4KbqLlN0Hh8xoWRkD3EjdZlD8I1GbwgmlmkGpDgCMhO/Q5mQjN0pTHYuYLQQny6ZC6yp1DXTQPc2AFPE0hMT0rkfd0JRdVqVhrYypyqqCZRm3tweeBDtyq3KJz9NCQi8SdcCLNZreQjiXAY2iRpZ8kixnAUreU5sOTMFdJPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/DhUUWb; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/DhUUWb"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4e4f01ef8deso251563e0c.3
        for <mptcp@lists.linux.dev>; Fri, 24 May 2024 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716543341; x=1717148141; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ThvvTcz7PbPdhJzuS82lhecbh81wn8mQFf3Cad/j4M=;
        b=K/DhUUWblRUA+GGLERQXRow+Kx10mTtx+xom/CGAqss2QXjQ6WTNZoS+YUKd7AWvid
         kik5kjezT7qtPiDrHu+6jS4weJF8+FugWtGM9UDuyvgDnG9UsYldjPLgiNG38+kO1ljY
         1hskb8/gNb7mG4nM8LE4EUkoidLSCrbd+A9n3k07eJTwMa/dcagvqp1CKZq5/7OmGb1z
         9AXApLNu2qjOoxQEpsoB8mHIrYEqiuLV+8m0sDSV9k+1A3jXsLdyeHi5VgVbcEUn9Sww
         vgPTjv4copzODeU3O3oexeZySmXb7uK2udB/3OQeo9zqY+wFO3sNt1t2zOnlQz02io4E
         qZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716543341; x=1717148141;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ThvvTcz7PbPdhJzuS82lhecbh81wn8mQFf3Cad/j4M=;
        b=J3Q88nyl76lHv6kdOFgQpGjKLhJ6JKJf+s+6P5HQs8saCzbcrx2TPzw0K4RnnVFlu2
         hgsMkO4gWAbqBNiHn0CG+lpAIEFjueHowi1DptXggTivI5iSHkykB83yFn3Kt+wh9vBN
         XWrLdNf0EnyncHhVbSEayITNpEW1QbWjVIhEA1DN+HOLejQymPGc+Y1tkezWwaHMmBBx
         FnNh+RuZmLwjekaGilfb7dDAtVasshi6cQMBSP93gIJtX++rYNqPa+rbFiteWXZSRhqa
         7F04mt3aa0gpG5LWx5okT2uMgZi5JX7IGQ8KVvVWHvHPE/XdLDbgbqQFfuX6Tfo2tbaJ
         ZBQw==
X-Gm-Message-State: AOJu0Yzpchcf7lv4mZsps8wcEov8hgRMhGan6zyIEoxFRRlh2ouEp47+
	T0pgLpUATNAu+m9KmB8CqxRVJuF6A4AqNMcnK5QwEfPlmpDBtVqP/lF6
X-Google-Smtp-Source: AGHT+IHSKPXJ9fVyv2DBGNMZMLfC2Lw/IaIk5f2auVhrHEhE/35K9WPHBNSzAlIU03CvMoCX5tW8ww==
X-Received: by 2002:a05:6122:920:b0:4d4:eff:454 with SMTP id 71dfb90a1353d-4e4f021f182mr1832031e0c.1.1716543341011;
        Fri, 24 May 2024 02:35:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.200.199.185])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb1800900sm6138821cf.49.2024.05.24.02.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:35:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1716533107.git.tanggeliang@kylinos.cn>
References: <cover.1716533107.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/6] use helpers in lib.sh and
 net_helpers.sh
Message-ID: <4699518b-4351-b666-8845-e6ff8ed98e63@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 May 2024 09:35:39 +0000
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
uns/9220006386

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e3fb24f4f651
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D855590


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
