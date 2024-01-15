Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D37417C76
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV5YdLtr"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78324e302d4so623076585a.1
        for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 08:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705334912; x=1705939712; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L60bLjK7Kk5mTQBm3LjNjKmg7YjQmejic1J5vb5NdLA=;
        b=JV5YdLtrq5Ca9SgWqQj5LhsWk17I9TsZhPeplVW05Gij7i6HXRwLWrUxWcYrdd8Tg/
         9A5uCta2V3tceyEwLkNPKTBSJvL72ckWS6NMq0ZnUODRGRsQYTVqNLkQtyWNIu1NoiOj
         Q96p16n9/gMS9btmWPfpbW35aWfQvQIONvyye02xrjORSHsGUoas6bWLZqJAp9aR81UU
         iwx61LPkH2iVJy2mfwOZNIfaJDTbE/1ghWJUXgtwjWXbZcGRGvv+Zzc+1Q7eanzv0rxi
         KI8jLY4+7QQUSFOw+pXs8Fu/25ELSXAG/9mI045aR+QPyvkBL4mGv9jDAPCI6OdJA/IN
         mnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334912; x=1705939712;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L60bLjK7Kk5mTQBm3LjNjKmg7YjQmejic1J5vb5NdLA=;
        b=MXQetgyzqoV3q3OKy4f4tYsNPq8Yd5NXrtMHLOJ5juLB8GqeWv1oYaRAQ77MoNTcko
         2WUfUFg9tkrxSDPj6Y9LXJ4oVYdrZQmvi8WG7Lvs1kOj6bxjj2nJuVLyLDG2sZKpE6D+
         R2kcHqG2sPMtBg3jIGHwAgAycb/WzpY//ClMk3wE8nHgSqS8VcdBAVHMxolJ367Ot+oN
         CTCICwgyY+0rKD5RkPfam2Qv7/iGqjdpfzpbiVH+R8T9zlm5C+yMA0Qe1ZWrxW3EU4m2
         1HYckX+rEWcxHH+FOPzWDWDo8vowejiyFU1UknKsN+ItyaORRqsL8nq8hrBWDI3XDniP
         IcgQ==
X-Gm-Message-State: AOJu0YyNTGL9/5tHgKH0rzdv0YfY7w/SnvyDondt7WjezxbNzUivDkVK
	Ehh2yOJWM2/PjB/LGX1Zgg==
X-Google-Smtp-Source: AGHT+IETde7sfwr/j0gHRwNfnuUX1pCVsdYHDAucgel9B8VuuNkxud+1vajpoVg/KWulWm7vmXVn8A==
X-Received: by 2002:a05:620a:b16:b0:783:597:9991 with SMTP id t22-20020a05620a0b1600b0078305979991mr6792682qkg.71.1705334912311;
        Mon, 15 Jan 2024 08:08:32 -0800 (PST)
Received: from [127.0.0.1] ([172.183.122.148])
        by smtp.gmail.com with ESMTPSA id sq10-20020a05620a4aca00b0078305ec597esm3010054qkn.71.2024.01.15.08.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:08:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4d9707b72d37cec9b4b6725bfcf3ae03010e0d51.1705330501.git.pabeni@redhat.com>
References:
 <4d9707b72d37cec9b4b6725bfcf3ae03010e0d51.1705330501.git.pabeni@redhat.com>
Subject: Re: mptcp: relax check on MPC passive fallback: Tests Results
Message-ID: <ea58353d-de4f-d553-d58f-a68d169710ff@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jan 2024 16:08:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7530884832

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c8255ee720ba


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
