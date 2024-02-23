Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04EF3D6C
	for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728406; cv=none; b=Fy2/N91/Y+Ye8qehm1p5ZMNaho5evSSBdkBjD8NxET3nms1jdcqq/0iTWm99UN+nk29LYn0ru2j3AVA9aJR1wXS/zEc5FkzE0b2DhDuDivs/1m4cxwXjir+8WPcbvCB/tnkPvoAw+Ng6Aaez6m7vNPGyoUrk6TiuDeCr8j8Cb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728406; c=relaxed/simple;
	bh=fYbnDiHAnz//5jcJxICv/zLD7eB0cePbqvMjPodtnpI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ARJCWIJHqLBLNRmSb45Zya3+xYj/mHkY7nZR4vaqtGHTHF7Yig0y2D1KOE02FGBp0i+r1OeQihd2aWX+T8hvD/hLwYAH1wd5IurKEkW2r0MvULmPf3FsEvyjzIHpa0f6atURh0FGrmfC2tlFvmDKCLNJFbRnd5v5aaNrUJ6b1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8/Gubsl; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8/Gubsl"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6087d1355fcso9585947b3.0
        for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 14:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708728403; x=1709333203; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGqjuFS494hrEVbUFyzDe6iwYE70liLRccE49QAoYsg=;
        b=C8/Gubsl8zG0g0+/43i9lMBK+gMTBQNeNgnT4rHmLan173U/fPosnA4GviGGNcyWOk
         5dbsESghgjmdbAGrNINwsJ8EHHdrPaRo9fo/KYMbFmcXjLZlFzpyGq+iJjLEJJnlO6RZ
         dOEAUvBTPGdlTGR8EUk9rVOVHQTrpMJeD+n8FnKyQF8vl9YCEyY4x8TNlVWd02hYa6pB
         VmAAtq5OULkvncz6K54dEmZ+YGS1ylNvfFhC3wGZviMlAMq/U5Jwfbc/wDuHHj4iQq/u
         vUwVtS+amJu4EMl4NobzUgE9o1Z7Y9xV+vHUJwQM2YWVIDzVW3MEumsXftzqH/2ndCCp
         1qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708728403; x=1709333203;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DGqjuFS494hrEVbUFyzDe6iwYE70liLRccE49QAoYsg=;
        b=Afu6mx3dBL5yAQR2Byqxjs6ViyvTyZ84TQXtsMpdNsgzf20XPDXOqS8qYVnYO/CDdM
         ZTTGIZ/Ve/MmjFrYL+Ow7+uZotR6NV075JMMDzeewcC6Z/RdJasny0PHy413rEQ6dECA
         u5M3mYP5JtJCi1tsgfk1ld5S8S1I9JTVE2ijmasMrwbChKW47eH/VLG99RO2uBzb2Xbg
         GvCnIR+ydgfUDIxWo8J2KWbcWMca3oC/WjB4wItnuFTMrwgbIJcxZOhGneTIBVMaCTbY
         Z6DOebJZt2HM2qaf4wkvjsSg4k77bzaHux/WmHT6V6NqlYwN8v4I+CijOaFHNuTRzpHD
         FdLg==
X-Gm-Message-State: AOJu0YzLe402Lq29AepdqwZDEyncX74w1urt4ALriMUEakw17JY+lddY
	h4UyRpjNaLmYInyaHexw1R74GzdYvrfjd3PkkXcemnPjczsraHV1yNfrPYI=
X-Google-Smtp-Source: AGHT+IHRwXixextpjwPZQO5seImgBJrGjV3flOtjjHYL8aYYCddwk4OjgJGhTQ/A06JKBUXgk+32RQ==
X-Received: by 2002:a0d:ca97:0:b0:608:6ea5:d555 with SMTP id m145-20020a0dca97000000b006086ea5d555mr1219065ywd.41.1708728403481;
        Fri, 23 Feb 2024 14:46:43 -0800 (PST)
Received: from [127.0.0.1] ([172.183.131.17])
        by smtp.gmail.com with ESMTPSA id h6-20020ac846c6000000b0042e637083b7sm953435qto.26.2024.02.23.14.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 14:46:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5253780363327733ee3ef1b57f56b4c6d8453ea7.1708657487.git.tanggeliang@kylinos.cn>
References:
 <5253780363327733ee3ef1b57f56b4c6d8453ea7.1708657487.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: add mptcp_lib_verify_listener_events: Tests
 Results
Message-ID: <0ccadbe7-03ea-15cd-7219-35f5eeb297d0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Feb 2024 22:46:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8025651818

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/44b36541880e


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
