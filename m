Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FBE3955EF
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977748; cv=none; b=QEkH6Xv10Ydkq851dBOEcw7A+42DRqSdUaftaVvHPIO69pGokmwwWSQdUyIknqWSPNU9oBNA032aN1i7QiALKt/GxCOizhY7pq8H3mUmyAbAusx3DEGe1OSAREUk4HZSxZUoXd3COZOAOAQZdXj/fkEw9f20gBNynnb5eI4+tFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977748; c=relaxed/simple;
	bh=p1dV2aWELS8R0B5xWiWveuIn0l5fr9vUwKtxWUPIYdU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=hFodKPyMloe07Fx+LoTD9DtEsESow3yNrv1E0Za9+7qQMPndOl2AE7EajrH5aoRQAMeBxnT+M7JFlqTlZSJw+AfZRXUPV0sHWixsToIvGTtifa83yR3zW+7tzET5vSLvDVWVDS+WRBHkMll5hCLLVF6+dn6/1XmigUhxQiaXLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHdfIASg; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHdfIASg"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9217d13c276so79874885a.1
        for <mptcp@lists.linux.dev>; Thu, 02 Jul 2026 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782977744; x=1783582544; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciuvFQWiET0rd+71hdYpZgoMTSSmv8KV8tZhD1ODRP8=;
        b=gHdfIASgF4B/JQ0QfcOGgQ0pAUyV2o9WEq/Xzr3Tl1LG3StojvbFoIup6rFVb9FOu9
         GBW70BqOZL1pMyy+4pC3h4WIM4FPS4AkX/rFooPwNVGRG3rhGOGT5FCKrJJzLzndKMb9
         k36ALfnZtFuSbiVX8u0/TTTFXFdIHdHw0Z7aqrrGacMk0IiOWghWoVKr+qXdSPtvvLdv
         yo59vSyXIVHStFisI2mEdd/GszSf9YapJDOoN+XxgbN4MeKyV77CcRNIMN+UJ98yzd4g
         5mlKieL+avcarYQBpkGNBpSKh5GSFT7+RQfqNDyvG2Q8QiOI32nFZNlWuGmh9/7/NRim
         NURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782977744; x=1783582544;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciuvFQWiET0rd+71hdYpZgoMTSSmv8KV8tZhD1ODRP8=;
        b=ownX2VqpFg3V6ZLCZMDAvfJjGnbVQEhwQhVw4Mv/pxvzFxn8YgccahpziAY6sanUvx
         oRz0Wxck5J8luPgZQZV24hlYsZ2eNLbA0+YJc8toeyCi3gU2GpKEapz8J6N2XsJXAQOQ
         aYP+ORI1W7vfCDtvXzxzNKNUDtypg2QqUPsKHeh+OfNPjGX/NY6lZjefhRNCVYolpux0
         H4Ee1hVmwODNpY2NaDfNH7mZIaDqV3x4XN24ixFnG0SQ9ncjCcAPiNv5JKCf0QREnJq5
         XpQFTfy2xI23M/XPYG2NaBPcmc/xQqfmQ5B9X7KjV8DMmTFV9p6ejCUuvpwjvp8sIfwS
         PAyA==
X-Gm-Message-State: AOJu0YyiMqQzvGWkEZt73nYeuvT19IZ+kENifk1kGBdSWNAEQAvSVfNt
	9vGdJgvYQLs2TEFC/LHIlNTFvdahL/iv2yiWwecbgUiqlHPZsGI2y0YSWphH
X-Gm-Gg: AfdE7cnUNnn8ki66ZVgabKXyPnjo2WmXm+5rhZHEqz4HXtbIbFj4vKGrP9HKhYjCCsE
	Dn3NyYhFmkOTR3SXBr9rhRFgIH9k0SBSbSVj2HfQoaYa/57NP+y+h8qleqmKOoKPrKi5i6Vd9du
	HoFJA7NsGHIFcyxUGD0LVWdmORJe5AHJCFVzqqvew1PfCaskbXIytFVT090UUgTYgYl16eKUZ5/
	CJSw/Ju7IDMgBo6OwDt+INLFR65cybwiamkgHIha1y3UAcvhHyBt5Q0NOJ1MPUrtI6/IH0OjKyr
	VM+yWWXnVq1bbehr5pRZDxHutobZJwwRQjXiHx8SlBQCg9zjBKV/2/pIswEbYeCC1c7tdaOX60I
	CEMm5xSB3l5eCYCzdZW+d53ThqJUn32UwFCp5IdoRllSxUf9AKsu7YtuCv5X36EUPBSHGcyy10J
	j66CsvKVi0Dyua4ltSfypb+zbQ
X-Received: by 2002:a05:620a:44d4:b0:915:cf88:1e26 with SMTP id af79cd13be357-92e782d8064mr731550085a.48.1782977744169;
        Thu, 02 Jul 2026 00:35:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.71.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e800405b2sm162105485a.20.2026.07.02.00.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:35:43 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260702063002.127027-1-gang.yan@linux.dev>
References: <20260702063002.127027-1-gang.yan@linux.dev>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v3=5D_Squash-t?=
 =?UTF-8?Q?o_=22mptcp=3A_pm=3A_init_and_release_mpt?=
 =?UTF-8?Q?cp=5Fpm=5Fops=22?=
Message-ID: <45659ba7-91a7-22b1-76a2-83fa5c75921d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:35:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/285712=
32891

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f4ca9be44841
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1120251


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
