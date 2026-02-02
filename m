Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4A2C15B5
	for <mptcp@lists.linux.dev>; Mon,  2 Feb 2026 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028898; cv=none; b=H4s/NpGWfAY3CQnrR1X6XMfwaxBEBMZSfNe+C3BgrDX/8xg+p6HANPHlWcfwBTEagCtvFgeul8ikY+ofyR92O+Jg9OwkOl2OcN+ob+W/PAxchVott18BwfUoEsryDmdz/ngBOsDptAGDJXFa1kB200/6ZLKndxk/pYlc9Zi4+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028898; c=relaxed/simple;
	bh=LpUBuZ6qMFlEU/6VMl+YdgXpi3GcB5v6jcpPGQLwI7w=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OofVsYpRRBcjO4KCzQH3yexVH7d6tc8OZYY43KK6a0P1oBGKmqkmM0Llpf7cReMmnEufint2wrnZS3WPBjWBSbRK4IY22Fo3sm8jZtvMNbVqxmCM2lQwwz/zwXLR2is8jRfcHTdENQU/HqwRc+awdpXcmFCbE/weH1+oApHQREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoClpool; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoClpool"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88888c41a13so55200306d6.3
        for <mptcp@lists.linux.dev>; Mon, 02 Feb 2026 02:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770028896; x=1770633696; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KziMQhnYryz97r1OqZZIkY4DTkUy8aNgy8xpgmqsUk=;
        b=SoClpoolQ1ywZKTo+UpMJmJVETOWZKBQ0eEkUFPE4gFLMmuoK2VT6DHyrm+3Pt4B03
         a+XqE8ZbjDFuxMPJA8mz/Xt6/FYv4K6QslN17L79aeLneTGOGH8dqewvDGFYucik91fx
         wybVk6LnlP2cbkvDJtWqxmcGrykAFdqr2B4X+nmLycqzgkZHR4P0MRT668fAXei/ngnt
         pzTWLGMBGyVvSLFBGuWuuq/ErW3xYrA20t2rO5EEY+k+/Wk86+pa/M/i1Bk4CLZoL+Ju
         UME8xgWX9WEQLYfWdgISieiAaWVoC4KEFkwd2ckVlY1gfhEVbOElHtri0xTLxrg0rVLM
         E+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770028896; x=1770633696;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KziMQhnYryz97r1OqZZIkY4DTkUy8aNgy8xpgmqsUk=;
        b=V/mBomLXNNh1RvqS8hPd8YYx4/FQTPrRvlagGqatpJi5hWZISlNYLWpn/UjyeN4sgM
         HdUs9+gEMZh83e/umCjny1qTlIs3U4WOUtShsCQzrcGV7cuaRYuN6lp6nnPCYqWYO2+e
         UCq2Ax+f8+jSvx0UzbHZXbIe9TeJKDoX9uN6v8HUTZyidv2lt8fKFg99C5bMQbnQZSKs
         ixUi9LFsmnt30JqOL/0YMNnnhve0eEG5p9AeWUCRHgzEw+HAssh313yIZivSbhYhxDbP
         m1Wb0p1S51gqYByYOZTtw5vVdTxhSnkLGSd4UY8L+SxgRqWfLqQD3v0pzMZ/gFExkjW4
         gUzw==
X-Gm-Message-State: AOJu0YwjmQIqm2KoujNe0xddEDE//Rg0ASVlT4X9UcQ66BJUM3UgbKR6
	J5tSsuDXJpBS2xOyo2728b+4/EEYuldLfHVV2CTzQCGDT+whcq+TKzmuulTSYug=
X-Gm-Gg: AZuq6aJjkyQ8kYK7Gy34+sYTkuE1KXYv38KWNG9aKpmBiEp2JzUsnhT3YU7bmOidsM3
	7O/z9/toDGmZ4Cjm8D/CqN5dq99habfOt76ConFm2Jo4BJ4+G4RIuTN0FzzdQ7L48ytA0Mmkl7B
	i2gt7mwnOblMVQcm1K2tNWGukUQttaCealf/Pdf6OKMw0/eh4ETVlXeRTdDMFli7Arq4JdE6zDz
	/nz9tNViF1dAHAp7VU2PEnXzMGGXRVq0PYknkqYWHFsEJTGmkcZEg1zB2QosOd1eMAjv/FEZJdP
	CtNCD/+ZWxqZ0nCfRU2kcnzqUbaO2V1wMUrDEw+dyxfYAQrtiR7hnVFp2mAncFKvbpj7zHBmApn
	6GUgQ+v7KBkG3MDggO8KJ41ReS6JX+17yaxZM8yotbkXsn3iWPomYZuhtDjbeGpTB5Gnm+omcX+
	tfud+lCzeskUbvEpU8OEdX8bDJ
X-Received: by 2002:ad4:5be3:0:b0:894:6dc8:924d with SMTP id 6a1803df08f44-894e9f70170mr142037486d6.24.1770028895862;
        Mon, 02 Feb 2026 02:41:35 -0800 (PST)
Received: from [127.0.0.1] ([172.183.94.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337cbdc24sm107515631cf.32.2026.02.02.02.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 02:41:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1770023932.git.tanggeliang@kylinos.cn>
References: <cover.1770023932.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/3] implement .splice_eof
Message-ID: <e8b3f3ef-feae-6d39-846d-254950da5cac@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Feb 2026 10:41:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/21584982091

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b605c7ce18aa
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1049653


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
