Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28A42D46A2
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770295778; cv=none; b=sOfzPuOle1MyASuQqXYMZM7BoVpjyJmGuIBFON0Csn/y94PrkMceix2TKpu2VaORk4zfltxD8wwbcnrfEZL9N8hqDauuYv3bvKm3ijXzR661tIvUqydX0F3zg9VCywlPrJeErGmA913xLoMb6yUSo8KafXdDHWG0ehpXKMVQxIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770295778; c=relaxed/simple;
	bh=UIMqsx6t+p6e1zuwxkcfUHiSYiosEjyKoCo18UHJ1DI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bDFVXijph3BArn6EXH7kux2kVThIXjgsx/aLRs1+F3Y/beg3ipxAtkgXj7jIu9KOSa90vjdlymkR2CZSTYq9YipYBfmJvv5hLFZ9fgR4k0K/P3eXEOiib47vELRUiNwr7WbXBJA27QNW7Rcpy9S4UBEsl2R8cuRl0kvws7XtFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+BjzAnj; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+BjzAnj"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b73112ab62so688706eec.1
        for <mptcp@lists.linux.dev>; Thu, 05 Feb 2026 04:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770295777; x=1770900577; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DouzKdxxyMjj3tx6CFjI7dOcC4MGLtwoFQ53qvVzxBU=;
        b=f+BjzAnj0ykC7fYHWBtBlbKzxocqiaDEv3apB1IuMbdzyrObvTXE0sQ1D5BzCNdaVs
         QcLd/8eB/fZK9CGcMmfeBEkYsGZ+OiQYV0svxa9VNHt9a1t01+o44+shsmZe8ZtDy0aY
         EGTjwC1Sjjwd/g7V75l7y7ppgUTgP1Ld4d+7HwpMaJ+g4QDVSMfXSwIs28Df6eDbyet8
         Fhr1LIVlbmOZU7gIctWmKKpb2vG+cYHFETgz6wres+JOMP0CW4W5kdFyeVMcwmwir+Ee
         WgD+m+umL2ODvJw48pG7wQubObolBnLUwrgoBLHPNIWr0hgSZLDZfo8HSr4KuhzF1Y0E
         F0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770295777; x=1770900577;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DouzKdxxyMjj3tx6CFjI7dOcC4MGLtwoFQ53qvVzxBU=;
        b=p4BW9l0XCWIgDMRf7jXLr7coUlewC+9QuqNwWWBHSsip/AKLQGEYe+by/WTSCcIokg
         /vKPdwV5oexoryW14rp1c6RgY5FtqFCzrnMp5jM+7Qj+XU6jwIAI0QDMiXcQaYPmnWKe
         zjmCIR9RwrOLa9cF6500kLLdvzhplECENwH+FpcXuUk5xbCbWMEY2T2aLNo5P4NqrynY
         NOpFFTyOSrpqfopsaACmKvw45Gi90gQOoMErKb7a3Srp14XujKLWDUhYz/KYYKwMcBck
         yNikwKNe+B8L00Tyo+EM2/aqDg3CenVNF/AxP3q9dOg7dBUmTFgdesQp54i04YIsFrgP
         HQEg==
X-Gm-Message-State: AOJu0Yxrs4ekStgTiT43OavaM2wAOJ5aQCWx3hSP/KU49K2/zjwR5ozT
	yDzurd2jeyGoyDTPPCjpq5gWWoW9sZwOS4CS0cglMpqEnO3aNZtjwy8=
X-Gm-Gg: AZuq6aI+EmcUw/K2J5U2w8w20FmOGUkUhKwZ49Y9LXekgOOhUh7IDpHRF1r0U6TfyPP
	EWWe+3PtsjbTEga8+7WW7Kvvo20sNgTNZRkk4mmRNZFRcMycPirp+Q8Mlg58pl1TAs/TjBi//iR
	ESGQp8PpoRJ+/HfsDScpMKOdiRpbrrLu7QJZv6WmtLCWT220nSGBfYqopnH4d9Va5kMTS2/2s3j
	3oih3WS0C8jtQH54veGFNJJDLZorY1jRgSXnv771dYVEww/zQb38q21udePxpSl/2NxL3WQORrC
	qwWHWT8ovhPsmKR+T3vT0QvoObIXjqOJq3IByEx6K6s40F4xrf2ymN2I/hwiPFUZdu5T2Sdn3ua
	xQQgD9yQ0rmBn06et28GGdXUcMT+Yy+YnTS7B75lzQ9tL+2/xuK1hToafSqVFxSPltk5ZZtxQFF
	V1SKRxZm4GllMa5b6SZJI/06GV
X-Received: by 2002:a05:7300:dc86:b0:2a4:3593:c7ca with SMTP id 5a478bee46e88-2b8328951a2mr2537409eec.10.1770295776793;
        Thu, 05 Feb 2026 04:49:36 -0800 (PST)
Received: from [127.0.0.1] ([20.171.126.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832f8e987sm3101805eec.18.2026.02.05.04.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 04:49:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260205-mptcp-fix-kdoc-yml-v1-1-9858c4b7baf6@kernel.org>
References: <20260205-mptcp-fix-kdoc-yml-v1-1-9858c4b7baf6@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22mptcp=3A_fix_kdoc_warnings=22?=
Message-ID: <ea3b07eb-0095-4f1e-05b7-2c333a6aa5b2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Feb 2026 12:49:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/217098=
63967

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/101313424f47
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1051124


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
