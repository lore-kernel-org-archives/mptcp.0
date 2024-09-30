Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85139FF3
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727666455; cv=none; b=oodfNiGJsXgPW6fA04mvTUnG2NT84TUhSHz3TnVVasSsQrJrPf/gTe+Byx/C3IKXviBUrOUi7oxXoNoF9QBjfxCoT1j8lzCcU2RukLNQmWrkKDNgkiZEqy+HyaIW/lXlzHH4DtMdOv3JlQpP1BU2/7u+ComxUomfw1rRQQuKTPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727666455; c=relaxed/simple;
	bh=75jLmVlmKDdDWdJwCEoALwgdWpB8joRqWG/fU+xxbcs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=eNeh4FbouXLLwac2UReuNnn9iHERjGGMX/yXIRI+PKf+vbYHO/unIGPm543UGG6NT/K0SCv0W1VezOIqYjbyn8mSHmevQql+RJ5DwoMHLrnBBvSYKFn2HUMS0Wk4v+XxA+tWNtxO7NubZNnwIPnP/R+elu+msfkSZ7lrl2gutlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iziF9i2T; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iziF9i2T"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4581ee65b46so33295561cf.3
        for <mptcp@lists.linux.dev>; Sun, 29 Sep 2024 20:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727666453; x=1728271253; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj2BLePieqa2rIVX0t3tdfVkRYOkrdYQ+8b6y2x5zCc=;
        b=iziF9i2TSw7n9NOzG/Tw5xCzziCPrUI5qq2rIsVh+CPB/lP5EFrH3+kjqFzMvzIagO
         MKr2MK4jcIHi5xJOdn5qJKGxwkLcHqEY1KvJl4vddGFD2dF31wfdUCso+OMqKoI9zoVs
         3Hvm3D0v5qwcmM99e6yPiVvlmAlnGDzAJAkE7DSEu0jNaXd5ciKSllZKQFyJvoJKqOch
         P9y0W+tlXc89oe4KCfwEwfYJjq1iMPH4aR4PS5gakhkURtFlnBzPj7zfNbhqQB2Hmy/t
         elizZa1BuTPmMjbUYT8qqRhbbauL2ZxlFiX78crhH0XbJQjACvSNgkRPbQwEjx+u2Yf0
         9z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727666453; x=1728271253;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sj2BLePieqa2rIVX0t3tdfVkRYOkrdYQ+8b6y2x5zCc=;
        b=oOYeP3FTR2D96mj2OZJ48sr3XlPeM6qr+/ECcvkhnSE63v9TMgiAQiG3OCYtyK8mFn
         LS636I3TDKWEbrVzqdKbnuigkTRqxDKaYT8ru6qJu/2Gzo6C/Rpy6gGkVHhR27bSVZLq
         CrwCYCGM4XycCt6BQz0v9lobddCP9xIilumWu9AlfJ8bSWCw9DnzpmogkhPwg2GhBjQk
         ucUALu/gkkCtFw5sSnuNLG5DH0H6s/tGXrTryvqFWYJGDewn23fc5hHR1Y1rIFAyCboE
         +qXLgldpBNA4VpEL0lH+UbPWWtHzeLIwuYAFF6DWhprf+vWNqD6jd1qhqqrri5oZ/pvi
         o4Mw==
X-Gm-Message-State: AOJu0YwdRYhZvYJ2+dZ76mn9c1tDaPGllTH+2KdAZt6E1Co5SExxgzbV
	ZJ+EkkFBh2Mb+Z5H0SUs0pifh6MwgCGe6vj1hsKM6O2o0jN1vysnSafC
X-Google-Smtp-Source: AGHT+IGzEzy4/IrznguNnwvPDOF+CHY23+8UwKes/fibdz98kRBXhCqP0lhNRbZeEf7OE3RnanQXBA==
X-Received: by 2002:ac8:5f11:0:b0:458:3148:9a50 with SMTP id d75a77b69052e-45c9f2c6cfdmr149907451cf.51.1727666452561;
        Sun, 29 Sep 2024 20:20:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.190.111.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2bb69bsm32554671cf.30.2024.09.29.20.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 20:20:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1727662123.git.tanggeliang@kylinos.cn>
References: <cover.1727662123.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/8] cleanups for PM interfaces
Message-ID: <d0ef4d8b-a37a-f1f1-672c-b1cb55ec6349@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Sep 2024 03:20:50 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11098291326

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2d8847051143
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D893831


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
