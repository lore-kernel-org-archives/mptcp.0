Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D03368A2
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064442; cv=none; b=SbNsVauZ2AI7PiwKlWI8suwKoNKsMN1H+YVrL7/JEBFWreIlSxCOFF7/F0eyl+IDko6qulI12gudVnk0BVHjtyH1EFO3HwvD10pAW7GVFwbNQNQLEi1+cLs7AQ8uE3yuKOXBgv13i2jxeuNA39iaoAeh9CW3cTgmvHBrScipq0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064442; c=relaxed/simple;
	bh=3jrEpgStnICOfskTl2BG39OOc2+/XJ+seXsWbBGQcZM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=dCiQCoWnzb2LYhtizuOSMr5B/OcklPTFkuitn9K1+Oz11J0nrhXnOGmu49hbTEWv5cwNlQvnnbzEfL2/H+/Y8P8/NU+dceg2xzf3YoidYycG4F9s2SmtZoJvmFUkGhlLp7iPs2sOygY+F/njzT8j8Dpl5F9i/3mOA9FMhS6z6nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFaxF64R; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFaxF64R"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a48deebe95so63427646d6.0
        for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 14:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777064440; x=1777669240; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8mWD39rtUaiKFfK5Oi85je4RauP4EirfuUPSy9hUc4=;
        b=YFaxF64Rk0mO4it0kutY5MpadK+RHPi2xOSSXnnctHdvKU/L3ON2YxiSKz+toFbVXQ
         BFs11FhdcqGcNlN9sdpf8x7FOmDbKDffZAXD3ok3ARdo1nul7L0nUvGCi+gbkIZjqXgZ
         r02Uz8/E2Kwinmjo9qDlsBV8DYWTBzOUw54Yf/EBn3wBYjKDhEEG3dNSNE462t7VMP3X
         9r20xscRlp5IUfjD3V63pOrR/Xcth79m9PRjW8TBvti3sI7l4MdMxiPe8zd1Bq15mUGs
         mpmUTEr5muywU2FYTOCLJ1KbKosoxJBmZF0OgddeLL4WLkmbAVY5KfTUbg2TcKRPgcO5
         ltxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777064440; x=1777669240;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8mWD39rtUaiKFfK5Oi85je4RauP4EirfuUPSy9hUc4=;
        b=f3kShS68wKcAB8YMuEZG5g/KY92aD1kCM6u+TJ9rTguwpG93bO8qDGipYhblc6Qa8G
         nKDppsJaQ4nU46L9I+yhoZ+J2CihSROiQIFXpzIx5NZ0CSsch5lg2qk+WEoPb9Ynl7nq
         RrjVFm3uWyhHbot7uIilV3SSx+dpeYJxTXmTpmmAd9Ql6JhveCKPWlmxrMiny7nZQUCS
         BJyVt8SZDO8LtiJ3CB1H7lmDzctoC2jlvd8d9Aiz1mRDS3LEMbql8R30UCmXV5OvV7tZ
         hyQ1yDFtxCMZNYFu18asFTOoMLjXflyQsZCLsP4mW7OAruzCo0dtoYaalDE5M0BV1J1j
         SrjQ==
X-Gm-Message-State: AOJu0Yw67f5Ubp391UDBAZ9NUvySsoO+eEly6pB52KCPupSPPkR/pLwk
	TBY0LQDG4m1E373CRkK//OUIQNtczhly0buWsD7Kp3WQ99bFG5dFhtXxOxt8
X-Gm-Gg: AeBDieuYr443eInFbBA1splcwwhn3BWxMug2aHrSkVKvH/WoBf+IUQI9CaTh6MnrVpC
	vyFP1Tr7/V4FbZRCIc9cAS7iCnzSZHnbFg7CSZzMXKjG/fa/JAYMR75klKN7CuatbUd2zRL3Idp
	DR8xpxDvL5KJco79obFxLF8u93K6fczkoW3Fwn/p4kIcH+2HUKLPpFpPh4SzOIdNWkUGDwWkQgs
	ji9ZxAkxN+s9nM0au1wFO9OdJSiiRIvxRqH7AscmMcuHFCHDfqnS9bmPG0c4LFzjnXa4nxnpyXa
	qOFkGUhg2al8S+tbVuaTNCvqV0/pdsOey99L7wf3UCGdo6lv3bSAzXvJSWWWB/NxWDA/f+AtoLa
	ObCtHIZBknptcy230qwO6VFk6STBlnux3g0Z7nfOtX4RlNQI4UjsLlQRcIp1arzmc6XLLWmbQSj
	H6IMfdie4X4JuBbu4LzHBIsYonA4hsZlwigdyw8yjMSFx6RgBdvHKnXwlB1A==
X-Received: by 2002:ad4:5de7:0:b0:8b1:f5da:f7dd with SMTP id 6a1803df08f44-8b1f5daf8fdmr255518256d6.43.1777064438624;
        Fri, 24 Apr 2026 14:00:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.102.74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac42586sm200166816d6.8.2026.04.24.14.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:00:38 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260424-mptcp-pm-sockopt-set-all-sf-v1-1-38e7023822f8@kernel.org>
References:
 <20260424-mptcp-pm-sockopt-set-all-sf-v1-1-38e7023822f8@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: sockopt: increase seq in
 mptcp_setsockopt_all_sf
Message-ID: <c488a3fd-2d7b-1e36-249e-25e5fdb56bd0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 21:00:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_userspace_pm =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/24909569350

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e2f27c46b96f
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1085341


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
