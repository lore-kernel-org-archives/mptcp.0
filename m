Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F6E80BEB
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709475; cv=none; b=bhnm8yf7F5aRtOfpplECuibyI4Od2Pb43UHsJWvSL9IT+rlxEKSbrEKGWpMaWBIRWR5NwAQdmd4MzoBL7oF89/PMtJXqtILDFnNDeihf36X4iKBCxtM4LW0MD3FgaIYTmvlllkCjs1rVrkdoIcbAGcswMEeVTP28zigAqHJAdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709475; c=relaxed/simple;
	bh=WvtywDRwLuuQMl4p4BAviQnqV/WYYeThMqn4B02kxN0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=J/W+RjbexVoNgeNGvhRFJM6tb/3gZdsB9SzOG7jZnvREGQqRhH1naK081Qw1/g+8tCFztmfXIlhIK6YDz6dkFBc8PqyosnkLFWp+nY3ebmrn7d72mdqxP6ZGAKdWLO+MhkHBmC//HvbFYlLB+5z/ItB3ZaDvfzz7DN7s9ImWtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU6XJJsz; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU6XJJsz"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6a631a90dso1463799276.2
        for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 05:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706709473; x=1707314273; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziloaOGQqAwtDisGg1d/l08lv2W9vAITIfowxCSzBb4=;
        b=jU6XJJszGglAxLG7OeGwOX7KDy+oOWydN9ModhhznAgtCQYuov4RhZSGY/eJOBWTbg
         19zuvRkbzyFL8zxzNSCxu6IFvVTkgZ6S7bBYO4XrNp+pSXLZdZ2JO4D0KLfXt6/cwX7d
         AjwEIlwygy4I+w6xhIxKKvCoLnflE9h9YoryIuD7/qS3GUtSGFAHFFA2QYsiQcAb/UPT
         eLukwosK4B7M/nyqHgv65GMnPxQi40RYfqhFJ6SGZO84gJwT/TZ/6eG7cN3idBzAnHb6
         84zdKgagkPdz4y4htaRvR4QLKtAWBEHFKgRWB6pUEK8W5v8H4v4xdaH3a2r2ztC9LSks
         nCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706709473; x=1707314273;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ziloaOGQqAwtDisGg1d/l08lv2W9vAITIfowxCSzBb4=;
        b=gIjbwn/svBMuVnbefzrWaQbDrvZ0JvUVPP+bjIPy8cvsdifNG1e4ketMyIPPM5CSUM
         pBN27rrifXaRfKHclj5yk6nBXUDXtBGTPAm6Fje4GxdiULieQcqp4Ca56qorDpMFSose
         MpTE23FT0X9QuUas1tpBUHWB8xZrMtPFxzo6Fu/oKn5/OD1JJezd5yv7+uZYqI5xRQIh
         bpYLRTyFTsKKe8AWqz+wHcfbDdYCEx2ikknWyiz5HUm7OmciFoxqt2DsM5ppseIc8vfG
         J2YQSYVHFg/7skcLxYoevS52JgPXX/SXk/GXeI5p6vAsDo4SdAHFTu4VMBzs6AbjxdOA
         kpYw==
X-Gm-Message-State: AOJu0Ywd3PN53j40zi72fcZHKKx//mz2rAEnHl8lOIDNYsVYAEvapZSZ
	neAMplRF7reTF5fd9h7sER/sW7Ewj4kmhzC4iQt2Q8k7Py55zUY=
X-Google-Smtp-Source: AGHT+IGomKebm8Habg8e2iDPrslJDzbfw1LOjZAfFKdrwe1Oy6fZngqPfl6MgxQyCOXwF0fxWGIk7w==
X-Received: by 2002:a25:ef0d:0:b0:dc6:b9d5:9b14 with SMTP id g13-20020a25ef0d000000b00dc6b9d59b14mr1714109ybd.34.1706709472649;
        Wed, 31 Jan 2024 05:57:52 -0800 (PST)
Received: from [127.0.0.1] ([20.97.189.19])
        by smtp.gmail.com with ESMTPSA id c8-20020a05620a11a800b00783ff37c473sm2488540qkk.103.2024.01.31.05.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:57:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240131134421.1045648-2-matttbe@kernel.org>
References: <20240131134421.1045648-2-matttbe@kernel.org>
Subject: Re: mptcp: bpf: fix compilation error without BPF_JIT: Tests
 Results
Message-ID: <28ec7534-01ee-a1ee-6306-88c424464a25@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Jan 2024 13:57:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- {"code":404,"message":
  - "Can't find artifacts containing file=
 conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5147216461955072
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5147216461955072/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6273116368797696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6273116368797696/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0192755fd7f4


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
