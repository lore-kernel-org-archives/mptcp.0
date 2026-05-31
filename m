Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CAD26F2B0
	for <mptcp@lists.linux.dev>; Sun, 31 May 2026 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780207425; cv=none; b=nntd22uXxVan2e/jmDga2aGzg6jua971FWoMRcbb7c5w+tLiupfGBRPU6zJm7wsrbKPpWw/modkYYoWxqu+KwyuyulocdMTHWUGFsrngOcb/5UxO18hoHKjv5dnJn6OPbLDniUqpKG3euRG1KA24YghKLFgvwtgxTe8c7xq4gSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780207425; c=relaxed/simple;
	bh=Hbb+X/uiRoZ/eYESaVMoH0TJpjDqs2Z6GfXbvyzil+w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=XOdIlQG9XzLn26EoACYT8Zd3SLEykjzEI8+qN62HH+vCYrpvvtdVuDARcWu80Rvy8adpdI1G+ISbjs5XYIOh8HDpAZ/Ur8P9bKXT7qyghwJK9rOAX04QWTM9M5z/F5whrRu1G2rxznNvEoD0k0NKm8CDYL6xCtsK0iKAL2AdAI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REQbAdcj; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REQbAdcj"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-13721dfd471so7839310c88.1
        for <mptcp@lists.linux.dev>; Sat, 30 May 2026 23:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780207423; x=1780812223; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66P6n8EuLa77qPMB9waTbrT6CLjl61VM6wmcyG6JQf8=;
        b=REQbAdcjO7cV1x/6LsomH+ssWXMAJcXA4FPY95oiKq07F4xSGNbiKEGc9+OAODkEel
         FhJ5SG3lgy7yw31MLo8iHtH+8dq/fPsABai2E31DLjka6Jf3AlrekuEBFUTLJ88axisX
         YbTP+2vdOvgbbCHxJso3/uRY/2pg3p+SWHV/2szjkUwconz82Jr5IvOs+7U4JOL1WiuD
         6yJckktN5jkF2YLNoYRM4C+A5jhj/xTpvuWKCRrcrXiEjiT0iYa8yAa3dFTx3rAVp1t7
         S7UoZrbCakpvsrwkMtOWdhux4OnOfEyli8f5QTY+W0veNP0G8oZqTY8S56EUp5bpIwv+
         6Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780207423; x=1780812223;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66P6n8EuLa77qPMB9waTbrT6CLjl61VM6wmcyG6JQf8=;
        b=rZWbEwqqGRpMM5wjhA75aTWhuwA/VSYHUSAjg674sqL38j8QkPbU8yPqyvf5GYC0Iz
         YHYIekjsZKvpVhmoY3nEhnTfn9h3o0HNsrsXcq2yUrXFYBi1G9hg/TaE9twQEuAQoK+f
         WWFPehV7S/lAcjrDk5cEJ04MHHtMXgXybqNOnGsr5LWaq6WJvW1zpy4PspyXnBTryyyn
         duouhjlFjzGqqPfeyuj3wQnsLa0jIOwzsrW0BrrPHdpCjlsCRphx8ny5HHacoC/zTrsL
         c/mnJgr6MVjOJxMn/hfYBeGDdmninko/eXth4CoLYS8Ym3DPp7coWUS1LybTdLZGmN5/
         OeBw==
X-Gm-Message-State: AOJu0YySeVn9msZTVC88EvgGYVxdb2tSjvT5OUs/n6hLb7+W/JfIi1eQ
	DOPnLfoMXmsB76kSXe6Css47aDSw+wrpGhGmSAbHjd9UswiL+sDmVXg=
X-Gm-Gg: Acq92OGi0+G/Ao6SabjxomjjxtL7jvEq41My05bEGHxVhdEftPw3R29WNMlJeHOEUso
	c2OhVWSLF6xaDxo9BmUgKvKA1Wl1WH55fGAD9vFMruy9S9y8gFi2tID7vUp8og96SayOpE5/9LA
	hACSRgLAKASf4psY6DCmO5vu/qJdh5O2prpZPOn6MUcmAieAGGS1hsjGjkU4FHshkm7htvI3AoZ
	D8GtRLcVGDZ4Eas7jgNq7+fbcqKQ57706z/X/4ISO4w46UI3C6jtfN1qCrVY9V7mDQ6MD+R3N4r
	QRtCu2m+gs/aP9RP/p3Y5Fkl7i2L3a+YuLNIvbmM2aUh+r76yuQ4eW+Xcy0Ivzb8uvXj/AhFp9u
	4mW5D/86cVxe2GRWReeheJzxWP8iI1Vut6QZnBE9WoLoE1FDHeLw1Jmu/6kG8cc8x6MGu/x8ePq
	8uOANY+1cGowgnAuyEuk6hj8Uo0jrsaXWqI32PkFkQRMxr7c4=
X-Received: by 2002:a05:7022:ff48:b0:136:c8a3:21b4 with SMTP id a92af1059eb24-137d426fcb8mr1896472c88.42.1780207423230;
        Sat, 30 May 2026 23:03:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.151.113])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b37cd5basm4522471c88.8.2026.05.30.23.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 23:03:42 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <406ff2a2ec71581f6ea6e7882a8ea631c20e23c7.1780153732.git.pabeni@redhat.com>
References:
 <406ff2a2ec71581f6ea6e7882a8ea631c20e23c7.1780153732.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash-to?=
 =?UTF-8?Q?=3A_=22mptcp=3A_implemented_OoO_queue_pr?= =?UTF-8?Q?uning=22?=
Message-ID: <52623a25-956a-0840-1049-3989b0e02bf2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 06:03:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/266874=
92560

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8b6df95aea3a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1103335


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
