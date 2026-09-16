Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A26145DF7F
	for <mptcp@lists.linux.dev>; Wed, 16 Sep 2026 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545931; cv=none; b=N/W4seCZYkOK6qkAWu9NQTgEB/nlXlUAJhubuhLe1RjQN7POPskxvpYXhnrIHtD9JzZvxfHH8plzz5FGpDgkjxRT7BZP3RItYd8g0rywN0GTKj4miMI9MWV4XFTihlCdB2YT7wJALes+rVn8ulltzE5y4oNc5HACl9frAofGxzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545931; c=relaxed/simple;
	bh=mMGw6alcaxruCfbdYZNos/fygQXG321xidr2hup/dwo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=OUjX3Yywm+Ru4aPONPGkZNoD3SbvZ+W5y7Nab6rYk7fVWSwZnHLlTKQR2NrmXeTKM0O+7dVQ8x1xAcON9eB67foDaF6aSfqoPL2GSdbe5Mu3NUoedvwZ2rVlWNPZCYOU2B8rV6S9zuFndbiGpC4dJeSoutN79TBD9XfxFRV+U5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMRvbiYs; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMRvbiYs"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-801a8bf8112so212549a34.1
        for <mptcp@lists.linux.dev>; Wed, 16 Sep 2026 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789545917; x=1790150717; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8rRTQzbbw0vdrh1XyAmocf+7iG3/+XSprx19U94+fF8=;
        b=mMRvbiYs5hlkaBYQv/GLwnu2ZUv4QJGXa6bz7hpwoBfKvHG/h41NySVPn57PBfrnPe
         MEuHuS0wTEgMbODwLYu88OFA1UpmkACkRjSaJvobxnCU4RIwIkboDOlPp20EKrpIwmYu
         Vp3igf8vO1h8s0bYsMO8EVf2G7+58Y+igRTxp/QTPxCUNlhDUNlyjc0QcQ9dl18q+32b
         qIBZvbf+5oPfBIIKOiHGNfIpzRczP/XXOvz4D68ianXUURZRZEa2l41Y2KF5irlo9hdA
         i6RZdIqopl/lvNbh4Uz4G7fGmmcc0Kg2A4FB0zEgfRju5Dy3jokrbuebK0Vhag1Jkcb7
         CE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545917; x=1790150717;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8rRTQzbbw0vdrh1XyAmocf+7iG3/+XSprx19U94+fF8=;
        b=ym1YmbhBycvjKPFC/JAi2f/3QY+GWPRTGEUSQ9+GL5dx0Acry7KZVmEbpsTTJFjU2Q
         6p1ApwigN1tiiJtP3aNONMLtFWeC8usGGahGeEJ7mWUvJY1Cfz9eFePTYzBh5CVu5QAZ
         Bj8zCLTdaR2hkyKqQlx1YzGhvuCh5Q886bpTHn1vJn/ZiVCxHsM8PmHVjsjxYIMoFIH1
         A1B/WdodLxStxMjHf+6Jqt6uwKZO1ioW4Oi4PILZxmwsbfYdfvztqjj9SYmYAAMb8x1y
         +R5Pd7D/ZJZ9Km3ApxUy/MdKVwg8Cq2DhcyLPS4qvlEwVao2iocmuybIJz1OZ/7pAc4V
         Y1GA==
X-Gm-Message-State: AFuF++nRVdtfAgEiMuhvZ2DowMpnzgjredJGQNWyZwysBalTSdNhCX5T
	xEBPRdxYknvSRT/f7nYR7nUyyk58Mfh/RzscY5tRNNa17yif+CX4guBH8wLs
X-Gm-Gg: AYBFou1at2HMK8e8rg2JMhSBB7gI2BqOATlvN5p8MxCRJp5CxzsecfdKYwwGCeUIuQ2
	RLeEvwxwEJ1mjZBxw20y+2vYxppTwjyfBJGpqREudfdAGlwFAYv37MJq1i0N3xCDeX4UIMvA/lj
	B8n8hzBMhU16RVT1lWGYkV4YGZ0LHCnH6+hBUs+CMoslor7HVARLXwAziSVs4kdgSNS9MSUfQ07
	WERJP1n73PdhVRhtoET6HDBpysQSl2cwX0Sqc6aDBttaidYLrhxsQzwiGmEJB9F3EbTwEFlLX3f
	tbeXcAqbjDyNHCQgsIO9veCDh60WJyITSuUWjKXRpl3JNoAYRooaib/r9sZivIxGxFC/8P0+pez
	K+gq9hXnjQq1U2fhIIhtDwyp3QWxcclq6R7pDGqnFwZ7NrileS7y7F1/b7mOsaEm9E9AsCnnPJR
	0DGmkd+yiPYBp5sbyrzSSEY4gSZ32iIRLp/le5iqnshx7hAdZw3LeLeO0pAsnGSHhY7gIOJ+yVQ
	qbz8Oc5f7XsSg==
X-Received: by 2002:a05:6820:f02c:b0:6bd:760a:a8ce with SMTP id 006d021491bc7-6c7d48ef1c6mr1612422eaf.62.1789545916590;
        Wed, 16 Sep 2026 01:05:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.212.51])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395cfb0d0sm4494979c88.4.2026.09.16.01.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 01:05:15 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260915093506.465110-1-kalpan.jani@mpiricsoftware.com>
References: <20260915093506.465110-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v5 0/2] mptcp: sched: let schedulers mark a
 subflow to avoid
Message-ID: <5ea52ec3-d57e-5e2f-b4bc-d74fdbc1a0cd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 08:05:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/34955126100

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/7a28b8cf9e=
61
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1165327


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
