Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF26FC6
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715434268; cv=none; b=DIGwHY7G3AycyP+PUUM+/x6SrgdeIF7TTjsRYdz1GbSCPF6z4Oz5lXiyCUGTj83K2/Yt9uGSqS52hV85k7jPP5RFN16edRUti8df4TtsEBSzylZ6IMqLAD1y9oo617ec7GZz5AUaEEfj8gz8OsJ1vYzk8O4HkaMG55W4LSTfMQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715434268; c=relaxed/simple;
	bh=GxEn69+EcBae/AixL86hPaITtDk/Ld8llhkyTWCIjMU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=NgKbVKyW795u8je1sZPJ6UXMEWePtkvUVy2gM4cq8A43zLcNlsNN1Ng1s0RlU44g/Jhn/FGuAIS9z7c018FcvvCH6Bh+VL5EeneYv5TF8a2sHx7NUYqcZsdpGUDRIKkbBYouOEj/wGZm8//yc3LHtQO+cpnDY/rh0zD5ieZ5fpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCOQe0Ni; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCOQe0Ni"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78ef9ce897bso217217785a.0
        for <mptcp@lists.linux.dev>; Sat, 11 May 2024 06:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715434266; x=1716039066; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbfCULOt/3kRDGTFCP/8X1pcoIGK8pzVwpl8z/gVRIs=;
        b=hCOQe0Niwb140a9FLrk+XYKTX78YIRZmp6HdOhqIz/2rwCvXm0OvxWlb74bKneL7Mc
         ctkbQxTmeJyHuMXytigSq+AkriRtQPVlRgHq4jKFZQbHa8Yfr/fl2Yg+9hJKHEm12ymF
         KY+P9OBWnP5tZTwTjVKCeM4dceLpht7Mehu0I3SoZ9pwoGNPv9LHOJFXrf8ScaxUjo4Z
         owFiY6x/6cuZ/xFiSZG3n1+1USmG2VmZwURNzFMCNcPqxbxKTcDB+MhUf/dlThYo9QI1
         Yw4B3fAB4ZZIhqYAxgI4sGP99YzBYOV+oh/lJy2shJo49hqxhHL0v047NaQLRz4Dz4Si
         W0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715434266; x=1716039066;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbfCULOt/3kRDGTFCP/8X1pcoIGK8pzVwpl8z/gVRIs=;
        b=IrEg7aXwh8gVc+LEgqbHV7SJggooGW538RfifdhWWkrCCvW3rDcbmXzsVdc1CmsZzi
         sraZaYwraCfE9AoIqtUi2dgUPfkEgHZ4SkE56YSydPf02t6zNVK07xXTHUV+Rocmu23j
         +HLHBoD0CE9AT95YgKV6pbCQP+2Eo6coF//Vx5VxtsEZ60weG0Hb5eRugB9T1fno9YxU
         RFCRCUFT7fF+kCqlwFl009rP7wijItBuSlPWudCZpCupPpraESErXaXSxnUunQ6v0HqU
         IjFxK9xwrDn1x/QiL0VD7JFV1/FXDNovGP76DoBkexM2+vpgwbBlQg+3PCI4032IteVX
         t5XQ==
X-Gm-Message-State: AOJu0Yzbit5mn6aPps2qMnnrZfCrq2j5o6ZEI6WGJGnBiJDw8YS0vfdT
	0ASzAbBv00ajZD/nFzFKR4Io0e93sNYTG0Noy1Nw9IrpOuw6P/tKWmMt
X-Google-Smtp-Source: AGHT+IEpz9MvVJeYR7fnkdjcr/UKV3Eofu8zOY2/fJqVip02xwvSUl7ifLzS9uB977t9FFRuYXZRvQ==
X-Received: by 2002:a05:620a:4085:b0:792:ba26:741d with SMTP id af79cd13be357-792c75ac04cmr676744085a.33.1715434265680;
        Sat, 11 May 2024 06:31:05 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.82.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc614sm277692185a.88.2024.05.11.06.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 06:31:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1715431177.git.tanggeliang@kylinos.cn>
References: <cover.1715431177.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/2] patches for new MPTCP subflow
 subtest
Message-ID: <c522e38c-a189-beef-bd7a-790252427522@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 May 2024 13:31:04 +0000
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
uns/9043831394

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a97ca4e44f71
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D852530


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
