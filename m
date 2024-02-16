Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDCA77F14
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087276; cv=none; b=lZqHgM8LkU/8xIqxFW31aSoSlYUffCDx+A/fKpwxT9/Uibu6jmA9+9DPoBvxhUniui8YlHtxbq8a5jWMoVRXR2RAWPCG4/l3ea367pfN7I+Dk/NfjhxqBFEH7lnycp4af96QMqKxxqK0olraNBAQTwgOR2bVw+M3i1CcFYKNtLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087276; c=relaxed/simple;
	bh=KlXhujJXfH+Q2kFJltaapKwhQW2Ry9kQ6rDCogt9Rtc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=lwTzk7tXzX2CQeujjuIgbW9t9hlJ+N0sNwTt3yyHxB03mQlfNfPipkNqDNEW0RhObcFzz0jI4p8YzSiMyL0YvopCEty2Y4GfKeechIRGL3yoKZ+IsTedTvxiF+NX3uIQAx7da47kqvR/qbWS95bRsItyJyPcByEec2D2E+WPSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M86wdAlL; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M86wdAlL"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42a31b90edcso12688041cf.0
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 04:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708087274; x=1708692074; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLfYgkcbVJ4G9OCLcX7XGTt53XYZKBZe7ci3wYU8eLs=;
        b=M86wdAlLb82RrX2hWxwtkEsxLrb+YPrBQ2XluRbCF8NQnRG+2lgh981j+6Av5Q55sL
         OfX3BYHGIb5t2jKOE1cAtYeYgTosuzqYVYRXwj0aUSLxzYeBc2ZrSJXk64XdkkR6ppoT
         PQtujhvBg8jZUjR7smd6VQBcm17i3iRUJyRekpw4XUxE+ORoSRpXJKJj+z+luHXYKkQq
         LJPznEjLMegqoRigqpRCUgVAq9gO9pue68MVmw1JqkcKVoTuEgsTctNIcCTAaiixZxl2
         4AjND8QQsvWM2ek8vT+POZV89/Rxw/HuF78kXCh37VXZY3DCt+gaK198SkSU3EYfc+tD
         iSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708087274; x=1708692074;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fLfYgkcbVJ4G9OCLcX7XGTt53XYZKBZe7ci3wYU8eLs=;
        b=S7Ps3/E6N8ODo9zl8w8KLMDQVlFg9CCirvvyZ/DAehy+OMWxTOUoVK4X1tnCACSvev
         r3S3nt38015MRKlph2YA4gxkYtJYmuHldNQnPVMcMAbrhYjrKnNBevreffyo6bjT2raf
         4lwHmmBxh1KPUGMNuqZ3u44EY2E9DR8JnrFxv3DJYwBeAGCg/qR7lKq8jvI0mk47GfQd
         NWtKP6uil0Dq0/J+xEIWEHQmNsb1iTEEzonxMRxlaOfx1hSVuxN3vssL1GZd/j+E3ncz
         HdB0+bOma/qQa6K/XVHPZSjMUWPWpohlz/ib636SPFbJ/4zVrlwS2X1MR1J7hWWnzFpH
         0ZZQ==
X-Gm-Message-State: AOJu0YyLzWUx00Q83OVbhMRxK3qv7ApgxvuRiJwocX3NdJ+YGkOE7E9H
	rfZq217KiK0AO0cpOhuRsLgHUWQ3McyeagHTfOpgcSUDPWKQwD4NLkeAEgo=
X-Google-Smtp-Source: AGHT+IGt4uCARpBCa8RdhA17Gm40nBot2YiY6tGjUobMPi0n4qCfgQddhygLeO02ZJ8BawYVUcN24Q==
X-Received: by 2002:ac8:4e83:0:b0:42d:d6f4:8ef8 with SMTP id 3-20020ac84e83000000b0042dd6f48ef8mr3900568qtp.53.1708087273708;
        Fri, 16 Feb 2024 04:41:13 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.94])
        by smtp.gmail.com with ESMTPSA id e4-20020ac84904000000b0042c7c802a42sm1469551qtq.88.2024.02.16.04.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 04:41:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cd18123f3ed884b835f17e29b77511e5313b8b2d.1708082765.git.pabeni@redhat.com>
References:
 <cd18123f3ed884b835f17e29b77511e5313b8b2d.1708082765.git.pabeni@redhat.com>
Subject: Re: mptcp: cleanup SOL_TCP handling: Tests Results
Message-ID: <c722d2df-8637-f3df-d48a-216619bff144@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 12:41:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5138880970620928
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5138880970620928/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6264780877463552
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6264780877463552/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4601bea9a9c5


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
