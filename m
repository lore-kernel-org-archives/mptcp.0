Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA812E1CD
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567011; cv=none; b=lLMxkQKX0QdmxfO/SYmYWmnZLxGokmZBqctezuBFJIowV4AFvOlItJ/Kmj5Mlg9APpYnguNsBmhPaY+h3hYHkSce3pEVR2ITFuOgaxiegfsiIHic1iH1sLkhIVtB7ZTPRr1mtv8McoJe9LWj4VssJsVIDmkhU9RVEKZ+BAFLNaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567011; c=relaxed/simple;
	bh=i4stZ7GouyqBzL1Xm3SbsZx2udQfQ4ys7qmSUiyBdbk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=reurOUcU2TI8Up8zKOa6SvbMbVbXhqRXNpzQcYJ2F44J0zNx9KD+DRw95ypybRfmwWNZSBV0LCSkTavpjS8t3zhkZkIcM/SqCWUXCzuDkelxiavqFVhtcdGaS94A+bfXhnuURPAEU63d0VYXlGY2m6cA5a7XpuCP6u/NyxzokqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NimjTcPU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NimjTcPU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f44b52f86cso8418205ad.1
        for <mptcp@lists.linux.dev>; Fri, 24 May 2024 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716567009; x=1717171809; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yduo7LRQm2MuQgYMMQijuv5G5s0NCfFFjn4XPOvjEF8=;
        b=NimjTcPUVAkftVm7nlzvmtqBX0c78W3O/o4ZTD3bFSIL/25Ock7+sCgiLd9DO1tONO
         2h/YBnZgHDU/mo1hU/oH+LagtC2lYAfffXJnNUETgXLUDwJeZxMhZOMnZK5l6TIaXRJZ
         CCSGMln4aK2Rw9mG/gxRQ/nc7e/qBW2bbymFTY9AcwT2uFxUH08k81rA1YT1pFqPbi1k
         udBPILdDD2MrNejDiR5U6jmX2ZNIjotTwLd7icdI34ye4OPczQPUxTLs4sr7ZjmyBU73
         AHBRUBGRsZR1M+cwXeh0TVNDp86B3G1t/qB/PaXBSL7LsPUE41vwoBVeyqzqmfFksMvN
         bUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716567009; x=1717171809;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yduo7LRQm2MuQgYMMQijuv5G5s0NCfFFjn4XPOvjEF8=;
        b=prtTNZQTEizlggBJpb8sBOEwn3KhaBWTzclZESZraCLW3hSmK5OUwqyUC4vlE1pZBl
         zqpFmMpj1vgBv8iQXATLihxRTjv1xx510jS+QFb63mnNAhG28O8+mIC0xyUOgNrBeSYI
         dM9/dls+miwD7lTpFPIyeIMHTIAGFM+/qC1X452c+LjOFXAkM9/704oWx9uZgvqF2Iik
         n/0GON5DW1uGa8GmHnATMjOJtal5XVH26DwtXIUjbq6vWZepj93VjP9G2h350jl62+YQ
         kH7VRSMErpktbz1cXA+YqPLCJbWoze/31qJKVqlkVd9KWFw9rtSyf7uQ5DvUdpq940bQ
         O5HA==
X-Gm-Message-State: AOJu0YwVJNYhbtt6T3pdq8jPNWCZA/dJ5e3sYVYLbaL/cpoo8yWbErb1
	80aJ99CDHkt8AYeIEDSz95ahCh9wOFvdw89cnZGvr2YT6ztKqVnA8mMZ
X-Google-Smtp-Source: AGHT+IFLAemNbHG7xqC8Id3ysNzebipvjGFyN3drdtsPul+UiBlaZhIDjKCY19VbRCyedSv+yuq01w==
X-Received: by 2002:a17:902:dad2:b0:1f2:ffca:87ae with SMTP id d9443c01a7336-1f4498f0cd8mr34335765ad.61.1716567009030;
        Fri, 24 May 2024 09:10:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.123.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9705b5sm16021075ad.174.2024.05.24.09.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 09:10:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
References: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
Subject: Re: [PATCH mptcp-next v5 0/9] use helpers in lib.sh and
 net_helpers.sh
Message-ID: <1e8e977d-d7bc-b278-1508-75063aa5c263@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 May 2024 16:10:07 +0000
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
Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/922637=
6652

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/079d74fb7b0d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D855731


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
