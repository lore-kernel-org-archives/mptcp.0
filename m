Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5963B8
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905537; cv=none; b=o7kS3ifeaCQKEJJSKPo4jVby2j7eVORwOD5yaglNSm+/ZwzEh+2H23tbisbpu2lc+s/EvV4ufsCBTk6oOb593sIv9py9eKd88NzQ8jjulB7F1LUZdn5fhDdnS3TD1zVpL2cb6nthAC5VHTDHDtrzVCm0TGUz0U9vDIR/ZXxOVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905537; c=relaxed/simple;
	bh=toV5UQ/iLeFb6KeKx0GZxvgHKC9HnxCSfVAYNWdXhaY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VwWp5qvcA6TGkBmfdzjrqIpTCI9pkaIG8Taak9aGLFs+Aw+eNky8VJeK8hMXUCBGY0712e2iORNIBOGp+UBXyGqZCbLjsTksFzPDdIvO8lyUIcoNXeBE393+loVL5JCoHifTlohBxTP4YigmjoFqxRw5wCake/X2LQ9HoFtG2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZc4VGJQ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZc4VGJQ"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6869233d472so4959036d6.2
        for <mptcp@lists.linux.dev>; Fri, 08 Mar 2024 05:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709905535; x=1710510335; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTeyMPymf7c32o+GAc/x1refGC6gF/HDgtTUDZaTIJ4=;
        b=EZc4VGJQ1Y5qGJN/kZQZJoJ24NU/NJjwfyN8ZXOgTz6dFfmQF/I4QqNYZ5E63FfvMf
         IDeh+ifb+NRT4A/ozftih/AIGesS92UJjrHlmnA/QyRoe0dPzDvNVViqB4FMeD9N6qHO
         6dEBn2HUFDWECKOCz5wiQ7sZ+mnjkjvfeqOmO5f1BJusyQ3CkE+qgtDD+74g9QnspDEI
         MipBdBv/eJfpMOXLjEFYWUgflIIKjHt04cw4F7BDFx0/joLMs/qwjcbF1gqwU6DlWsuD
         rHCSCQf5JmRFDDtVfdOHL1WTzqlkqxeFI4jn5K1SEOVWXBNmRA9Qi7kE/9vxl1wrxuLk
         VxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709905535; x=1710510335;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zTeyMPymf7c32o+GAc/x1refGC6gF/HDgtTUDZaTIJ4=;
        b=rI2xtnp6i2oMZ58TTQ8nsB1fP3e+d9ZhxjiOFDOuC8OCetQFZ2BnFkFqvcUOzKcnhJ
         Ddqja2hzfW6ADMMQggHr1Wfn7S5GMgDpnCteivCPq8UXT6sk2cRo6AZjJLskbwZ6Rwyw
         ODut40uhDiLJVOP1RIqGJJiRDu1nJ0gm53hBKoh2cr+uR1wUrXpkY1n/gShIlXipfYNb
         Q+bz6/NoP+WBLGIvNE/ct725DSmNFdxr5MuBBeiQz4kGcQvDL/wSpcL3hBS0xn1IVPq2
         i17GOOYdACVwFBEAB5X1048n+8ExSjWEub9bJp6GZ/jakmJ+Di7v2UFiyiqI9AYsVQ8G
         OIlQ==
X-Gm-Message-State: AOJu0Yz5rnKSAmBIEsJfe7HIZQSr9eAQzOzPFsTGuurhFsK2lDaXCUUG
	I4j5bgWf2kgta+2rUg+pj3lyhpFIOm1pwNaSqcBchVpKOPoUxXsOJDMyYOQ=
X-Google-Smtp-Source: AGHT+IE5dtK0y3xxAWT1jojKILDiPX8kmHPP8ALLkGS1jOzdn/IZrGcGWXEU1dKHQiFhdBT3kM2yZA==
X-Received: by 2002:a0c:9781:0:b0:690:19d4:5eb7 with SMTP id l1-20020a0c9781000000b0069019d45eb7mr12909305qvd.14.1709905535143;
        Fri, 08 Mar 2024 05:45:35 -0800 (PST)
Received: from [127.0.0.1] ([20.109.37.2])
        by smtp.gmail.com with ESMTPSA id oh2-20020a056214438200b0068f572af88esm9798738qvb.75.2024.03.08.05.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 05:45:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240308112504.29099-3-kerneljasonxing@gmail.com>
References: <20240308112504.29099-3-kerneljasonxing@gmail.com>
Subject: Re: tcp: annotate a data-race around sysctl_tcp_wmem[0]: Tests
 Results
Message-ID: <c7268a84-51f2-4d81-cc72-a263943db0e2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Mar 2024 13:45:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5015312026828800
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5015312026828800/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6141211933671424
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6141211933671424/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e55bd7ed14f5


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
