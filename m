Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300A5256
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656370; cv=none; b=NhWpYhLBpFvbSjGCwLMxyCQOSUXYw/0sYmWIlpGMMiH05qJDf7GgbijlNnmif9jm9XQ4cyMbH1uAGbIfNxcflliTT2ub7Wibkxz0fP1DW2wCSGXwvunMTIJh2S9IE82NnfasSQFPr/m71pWLNvp3b2PU3cFezGy13WGLOm5FTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656370; c=relaxed/simple;
	bh=gffhQNVCGIP/N6b6dnM6AEfNFrMAZ+K65LvYwgFAIKY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=YOfg6u8QgomKENlgbYvjkVUo9Qu5WWAlsTtFHsnl84MwBYKyR7SZ62sWslek9BgDOtqibFIa9lvmxMftj9ubVPErUXFiHpIqQ9SrZ6m/hOZqO3NKTZrgaxIwOR/WQ1TCaMffWAQEOKavPOQ0loP8tIpet0EhGwK63p56EfkwSd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wb+mDs7i; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb+mDs7i"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc13fb0133so43820455ad.3
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 08:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709656368; x=1710261168; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpl1slvZVRDo3RLP1i7k9qt3Ilaburn9dTgBmYjoCik=;
        b=Wb+mDs7iJdeTdio+lXXepU31rq6cJzsLbfPnycwEHiI8BsOz+5t8iPcrwszLcqH1zp
         UO8eI71lsqRPkxvVo81si1XptoR4kPKEIsLEzZxBMyTN4uCtGkMxwLWOLWaLrXB4GBSt
         dnrF8bf9ZCdG4fdI0r6qUT2WDYwUQz6+FT9uI6Bq5IfLw4orhGc8ivKXr1ILDtc4ZXvT
         Sf0rDpT6N54SJ0gMfd989560dk3uTXio85bLG/2yrO5BBPv2sVngQJiobPgoLYQ5K5rj
         Xhey2DxVjK/aJTUEnqHGggpKN2nKM3kYDpSovNbfjkNr0kgiOVgzLCUzC5Oye+8n68la
         wpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709656368; x=1710261168;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpl1slvZVRDo3RLP1i7k9qt3Ilaburn9dTgBmYjoCik=;
        b=Ilvk/iP6aNumybCzpuhhwpUe0BRE8ndKgYygC4zPda1ycboeKifZ2LtHbzoQKZW3V6
         0DFE3XlO+tjdbDP1FUWNUbXNrtTn6KW3lmsX1uTZOD3XqP/Nc7Ww9kqNNPLQYaU9I1lM
         L1q65YKBJ4E8HwER7Wdn3pLvOQhTHePH0LQoL+EosPq2x3r8xaieNbK4tUZqjw5IJvDY
         IXR5ay+HuBGd4nTqhn7r4cvcOb+u31Ybetdyb61xjkP9LXvJhk0FY9nq7qTYSs9G5UYG
         0umvxD2CK/I1m6VdY/qNbIJXB1zylKJe/ENrmiIMyhaNRlEoAQaZiIrNkTxYHcf4jpk5
         /4Mw==
X-Gm-Message-State: AOJu0Yz0MdkciiD9q0RbhO43EFP3TcbG6s8pCJ+e/bRCFBkD+W/RGxXU
	8K6btmOVNqfOO0EzvoeLzG98bA9sSj0v8G5zr4Hp7OHGeFSmprSCR/SkMWE=
X-Google-Smtp-Source: AGHT+IEhze9Cd+DiIGno8vBNxBUvjsVjbv0oC0ljbQAUOOxt0Jge+UrUbGrZqRzytsGWE0QMNiE+RA==
X-Received: by 2002:a17:902:e84d:b0:1db:c390:1fdc with SMTP id t13-20020a170902e84d00b001dbc3901fdcmr2815321plg.1.1709656368515;
        Tue, 05 Mar 2024 08:32:48 -0800 (PST)
Received: from [127.0.0.1] ([13.91.68.166])
        by smtp.gmail.com with ESMTPSA id bw7-20020a056a02048700b005e438ea2a5asm8174950pgb.53.2024.03.05.08.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 08:32:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <be9176dac04b292242d6afc2eefc0c931d21b0cd.1709651670.git.dcaratti@redhat.com>
References:
 <be9176dac04b292242d6afc2eefc0c931d21b0cd.1709651670.git.dcaratti@redhat.com>
Subject: Re: mptcp: don't account accept() of non-MPC client as fallback to
 TCP: Tests Results
Message-ID: <6c934bdb-19c4-10cc-85c7-f3abcff67c0f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Mar 2024 16:32:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6707619503538176
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6707619503538176/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4561372806119424
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4561372806119424/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e5de41746751


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
