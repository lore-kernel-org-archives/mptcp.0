Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3137351C20
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051946; cv=none; b=bxx2akKPIwHGX1r0B1n+grY2pLWGCvguc54yRzoazggl818sBTMdYoD0UAkbBASz8mKuUYB9JCV89ZR1M+RljSxJ0LTU+h0Bdjar/O9yptVQInY7xqgD2n3K4wxLlDeARkr6Y3yEXi+8u94cRbKzehIzMopa8M6dKKyGIJwgXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051946; c=relaxed/simple;
	bh=vMU7Yrunf9+Z9uJlg60dS4BglO6lt7trvhl8eLPTuCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=NwXze3zR7tFcnM/SixMTuVkhPcludKeYp0URPJWPHWKm9Gux5lGEuH6Mp90cDKMmOmDEIK9iX5nrB0HD6vi+lE5cci+QX8c4IrMQY2IOt61L3My8XIt9DIqL7Q5G+BZlNjaKUpn0HAHRZvyLVfWD5SiYE3rxqerA+Fk1t33WCnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho0Bz5Va; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho0Bz5Va"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-133466cf955so183150c88.0
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051945; x=1780656745; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFHYYFjeD5ov3pMSIms1Lg6O7Ev6UnvwMP81JatXvHs=;
        b=ho0Bz5VarkBtwTedtj7jfbrH2XqNmlGziOg1nQWQCxNr32FA7Td/kZNQ5st2HU6Itv
         buJp72jSep3radz1HfqzIP/rTJtmYhpJXcqZd91wbH4ZJil+LRRzO+r8dBN3BNGCXKUJ
         wxXlNpQB4UjDmrXylySSuvXlj1qqFAVdd/aoup2GoEHMSZchlBYkojspOO+D6fDZzVi9
         9r0pU+bgLuzkCzSOtbJn5jnLJ6pvMiGn0XCkBAtnxnlirdNZO5KF84TGq4KEMycC+Ubi
         HhSp/7zyZNxembCCbqTtSc7Ios3L21gDdf7o6cZGC074blUAvi14u5xDfKTTGz5IsxHe
         OJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051945; x=1780656745;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFHYYFjeD5ov3pMSIms1Lg6O7Ev6UnvwMP81JatXvHs=;
        b=kYtheDTf5MOd6KYEyf86JUJsCZieM6JGSJ6pfl9Iw1rC0cf/u9wFOSSthDUjr3A4QW
         eRy3nHBy3zQNdJtut6N2a4eRNDkmCBYwfSe46m7XFqwWPNE7qLE5xIEnOnjqZeTbWIEK
         YlccFCgNgg8eNilyrcWnGc9BhZvpq40BnqCut1ccinEx0+lbEPy84YBevNiA9v95A2hr
         XTIAvzlWAJkNUDx4XlI3a5OOjk3JpX+UbM03mQ0Sb2AbYJ3UG/nwv6B/D64yIVKQFv4N
         j1JAEHVFQ9zORqOhx9idPP+W6v8tzmYwswe938C9smjUf6/wVHKXTPWGu/ZSYnXne8uW
         fxEw==
X-Gm-Message-State: AOJu0YwfQKsIecQvwEhQpmwCYu+uP/ZU1AZnMRe6uVy4lMc1NJQkphwQ
	t4BXttY5lkhC5CTzF5xVJY5gylHrMmftAsinBKeVeJCqZgMCFFpFicg=
X-Gm-Gg: Acq92OG0+xUZvLBIuqByN/LsMXgBfZrYUoxhfz1Ho54rSrBRM8VUsur5CkRr/Ic5X2I
	IcNSUcj1c6IT4KQ4JOu+f6ADWTO8kbljlEitoEHAazlR3CxwCB7xtnMkmk4jFV7Q8mcY9FE4N7V
	1cz4FkisyO+kc+LGdHXyYwT+VemgVU9Ixu5zmfy/XouhX9lHpyseZ1BV5pmkNkRfz7G3wsQFthy
	ashvTVj8BMEH5BZkEJgdCp05EN6W4W+8JpZ9nPPsQYE3eBDtw0djthbOIohqGWFDQ/xllXhp06l
	RrOy0gz8RLZEOx7tO4dXJFVQq60VRuMVGfl6AmD4lK31FHj5TpB5LKXSY+G0vyzw5URDdXqi1d6
	AGqcSsL9wI8RBn2ugiH1DlXFnXPzTT2sX1JfZexSVNfjKs9Lwt3tt66GfNkvzOX2kPxUQqTgcR8
	X2guo9mJcZXk6QQAuU7w1QC/1FvhxLJLs6Am+G1MDh8V7XHCrv
X-Received: by 2002:a05:7301:fa0d:b0:304:cefc:5fde with SMTP id 5a478bee46e88-304eb12b1a1mr1121675eec.26.1780051944593;
        Fri, 29 May 2026 03:52:24 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.182.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c312csm1172048eec.6.2026.05.29.03.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:52:24 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d776e14d19a313dd697e3715121f4e42e915287d.1780045909.git.pabeni@redhat.com>
References:
 <d776e14d19a313dd697e3715121f4e42e915287d.1780045909.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix uninit-value in
 mptcp_established_options
Message-ID: <06fe7032-df2b-f213-588e-0ecbb13991bd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 10:52:23 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/266301=
71516

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e2df8b37ca5b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1102751


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
