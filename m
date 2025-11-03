Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956E23009D4
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171033; cv=none; b=TGthOgv0neDNY6m8VMg4Hf1hchmYtjxqiTsJW/N1b90qcF94c4C6AnEyP6aDMNz/CxB7bQxxO9WHFt7DHC31kZsWdkHeIOrtcgWBYa8d24VXS0jQfi8GxpvOv/KdQNABbPEgVay6623SQN5hFtMpI9rLS/dOQ6DawJM0nddcCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171033; c=relaxed/simple;
	bh=z9kWeFG+e7Zm8DL5ectYMh1LwsWXUyXwmsevKdRTzk4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=QbF0eUkAe7tFZ/8Bm7GS+rlBxCRSejwXzVJMlSJrql2vISHxQC2WXEeQAYB0QisBZILmcmBOH2+D3enluXAi+nc8pf7NEF6CY7hp0alC6CGSDTR61NcRe1mMkXtcliSfJAxwRqy844LEyQ5IvZWTFWHWVU7BHhzRP2d+zEfcZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbnAcyNy; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbnAcyNy"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4e89ac45e61so39908981cf.2
        for <mptcp@lists.linux.dev>; Mon, 03 Nov 2025 03:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762171030; x=1762775830; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmyrMvHldH/GHV68YLbTVODWn8VCIvOGBS+i/TmoD/M=;
        b=JbnAcyNyBEE3ytUWFezrma6GvSDWIQNSdzX8gH1r0B3JL3KEvfMvsp48UoL4EyAd3A
         FoRsEu9qXt4/33WCDraab/uVp3hy2TtYvzEQirZOf7pBG9IOvpy+k5M3QVzP3ya7k0Z5
         vfp5WdjjXCR+1MDRUplQitiQGwloN9ZyeZ4VzS77eheZBnwVuaAJkNy2g7aET2ggp2W9
         PprPWMzkQhqIG6GmAkcuYFyW4LC/pnI1gdWqjzGEf5Abj9D3MfgazL710e6X1wKnRiP1
         4OZ6RmmZ0BLxJf5epfOZ07W6UwySzBgdvkhkxqnM5lpSGUfjV9Fv15y6QJd/EsGAI1EC
         G6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762171030; x=1762775830;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xmyrMvHldH/GHV68YLbTVODWn8VCIvOGBS+i/TmoD/M=;
        b=WAgD/uWWbRPmqs6h5yQWPuL00BKwZbJKWY80j0MZniwhNqRj3MDntjwSuioQs2FRE1
         lh0vWxOe8ogPIdCo/hY6e2b5UoP1iMgXAx5mwSI0vDy+mUjwVs/t+DeQUAtCWCsaKSJ5
         xuSZwdbprCViy4bF1u6Hc984j2kJJuH4SGtKRpqR1y4hXyFolDr2sTMAuGaoMd0OivKq
         8yT7YomS+wzRxRpnAw9fb1KyTiIlcYo5RdvalNgrI7qovhuOVyGzHn0IGeq1EtJ4eu0S
         hI0g5nQtIxuSaZ1hNCT5wep7ynyHL6J+7nVitRE1xHQs7olbisA5nxY5qoxoExPIe/it
         cDtw==
X-Gm-Message-State: AOJu0YzVD8E9Oa/4lYh72Yzjy6LgEzIMhNDSmBf01iFX0R3k3IWYMgWn
	SDOOlIslQ5pp+7MHyGTQT0YJBckalg1VlCQ9gQgvmzgZbyxzT/3DUmU=
X-Gm-Gg: ASbGncsYOvLhMGW9dQYEoW11cXXyhXgjhuA1duhAffl7fMpTLMB6pi8lhbYXounGQ9E
	pwbNJGREc8ts4GyeFpPIzD2RNEdlhU+7imRj3Nrrskvhf72bWJU1qdbvQmDXz0ud6SdqveDssXK
	q6691GA3tZ+7q6nsaeP2y+B4/yCJa85R6aukHEwA4MhS1bNKaDfVBWd27PVrrxgxJflYo6Q8x69
	MVL7bbGZl1uGJjDNMmkziJyCPBrkYGOZwGjJbMtzijRXKtfpwpqnJ1N8DyKPmKDr10EMBYhwh6S
	MfRwxrw0MuZZMH+JG7iaKzt57OgNmo8TpB1lADGmN1pTzo35DKMaOAZ/XJ6UKU06MVajYXI6K9n
	9kqj883bwmcwAqjyag2qhzquPIW7u3FV+Qlh4f4r5trW70na8IccuOZjJMa3XIUepC7Tv9jLa5a
	w7n43cBRK3PDCZffr+kKh1mQ==
X-Google-Smtp-Source: AGHT+IG8zMKjB9+YxI0W4Ka1D9ZKwy4Lx6X1//l/LPd54Gs1T+8xi7QPHrPTBtdb7YCdBUocAiIbUw==
X-Received: by 2002:a05:622a:19a6:b0:4e8:b9f6:6379 with SMTP id d75a77b69052e-4ed3100cad2mr132276861cf.62.1762171030131;
        Mon, 03 Nov 2025 03:57:10 -0800 (PST)
Received: from [127.0.0.1] ([74.235.123.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed352897aasm55069121cf.17.2025.11.03.03.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:57:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/6] selftests: mptcp: join: fix flaky
 tests
Message-ID: <3a2f3ba8-c35f-dff1-d5ff-6d5d60e24b82@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Nov 2025 11:57:08 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19031627642

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/22e5bba93c31
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1018612


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
