Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF62C15BB
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020412; cv=none; b=K1RZPiPON0lY4qgV3DFZ/FKo9jB5haq8ZBAzuBcNJ60gaPj4MsvdsWeGJaO3b7RfLncnL53cVZx3+OGYmUsKdpeiIXtcFCj0phvv805qd0YUdjIgJdWU96//YA89Fny00ThHEzahFko9gZYVFQq0Rzz6p64HcxjXPxU0iFNulwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020412; c=relaxed/simple;
	bh=fADjOi17Ed3bHfYjZeWdymZZ99jDEtEFNigqxwc82Io=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VQjZUsaS3OSxQklTYmw1uC+NdVgDtA5x33crorpCc7MK2QVtWmSS+iSr16Qi+AnYi3QZBeUhQX/XwjQ0SAS9yU8q6OSNO/FWznn3d5GNCy4uKPOz7S3pzq11/Bp+Ru0EqT5Y+dPC2MbN5vseBJHWPT8QIhjqXhM6LaE4r8HrouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clxOecV5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clxOecV5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445826fd9dso62846775ad.3
        for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 04:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758020410; x=1758625210; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPCLgFUA173f9FDi5MBXvxxZG4PA3OObduTXiBQLwdI=;
        b=clxOecV5APNVXLmOQKdycUCwTWmoF44KzB4SZq1b1uhMTufDZwrhy6dAdPDtfjSRb3
         MyZBKk+LtYwK4fC4Z3HNZvdP639dyA/ESN3cJpoZXEOTLWPb4eRgIB7l68zPjuBrdPfZ
         cvWviQRmwtDAasf9sHl157B0XRKFbZmM2a7YHDMphfu3wxt1SQH/ZfUkke6idUcYKqVs
         JlvY8m0z7bOEM9wB9xXmdrGnBLPT5+gGafi+Ol7VaRTAnFr5qsPHZmMmvcedD+AQBFtk
         QM5oB+vSBLDXT6hiwWhPDzchabGmyw91wytGwyDRpX2KHZz6JxmIigyBsmCHw2i8D6us
         lReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020410; x=1758625210;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KPCLgFUA173f9FDi5MBXvxxZG4PA3OObduTXiBQLwdI=;
        b=ODEGpRVQFhq6XJojf6Cu9iB0g+9h2FnamGuEcnlozMCcoQ9v/eSIXmboqwWwqk2jEv
         9XTe4FkJbqg9vcaYfPAdZ0pmx6FGW4Zo64WODko6iO+sq0BoToSNSvMs5Easw35sF/Cf
         snxqjpSrLE0lM0sc/kb5wPVMGGDU1KwTZoc2JsLHJs+luJYRH2DdoAXGBdCAwvxHA2+Q
         442qbxeqvTfSu2I07VSESox+4Wc8YcP5ma93LKY615Ji18PxTzSgIinOJMbPQH/MT+ib
         HOse0VTfFe8Dy/DVWVE0CXYnzJLyPxxDsTslxc1LO4nNbA6eLM6GEQj4IKYIkjM/U84r
         prRg==
X-Gm-Message-State: AOJu0YwCTiVEZAaf5vMFVRB3ICU1riDQC6D6NOXyA99Fzf6Cxa/f/RCS
	1CJKdG9jBiYSRmxld5Yo7PFf5ZHdsnVn/muqClXZx+5BJgehMhcIvMo=
X-Gm-Gg: ASbGncs2Ur4znsk5TFXOwkGFCH5Pv1zUIwxnXgTQRIIlaSNnlk+GhO5HmP4/xuWc8To
	9tSLDRajW5zAj/3qrwJUUsyzGJx3Pi3+btEd5afbEHU0/95542cxmqtRXHxwAp6oMyI1W5LnwqE
	eLYHH2CkFN+App8d5O3Bxtmq5/5uB53aALNKyh6cLTkL1UezNaJNNX878TYMvlintBMNIg1OxZo
	P0Www3inBb+va1SZiWR2Q3FnYL3yAvi/G0vQalrx6ykZQqFvB4Ik6syFQkqGpM5XyHKuVCRyiUV
	4MpxVMTsl9CZ+ahejAkZ2cDmZVy2XHShlOkGy5xqkuvcDIrWpSfvQ3n7TSLc9cnObj3cMYtcCHp
	E7m0S341iU1ySNU+AXFlHhg0pCKitGcKEvw==
X-Google-Smtp-Source: AGHT+IFdLEZICpdZA10wgCVACkNRel9MiIJ7RG+KWkdOVI6KqVY1/JXQPe9PDnAFQDpE8sxcmdjf+A==
X-Received: by 2002:a17:903:46c3:b0:264:3519:80d0 with SMTP id d9443c01a7336-264351981e4mr111419265ad.33.1758020410329;
        Tue, 16 Sep 2025 04:00:10 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.246.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267dbd64df2sm12416805ad.109.2025.09.16.04.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:00:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250916-mptcp-pm-addr-flag-bitul-v1-1-5805a6ddde27@kernel.org>
References:
 <20250916-mptcp-pm-addr-flag-bitul-v1-1-5805a6ddde27@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: use _BITUL() instead of (1 << x)
Message-ID: <7f50a6c0-2224-1dd3-187e-ff6247956ac8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Sep 2025 11:00:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): packetdrill_mp_capable =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/177612=
40676

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9353586010dd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1002844


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
