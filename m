Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A807F3A9BEB
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562869; cv=none; b=tAytZj4rBqcC4cINam3+GtFgSOuornTWumF+t50P923jFOUT9KbpssmQtF2Fombd49GIY4FAQg3HKIOg5VYO18Aq65FbQ52VaZWfp3598pk39yO8e0yfqD079ltCJ/Z0AFocYObtcUkQCYEPvkR446WHt4eJAT/G0fHTqiz7TNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562869; c=relaxed/simple;
	bh=70DtWKtEmCbhHZob7ercAgnYc9PYJ8t0MZFNOUL1yFg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=MFdEyPLFj4vZ1SPxkQ7yULVRI/dd5pvoVmOC07aZPSQHVTjLYeIYS+TYxYWmsFzC5c0+Cz7t23U+UNvfiy3hIzgpNgbzIV0S1v20Ue2bTOiQDDVSWKsc4Nn0PIcQhskqSEl4diorLIZCrOG1/wauOh7ZrZRRB3C5xOUZ/CuZYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RulrNtVt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RulrNtVt"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-295548467c7so78892925ad.2
        for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 06:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763562867; x=1764167667; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2n+DuKddKqUWHSBhi511Ih38iSC2DkTKkCRVKR22OIk=;
        b=RulrNtVt4lhEBGA8FtulYqjgE2G4lWVXlGTuhrC1yuWtyiMYOPuky9xvvn5owwSltT
         M7HaajXOEhHD1EeY1EIlA9hcjtozmal6DOkhE0wqCQ5dhgD6Ghyevhfogjo/VSAJGUiz
         Hu7LBdKAn5ko/KWdOfpN4P/YLvz/v+b3GqrbwjVGltLHmdgEBaidyxcTRmbfLOrkjcsb
         xU6G6NO3uzThhuGBj1qKfUGAIoONoDLdRBGA4PfrqFjQemCTfk40ZE3/fxCgI7Ij2jPi
         suf6B7XkJ/XfGFr3p/PPIxcgApqL0lkqvJZbSyVGasuf0lk3+FQ7kprXB0551byl2Lxv
         E88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562867; x=1764167667;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2n+DuKddKqUWHSBhi511Ih38iSC2DkTKkCRVKR22OIk=;
        b=ZrcuVn1l5jkjwLFnqmTiUbmIZEHRocvj80au0sICuJVp46QkEcCa0PDl5KX1Si0+fb
         lwK6xxERub/hfdljYIJ18hFe2D/MYVFuKANht1tmdqGIzOnB23AYmdhqRt2fQdlAAxTe
         LVpwyZx1dRi665WiPuRBFdP0XgOVqbjCsGjxrhAhS4akpqwH4DWlNxkHPR8U9hZTsCrB
         O+8y4lrMqb8I3vjonDmLdB+4+HsYKpcNwURschLs780OBjTcJRqZ93ktOTNRIyKOsS39
         sSkqlIwvuzlDjwy38wWFjHkn//hNXnVmezUwWOoIktkPHxzeVw27jaUktFPgyb2Fj1PB
         PkGQ==
X-Gm-Message-State: AOJu0YzGl6eBsnpdorcukhgo6Ozr+aFGTLIuxxc7ttG4xUDkwzA5yHJ4
	nnrqlMnSzH82ZrwOGvZCnZnYhO7N85e59JIfsdEvThlrZw20usycDpE=
X-Gm-Gg: ASbGncs+PnROvkFfQIhPwjm/QPo223TolqXKGi58gxM1lIck/HQ8A+PxDwryYKOCvdG
	SznpN2M0j2aM3pz3d/M8Lk1rgGKl+zRSw8kIc7w5NosYaHMoEH42CrtfWj8JfCRbXg68Q8LkLV/
	iV9tayWv6Ysw/mFf2s4dSrTv0fRYZ9kuYQM6MEFg5DCf6Q6Fe55SxpJmHYKb2+WAPbq3gvBAqey
	tIb2CjJUQadoJTvcpvbZX5Dbh/69wKaWCvsI3jV90M+08ny/4A+RbIJta2V+u2L79HjbzUbVQ2N
	EukKn8T8sorRmjbOvEtpbHHin78+htMr48Hwg8Z4irCcDOWULPWTpFfEkQhdB0LTxfEIjx26xA7
	cuRNDlhUhUYL+lnSyzEYZ82osIcfwCmXYKqlUR8j+FKsHuaTdqdJdfbICQNOCvtgLc4IkjDIm2P
	jJ7X/2wbGQ7QaJV5ftaHlD0n0O97kLs3iVxg==
X-Google-Smtp-Source: AGHT+IGUFIO/Cq6R+U2Q4ioxd8XFU8pxpXfEid8btMl1Oe/m+zJrbuSI/4s5DxLdx+Hdc8PrwYuT4g==
X-Received: by 2002:a17:903:1a84:b0:295:82c6:dac0 with SMTP id d9443c01a7336-29a05484291mr41217565ad.36.1763562866905;
        Wed, 19 Nov 2025 06:34:26 -0800 (PST)
Received: from [127.0.0.1] ([68.220.58.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b10b4sm208834295ad.70.2025.11.19.06.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:34:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1763553361.git.pabeni@redhat.com>
References: <cover.1763553361.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v5 0/5] mptcp: autotune related improvement
Message-ID: <596d3e74-6987-8ab1-838e-7570bd96f7ae@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Nov 2025 14:34:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Critical: 1 Call =
Trace(s) - Critical: Global Timeout =E2=9D=8C
- KVM Validation: normal =
(only selftest_mptcp_join): Critical: 1 Call Trace(s) - Critical: Global =
Timeout =E2=9D=8C
- KVM Validation: debug (except selftest_mptcp_join): =
Critical: 1 Call Trace(s) - Critical: Global Timeout =E2=9D=8C
- KVM Validation: debug (only selftest_mptcp_join): Critical: 1 Call =
Trace(s) - Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19501595339

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f3d6bb310960
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1025302


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
