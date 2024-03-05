Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454131272CB
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655176; cv=none; b=YNytK6EMbpm11C6qnoMnzj2RYEwFNzwXlfIfbnjBDrVwN1AryR3UgaBXKGcmBxIA+5Jj9eu28D0H+yJY+1FAtp8UVf+VdfXV8dSpdnS+zpHKZAVm+s9vg7Z5WnTdBxaPFIgck70rbZqBf71H29EVWkKZnZI8j0s5jz2uHMIQXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655176; c=relaxed/simple;
	bh=vFw9SHmVZUn7o6PCIWaeJebQ4OMWhE6/cQjvejWuk+A=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sfbTToXzbEdQR4QasP+IeQKAurh6XuOt4xGaUxOrf1Crard+q+MBfMsgHJFJ6viZX5vpXWtLyixHI6lXXpJYdQdGYKTegH6hKbYTtG6LtxxXE3N/yL+mHIETAPnGRq61ItKYc56RKw6XvJ1h9/m6ks1MpYGJ7yAEp/2qmw45lmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzkrfwTT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzkrfwTT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc49b00bdbso52832125ad.3
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 08:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709655174; x=1710259974; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fse3ByjloLKSvkuQY5qKcYuwUgL8bJM1AuMUHpA69M4=;
        b=hzkrfwTTVdd2bs3NEGpkHryq6SfITVdLzKFrAxF8fU1yUisW2YwFyyOf2Gx5la9tvU
         BXrxrz53wfhE+kXSyRboC1skT+CEANG8PQUb4R9X1kL5KqklQktTbT/YA2shvLuiUQ9y
         SdvfDuurzpqnTy++k+VoIdsbwqEj/XsjiqoGyvwYD69rxZYxaju6Co4yiX2VrZS7wTpc
         2JWnW6YHL3/q0fvtCmsnayLjuNTVfE/K1FxhmhzIRJ/7uNUkgXHWsmzuPVWFR4UORdpp
         Gj11PKoFiKY0ILgg9sj4au+0U/h19/jRXitdCTdIAlWtyxlF6TsLsXcU4+HwRKg5HAq5
         2+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709655174; x=1710259974;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fse3ByjloLKSvkuQY5qKcYuwUgL8bJM1AuMUHpA69M4=;
        b=grZRzzn0AarP45s6X2Ui4/0BF6wPLEchLgnOnV6CzwU7/tpgav1ySqRY1cUf+Al4Rb
         L7G/23xXVXbM2NtvDEpGQIdQh3o9SoZxhntRGzPwNWTNOc2r8lkAnoalWNUS+EH0zlAc
         jIq94jXt1By24rJZC2maDCb63TKay2TcjCga4Qojg4CZp11OPefuz/17KgEkIU7n0QcE
         sYnVPx1+7Z9aNB2pm36yP/9h+NbqnKg3U9FJqvZBUe9mBvDGQ4BCpU1I4RR9SV4X/le7
         CzVskDUqXuBi/JXIOgrU8JcCA4MPWAsUW2BmBnoKtT+TWI5l7qt2Nq1anZyf45r/0X3h
         GtvA==
X-Gm-Message-State: AOJu0Ywc1FWtmGqWqNMpFT+YW19ahLVcOrF0vWVL5PcbUcOZZh8kDe1F
	59O5Y9jcbp7hhe1o08miHhg/1eu6ulfTiannwsfWAYobkaPACqEt8qiG3ag=
X-Google-Smtp-Source: AGHT+IExQotqU8WWI2kK9yybDJRQntSkiSdjrnt5TjstLgL8NRJjvqWZJeEhpfNQ2Q3QzP9xFBPxHA==
X-Received: by 2002:a17:902:f68f:b0:1dc:51b5:f9b3 with SMTP id l15-20020a170902f68f00b001dc51b5f9b3mr2725946plg.67.1709655174365;
        Tue, 05 Mar 2024 08:12:54 -0800 (PST)
Received: from [127.0.0.1] ([52.157.14.162])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902e2c300b001db82fdc89asm10816097plc.305.2024.03.05.08.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 08:12:53 -0800 (PST)
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
Message-ID: <fbb24254-5ad7-3654-281b-3f9a8e482278@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Mar 2024 16:12:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8158923073

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e5de41746751


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
