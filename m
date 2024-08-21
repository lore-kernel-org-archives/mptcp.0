Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF9A1D6C48
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230055; cv=none; b=WLn7TnTlyE0HQAbH2xsQBdGQEVRDM9jcZV4hdOVFE1YM3G62LSNPdXmRMXitU2bsbnnR7II1xhlgFsDdZNjDb/xNFWvEMTdaL1jCj8hgPrABgR+l1l3751Sf1iVeBeMjFO7fR88ovRR0j1cyFVRRvJfferervG5wQgXsgg6AX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230055; c=relaxed/simple;
	bh=EbB7uLTbZ2py8nna819o54hg91fnIh6Rz1LIva27jac=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=c6o+r06opD56V3hV5J8HSPFfS6O+2PHA3C0M3kZdmKT3oyhhOmTfVuvHnMBw8nx8zCR772aP9XglYuTKNzNCCI1MOUPHsudv0Mlo9n5qmkkOq61IDYEEmvOAwEhdelwItPyjv3TZoCjjduhUA3LUAbcn/8B0x728TlbMHmcGnTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpwQ1Q+Z; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpwQ1Q+Z"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44fe6672297so37734391cf.1
        for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724230053; x=1724834853; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pIkWyZpeGzqEXqbEAaZIlgU29WDaHKaV4O9T+uefUI=;
        b=YpwQ1Q+ZVWiZCqaOEGgvKbYbh05xHpVReR1rUYexxBkh9OovOif39dWj07KxeSjzVF
         7SFHm36tvXlxCC5BSTrwn4UTC0pk++jD1m0p0E2m8YK7jK78uYDUoijVhyyMBUHitTnn
         meoAFG4MUfsFRVrSdjCG0etFpasImK+Spix4gvIdKAVG1L/yA6ju7MI8UTUD6KhoFoI7
         /JHE86fvTT+FLE1WZM3BhxZkem8KRR7gGccLCHHc89/X4GgiiONtN1T8Nalv8HqA0G8M
         jsShFRMrOIrQdJgg3fY4NZd1dka4GUNmZI0KghR7i8EQfQuRMTfyCjkEYNzYpsnOkKlL
         3mIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724230053; x=1724834853;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7pIkWyZpeGzqEXqbEAaZIlgU29WDaHKaV4O9T+uefUI=;
        b=SJ1dxtQR0JiEsa2443aAyYwxgxqjD+SBjChx6K81YZX+ZsdsT03OwHd363zKOOkvcn
         HsKLf6q46beT03BRX0VB20gp79QKo1XPN7fZJEaQpF36bipsJ0b8UhcO+FN43ivO63az
         U++yoHeA1C6/UTG3qQ6NIstwqrKNpw3WW6TOMA7YbdmCVdexnxsRFXzyIN9zp2N1FOCD
         Q88glUjzLTXrP96ZGZYAFq2ktCV0yPFg3P0HQ9nfcc0htG25LM0hK2X+7MBivy51Tf51
         fgPXEtY5Q2SA8opXSDuoPwxRHYihB88EQPyZN+pTCFJEgyXO51jBL5zBD4KfbrnfL/RT
         Wrpg==
X-Gm-Message-State: AOJu0YywyANvm+9xGcBsLJ18l/tzqGiz4cDixHnt21BRHSPaeyR5XANv
	KB2SJzfnq9AL+S2Nk8kJhwtpMFbcGsnzV43vrO4c9T1Z94+HVk1HFxE9
X-Google-Smtp-Source: AGHT+IFJZo1xTBBKk2xXMM5fkSAl3iamRky6NWIRdn5gYe7AV4s2eCZKAYxoQpVguVp0GlQcduAhrw==
X-Received: by 2002:a05:622a:424d:b0:447:dedb:99eb with SMTP id d75a77b69052e-454f268f8b5mr18271971cf.60.1724230052896;
        Wed, 21 Aug 2024 01:47:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.131.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a0037b0sm57527711cf.43.2024.08.21.01.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:47:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b408bd6c62d50c91e02b995c1a09aae9d2fc619e.1724226530.git.tanggeliang@kylinos.cn>
References:
 <b408bd6c62d50c91e02b995c1a09aae9d2fc619e.1724226530.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2] selftests/bpf: Add getsockopt to inspect
 mptcp subflow
Message-ID: <a7239e59-3e38-dce8-3744-cb2dda96734e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Aug 2024 08:47:31 +0000
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
uns/10486016292

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3089f4d654fc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D881644


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
