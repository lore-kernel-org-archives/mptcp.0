Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD32741AB
	for <mptcp@lists.linux.dev>; Fri, 23 Jan 2026 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168196; cv=pass; b=RRLyJQXcgiXAUrohqUbq0RsW+v4LR9M4WkD+hXQAg/Zfvb6dHHztyFomVtvV/TLudm5QhEC9TeGm4QqTaO8VQeryCOHCR3xRjcReRBasdBt3Vbd0G4kpJM5h+nbaP+JQ9d8MffE2yKSKvcnajLccVNlwot3rc/fMjL0Xa39q/R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168196; c=relaxed/simple;
	bh=y6MTrvZG8VupVu25MNpn3bdLgsc3yejB9DqMLytJSR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jzhwWF7sS/STqNdcg2E1+ErSIm9MQUF9sFMsAVSlMIfGlN6PnEYw8atrJjmAqZHoPajZL0iYu9DRorYfZDpfLGSeZuxb8phLxz8s2WkuAwjeeClhKeS3wLQCaMGvYEUaCTNsjbMGX+sQhkJPBLO663hVvP7nHwO0rk9cT1fn3h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPver49U; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPver49U"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-894774491deso37336746d6.2
        for <mptcp@lists.linux.dev>; Fri, 23 Jan 2026 03:36:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769168194; cv=none;
        d=google.com; s=arc-20240605;
        b=iy3KQJiZmxYaLZNuG41c/6ibJjCjQc0wLuCJU2BXCyYm2kpNFEeQPawh4FgeDDuM5m
         Bx6X33H6EufVBNbK1lVe8LBOwVBBD+uJaMyyyPCrWoXhqn915Wm1cZqXzOUAy8SrRhhj
         ixyiefDnLlquriyDbiESomAnpwaeX1q1KXnz72NkzkvyZ+iEW/IGKa6uhyT8MA3q0esN
         oF5Si6aqNdgjNQ3i5Ru4ECOcvo5Pxie3z4W3jN98EjeV9kT0frCVaj2ffUjSHfT5ZNGt
         SCltNDmzF9RxkL+goRiLbrP4gtsUEL/rnJau+K2tUjpPoqHxadOWKBJZdFD3j2iWUXrw
         ILJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XfBeo+UuxpBpmV4YRzeR7r9q0Ag6udZmjfpEkEtqvpU=;
        fh=KoOOhf6J2pokZKo/B0+oz08+WVYAFzmgcZVfHglZF2o=;
        b=OuobMH68ngGhzdCvla1wmgHaWbBhj7NGzz3hcHBd8WtpDVI2q4tFSC3F9Mr2wmwKSZ
         pcChcJ6i5InMY0JYOq4p/L7ij5mnjev7dayyRCAL6KN3g3EwTx/RF+RMKls1lqKWrQwr
         chzQX7w8bINUJdJWxYsPaMTar82yft+sysRtAVvHR425OSP92KChUfS8OR4YgJ9XjCmN
         N982f/Vo1yEOxJo2bt7V1lcNMgVLyHkxiYMwqP/4KQl1iGNLmjR/h2oZm4PbRjCoJbx8
         Px360/9uGZF8mcdh2f97KmJpsOZSS6AaDz68oaQliLJ5Hq57SzNDqHY8+UV3qK9mF7zn
         mOOg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769168194; x=1769772994; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfBeo+UuxpBpmV4YRzeR7r9q0Ag6udZmjfpEkEtqvpU=;
        b=cPver49UnEi/d1AHHckLZtOStHZZVIDUSNCRdPE4BD7SXNj1zPfvT+5hXsW0e/9OPQ
         Tn9bhZCBpibHDnhc49Rjl3guVQM9LA/pXe165TJsZ/aapYS/lPvxEvesrwIerCsUOhFE
         XUll0xeUuM+EuLv4BU1/zc/ZHHdemFLokLdNJqkgzzHkuCT1omd/ejdeX0Qk21pkBxDK
         hqzXBPKdMAix2TvD1DA1jLF/c5QOzaWtp1YwodZ7KYXGb3QR0/GX1hxnqPvjJJ2NgQas
         +XlrW404xOQvs7jsOe3uKpdsMUzbybMoXU00OQTmu80DvJf0w4k5EeOUskk0/3/EQtKw
         oJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769168194; x=1769772994;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XfBeo+UuxpBpmV4YRzeR7r9q0Ag6udZmjfpEkEtqvpU=;
        b=YMfDtmevYvL9XTXytQIZTTsuQ0+86o0jDBi7dshtMGauEpTSjBwVgNEjtuWq2FnxgY
         AH14SZPknudlPCp7TqI16SBmXENRAuyxO5KcgUQe2vqR1Hw1zMUV1s86EaKRK7evebMm
         49Q+2Am4207hwJ4moBjKp+UWaqr8msqOR+47EADzWHMmZ21/Rs9NvRso/Nc2UXTKUiHC
         zEukFQP5FCXhaT6M6VmEALAhBVK/IOVmBIC4jj4OqUuBYU5lRw5n1UeTpOyI7GMIq4Iz
         ePtJqjvKH44b+Zsk3yxwRV2yOY5suqI0DAxcON1PEZl2oazHwXSlnrkWl0o/x/VtttOv
         xBVg==
X-Gm-Message-State: AOJu0YxGoj2TQE0EgF3c4zwdtPnlPXkPlf5QWaaN3oKEfNm/vssQVNCg
	vIIitbDxd9FQuJzKOHzcGfGCuTdOyYFaHEgSfm+c8AnO0WgOpdOoHAKo/JILh2b1PVHklbRRbK9
	WOITASY7n3kZV8yLvF0CYRWc/0+cZCVxgtKooB34felhyoYeT+1APBoj5yEA=
X-Gm-Gg: AZuq6aL0L63QmAv25n5l2vp1/aJF/3CxT4YLYSMnNUjcdfskFVWy1A9guMibI+uaLW8
	9uyIqZwieyOio9X3tO4pZfFPY0IkMLJDG5SXCtnAktRQtoCTyFHG05vXzPigzkcXUxpbckhDGu8
	isaELtX7bvvBGQYq8uAUjBeLyOGPf/yPOrRrtzESErJUbz2rOh58WJYDPEPZXYFpUuZXLOx7RqG
	4Pw6uC+oo4sxTE7yTQR2Vr4WxLOMasTzo9Mh5b1eg3jSM0EwUYZDWaLFJ7M3aS1BfwS8GPV2OTc
	arDlXw==
X-Received: by 2002:ac8:5914:0:b0:4ee:ee46:842f with SMTP id
 d75a77b69052e-502f770be6fmr34301641cf.9.1769168193803; Fri, 23 Jan 2026
 03:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260123030327.3041148-1-edumazet@google.com> <f146d0f7-1d16-e749-04a9-05a79d1ddf98@gmail.com>
In-Reply-To: <f146d0f7-1d16-e749-04a9-05a79d1ddf98@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Jan 2026 12:36:22 +0100
X-Gm-Features: AZwV_QgikpWAgYeVNb52EmVCbuU5O98TjL0X2CUtRtX_h0J5Txt2xkoCFjWOhpk
Message-ID: <CANn89iJ+c=_DdT5CPj4Zxfhx__gKOeNjBhQuOaBqOgkR7ugkdQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 12:03=E2=80=AFPM MPTCP CI
<wpasupplicant.patchew@gmail.com> wrote:
>
> Hi Eric,
>
> Thank you for your modifications, that's great!
>
> Our CI did some validations and here is its report:
>
> - KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed=
 test(s): selftest_simult_flows =F0=9F=94=B4
> - KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
> - KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
> - KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
> - KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
> - KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
> - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2128=
1916251
>
> Initiator: Matthieu Baerts (NGI0)
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/c14ce301=
6a03
> Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D1045=
988
>
>
> If there are some issues, you can reproduce them using the same environme=
nt as
> the one used by the CI thanks to a docker image, e.g.:
>
>     $ cd [kernel source code]
>     $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it =
\
>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>         auto-normal
>
> For more details:
>
>     https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
>
>
> Please note that despite all the efforts that have been already done to h=
ave a
> stable tests suite when executed on a public CI like here, it is possible=
 some
> reported issues are not due to your modifications. Still, do not hesitate=
 to
> help us improve that ;-)
>
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (NGI0 Core)

This seem a flake ?

No issue here

make -j8 -C tools/testing/selftests TARGETS=3Dnet/mptcp
TEST_PROGS=3D"simult_flows.sh" run_tests
make: Entering directory
'/usr/local/google/home/edumazet/git/net-next/tools/testing/selftests'
make[1]: Nothing to be done for 'all'.
TAP version 13
1..1
# timeout set to 1800
# selftests: net/mptcp: simult_flows.sh
# 01 balanced bwidth                                             7412
max 7906       [ OK ]
# 02 balanced bwidth - reverse direction                         7389
max 7906       [ OK ]
# 03 balanced bwidth with unbalanced delay                       7522
max 7906       [ OK ]
# 04 balanced bwidth with unbalanced delay - reverse direction   7519
max 7906       [ OK ]
# 05 unbalanced bwidth                                           11588
max 11921      [ OK ]
# 06 unbalanced bwidth - reverse direction                       11431
max 11921      [ OK ]
# 07 unbalanced bwidth with unbalanced delay                     11378
max 11921      [ OK ]
# 08 unbalanced bwidth with unbalanced delay - reverse direction 11304
max 11921      [ OK ]
# 09 unbalanced bwidth with opposed, unbalanced delay            11605
max 11921      [ OK ]
# 10 unbalanced bwidth with opposed, unbalanced delay - reverse
direction11579 max 11921      [ OK ]
#
# TAP version 13
# 1..10
# ok 1 - simult_flows: balanced bwidth # time=3D9708ms
# ok 2 - simult_flows: balanced bwidth - reverse direction # time=3D8764ms
# ok 3 - simult_flows: balanced bwidth with unbalanced delay # time=3D9414m=
s
# ok 4 - simult_flows: balanced bwidth with unbalanced delay - reverse
direction # time=3D8847ms
# ok 5 - simult_flows: unbalanced bwidth # time=3D13405ms
# ok 6 - simult_flows: unbalanced bwidth - reverse direction # time=3D12701=
ms
# ok 7 - simult_flows: unbalanced bwidth with unbalanced delay # time=3D132=
47ms
# ok 8 - simult_flows: unbalanced bwidth with unbalanced delay -
reverse direction # time=3D12589ms
# ok 9 - simult_flows: unbalanced bwidth with opposed, unbalanced
delay # time=3D13441ms
# ok 10 - simult_flows: unbalanced bwidth with opposed, unbalanced
delay - reverse direction # time=3D12940ms
ok 1 selftests: net/mptcp: simult_flows.sh
make: Leaving directory
'/usr/local/google/home/edumazet/git/net-next/tools/testing/selftests'
root@virtme-ng:/usr/local/google/home/edumazet/git/net-next#
