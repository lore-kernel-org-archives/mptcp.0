Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270621849
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707441470; cv=none; b=Na5T2D6uRkxaP7XhiIE9pldqEsy8R3u1vrvq2ofyuGeu1wpCQEnXfoc+hZNR+YSV/lo703+P00V1/bwkwhzK61FoV5c/93W7E+QKH8W/n7P1c7Le4P0b/HatpMvoEmGuQCJ4TVqhwMK3aL1L8I772sGhgpb+1lustkEh8RRtFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707441470; c=relaxed/simple;
	bh=aB5D+hCHLcwWrkO/Ccuz4BP6gU68L//IQWgOV1Rl/mw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=n+sqRIzyqotrv2sFLCokhl2lba6bscQ9tDrQPcpYUfpjGBimAWm2w4yCIhUiMvludPuftPf9QWTB8/w6bmSWiRn/VQMqqJtEr2k/sY4MiIU55+PHwvMNrFx1B5ZykenD1PpZ7OY/Q561QdxtmAjhOKX3/nToB6I7SWUKq9rX1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbiJbfOh; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbiJbfOh"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7857947b179so31533485a.3
        for <mptcp@lists.linux.dev>; Thu, 08 Feb 2024 17:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707441468; x=1708046268; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eb1QtkqL9m0vRiUbKa/RFQxCbTbsSo9rAtqepjqDJpY=;
        b=cbiJbfOhUDY+oASh9sIG33aJGieLKlwih4T+4T/5gS52ofuObqmT3wwzzshYsVReLD
         MI1la2mE0xcsF1f8UO23sxLS7d1A8A2VOvQ8t2SJ87i9BgQM9W0oenvU8hEI8rdRgcUg
         blWloylQPG7TlV1Y3/GCG30kPRvqM96qUyLORgIHAmuAJWXe3JKJKEOemWPA6pmCb1ac
         TyfnoThC8X23YrauiWVNDqbfXHHZfHmTWAiGGg/Ib2yi4weRvSYBrAWvg9XbA4LAV8ag
         TaLTidzHN5Zx5h7C54yFO0MM/eXWaDhqFSBO12SZ/zpcWfh4PmohhxJW5bkoOoAwKIl2
         WTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707441468; x=1708046268;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eb1QtkqL9m0vRiUbKa/RFQxCbTbsSo9rAtqepjqDJpY=;
        b=UEzKILnHSsSaUy/PPppY15M40D9PhGuIF8+Ja9uOqDV5X/r2h2yrwZu2+nQ3uu8sXY
         u4YQJoUyCrC30Ahfo/1KfSWfEWlvbkjX2XzL1meOlVOgl1lz0WfJsC6t187zmuF3f7XN
         h5V0j2o9hKK2epZdPM8aZHoRgJhkeAbDpoc/tfsX4WWhajwfYQ/JS7zk9xYKHtk5NhdU
         6R5MMm8FyA6gy5n1mHQ2f33bHi1zKsbw3UEx/boGmOSGll8TJ4bwE3dAM+TkjxKi4PTr
         tKgg4G1Y+vfkWykMZnu0L1SA8UJ2aUE1xUQP0wcKJIrJpS1W9PaMwetqPyPpJendxkvV
         EvYg==
X-Gm-Message-State: AOJu0YyyKn7cKcDugdcD8T1tkwXsBpBS2GnyTru4GK1J6Byr9WInrgR5
	Cc1B1rkY9qaVYwEZcVErGazUuDaP0AOJ38KVp4+PG9DOmADzuJI=
X-Google-Smtp-Source: AGHT+IF4K39xQxRIXG4X8AQ6//n398CIWeGvZUGJvSNWdEz1VkchCtJPpAthpQw5EgZxfMI2naWosg==
X-Received: by 2002:a05:620a:5694:b0:785:a4c2:fb5c with SMTP id wg20-20020a05620a569400b00785a4c2fb5cmr188361qkn.76.1707441467938;
        Thu, 08 Feb 2024 17:17:47 -0800 (PST)
Received: from [127.0.0.1] ([20.49.54.12])
        by smtp.gmail.com with ESMTPSA id o15-20020a05620a110f00b007859b93e651sm312536qkk.28.2024.02.08.17.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 17:17:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <65ea8b9d71895455ded0ed44d74e0de0e2c2481e.1707418323.git.pabeni@redhat.com>
References:
 <65ea8b9d71895455ded0ed44d74e0de0e2c2481e.1707418323.git.pabeni@redhat.com>
Subject: Re: mptcp: fix duplicate subflow creation: Tests Results
Message-ID: <c997bee2-b979-0dc4-d389-96da23f32e98@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Feb 2024 01:17:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7837946973

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/57268e5e5c3c


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
