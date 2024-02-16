Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29715914C
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081721; cv=none; b=n9bXHRVfddReQ2TUotHoF5oAyXnn99bLiCpqpXYHwly6cr/rrmQmPPSA5mwAzNLmAwinGvfeGiX7XoF6wYxXoOF6ZWLTsojUhqkWKvMhEf/nWjjC2eHuh+hNZYfYxJ75o4Rhh/8CFAiDRJxyJKE6vos2/Fb6I7L0iMquynayVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081721; c=relaxed/simple;
	bh=57h5kuGBsnplCKtM6yS/i2Ytah1+PQ1PfT8UvUf56L8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XiLjiAZmIfdxOUb8n2crBIZ/73DbdWkxtZ/p2sHpjuCPDctxP0kQ/llpOn5CKNjbeRRy2XuW/i60mFlf/KrNEbK/hv10h/cz31eEt+IJAwaqv7xb7yh+dN3hO2FkFzcTrAcx5GoTlMEbKsMo9kV1iqMp7JBKrEdQEILEDJCXOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Adf4Y5Y/; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Adf4Y5Y/"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60800e254abso2575217b3.1
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 03:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708081718; x=1708686518; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsyI9VrIs7X90HQ4edNQCQOXdqeHAQMewfn1qmc4Y+w=;
        b=Adf4Y5Y/ukNJ+CslQ4yEk2FhtEykAjwB4CPb2x4RiypqEix9XDAz7TrtTQTTQR1Dz1
         3j87YkIUoCd6v5hdzv3NhH/cKGa6vmOb1sprFRDAbz1sSah8wvT9LkTu7p75nWv/Cynw
         1fe6hxHREqBNn28QsMo5RsvHb+Nb4/Za//5agKA/vfVW8Yr4RQH1r+aGjGxSsQ9j1VQj
         dz82tHHj2BrB2+B/TKEiTwGhTxKIyFK9+AF7OBgOMnOPDrnZLUQwW7a+SA7hcPjRnO9B
         Wi/zLf9u4rkh6dfIaWsPviWTOCgpnvNTOWylUWsaVdKJrORYWLZHJH6PJ62mKNQi35vh
         XkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708081718; x=1708686518;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QsyI9VrIs7X90HQ4edNQCQOXdqeHAQMewfn1qmc4Y+w=;
        b=a9n4gTDtMNRiDilTVi2YOcKx093AnSB4LLGGb75/UhzRlkoXThbAhHSdZbSns0rDcJ
         KndAmiu8LB+JHk+O/RfJ5UTXMzZwOFm9aBt2rO+jaewt166PX4HOnHOzTzjeDjvocQBe
         0GqMVFJNRkX0f80jzzDbouejMIVhAXaBnsb4+f9XED0wN7QyDylZiUX8ybzAhBkKW004
         cifKJ/3gmPNF13l/crZiW7pR3spBhc0lxvq3bnQ9V9i6nXsFk8syO090hCnxdVeGr9Fw
         /gBu8g0Ekw0rHZKOsn8ek+wwCLoEV1UVX2/XP9UldL9+dx5E/JHAC54yY7MIPU8CiVGQ
         rVEQ==
X-Gm-Message-State: AOJu0Yz3mxkb7dOmtFcahmSwR2TKRNwi5yvkUyNh0eLShLJ/+V4NgXte
	axmJpl2rWc41M42UTt1yRyhFE4cmz7nfyUDYT90249wuFuKC1dVlBbNYOUY=
X-Google-Smtp-Source: AGHT+IEBgZVMgi9WN2QeWmZhIrA7j7S5Q6Mqmj+2cv+4KmBiZJKujVASxddBdMUrRBYCXP+s2y41xQ==
X-Received: by 2002:a25:abe9:0:b0:dcc:f2a4:153e with SMTP id v96-20020a25abe9000000b00dccf2a4153emr4167029ybi.46.1708081718567;
        Fri, 16 Feb 2024 03:08:38 -0800 (PST)
Received: from [127.0.0.1] ([23.96.249.167])
        by smtp.gmail.com with ESMTPSA id de37-20020a05620a372500b00785cad6c218sm1387944qkb.131.2024.02.16.03.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:08:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
References:
 <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <9cae439f-4171-f579-65b1-fe9e7a5930b0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 11:08:37 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/7929313128

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e8eb7a156396


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
