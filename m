Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA5C51C4F
	for <mptcp@lists.linux.dev>; Tue, 21 May 2024 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279520; cv=none; b=ZQPiINv3BfvWK94tHfvXPPMlHRCg6H/s/ObOiz5k+GCrbh6VNvi4/vyJTBn6Svl88W+1DwQ5XjvucIMNKqmNqZyKEKRUORUFMPDmFkmVc7jgodoen6cScOZKDju2L51uDOzrhnWd7F6kTDlH74ZsLdsJrIsQcPPnO1Vo2SMIXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279520; c=relaxed/simple;
	bh=hEPJ0RkepgvZFfsRfQ1kYNdkcIJkm+r4m/AsNvxAtyk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=EACrj/qR7VMntZ6d+5QJ7heILAc7hL89mv5BCaDJgYmjANAS54G/IgMEvjFtFxwBbYyaJJ7Sj9RW0aKMv8MgTjTqU5Ty00TmmeVgaueFe/euaIr9KLHrVHLQt4nImqoG5gsf2Df8hJBtCS0zP0yiaZRe+xzBYOD/wnAcj9/z9SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrwb60jb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrwb60jb"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ed012c1afbso28626085ad.1
        for <mptcp@lists.linux.dev>; Tue, 21 May 2024 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716279519; x=1716884319; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkHHe09gg4zx13TF3BXpIaBtYV+O3bJisKXMnc/F/cQ=;
        b=jrwb60jbtUDyIQ7bLTKRqnIqTt1EO96YyegEZqMKNuKbSATcFun0koPJNta8aQ2Nzm
         zQnl8SlMrIiZFv9VQQhVg/EwFx+iXdeOxIQ4qHrN2M1bE/c7rfwz10CeLBoiMcecna4/
         6lLBcHnCjRLROwObQUZk0GXNbh850m9Cunsw6EyZrZ3LhviKaIqRUFsA0svrswuDPH9B
         nC5cn4TpyZh9Q/845cEywBk+PRX6Jl+PrmovjcjisbYLLgTe1WrKBeHgyb83on4rdhTu
         joJE8PVsmxBah36A3umQR+mvvt0w4g1PynIsWa/eT0fD992IZfRgXplS55fjx2Yk6Hpb
         EHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716279519; x=1716884319;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hkHHe09gg4zx13TF3BXpIaBtYV+O3bJisKXMnc/F/cQ=;
        b=D7yUwaJL5hN+3AA5PNDOevxfNGOUZkKZEglJglUfeAcijr4vQQIcYBMUwMJFA51c+/
         GFMLFArilJlAmo8zWY0WdOklHlaMWHfaJgYcHkLl3fLRIx/yltf5atga4yl+usGYLJJI
         KrzZW2oNi+7zFA3LJsPuFNTA5o+cPr9lcoHW96SOoSWQAhJR5s99WrBN6ojpAD0qmi+5
         oz/Rj0gixhdjTSuiIpmJeVLc+ejAPSu32uDTMPt1xXDlTnvqaLV7v2EsTZtmEymrznEK
         vDQXiMs4L7fpRf/FmsHGtyOOkvjqWAbPx+zIaIArYRS4OYXd4jK/F27zAcbucwQUHo/P
         e4HA==
X-Gm-Message-State: AOJu0YxFTNZWFmd7bHpXyyJ52kE7Y4yzy09HiCaBaD+T/0gAjYXNdFUf
	qPGJtApnA0Y3hQzZTjpHP1PTlnGoL3Qjjsq13zGlaUZpw+5u0QI=
X-Google-Smtp-Source: AGHT+IHc42GrF06yHJGNZS5rlBFTmz91zIQHt5s9P6Nsk7OfopEqKU73507Fscu1VlLihjeLc7YSuw==
X-Received: by 2002:a17:903:22c6:b0:1f2:fc06:4978 with SMTP id d9443c01a7336-1f2fc065886mr86356785ad.12.1716279518589;
        Tue, 21 May 2024 01:18:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.5.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f306176f31sm25315875ad.199.2024.05.21.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:18:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org>
References:
 <20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/4] selftests: mptcp: mark unstable
 subtests as flaky
Message-ID: <c74cd11a-1c2b-c004-09c9-81ce01526eb8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 May 2024 08:18:36 +0000
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
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9170799442

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e85a7e5c1a53
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D854625


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
