Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB28374194
	for <mptcp@lists.linux.dev>; Fri,  6 Mar 2026 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784023; cv=none; b=MUt2wJUKomAx/qO7MlFUBjn3lB0tiZfN5S1BnrX0mk9SZtAkjsa15h6R2SvOne+j2k4TudigYcONBxNnJrxwR1BQE932lVNXuLZ1m/EK3fc6KvtYSwrtErtaj3NpGCPnYDZ3fB7y8IDFHL7wby8auoaS4UuAjWluDpOQo/Le+dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784023; c=relaxed/simple;
	bh=W8pkZBCrOO00mLsQ8vA8EWbuUbGgatLSLffGvH4C9oA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=fWh4o+P+92araFHFfJkzLP4aBCEjjXPEy4/twYIIai+InD0EZpZcLEDAMS0+olasHBDn3JUkXg8PI9mgR/N7UtIz6UIw++v0Itr+Ybpa5sDtg19edMP/xXYGCClPG0IJP1gXkmHAb82mEZEUc238sLvDprXw8+qd6h/99uaHqCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1nhvtAU; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1nhvtAU"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a0ecbc713so47317796d6.1
        for <mptcp@lists.linux.dev>; Fri, 06 Mar 2026 00:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772784022; x=1773388822; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMyiorWShlE5Ze0Es/tUcIZ1PVJ+Acwokl3Lo+Inm5U=;
        b=k1nhvtAUuw/0YnpSfkyeLaICUx/j6dws5a4ArnwGM11oLUjHng5xtGFOCUB25B9sjh
         oUAk3lIxg4sd7Tf9X7LZ+e7q+BctWnLhOUTQdvddIrhIk6AMgfWSQAZhWWaonDmX2+t2
         pBJ4yhy9Vv00iNaMJvFYX2WjzRLiA6hg3+SKy6UjzxSL/SzU0Cv+TmlDWM5gQLPGw9jU
         BrBYRszMtMppDUFpzBWHyZJw5z0Wy8Gh21AXRUE7DejN5sqYYPPM9xkQD2/Glb1vwOfh
         oDi/g9CTYODUySWjqJwhs8bUMutKZd/DvMc/KDNk++ducOUVSu5/Tj8ALUv0/eby6010
         dTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772784022; x=1773388822;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMyiorWShlE5Ze0Es/tUcIZ1PVJ+Acwokl3Lo+Inm5U=;
        b=FZ+ssatT9uzR4/wl+URSs5yUZxSPARcVb2BHv7k/Ms8KQl53kU0Ul5qL3YvUe+1YLp
         1lK0StWTKMXh0M0irHTUVXyF8Lh/r8IYluL+/eoII+O5mdRMEbuoKbJeLJrgIPpffBds
         V4n3sOZwJNZ7q44/U8S/nHGdcZVpDXxrD/OBmHRtWj02aOv3bf+W9frBmxtKoUfuJgQL
         9hTAVqoByOsEl3vbezgjFx/JsbGBFy/vIzaZ4sHGHiDGUaEWgIrz/8ZHWO8hYzfqsoOV
         kW8QiSwoqyDaZNr1PqrBTeqlarpE1qMiquFL2RzcyTGjgHxJEFGLEeiUym38iIEV9EpV
         Q73g==
X-Gm-Message-State: AOJu0YxzDqZYnADFIWUxXCGDmFC2syPaI4TIdqlUT76KyTrA6vyxqane
	p/fHvsw8bGGFntcKlY9Fy0vV7aGGf31yB3NdBIfgOh7Am/mvvMciPUL0eDga
X-Gm-Gg: ATEYQzyMkYr5jMksqpcFeq3SM4g+GT0Oqt4rIfwlbp85/ckb4Zi7b2eaA9+Zd+lsrZG
	xB2WnbmTwFkRIlVjZpsbVZbR6ClDuM0RF5FDERY2Lwo7yr2LpFkWHABgMUyrmdmssmTuOBDz0rW
	pNlIywjEruVtnMENPxjm6eag6rQxYp5IwbgSKgoGSyLxeOsETpoDsC6iB0hNqHCM3RFlkfqynB/
	ZMyPsY8To67M2JyBClEicbHY2cpuRfV9ODpXu+EkYhtY28RFzGulSGv/53oM5PRY814v2DJ7tPE
	TdL5Hk7EzZ5EEuSAz9cMgHAOrrEEQkxXELFEg9SdveeNGU471ila3XSPwuRrXBFWmZC+5h7LqTm
	rbyjrnW1ZPqQGi+XQOv3V8+hzJ+LwUdTzIJoR7uGUHZPQQEsuOKG2ql9mo1u0g054xxEXa4o/0J
	CD7y8ch8tQWd4lHRgnkTKLBrqttrmQ3MSJ0EXlXg==
X-Received: by 2002:a05:6214:29e1:b0:899:ee6a:50ad with SMTP id 6a1803df08f44-89a2457f7famr75960546d6.9.1772784021500;
        Fri, 06 Mar 2026 00:00:21 -0800 (PST)
Received: from [127.0.0.1] ([135.232.176.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316e8eb2sm5742916d6.35.2026.03.06.00.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 00:00:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260306062316.1333680-1-gang.yan@linux.dev>
References: <20260306062316.1333680-1-gang.yan@linux.dev>
Subject: Re: [RESEND PATCH mptcp-net] mptcp: sync the msk->sndbuf at
 accept() time
Message-ID: <5200ce5e-52ef-8144-6724-6b92e61eb90a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Mar 2026 08:00:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Notice: Boot =
failures, rebooted and continued =F0=9F=94=B4
- KVM Validation: normal =
(only selftest_mptcp_join): Notice: Call Traces at boot time, rebooted and =
continued =F0=9F=94=B4
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/22752507226

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/56845d31abb3
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1062356


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
