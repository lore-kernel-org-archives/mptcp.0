Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0368A111B0
	for <mptcp@lists.linux.dev>; Fri, 29 Dec 2023 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM/jAReg"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78117c8b6ccso563836385a.0
        for <mptcp@lists.linux.dev>; Fri, 29 Dec 2023 05:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703855870; x=1704460670; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY/Ncnluj/43X4q4QNE/LamFPooOBJ434Ue7kr4D2Tg=;
        b=hM/jARegn4C6MR+nq8FyXllOrdMBJjfRcFVowe+/Ml/6esjITfYF7FftFqUnuoWWDO
         iM/2tER75X76bdP6si2CAEOy4tPMZYW5WvYXSjxS7N+2NGkMtyvtL1DLXgmrx4F7ckFx
         hYgDHp58KXLsL7oNrkJh9652x2pgWkgGovqlqFbPvSa227vxWEhRdnLV3kM1nmZOTzvq
         +hiyz6kEAJnLVxKLVV6EOH9mai4IGpQs6CyAKCjgTD6eN9Xhq2cA2mkU7RoipIsbbcT9
         OwxFwaGWETJQpGjabeAnDRnbqsQmHxQee1+y/bHoAWIV7W/5c0on76c7UY+SYzNhXiR/
         SbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703855870; x=1704460670;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iY/Ncnluj/43X4q4QNE/LamFPooOBJ434Ue7kr4D2Tg=;
        b=POk8YQvzNEbYnbOaO/F6G+i01P3etlWLlv0kOtAyRS4QkyNctSObHS6KcMVcNRE0Pv
         /x5vPPy4Z74OfvBlZF5A8zuk4GAB2yVQCiPsLQqjo2UQeSbva7VovZ8GYDPTRVSxN3Rt
         uUO4sKnXY9pLvQj150XN0uPRhRObzYBgN366JjUShD3vrWW/Uq/CdMkerORlpnegPdUf
         7oOR7Jpo89k+MRHj3b5GUDeLWhSFH6JbdqSiE5xxGUZjWX1U+z/BjOmi6QNPUOs4mXwI
         0WWDwmnKZotsn4rlJq1O6z0BsrWolTZecId8fI4lhxaC1AATJHAgLuiMB7aF4tdM3o7Q
         ZzWg==
X-Gm-Message-State: AOJu0YwibqMBf/EWkQ7rBtqZooOD1zQdU+LR1pk+UV4AbmXCjd9/lDjY
	V7o9u45WyUcYx3TYXUG8AB+yzOMDUg==
X-Google-Smtp-Source: AGHT+IENuuQbPO+6mLTFTfwCaDYzezeXRWf+DXrp961Y+z+1HFaIYkirC1xepvdGUyJzZQdpbZOtKw==
X-Received: by 2002:a05:620a:472c:b0:781:5e2f:6265 with SMTP id bs44-20020a05620a472c00b007815e2f6265mr5585235qkb.12.1703855869749;
        Fri, 29 Dec 2023 05:17:49 -0800 (PST)
Received: from [127.0.0.1] ([172.183.130.197])
        by smtp.gmail.com with ESMTPSA id po25-20020a05620a385900b007815fd24b2dsm1980813qkn.63.2023.12.29.05.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 05:17:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <33341ee1f12b97eb0369c4ea6c84c4b99f03eb8e.1703853513.git.geliang.tang@linux.dev>
References:
 <33341ee1f12b97eb0369c4ea6c84c4b99f03eb8e.1703853513.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: flush userspace addrs list: Build Failure
Message-ID: <69482924-45bb-d457-a75c-a154b49cb7cc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Dec 2023 13:17:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/33341ee1f12b97eb0369c4ea6c84c4b99f03eb8e.1703853513=
.git.geliang.tang@linux.dev/
  https://github.com/multipath-tcp/mptcp_net-n=
ext/actions/runs/7356843701

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/5fbf3fd9ea=
bf

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
