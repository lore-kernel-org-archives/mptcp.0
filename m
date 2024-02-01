Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432913BB3C
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706763723; cv=none; b=IWY6FS6AbwAoBDgmZMfXbiC5L+KDtMRjybwpObssny9NHpH+ViapeR2UngQIuRxJAEFBrcs7dox/gMlpfuCuwjmsaBLdKyJ93nUCN5/uOyq+MyGWUb19AVpcmDz6wqKY159TQDMW26Pqz5pkrmykvZNg/bXyhmKjLSVj8jXTf4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706763723; c=relaxed/simple;
	bh=dBHQSSG+brkiCZ7/9lG9NcY+YugMQ0zgt/YsnS/+nio=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KhuLIECixI9kEIfbBMs0cIYOaNac3MRVExYrNMqydxyjJB3BrF4YFdRY4CLbP3hoeZrkv0SG5bgPnED5FMxif/ZQmuom1fRnY3y6Frz8jKigr65fRIYRg/HTzdz/Jrbd/HcZD38okNKejEfZXvwzk51EqfjwsajynM55WJBSKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJQFbg5u; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJQFbg5u"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3be78c26850so359214b6e.0
        for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 21:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706763721; x=1707368521; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx3GvllNm1ly6slCpJtfDxAr8hS8QeoYz98CRLqqSf0=;
        b=hJQFbg5uZj0mtWlA1hGgOG6QSWfBRriwKH9wCv9Coe1KZOMtXSJiMwK4sxdTSdCo1I
         AJsuO97C0wvCRfiely0SO4ztmzsPqu8bGq7OWMsOGkCem8ZdL3Bq7GJkha/zPW3xurjY
         jQfcpZSToCm1wg/147V5a9o/DAH/ddgwe3y+kC/1zpk+EAVajQtQARg6/EE4tfSu23lo
         XN3HDOW0vctfVPw3/ttQt5f5U9F/rYDhsaQ8ofhqNzec0CwOhyf6f2Kq9vXRzVI8WCw8
         x/MyKAC/grMsimoOswIbXgmYhK+IAeNWoap/uuWYQnny2CnyO1qgk6TjbmCuSCylnmeP
         UKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706763721; x=1707368521;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jx3GvllNm1ly6slCpJtfDxAr8hS8QeoYz98CRLqqSf0=;
        b=vH/zcMw6Z/AgKzs+CnAKmCNV3hvnnczPY68GO5gKKuky+Sg+O5DeIapksrhLu1BnTc
         ePcRjnF+rFU3SpBPL/weCMJiU1wwfcXT8lhwPQ5HGeJY9L+c8kVAgfNV4ARHOD4Hrm5j
         pFd2gXjFeCLjKNr5rxo8IqYH4L1Ab91YFBpb024dFhBGjTxGwitKmNU1nLIQtpqyGGMB
         Kmp8OMpmxL3R6iLpoYRAyrnnNg140GbLi5nqZvDpQIuUR4OnNSMMJml+VBGmYpvShMxb
         copIRoqSs9SVSLN4ZQGpYZb2SLDNToJ0Qjg2UThIf4rynKKKpwh85FOpMh0xOPLzLAdu
         0oEA==
X-Gm-Message-State: AOJu0YyKNiekdEraT/4oI8wk5GXqm3hcJGjps+h71+Or+C2tppZPkhYE
	daxUnTLzFEUfykTlw93aei/lmuDSLoV13Ao1xYeRBMIxgHbMS7uyrZuuTaQ=
X-Google-Smtp-Source: AGHT+IHn/ey0N4QJLC4VhGXRewOCwIs1qEC1NVL7G4G6SAx/YFwqOvgfd3yL2oOhZjOhaoWLZqFnxw==
X-Received: by 2002:aca:1c14:0:b0:3bd:2fbd:23d5 with SMTP id c20-20020aca1c14000000b003bd2fbd23d5mr3694622oic.49.1706763721092;
        Wed, 31 Jan 2024 21:02:01 -0800 (PST)
Received: from [127.0.0.1] ([52.159.142.199])
        by smtp.gmail.com with ESMTPSA id b6-20020a62cf06000000b006dbdb5946d7sm11250969pfg.6.2024.01.31.21.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 21:02:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <192be0c3c28b3fb8ab56ca0ac6b02c40d9153f8e.1706759413.git.tanggeliang@kylinos.cn>
References:
 <192be0c3c28b3fb8ab56ca0ac6b02c40d9153f8e.1706759413.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: rm subflow with v4/v4mapped addr: Tests
 Results
Message-ID: <685600f5-2059-ef21-d6ae-84b14aac2583@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Feb 2024 05:01:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6118213113610240
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6118213113610240/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5555263160188928
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5555263160188928/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4625d77bcf04


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
