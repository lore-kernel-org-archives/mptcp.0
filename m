Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03551876
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742525963; cv=none; b=qGnJ7dp4nMPWVLPhAonrkHjd9Su6MTekE95RU5mSzD1u/cFYLJt42x0r/mrmOJVK3UH2dr5+438tCU5Xb5a+aC6uUUf4ts0Z+arZYsrKAr7530UPKXnOLCa5khdlpCdi8fgMF4VPevkvnVD/kSDUl4XWRVFzL4/lNma6v/UeQ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742525963; c=relaxed/simple;
	bh=Zun0IUsSGkHqKkti9P0XKMwKNOCeCwN3fbo5l2/ZhCk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=gAd+o+y1StALmLIDpwoLjbSajByTLK/WQoySGN//zNqC8zFNapIwFMVORsd8Bv/ggrHKMVhjIjPv48cHrE4CXXkvzpG2pE4wf1vRSwXLkqQnGzIqM93McKjAl5eDpoZxHRx1UJjImXdq0kwJlM1cKFlJwKr5HK65xDUiSGSgJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLhE1adr; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLhE1adr"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5aecec8f3so226459385a.1
        for <mptcp@lists.linux.dev>; Thu, 20 Mar 2025 19:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742525960; x=1743130760; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4j32Cbyhj8aGXePh8I+CJlQTIGPlIWVUPsqJnBgBv0=;
        b=kLhE1adr86FB0atErNERO0EZwrG4k7VsOcPpaQH2utA8g3ONzx6iY0BehUguXSscR1
         wH/rSfzboFlQfBH1Km7reYc4FHvd4SdNPaZW7xr4JoveLhru+0rpJTq+RCOPOGmTC7B7
         m/SSEMba55KJ/yZHea2N05o8aZZKzcdt/i6eVdRQgU3WSKwoBF5vUfjnU1zfNVJeXBVX
         RJGvke5o0zNSixd90noiDWnWomNcJqJ51UmMx9Mfpmmw2t4fw7AiRurW0i1NQw6Hwuwf
         7Bbwk1DwboW+63c3ZTyypGPpyGoLivuy4WDygY3/uMX1E02xRyD+CMtyW0NrFjw6Z/pw
         Fu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742525960; x=1743130760;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d4j32Cbyhj8aGXePh8I+CJlQTIGPlIWVUPsqJnBgBv0=;
        b=ssFwh/JmRWVRuqlbC/dKQaEYpoOH8VqrdXe+kqhOwrrBCWovl/x6DszieMvo6u6Z0W
         zxiy1FLzDVJU82Mjy1F0xk7MqKgjs/cDuryWOAuwEQYEs/R5iaDQ9CIQPCp4mwiF/OkI
         9qWf3yk/+XR37z82Uvxd4ERGijnooIC8JDMZkmtl2XSOKXb2I+Kw1UWQ+8QPreua63Gm
         QY3TYzUAtArKpo/aoulk/fTDMAdFvkG5zsMAzlrlbY24DTGgFJNAwXPTf4pzK1KDlnwh
         JQalwwxzMBNonY7wMYBD33xKYLrWo04rX4mybemN26quTtZPMdDaALtSCOM0rdCksPe9
         +0AQ==
X-Gm-Message-State: AOJu0Ywcy69AERU3NRWLWsGcc+m/US8T6xUS1QB+SbSAz5csQX1nEzqE
	hW3Bs1jA5g+b2/ec6Ry/wIvrsEWqDLYWr/g541ddlcOFbMKfC8BY/cDL
X-Gm-Gg: ASbGncvFxrWVfTBCRWDVaAzJgaG9xVdFszqdualPW9uqoUqMlH6HC8vUsOkd5WF+8bo
	GevM0kvzmdWqROIL3I9aoFAkWToTCBn0kuuk5ATdul3WyLr30iEV9kgSYYyINLI5bLQdfVepNSt
	rB+lsYAJUFT5wGtn5YruuUZRcOmV9U/EOruBU8s+f6hYaplHalLkoPOv0ZTMm4hcdNPqlM+6kSs
	di1Aj9GDjmwbOLMACBJttLa8nNgTMWGkFZDZ15o6xbK4/H688uq4Y3U2dRPn8zloTCmh1EtbXPL
	YjkDmwpTTwMV54YVX8GAbx1c2WKlZ3Afn1LKvj+3zMRoCW6j7pCbbprJ
X-Google-Smtp-Source: AGHT+IGUNTOCmZby/TKwQS5GKxIFAa6XV7mBco18azRDRvb0FCXvPnE7fk9y67SL0+LQIKw0kAc60g==
X-Received: by 2002:a05:620a:4620:b0:7c5:5339:48cf with SMTP id af79cd13be357-7c5ba1954c8mr219353985a.30.1742525960472;
        Thu, 20 Mar 2025 19:59:20 -0700 (PDT)
Received: from [127.0.0.1] ([20.246.78.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92d68f3sm69667985a.40.2025.03.20.19.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 19:59:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1742521587.git.tanggeliang@kylinos.cn>
References: <cover.1742521587.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 0/4] BPF path manager, part 7
Message-ID: <50086f0c-a6ab-3c1b-92a6-4ce60e68163e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Mar 2025 02:59:19 +0000
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
uns/13983028079

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0d2604c2d943
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D946095


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
