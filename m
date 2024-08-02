Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49281E522
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722625963; cv=none; b=FZuOdHurwon6EwD/iOW/IhLdFzpZa/8dB05v/CxdnKOqSdy/MzgZBbOK8RA+P0JdJ74K5PcEd2z2J0+srWZ0YLVvYnIaOOfkO5yd3Xa613ygD0ESfyeP+uhHx7DB0Un2ZBez9JYcOMlJQ34Kt5LA3/1YaqQzn7QpwUBtembW8q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722625963; c=relaxed/simple;
	bh=zjWP2QJW50CZnboEIJXhz7/VOO2EE5Gqj1lGRJrA5vY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=oqh0uXi/17CGLVf6+bE4AckSPVAlHfbymceJfYyGFwPymHgu3xUy7Q7DAUxG+n3Sd6rC+Q58Pmk7fxKOWm+u+uaKrKDsA2+hWLw2H0d+4KEHEdho6BKoVMXd1W0xtZ9CjoM+QE84JbQZsr27n5XAZVBKyux8M68faqVGnPUI2bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSJrzy07; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSJrzy07"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70968db52d0so2755267a34.3
        for <mptcp@lists.linux.dev>; Fri, 02 Aug 2024 12:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722625961; x=1723230761; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC6eDrCkzTxTrSaMwVCs6H2Atnwj0X1ig/ORMuopsHo=;
        b=gSJrzy07l68rmz+u5Bgyx34htoWR5nu9jsl5UMPC70+9fcK9VEm5QQ2KlC5HUSCjXk
         aFHLoiHXYgZI2CvN3gpfUQ1oh3lwMxBXOxXda6f63VoHAycN/j+/N0+ex/XMotMauzUn
         7T/J6V7m529YfwRGDR0FDzDsjMtYHB38sDafT2mccdlJ5hldl89Kpdyc5/8EFEGWtSO+
         e1ZBAWZTTlCgW7hi+DGEkrsN/c115J9gTQcv06EDQpADfjdJe7swnGIpETLPdsGP4pVa
         R+SrH3I61CYsmIn+mdEunlgRxVy8z0UJvSzQ9ak9Tp7LEVt8ofvyW9310UvSUJCL8fE8
         Ll1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722625961; x=1723230761;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tC6eDrCkzTxTrSaMwVCs6H2Atnwj0X1ig/ORMuopsHo=;
        b=Xh84N/5n7rkWdOMrwgMUonI+bpkE0+85Go+iLAWQLOcRge/3cbZQp10kzckqf6DmCU
         roa8TMtLdDbECno5ngajtwhG03MfLrxusN05/B1wMfSistLowZtGhUMDdXdrHzTVw59g
         Mk7qmK120bfMhcI1t7ldA8lFO3C/2wZ8obMC1mw5jbF0sZJhVpOSQhsH+F+TIg9fSIuf
         l3lc2mzbBOHfqYSVy5FDG+tUpeYfrQmophu4gIR8eWYZSPwMKT4Pc04fOhYCdafILi/l
         BE4p9VQWl+/ghbiTCYocEBHq202B4KcH0QGMPwJvXlgb/Ch+izHWzl9vRgti+BD3HQTq
         g8Qw==
X-Gm-Message-State: AOJu0YwCDIwkJOQ2M9yvqSbOJTNE2/b+hnmbhVB0ggjnm04BJwDqIj+E
	bRmiP6qUoDYtwQ1G4925hfDJWDllvwP4UGMw9pR640Hq6DtRhvU=
X-Google-Smtp-Source: AGHT+IH9IDfuUtiDfr8MjOuTfWo9p/hCfWShYNRls4Ueiq02EvKRsJ0IuHtKciIszYfLTq4uD4cQqg==
X-Received: by 2002:a05:6358:787:b0:1ab:e07d:c93c with SMTP id e5c5f4694b2df-1af3ba46a92mr542981655d.4.1722625960681;
        Fri, 02 Aug 2024 12:12:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.78.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c8678f7sm9453486d6.109.2024.08.02.12.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:12:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
Subject: Re: [PATCH mptcp-net v6 00/11] mptcp: pm: more fixes around the ID
 0
Message-ID: <0e19c6c0-b84e-e7b2-44f7-18ffa5dfe90f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Aug 2024 19:12:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10220396170

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f6e2a49ca2ee
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D876308


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
