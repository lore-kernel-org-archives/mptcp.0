Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313620C48C
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980282; cv=none; b=V4v1QQ7Jo8D7q3uMAtmxHYqQthmlnSL5P6WV9UIQEMOE2VwLZlWkcJLX3a2vU8+VFgfxULkjpgxBL52Z2U6GiO5hDjSha1NeU1F53FaQETZ0krmMs2Kr1xRBX63eg5HjJpnypffWiRv7F319oZKvm4RDTXJNWBXunIiKVdsRRLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980282; c=relaxed/simple;
	bh=M1wp/T1K5sewczJqOfhDZfv/2S14At+/33CFQIvuqis=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ADKHy5zMVsREigos/0ukKTC/4cAz2Ea3HuMDmNsU7dKXhI+ogGsKBRyddqz9UDGwMRNqJEjQS0k97RRdmaAC4ljuaf+t03AXJIBlU7ke2vM1LuvNvXxBJuDVR4f8ietudi+OZC610coqc5y/EaTQTd6zyR5oJ2o611zTu4gvPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzQcTTz7; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzQcTTz7"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e9f69cc576so6392107b3.0
        for <mptcp@lists.linux.dev>; Thu, 07 Nov 2024 03:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730980280; x=1731585080; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XS8NWOuMwuFUTSNWiAj0LJBdrzyQH0aZoPak1wWfzWo=;
        b=TzQcTTz7rqPJ9TEBMzBxxUF8sEHdSIULvYR8fXpYmZMJu9nmW2U4E/qG5KPaJMl27D
         fc5ETxN4aRUeGn/tfL8HKZOxmGthsqKM929cfsgZOt/6BWLSVujqunmC8vlOqvAVrj9I
         diuUTuMmW+meTo0DKE1qpzahuvszfwT6NLWJTm7z7JKmOfR4yQKK2zmkVIhH9Arybik5
         kZsTeFxvy+EKg9yalOEb3XuRIthRLtyKG2yhyic3JDWw+is+UQTD8F37eew+Ys1FChvY
         2ICoGhHjkCVjRIklCmzjaCVUraT6OJnzSxJzQoF5gZlgRT5VCJ530JcnPrxf+D996aHo
         aP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730980280; x=1731585080;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XS8NWOuMwuFUTSNWiAj0LJBdrzyQH0aZoPak1wWfzWo=;
        b=or4ja/zXQn63R1JThJT17nMv4S7BoCzfNQzLyJhq8Siiq6+CYWDzJhYSelX9dr1r2Y
         y1GV4qoOUT3Uler4dLDQyAB2PGeLaYK6mdxaMTZRXEGxspx6k57iQv7roMLWChDA7sd9
         rY4KA3bShvt25sUx8o6V2OvZBLl2jydtKcvWbTDKMLC5xWfc112/smk/VUu95jOo0tih
         PPKYiKjwkoKdlGROG4dh948Y5cBp6t7Kv5RHcVAtHuwkypeZYRgzcPq4VrikfNsdBR4o
         bnwTjVprCeScp0ObnHDea2nLVw+9uVTTpUcyiEcRAXnKmUKx7WfUQKxeVd6hGC9eeD2W
         rtFg==
X-Gm-Message-State: AOJu0YxKpQVkPyC8GxsR7pBc+mDhnWD4NbOVRYidu93dK3aLGKReJOwv
	ZKAFpwanWlLL9PvVJAmJUDDlg9isKDg6/j5pqsZVDMD981Xt7Yk=
X-Google-Smtp-Source: AGHT+IECvTk4K235ZLa8j+rKtMo8B+MSvFR0vptiYsHDM/h7emYy5N2cvkDR1wJuOYP+8eJqUbrrgA==
X-Received: by 2002:a05:690c:2a41:b0:6dd:d25c:f043 with SMTP id 00721157ae682-6e9d89b96e0mr318105067b3.17.1730980280309;
        Thu, 07 Nov 2024 03:51:20 -0800 (PST)
Received: from [127.0.0.1] ([172.183.53.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8d543bsm2500917b3.24.2024.11.07.03.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:51:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmitry Kandybka <d.kandybka@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241107103657.1560536-1-d.kandybka@gmail.com>
References: <20241107103657.1560536-1-d.kandybka@gmail.com>
Subject: Re: [PATCH] mptcp: fix possible integer overflow in
 mptcp_reset_tout_timer
Message-ID: <5a6400ff-3a5f-c6fe-a6a2-72acb13ab361@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Nov 2024 11:51:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmitry,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11721572197

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/92d0607638c3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D907289


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
