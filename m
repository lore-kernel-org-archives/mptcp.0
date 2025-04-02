Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB74B33DB
	for <mptcp@lists.linux.dev>; Wed,  2 Apr 2025 04:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743566521; cv=none; b=awAYzJcabtDEc4SMHOAyChUuVhUgK0nlKMWrmBMjqecITckyvM6WwRGJYHUJyiGM4WqRW4SZ+/FHvgA1bu2bIjYRWps/ChePxg1aVKT8RggqJ/o75zzpqovWWspD3b8mf5sCO8/kn7uVlHrPH1W1Ou4bYAfit4FdNbZ0toi5Orw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743566521; c=relaxed/simple;
	bh=lYiBGD6qgAW84a/xrZZpRl1YPdL9jCTPXIyCtJA1ia4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=e/U7CQENEh7HObYg1AhK8AgCcxJwykkOTLKbefm9o3HQ0YUJMzcLKzzew6Ga4LC1UfMSQPGhEkiJpduaHyoM/yT2AYqnhvHPjD31RrGv3bZLVKbPkJl69T8+/EgLa6+myfnEn5Bv3dNP4r4+hnzDGisYCG1m81MYYuoUnenL3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiShefMi; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiShefMi"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c081915cf3so775215985a.1
        for <mptcp@lists.linux.dev>; Tue, 01 Apr 2025 21:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743566519; x=1744171319; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9mk8WdJwaR8fpzvE94cz96y+br17j5Fou6WdPXGqys=;
        b=BiShefMiBbBFZMAXa5QhwxS1+OwFV1iJXJFCCMfmJbvuqSOvnuyyGvStKcYokWzwie
         HkJ2Ghf/SMBaL0RkjoVfVbllr5ZpefoFy13XTlEGovRmuVco6PH+IxTanR+03mMMKjqP
         RIO47tx5A4qxHaiwJW/kqu15gXCsO3vnxI/m5/fzeuo+qq1GWWULwW7giHPVqvUhaezk
         pt1HvYsWFR7rQKlJLnugFDcT2NqPGUKp/5nHGgDy9obJ+CRRohzktpzF9th21fdQqQou
         jgFDQ0xmjDtR1RUnvvjXlTQK8xTJXFKmypHMc3JmkIYlaC675OJBUntxwxj6nd10vN5E
         Q6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743566519; x=1744171319;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T9mk8WdJwaR8fpzvE94cz96y+br17j5Fou6WdPXGqys=;
        b=crfnjcaKcev0D3ZVmjZyeFoh2nt9zDC+tqzY2FVrU3G/aZNeWWNv1RheBjfgKIXQlR
         6SKAEtpdrv8hyLYIErXd23MOf7D0K+sv3Vbt+HDUtrKr4En/zvclq8Y15FtDMyehqSlV
         PXtq/mcoTnddC6pMMoFoQVnPx2NTvzShUxzDVhGnGb2XQa528QACKKhCv2rRr1HynxET
         CX2WVTk2EYU0PFSrzytkqAXPzIpceGOoMsWKUAa7M/FQnQuXNT317/Qk99K9Ouj4vlTe
         Di5PuQEBSl1V9jiyFXPJJsdA7FvAWW3MsrLMeW7RPSpDM5Bb5wi/lg2pN3Vvee2I/48F
         huUQ==
X-Gm-Message-State: AOJu0YwZYNrsf15PZG18fOZsvZV0lKZ/xA3lCx9GcBoPhrAsxQQnI+yI
	/3+UfVN4eL+3oz0incJ7hbQSQvtRX7ozQd3IsRZDv24ZgRyOMVJlXQOT
X-Gm-Gg: ASbGncvLeytUX28yCs4IbqZpUIhNEdrZAs4tV13v+vYhqS21tZVEeG0U9yml0Msq2IG
	6qKLxMCTVGzbHLNlndiE7XWz9BfoY3XswxTNxsCJc1x/pZ1NIX+FEJuQCVIcWjyiteJ9257O7WD
	+yoi/chhbflsu8qGuCFLFEYRZ9RZL7Dh05hkb4Ate1LUmVd3Rj/CZR4N187fOJ7hCMNxSm3J/pf
	ZypqfMiAfBL2Q9kOJixJIcRTxlee45vunAxtBInyEb/qZRu5XJtc2JbRY4kIvwlFSiMpoFb6n0i
	4GCvUIlo/qL7eKv2bzDR7nG/XRefKmd1JjD09BBEeF4h/t8YjQIX6g6Vpg==
X-Google-Smtp-Source: AGHT+IFJfD7eq7CcyxX/W7pw1e5HUEkdU8n/DQgh8TSJI2OJbwOuxlWHHPtcActGki4r7rnaXrZctQ==
X-Received: by 2002:a05:620a:1724:b0:7c5:405e:e88f with SMTP id af79cd13be357-7c6865ea9edmr2309509885a.21.1743566518668;
        Tue, 01 Apr 2025 21:01:58 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.78.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7666c37sm749337085a.4.2025.04.01.21.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 21:01:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1743562290.git.tanggeliang@kylinos.cn>
References: <cover.1743562290.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/3] only remove entry from local_addr_list
 when sending a REMOVE_ADDR
Message-ID: <e84c61a1-b1a2-e417-aa07-434b88dc964a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Apr 2025 04:01:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/14210668405

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8f913c652044
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D949152


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
