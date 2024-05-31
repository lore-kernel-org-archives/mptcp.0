Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AEA1367
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717115286; cv=none; b=T5y2qFv9g4y1rToT4S9bueRrxVAVILzyGydQz0s1Ex0pp217ww2TAlLNEa4uNOAKo+4vXbrof0Xwq68Nk9rjvwJe5zNDoSBnfdgHdGEIjWZqf+AslrjRuz0tmiZr+uLrHntV1h5WK+fVjV4YJJsv3EulMQMRMYpxreAR6dFGeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717115286; c=relaxed/simple;
	bh=/cXR8CqIvuMigMCbvbr1Z2uf93foL6/yurXtMH/mDPE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=cwELUz31wu47MxkcZLKEeNWzvHiBby5TNgOB1yh+YhvUHpvF4uudGeWhF4r8N7FnDaR1h59FRVwTM0EIUn+jhF+u3Dn1L1+Ne3sBYKnxfbxTuWFFWqns3hm/mKVn5XnmtL/3Z43FiFtOHFL1O1q3Z31CYRwfTbARHeuD0fPf1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9z4zd1j; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9z4zd1j"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d1bc6e5f01so832514b6e.0
        for <mptcp@lists.linux.dev>; Thu, 30 May 2024 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717115284; x=1717720084; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbHdaoUJ7wliRKDzSE6H2y1fJJ5kU0Rwa6TCqBorNgg=;
        b=W9z4zd1jG7jmd6F1ZWmEyuglIjenRQ4nnU1xAAqdhyeYDat0NC6f/hIF2mwHn+76s3
         SwGMEiHVhdL7ngnT0wef3tK1Hd6SeOrvp2FvjrR0MLwLL1MZSJadyTp8zFTCEHo6I2JO
         0mRKW+LhW6chIwoDS7ge2kwYJgpVucJea1JX7embrhvRrkQHKPd6UBml7kGg+9h1EjSR
         ht8ZWcFNIoG6E0si1FhqNROtkdEEy7SynpRrNg3ci7fLnmx3VXPw2masNwckwuRsRbM4
         iPBB1fKNqN+yKo9iqXDcuk+eOUAMBwD3CjsJEFasiIrCAw2Py/gkuW++qqmpFzKOVC1J
         1T7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717115284; x=1717720084;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GbHdaoUJ7wliRKDzSE6H2y1fJJ5kU0Rwa6TCqBorNgg=;
        b=CNA2oKpAResbP3kGf3QDiPBwG0e+2jLC9CEdzNKuMcVDiSjPvm1N1DfUYBS9fF/8oy
         xwEOnS2uc01Vai4bdfyb+cctJrQxsHo88oQkGQm34sU9fmX8YrTG5QuMMejMZNUwyR45
         bs+RuIfFIudC60ZkIYyJ497JrEuZREvMqzkTESOnE1NiKihxDW2kDdB62BwP2iqQUV6I
         drqpJhKCvZqVEN60LVQoNHr0YdsPd2I7oYth50py861OTgSVbZg/6tcLnSMIdRR5fLTa
         aTRaTynCGE0K4Jmetwa0h8cKQt/hHYPm9RYJ/97X/WSRLe0luLsXB+BnpUv31WDGcOEN
         HGYQ==
X-Gm-Message-State: AOJu0Yx9vfTEukmVwUnz6sv5xW6y8f0TOJcfItBr69b6kGVjYx+zZYIB
	cGIsB3qcrXuN4PzDun9RqR6tfVPMsX6pzlD8CfcT8zIlSEVB4LI=
X-Google-Smtp-Source: AGHT+IFAP5dvxdwh8Spvrp6YlH97enk4N8AHkDVZB1I6/CoQyOLypfhhbMY7BkbZJ3Q7tt08jw6u9g==
X-Received: by 2002:a05:6808:2129:b0:3c9:6a21:8cb4 with SMTP id 5614622812f47-3d1e34953e9mr501515b6e.18.1717115283605;
        Thu, 30 May 2024 17:28:03 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.53.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a73e48esm2762346d6.15.2024.05.30.17.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 17:28:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240530233616.85897-1-kuba@kernel.org>
References: <20240530233616.85897-1-kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] tcp: refactor skb_cmp_decrypted() checks
Message-ID: <bbf56f74-593a-4b12-ba5a-91b5968bf53c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 May 2024 00:28:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jakub,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9310667506

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9ff802fa78d3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D857501


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
