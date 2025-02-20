Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECBF1E9B0D
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051716; cv=none; b=Gk2/7qYNdmvBGYwWsKVH9rU0PGFElQmJfKnY4SXkBxp45owP8Ln1sVE9EzAdgznmXuTm7fZLhzPmTTgfP+mOSKR685rw7MSpsC5gV4OsNQecwBv78n3K52iSml1DiPL2b6nvdg/eFingFqcg50/t7RFvbManXDhOtRMwJhr48PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051716; c=relaxed/simple;
	bh=7/itHgssdjBREagOCpWB/YS5CCOfCZIC/nOL7DxY1B4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=dDGaaHrAuM7mfS7pBNVSEi/kHFUdt1S7qtpJEDAbJp+5EerCxoeaot6r+yNbmmF3eL8rGVKXYz3DZ41NHpuFKgm3VN4N0LaaQACiGz9Lu5xjetbYTuM//q0GTnGFv3obFpRxcUXQnM5K6oIzUJx2vmXnsTOcZ1R4Gdvr3I9czwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTEmfPj2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTEmfPj2"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e6864ab228so7388816d6.0
        for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 03:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740051713; x=1740656513; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbcI8Q4QiW98gB/zmtkvyTjNdq0fD2DDhfU7xOTSL+g=;
        b=nTEmfPj2vgU1YqHP32804NpAuPRlAcw9kSkJTqnmvde2E2/MF18SxUynYJSP1RUr6O
         iUAU41MaEbvwQpEx+F2xSAo81nsfomEqa/H1MBUsPxpp4qFRcDCFUzfzuSendKRjteaH
         jzzRRNVumiK2nUxWfksjZt48uxHcwERWQHv77Z/55zipu4ttkfhNMC+8gRJEftQZpYsq
         Vg1jr6FGs9BH06px1udu16wj0YKYQBRote14v3FJFZviHHjXf3k38NFnwkMVBWDF/LyP
         yjc8wfL2KHlxFL4OXOVqMviToeW5o4FnupJIL0m56P/Gulk8sZDR9IFfdwufYnxH5Mrw
         7WTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740051713; x=1740656513;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbcI8Q4QiW98gB/zmtkvyTjNdq0fD2DDhfU7xOTSL+g=;
        b=eXUyAZIVqYFH4GdhWIkKiahI6Kb3ON27SD/KSwCG2XZwohP62ZO6AHN1DkJZ549HcM
         qv3JINSOSTlcTuj8NLzmhjr/WEYRD4lqZ6iRsyWaUrZdihrkF4kCPK+kUHQtbfbXhe/Q
         tKgYHwU2qQtCNFdIYzeMxJV4XiqbQDXytC6uV+Q4knDnauM33edTP02PTzvpzQLceSYy
         dVELm8w2SuDHzicW6mgva4LEPBA08Wl8y+rT+D3xVhlTQwkjCryLCMuz15fvQDKMnuIj
         5V2VBuwWrTfqxS8KBk5V5yDr7N0IleiCfBBKOMFftybbLxTUAY5NWQ843YvPAjylXGxd
         csBQ==
X-Gm-Message-State: AOJu0YzqrZ9bpjesSFP8tAbA3J/vxt+xch7zY8Y0w1J/UviOob4VUosR
	Og4VTWMYujBIBSzQkeU3MR7JFEDBOwH9YPm3HmUl8tnzAD4N23quWMSU
X-Gm-Gg: ASbGncsxn15RLzyWw6zEcjIJFgc2EqJyvhYF8zRlVq/sUkiMjy3KWqgvXR5DX9nR0q+
	j6vIjfhU0IHviRp/MI04nsh9SLXKoBjG9KfgNsdZI2XX+0IpeF2ZXSh4Wkqh3vchF5+ZhEH/mOF
	/uNAfYa5aDIw7cHhS5F+UgDdJkwtuHKjQg/13rU0lZPeDxAEqFgb4UjWtmP2UpW6INqLdPIj8jp
	1CAW2i/czFTHO+txGLdLvpCrjd24dT/SZrVhvlwzSm77UfOaQF78lRVLVD9RRF2zrPX9TbOWztI
	/Eax/LLe8xQWFDIibnvoyYPrza4=
X-Google-Smtp-Source: AGHT+IGDfQu5ClwGzL92WPlHRLepeO26DgIrvw6TFIW/52j2XZTs5LfEWAk7PhjfPw0gdrM5Pf4cRQ==
X-Received: by 2002:a05:6214:2482:b0:6e6:6c7c:984a with SMTP id 6a1803df08f44-6e69755cdb0mr92785636d6.29.1740051713291;
        Thu, 20 Feb 2025 03:41:53 -0800 (PST)
Received: from [127.0.0.1] ([20.88.39.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f5f71sm85001456d6.86.2025.02.20.03.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 03:41:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740047738.git.tanggeliang@kylinos.cn>
References: <cover.1740047738.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 0/9] BPF path manager, part 5
Message-ID: <12625fae-f7cc-e4d7-e0fe-e177aa50327c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Feb 2025 11:41:52 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13433564994

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/62700b4b6dad
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D935957


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
