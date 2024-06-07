Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F18DDD4
	for <mptcp@lists.linux.dev>; Fri,  7 Jun 2024 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725995; cv=none; b=CcAxvH8SAD9eaFDTSpNVkOJfbQIQRyDSAk7Tq+BChCZ3r1oXZuPoa51rosbDpCSzGGeRGdlcTume6xkRaWei5pn6aJJvHdSntL4n3vUxGKwMSs4Kw9KTP2mRXF7Oyf/mnoNFCeCpGYJ62vjfs31lixgHoSaMD5/pAcO8rAUEp8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725995; c=relaxed/simple;
	bh=FnHZmdQOtfU9LZxDc2bOmjHbYbxnPkjROSM3QOiPER4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FJH9qva2T/HAZYHIp8Wxtnr15CH5TpVQUWLwGSSck1lscddT0EG3lqesPChOdwWCd61odgYHN67Ury1acNHYNlnJlweFd/2NYygDYjrdS7alfgz84fFS2oLEUXl3UY2UQbV1WBVIMddHwjCTwo9qJ/Az/UsAzHvXIF9H0GK3X8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gke1P3Ij; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gke1P3Ij"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79523244ccfso128620585a.0
        for <mptcp@lists.linux.dev>; Thu, 06 Jun 2024 19:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717725993; x=1718330793; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxvYD3nxAcCd1fmxelF+e1x1W0WZz9dBiyklVah6ca0=;
        b=gke1P3IjnbSu1YX5K/aXoxFGZSWRTu2FXe7Vc1CENhf+LbGZrja/mNTRLX3Aigv/Uz
         8lncXaQnUHSsYzoLwhmzX5NXGqCBkxJV+PnFAiam6NDbV9tN05FqE2ZH51GLLe5AGV7G
         DJO0e76bTL/SgNN07V4NsIaW1uJvaB5DDp8Wgo6MWNFjEKmVcEmo0NWcwTP0yApknuFe
         cZ+m2/+kA+J1LKBAcmBKQx4OelhT/YdUTnjVzH0mr1ZEKVum+xczJPZJkbKGY8y/qbqf
         SkBinQeeGyQegviEd10tZYGpTBGb8sJFwcYmmcZ2ce4IcXLOylid5Ih859TqXHzyeA+1
         plBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717725993; x=1718330793;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cxvYD3nxAcCd1fmxelF+e1x1W0WZz9dBiyklVah6ca0=;
        b=fAGgeOwZPo0d00Aacgi32Bp2/rlVDikYMyKqlxK7HeyuUmGR/jc9CS+evod1hLdwVZ
         wxASmJQEtWOUQSU/VGZEkD9AQIZh+CN/9P/InbpUXeEEb/6zp4znBhgt8xQdfhPqfi3b
         8HcOXVBZw2GKouGEQjBz46AypIBGdrWlY5iNKy6rvSnwVV+P8JBbU2Q650Vrq8b/ebui
         s/ymrdrjsFP+n+q9jCtdJEaCb9VjncK4P1+XT+KikOZWtVyZM+adegkXJKVbtakDGKag
         UZTVxnA7a9CVNDYzqcDoYig/pLPXLO1vMsMkof3qcDuhD/BadBQURfQpNMXCMvmcWMnB
         XmYQ==
X-Gm-Message-State: AOJu0YyjpKV0tnFW0+AbiQ3ddJip+BRyt6uJdvoMt+nqobLtX3ckcOtR
	yK3QNQIVspCtY19wsxbyJN5A/lWEguLqO985yLuSYwRrMIdSUPaOB+HR
X-Google-Smtp-Source: AGHT+IEU5p7cmBVav5zJwozzoBlYOffSnrdjC86ki9PlyHP/UUFlVlUFAQcM58gaiEmeeaKJxiU3SA==
X-Received: by 2002:a05:620a:2546:b0:795:195a:1716 with SMTP id af79cd13be357-7952f0d6becmr844802785a.15.1717725993325;
        Thu, 06 Jun 2024 19:06:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.191.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7953286c5b0sm115315985a.57.2024.06.06.19.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 19:06:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn>
References:
 <dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn>
Subject: Re: [RESEND PATCH v2] checkpatch: skip warnings for symbol links
Message-ID: <2f630bf3-5833-4a63-0c85-f56e8eefd36d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Jun 2024 02:06:32 +0000
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
uns/9410225176

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/831f90aa6b34
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D859755


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
