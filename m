Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291FA58AC7
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995599; cv=none; b=aIwZjEdfljeuZ1rwZMnBz+aB7MbxgeMKOdHmjxoyVcH5KbednVl4NygdGYCka91RPxVruGxW2WEz6gIS0EIfNUZLi4kZwB7DN6JqIH7NtDy8Z6wOT1U90UuGuvHWBrnPUExpuUSFE1EVbf865p4FQw4rqS1y9mrdLji4uidqT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995599; c=relaxed/simple;
	bh=QSY3HmCcVbZyXUahsw+gLnB+Ti1EAQsayaWBcIWNYtY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SvXUWE1xySCvT9MR5CNevoM9I/+a5POhUm8UjlA/xNlgoRWmA8rAZIRRE7U3VSm6aM0t41L4fG/kKKpNZpbwHIwzbLVdfaYWwIugJ3tKBafB2fNGcxJirdVxxp+BRyQwkKox5Zo7faOhDmBfWEuAD3Fbd+1VJu5M+1tYxruth4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S985qThl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S985qThl"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d95d67ff45so5322555ad.2
        for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 03:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707995597; x=1708600397; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56Vl4py+LA67xOkwFnasneGtBzVFNsKPZ4q11Lj5amE=;
        b=S985qThlGf1ey/gSxdSPyJ0l1oDM77jPxEkjvzV2wCpWngbPOKJEZWREcapWaPtNWJ
         qU3tELiJ2vBwXDs++5rzbSfm7GJwCrTTmojnIfyhKawn8gwzwBHuwcqwXsdIVxcSot7F
         nomrfPkhVplP3SKVzuVpl4rPJc5g8FnPPBLktwTmIoPAedlefdWTKajQfTRj1e71Iu/y
         20inj/d1jbLSJsz3HYo4gf39hn2QR2tgr2+UZegDRhc/GcO1dugmSrVQTfvm/zNRaRdB
         mlI14qEotzHldTqhUnKHgX8nyNMlFfO6fMdHxchzLXX9V6w4/fRgdsaBy1+5+wpPbz8t
         8i0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707995597; x=1708600397;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=56Vl4py+LA67xOkwFnasneGtBzVFNsKPZ4q11Lj5amE=;
        b=C1ILR5/4tzyAc18JuVAkNI/VPbvdRXvxQ5AcbgVclww3pRZRdPtJYuDGxdT2JF5qoq
         Cgh09A8aGe7dHwewO2Y5cGG2vgHuQcao0qIuADTsm4suY27MtWmgnu1fGUuyj+/KIZqZ
         svXAgSBXSn0HjnLuKxfuTrO9gPaaUNi0KfpEvPMYPZ2aVfUb6K7P0cz4pNC8FluQILyp
         hz0IQFP+hW1rQisFQyVuJbB8hp7Hpiv80pGPXPd2VU5OEhzeCxgt5VuwMqUn8LUGlxDX
         mZSu5CGr55vY6O+8kUaDPXnQVfCf+hS/o7fKYSCnyRd81SwJ7lTDVDUTzITyPVcqSRIK
         8rrQ==
X-Gm-Message-State: AOJu0YykaoVWsUzhcrLH4zvbaNyxOifnEw1gK9VGFg4AFb8JwKU4T2RS
	3ONWo9ZMJFnMr/QueSrDucLgpn4rDMVolN2howpBV80CFW+myas=
X-Google-Smtp-Source: AGHT+IHrAOcm/1+eOVVUW8d+/tkkaVJw9M2TlwzRXsTWyGxn3jNYPRVAm4C3nhoOx62xAreSyu6LWw==
X-Received: by 2002:a17:902:e80b:b0:1db:716e:e9c0 with SMTP id u11-20020a170902e80b00b001db716ee9c0mr1413418plg.41.1707995597065;
        Thu, 15 Feb 2024 03:13:17 -0800 (PST)
Received: from [127.0.0.1] ([20.171.70.52])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090320d200b001d9606aac46sm1030667plb.212.2024.02.15.03.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 03:13:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240214195407.3175-1-kuniyu@amazon.com>
References: <20240214195407.3175-1-kuniyu@amazon.com>
Subject: Re: net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.: Tests
 Results
Message-ID: <dd15c73a-601a-10c2-e138-a43e7003fd48@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Feb 2024 11:13:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6157288147255296
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6157288147255296/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5594338193833984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5594338193833984/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4b23a08aba91


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
