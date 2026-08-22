Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1C2C0296
	for <mptcp@lists.linux.dev>; Sat, 22 Aug 2026 04:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787373194; cv=none; b=Zkw/Hym62LCfHBEzNKEzGV6Yl47vOsWWBld7aFI2wl6eVHBDNRoJBctesjGWgku72KbnOoQWH7CXsGIKrqx6dP57AiY4So77Zmm+d9xI233mgDol0aZb4js//3qgbe/6P8BWhAfDPwSEWx1R5nNzpjxiaJGW4vjguq1cvZM1c6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787373194; c=relaxed/simple;
	bh=oeOfry6h6ZC5RHmVjhjjDq6oRINYKOa0uWk/4BHJVkk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=M1gQHBQR2fu8haScr+KESF0MR//dQU7zNhYCYFYaPMyPFLjomFH1bl35clTFcMWz26xOJFKdNwGS9UKv3j2IcscE2McF7nmVHtRaEqY/W+apCUeVR7F1udDC5iY9G3UD+tAt3k8xDR8Kn2jobYjX6raC74PkgeVf6D0i0/0t31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wmjpwn2L; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wmjpwn2L"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so1096196a12.2
        for <mptcp@lists.linux.dev>; Fri, 21 Aug 2026 21:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787373193; x=1787977993; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qdwn7o+Psw+N65WWo7yf+HbZUmmfNWJNVHBP1XBjc/Y=;
        b=Wmjpwn2LxvTQBTdPI2JBdprH+Gj7xkmt1qRbmLYhp8EH3Hxzgp2hRVOHVs8dBN9edu
         0jsLZ0mKtWhC1qz+JRqUQzJ0121cyl3O9LFhjWLQrd9xLxGLa3Oi5xk8d2kS6RDjZZju
         DS+1M59VJSkwkkrXnd4ZFTKdmszQRp+mujqw0hKHA0RbNQzuXO60gH2au+e2bVD4Zunu
         iedTCTd6b6Edoi4tEn26UApGREWTy/RQAGoTWVxnz7c0mU8D6weaeOlKdoMr+qxZqWNY
         H4qN7iyh2cVi7wkdliqJLkF60IiOhniQ2a2EGcD/8evnoxbmoHTC7Z/rBTd7Ctujs82z
         gqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787373193; x=1787977993;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qdwn7o+Psw+N65WWo7yf+HbZUmmfNWJNVHBP1XBjc/Y=;
        b=BMFI5UCuVxCX8eayKNCGi2er1/iGs9v4WXek6g/YvdFkCjWb78VeZPmsVjpV999u2y
         aaK5q/MKt1+90TNo+Tjq5T/qdXqUkWxUXCbxQH9Mf6HAOZYok6axlM6+H9u9gO7r0YaS
         D0RiNAUdB94ZIOcyxr66GxN42SvTdZcqfgTkrz/XPCpMWNuacf8Gd51cxjmgHJ/93yuJ
         gftBMR8oNMP8hXYZGMWSHlnoxMMgSCdyw1ZI6H1SQ/+XuQwQyKw/2mDidrKuvSket1v4
         dntLx/LyfCtYL1Qa+WZBru4zyv7nM0naPU98QRhYng4CKtFuMoD12URPZQLGILvvuSy6
         /Lew==
X-Gm-Message-State: AFuF++kcvPtMr7jMjW1RkMWTjqOmOJxh1pkXe07lqo6EVk7Zit6etQbe
	UkrNwKGtAIOPWSCO7J9X8mjbLfhhOiuTc1IQPys7uQiEsE3eXb6nVw9Wi2ilO28=
X-Gm-Gg: AR+sD12tDyoLILJHaU1WagJ0xArPw2uGz6MKSZTV5T7xpd9/9MPKmhPWTfWEJIPBbK/
	bj0n8+fWelaqxSvee+WGqcgihv5I09ZbPiCfItVJjc66hY3tOIEbPCeFYRavnV+1A+cO5wlFyKQ
	08N1wmOmTgVBzt4t1DFo+xS/iONBXgl1VTsxVJ60HkDxhGA9KCohTde3VFXAj0EfQ89wtjdr25q
	O0ts9sO/t/X+enQMjYTM+HOKowEcThwCh/frgwFgd2C3Ts1lNOJY6q+t3BmBtG8xahzYKxBfSzP
	crhFedcbsDWsX2XRbmd848XCBwC9Rhy9uZ+f+Te9j8Jf8N2fWwT645D/uF6hW1fCakhCVgJsUL0
	G+83zvHwJSW8+t4WtwkXVkfCqBZ5xcd0Aj8io5ObPIZgLs5xiaTxfG9DmeYATG2L0hYrF7UiIPY
	/Ks9FHYXNH1yMm9SLsvDhU3Nj13iHEsjcnogcyk9fMJNcEiiJ3/C6GY3czFMOzOKrrkocEkUzZe
	Fw=
X-Received: by 2002:a17:90b:4986:b0:38e:e9b:ffa4 with SMTP id 98e67ed59e1d1-395c33cf295mr21013783a91.6.1787373192610;
        Fri, 21 Aug 2026 21:33:12 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.243.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860ef75esm3432009c88.7.2026.08.21.21.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 21:33:12 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1787368526.git.tanggeliang@kylinos.cn>
References: <cover.1787368526.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/7] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <f1861358-99e7-6237-625b-ca0f06459332@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 04:33:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/325496=
84249

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5e7e80d605ec
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1150080


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
