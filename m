Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B22C1580
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504904; cv=none; b=FgiQe2esGLMwJtUFDhocDprVJIOh6YRYrYdPj6J7wBlkYylZkfshazseb2DIWs5pvViRwTwhb5dhj3o2AUkJqA0EYOxELt908tPzEaDZvgPueEzi6hgVrOfsVDg8trrjWBI+BKDCgQfvbknmKPg7SIqrKGzJor8GVZvm0IHBA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504904; c=relaxed/simple;
	bh=KpkHFtg2xTyv5lBGG2UvHGEvkDI6y7GEIjWDM07JVVY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sjmr/VvYu+peFCRcM7ePO56XF8CCrv6fSunWKaNz2+qgqacetw7Lq+Xc/x778c3hGwt1185KH0+wCz94hRBasKyIa1mwiEmyMQ6UUdJBjJ40KSPori/N1zz0MtGwWVfktL2CnKfO/R8KHrOjyzglK7t/ccnyrMCOjQsX4q0b/Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmfewmDN; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmfewmDN"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8a479c772cfso28990185a.0
        for <mptcp@lists.linux.dev>; Fri, 07 Nov 2025 00:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762504902; x=1763109702; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wq83FLzBJaO1PnGQvqCQ5FiV19RDcuKXdg3sPCWUmKs=;
        b=UmfewmDN8H2+fDb1zZjrFpiGCdqzo+VQdUCw1rtOea2AGJRtRmy5Wsh9xPT562O3s9
         C/3HPGA8Oe2ho1Egl6OhEwRet7dfAUXUqxsn0HGvLwkX2x45vJ6claCQ9Olu328Kk4rH
         o9SCZ+c1tvRF1WOCb6wGrM1vGeFshy7MxnWSdrUc4uIf9zSiTfox64T0zw9Czt6yoiSj
         HMseDTaHPuhLJqjPSA08IWMVKpJTYkJUOYX1E/5Jys6OxchIw0Unbdj9LZPknhU2Vehf
         TRIkKWyBi19fFVBd0ZSByTd01vnJgbB3lie5NXTY4DIBBHeUDheTmOiNffYJkMvfdrce
         0j6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504902; x=1763109702;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq83FLzBJaO1PnGQvqCQ5FiV19RDcuKXdg3sPCWUmKs=;
        b=IRNvH76KPEjnM5fbsBe3K0CwWhvznn4LMzAlz17MWPH++u22p5CWVoxRGD4nqCtaik
         GxG/tXGd5Id80dx6iIUOZGlw4EUUaeamhtBorGdG9CAJvMrLDCOidYJAWDoMUwxJwSyc
         Pjh1uroYXJNESAnRaPOJALRkj72oJ6ZQaHoAEGSc1WkkwD8D8ZoigFy96Kjmm8MthbbL
         sCm9pl+jw4oReBAESBqWqjsvChMdBbCLaybu69LQ2TYNMuOMcWPQQXG9Vle1xC/o3JZX
         1Dzzdu9IxwZfN0T4q7t435NcY7ofMmgrFAdLUBVnsQURlJhDHqQRH3F/u8Epf/YqiM4I
         II5Q==
X-Gm-Message-State: AOJu0YwN5Ur+aLlYQyDh3BQFkqb/F7vffUOjDNfD7M+uIv9G7QjGb6fD
	ekBOrXL74EmJMnn3jHmrAsRguxDm1Jty2M3nUQhmwOk7tX3n7U+JHHQ=
X-Gm-Gg: ASbGncutuyi/VIfRJ7VZSgcxIvzUsMT8oIasht4Ap9QuoO+Vw7x5RU0uLREG0M/V0aw
	9QEwMVBiW4PX+ceNHOrA7YCFC6EoTPRr0FU+TBq3nZV2oqY4V4JUI5+jPeAkNPiN180BYBKIdf6
	sUiFITZQT4qxs6nEZ0LLzf5wwL3CPFmrGuAAy5X7g8HtgSkxsgqi2dwUtddeP3xIsCUhx4wa2L1
	AGz/j9PfX3QG5gum14WLvR8E/ZwY2bgi+nakJVaLVYk7yPRhwBb/s2Tl8jGmpLLk0wjSXWXpMNH
	IKj/L/LWoVC33GZfBxXbkCD0O08o4HvlVgSNjQ9e08tk3q7b72BeYzvKL4nr26OOIueaF9lgOhY
	cOF59H9b2iJ3r9f7K63RNnGmIqSZxQwu1mDa+6UyTMWzndNsUcqgcZk1pNqa7tcbjDHmZ1y2AJw
	WEg72rHZ6Igx8=
X-Google-Smtp-Source: AGHT+IGlt9AYAUj6SqiTbtJagFLBy0xeCwXtnPN0n98g4hWbAR9Zta4UqSXjIFVAkhi+cHU/a+CwJA==
X-Received: by 2002:a05:620a:4690:b0:8a7:c2e:6278 with SMTP id af79cd13be357-8b2452811e2mr335970985a.17.1762504902049;
        Fri, 07 Nov 2025 00:41:42 -0800 (PST)
Received: from [127.0.0.1] ([68.154.38.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2357dbc51sm369014585a.29.2025.11.07.00.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:41:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <14a868192851deb4145a90e3b7eec616544da262.1762474159.git.pabeni@redhat.com>
References:
 <14a868192851deb4145a90e3b7eec616544da262.1762474159.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix ack generation for fallback msk
Message-ID: <d6141acd-ce39-9f8c-f3a6-75bc91e77d90@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Nov 2025 08:41:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19161858402

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/032d2f7924de
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1020688


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
