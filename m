Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B75126F3B
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773376071; cv=none; b=Y6GdhL4K7EZSqccY9S0epf+85vBfN+OznoOsgEFszguRxscxePOBYsCKZtpBjxeUHBvdW3vkumOgaQTLVtWxY8qF/aTKe1mJEmJIQdfXzia7OQ7Wf+7I5MegU8+L1oLcbS7xELqi9rd5oaJW44zG09CY78dbr/OD2gCTTZvrbTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773376071; c=relaxed/simple;
	bh=MNCL8lUKfQL/PZmjei+xhqyoAduSnl2oFyR/pQtmccY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Qi29uaJUjjVnA2ETL9HijO/610Q0liyMvYFspDKY18f6QeYqyPng5du6ReInhj6NSYDImQKY0ZddsciDMgq8YMaZ4R+hqA+nUTIVZvtIfFrCJgpNvybn/X7rERUH9MnuWpY3ukbNlqSmq0vIQCUqGSvHDHpB/Ofn8jmDdgxtars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsyqefkK; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsyqefkK"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899e85736e2so26972986d6.1
        for <mptcp@lists.linux.dev>; Thu, 12 Mar 2026 21:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773376069; x=1773980869; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQfQBH2bE2lHIgiy047WkDYl8a9ruE1VYUOH0IhnGHQ=;
        b=ZsyqefkK6q0VtOOiS8SqNsXUM/Yjm6rBYIW+EKyOCPKxd/oYnFz5x5zuv4EuOZsTJ6
         nnNgGD398E8jEt2H6CJu3SBeICgspJM26BuLrw98cTgRdWBnySevT3wfezhs3OmJrlIZ
         TRT73cit9h746xd+wh1RgGM0T1MV6h9+FAFbxdage6UKCLRbSLVTRH6q3dSrxD0d2Dhx
         9YOSsPooQeZZzXYDj3B6mgyRuUM1G/kLcnHCUdjb51+9nEzkFprFfdMGy1I+e2ipOwsX
         L5NdxL2XynY/ae5qXYoBlMfdV2RqH5+Tw0Hn7VB47l3ImQ70PYdv3H/VboHK33V0LkYF
         R3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773376069; x=1773980869;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQfQBH2bE2lHIgiy047WkDYl8a9ruE1VYUOH0IhnGHQ=;
        b=AG/uZ3aW8ItnUSRPU9qjjfA5FARP+23+3rLM+qxXTfGeSMpCRArx9c6CF+R5TfEs42
         cRb1v0Ra1QCluYAPwJn5+TkLqmPMPXKxD5qeSjGTpWE8VLb2u5shdI2/dL52RU13jtrG
         kzNOZsD2LzG0UvcnmCwjEipKTM3WEDiaXvQXojkhtTIqAXWUKoco9Cbk9p8SXeobE1zx
         NhDNX4EeTJ+UK1bsDuWJLe7AXtf++4casGOMOL3cvAn70n9SDl0j5VVTCFhetss2bdmj
         IxMbn2QeK7RnwDsglfsHWlc3X5AxX9+L+ResvJK8WNoo28jE+BHHvBJqBDNy2VYCO+Ua
         XQBw==
X-Gm-Message-State: AOJu0YwldvvGGRPyJBwuqh6TZz04G6K/rKqsLu4iSYdGLVFrZygpNoNP
	zx5MuMwDxRQxS7m5wRUbokWa221lFZdIyvDvq6lwZR7lWPzVtNSknbrdXmDR
X-Gm-Gg: ATEYQzwF11xRa6yTTQvtnETiy4qSDSKFoRH5b3wkGpaFI/hJNYOxeDKK8yA6KD58+bO
	uVg07FLBXLhc/Hn6ZFWTSAqnLxe1qOILGyuJHLBnUiE/nVc0gJ8fy2V8mO9aNN0DHqv/qO/rUeU
	Lpp4lW4LXs0/+vQzXu5fJYZG7bagYxm7NDiCmN+L3oK+AK3YPt3rrohEY3UsVTPcvFU22aMxgUD
	9K4PcMj/T7+w0qS2ms7yTcLKBl0DwnvTNhqo6lfNjPDpF9zt/Vy4FNLeN2VbGUnpYLAIrzMlN5f
	mO06kKz3SvB19zfQvXTHKwBm0SAjGqu/7OKuT/+Fn5hrzXXo/6jgUfzYYXVOKcL83STOMrcSvyw
	C8CyoEbWWhW+IYHmu98vdQcApIzFZgwxxA9njmP8tMEJLMzZleXOTMOhFvQ7siJMCTqp2QLeuGG
	Eyk2p011W63LE0A5WqCR+8j9xFVzuNEUQ0sqc+ZQ==
X-Received: by 2002:a05:6214:528b:b0:899:ea4f:12fb with SMTP id 6a1803df08f44-89a81ce0280mr31483476d6.2.1773376069212;
        Thu, 12 Mar 2026 21:27:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.126.100])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beb4b3sm48615776d6.14.2026.03.12.21.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 21:27:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1773365606.git.tanggeliang@kylinos.cn>
References: <cover.1773365606.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v9 00/10] MPTCP KTLS support
Message-ID: <98a77c2a-ad83-349f-0ad0-c687637218d1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Mar 2026 04:27:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_splice =F0=9F=94=B4
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 4 failed =
test(s): packetdrill_dss packetdrill_mp_capable selftest_diag =
selftest_mptcp_connect_splice =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/23032875328

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6363c87fa2fa
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1066012


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

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
