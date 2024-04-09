Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04794C69
	for <mptcp@lists.linux.dev>; Tue,  9 Apr 2024 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712642856; cv=none; b=Fwi2KyTwHjjvmGIuqfvZodVHjTjRkvrWyTQsFhM4oYKQnOG04DXh/x/7yDNjXwCuOugdHauqTUxw2Il5euJWxUqVFSXYIWq6AWH8AhyUYqh1NLYsaP09MWnhhGIBBlOM+ZnhyMFy3le2+DWC0t22DUzXoFxorNTQ5EQ0+9InJto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712642856; c=relaxed/simple;
	bh=IRtkLY8qPpdIw6c3eV9AifXjV1OfgOdWc0PBiD/sOtI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=NDI3fM5dtQJzqjmrAsEbnr0Bs6CRNOYR9jtrgYXwCMFRwvYU1i0w62Z0+Ska+56b7kl3X45Cce1fgNX+wkSFk76nJ0+usdzET4QHGPWEkMdJ9FTB9x+koaFO8KQvLVfQlg9lkD02MLHEnpQUEkzYIIQwRw3Nz9hEHoGzYv1/Jrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6855hBk; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6855hBk"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78d6bc947aeso48847485a.0
        for <mptcp@lists.linux.dev>; Mon, 08 Apr 2024 23:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712642854; x=1713247654; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u163yaNP+lzqxDSTDL6ZrHxXHEJWkaX8tfNFgkSIgrQ=;
        b=m6855hBk4NXZy2qJyt7jcr0lsymWLtEYj8zywXY25envuCJDTd0tTYE+X2OMFozo1G
         gtI0FAWIrlvmqKj0x85gOyBYvYzurY9bJoejo2bRvcpEAo8ZJmO21yhm5ioJs+20W+t7
         s6lD5SM//XQbOL/PbQFKDqqRqbeUuVoxZR14MJkvkWTH0NZWH9IL8nVEtaAmHN0n+UAf
         VDMP0bEvzUgvLw4JSk87GYEjwqAAbWe0ngeN1q2XGBz+XZ8mBG/ZqpzeND6Q11fcOPs9
         chPftQMsr8z8VknGb/gm0dGye7efwgqFcCqGLn4W29r8/Ijm4s5yLUWPY5krF3utW6ZJ
         GtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712642854; x=1713247654;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u163yaNP+lzqxDSTDL6ZrHxXHEJWkaX8tfNFgkSIgrQ=;
        b=MFYPx+hqPKAPhb2Usg1M73F9DAmzi3jb2kWTS5X+PNB6G5wN+HuDbFuiYEvAlVn+Hy
         VcHnhy5+jEShVcnaLkMxoQAcdregIlSvmue45uhDWeuI3QF28X9u3IRUxCWgks9HryIt
         cWmcPEA9tFC8pOw2OpMx4hO5F4upOGF7EqHUeqGV3eIP7rHWkYEpO74Z0ba5BHpudNKV
         OrcucXyptJvJa4mVdfMP+MMgFx7/44nJSY2iJPeeQkb4Zn75jS5rDPD7BKSuPUwaK4j0
         Bz2Lr0+zavQeOHTjU5JyBfwwf4J6nzsioCuyt01oXbbJ5Gkb9RTBjr2/q/8JT5NFnwQ+
         GAGw==
X-Gm-Message-State: AOJu0YyiGDaIuFUDHuE265+t38GP1mbS4E404DfSQz/a50tNyiKb9ibF
	ousDW9BNwMBszRjFNaqslAWs/uRLJJTTFYNqxO5Pk/LkyDj1/+2CrnH18to=
X-Google-Smtp-Source: AGHT+IGNwUWgPxQCibAi9TMLmOojkPXO0S6qmQOkH5yKZjadNXQ9wccjcmrcQtVyg9RxOn4LhMCZ6Q==
X-Received: by 2002:ae9:e606:0:b0:78d:63a4:bf80 with SMTP id z6-20020ae9e606000000b0078d63a4bf80mr5581107qkf.74.1712642853692;
        Mon, 08 Apr 2024 23:07:33 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.5.176])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a0c4e00b0078d4732d92fsm3853151qki.115.2024.04.08.23.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:07:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1712639568.git.tanggeliang@kylinos.cn>
References: <cover.1712639568.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf v4 0/2] Two fixes for test_sockmap
Message-ID: <a142f6ff-33ef-d9f8-bcb8-7d3089deef8e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Apr 2024 06:07:32 +0000
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
uns/8610829214

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cc8f1e4c2ba4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D842664


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
