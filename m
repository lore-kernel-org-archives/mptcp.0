Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C6179
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788015; cv=none; b=cistLUn4z1VjoLqF6jfTXoICJLM3GmwfrN8o9DIh1o1bxd3E6w7ddnlIziC+IKudBqszb2OL1zGz2k5ae5I96g6DfipPF4PmtoKQxjo1mdV6Rd90wP21yFHdVNIWCA7leda/J5yt1iP5dV7GEGGzusyAv9lQ0bCXA7SGyqemvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788015; c=relaxed/simple;
	bh=Mf8O6qrAuWuc4Evwhr/QjE7we9NZbfoa9wAuRb0TCAQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=a9x4FCkTqsV4x2enIJlkuvsxrlkCyjU7wlZDnek+iV8+o8E2+HBgFJ+UK+OYp+/E/+oPmFEomB8vwLt0tT3ym4KumnLGuvk37xd10abVmMMY3ZTF8B/ddxPeOWuUVet58zNjvnOJjsIkz6jneERza/ojUxhNkNJJcHthiPUutjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJLMfzHB; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJLMfzHB"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-695df25699fso21195976d6.2
        for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 01:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711788012; x=1712392812; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hu7kNmo+PnakhODg7GILM58OB16m7qnnllQchm5uYLA=;
        b=ZJLMfzHBa9thnTBUdCdgV8Ifj5u8H41uXkay+9CL8uNOOgdB2hTLsatvBsb+yvErMR
         RzfOHcS8isFY6yTxzBMK2Tw+yZxCCDT3hmtiXhgyrGvdoDtOAAwwuFGJTivOeI5pID14
         tCW5nnYC+DmIYfc3+qAtmCGtwEE9Y9xWWVgl3I6UqpgGF+XaALNCzYcDd+CGpHcYoZmj
         2XRJXP2XlWQG5uJN7sF39ZFQkQPEJknyIzJMBlxX7aOg9LtbW/US1jUlsRtEgjzaMCXv
         b9SIf0Iqw7h5IrweEofD9bIdUwBwbCtFIvW4m9vL5a265IFTOkWPJe1cKQ/SYSKp/bNv
         OvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711788012; x=1712392812;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hu7kNmo+PnakhODg7GILM58OB16m7qnnllQchm5uYLA=;
        b=R/If+fASROaQL4/pKJs6BA7YNUdaI7HYh+I50XrUiUrbbJ48WnKx+9Sc2s5GmXgmH0
         lrjuIOKW4VZmcv9gS2WIEcNeKnpvv6gKWIBfRSs6YVS6NPQgxM4uAH31xTM8fRb0ih0h
         gVWRHZnZjkqxYR/1lYm8obGhL0U/FO4229zBz4R4ndrRvSlRqKlrAZK1jHAIytSTxHWL
         NWWHPlTlrf5ITNqEZz8O4VbPbCYnjwQxZ64A+bfybFjXufMnGifxp+KeClGY8LnAGimN
         Sny96Q5UZoVMiMuBwRzjlnF58HKZf7Yzbuh3TN1d+O/CJ6Y0DjwUsG0qtGpVljq7RjPF
         TFSQ==
X-Gm-Message-State: AOJu0YwzkC20dyHgW1UqyXQvPiI/IGNq6cmIJzxoQxgmQWWXb8s39PSV
	wvAXQ3G9L4supM2Bb1GPQI3ibTT0GznPlAolsR/yRM3djH+h5gKDloD2VCw=
X-Google-Smtp-Source: AGHT+IEMOQqwr80qQ/zx9/hcWXb/i7OjdXb5Q6PuZC1GXruPAsVYTBBZ1BVKAkOrnBJ1I5HJTy/n6A==
X-Received: by 2002:ac8:5cc5:0:b0:432:b84b:f05 with SMTP id s5-20020ac85cc5000000b00432b84b0f05mr5627135qta.48.1711788012027;
        Sat, 30 Mar 2024 01:40:12 -0700 (PDT)
Received: from [127.0.0.1] ([40.79.247.102])
        by smtp.gmail.com with ESMTPSA id b2-20020ac86bc2000000b004309754810fsm2426722qtt.89.2024.03.30.01.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 01:40:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1711784619.git.tanggeliang@kylinos.cn>
References: <cover.1711784619.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v3_0/3=5D_disp?=
 =?UTF-8?Q?lay_=22last_time=22_actions_info?=
Message-ID: <4463a4f7-e771-6e2f-94e4-19ed5a138a14@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 Mar 2024 08:40:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 failed test(s): =
selftest_diag =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): =
Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/=
actions/runs/8489380071

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/104a535710=
cd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D839974


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
