Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF78433DC
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715772653; cv=none; b=ZHWMred/nhWayEdLcHTZChqwpCdRsSOrxjXh3pB4RqwjtX2S0YWSZobruO1r2lDw8YYJ6jGCcNEO3y/5s3qBYxGCl7Kkcr986noHlJu968MDma8lUfe2um9rAvp0LuegtkxpIEHbo+pdTGa5NmMOBPWEGuYDkdsADPRd2Cj7eBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715772653; c=relaxed/simple;
	bh=TVRzAZd/Ejmxo4/yqmw22uaoBMYqxYCfoD+JaDlBj+k=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Acb61iv0YEq8ROHhDEH2ln3xf5vqQxQdolyHOULBbzw4SZsLvVoLOlNYsLylcqR7U2YsLK+FAKC5koh17okMQ5H5y5TEx+LTGdNrhpOVArwjPrQXTGmX9xNaghaJsuPbxUabyqwxr31C9sWWpF5/UBVcWxm7ImRC+8ETShnzwZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxzcUzF+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxzcUzF+"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so6256413b3a.3
        for <mptcp@lists.linux.dev>; Wed, 15 May 2024 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715772651; x=1716377451; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/ZnTYVbEw+gUxVLA6dn6vav44s6jqE1yphOvQBY5h0=;
        b=ZxzcUzF+nkrc64M89wvlMeqt+RqmWhyL4xQWgTqJjuqL0ZETj9JlyfTKNum0UhaqqM
         XOLOIaWERBH6Yk8Sx7k2USFkrhONivGK2RGACGk0/rf4inEJ27WZh8v3pgDzGa1bNg+8
         QWbIyqHW6T24JtkoSmnaBkYPgT3fCt++FcEoksLWQUpwLsjLXXAfT4WCkxxLFSM4dxCL
         FxsEGXbhILg5GtAZJLlrk1SaTvv7bVYeTpUuzwpEfdH5gAVqwE4VfHls9DFx9taU+ph8
         D5X3jzZ9hOYHH7+P8BRsru4VD3gQigM/zULTBjAtX6syKFCgStZeqh65LCh3J8tB0nJS
         igyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715772651; x=1716377451;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M/ZnTYVbEw+gUxVLA6dn6vav44s6jqE1yphOvQBY5h0=;
        b=k8iVNdI2QdNdKCE9y6QhTvJt0c6pIOFjakmyCQR/Wuj8NFkP+5aNq9I4MBwl9TErb0
         R/7NQwhWnb26ySym8+Lfd1e/UPMtqCbpvmJNPHiuXeXlvl9ZdnW12CzblglxZ8jhBslX
         9SUO3XoQCuYRtk5yg1Y5k0TLYlXnTyOgu8tiAp9tW9+Fv+QQkmZmgh2w6VozdJz5igwz
         cghYvLjVN2Vy5ovuAXsZWlDVnEfmTXuCjSuKCeu716cvdfyK2gvlTDu5nJSZJ9D/bW8h
         Vpa18hR4KjFZ9mk5amtnQELm3hw9EoDPls/TcO8H07HqcHi51wiLTxo0f0SmBT5XHpxF
         o1xw==
X-Gm-Message-State: AOJu0YxCt2faL8FHGt4Otquod+MlmJCFNTqT0Gh1Y0lEfvQKaXGwvBqq
	wFuSvdQyWWUXvczUjWGL2Sx9elYZ1KFxUELp5YvmcpDkorklGfTYQbl1
X-Google-Smtp-Source: AGHT+IFibt6/4ra8KXKM2J4PMBRNc9od4ZAcEDbSNfrrjtxtnLmQjwY3bhAKu13PvkDhZoq9QYWyPA==
X-Received: by 2002:a05:6a20:96cd:b0:1aa:4289:5921 with SMTP id adf61e73a8af0-1afde1b0187mr13327790637.50.1715772651224;
        Wed, 15 May 2024 04:30:51 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.27.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b02329sm10828031b3a.181.2024.05.15.04.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 04:30:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1715769419.git.tanggeliang@kylinos.cn>
References: <cover.1715769419.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 0/2] patches for new MPTCP subflow
 subtest
Message-ID: <856a7b3a-41f0-1973-22f9-3d35a5682c48@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 May 2024 11:30:49 +0000
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
uns/9094420496

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0c3b8e6998e9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D853374


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
