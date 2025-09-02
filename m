Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85443207A0C
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 03:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784382; cv=none; b=OVECJFVS32ZVl5Ij7jJPgS0dgk3h1PSXt1Vnu6mnehT4mjWPIPo0iIYA48NPsWy8fWTlE1Wr6gLcdR7H8HEEhR6FgLEz56Hdwa0AJ9heErCimPhqOrVH5KFU6BMXlKqz2Kh9J+Q9ux5cw3tO/LA/Jv7XPJ2r/cFPS2iVtDKpLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784382; c=relaxed/simple;
	bh=fLqsTFVNBKLJkYhMcsNEz4rNfFxt+d34ggnRvPqTzKU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=kuHQsutYZL7F+KUHH80rBRM0gKJUgyfI1IMTlv4q6QPHRJZpL7Mwe/ERYXGBkix51i2V4+IoRT0YqT1W6dLIk46BssxRPN06N+/ej6Q4PPZ/pVENX2Xjk/pH/oDOb3VPIKCksfEbwaN0mIzmVtyhIbOHzB0xe6jV2rMfmXUA3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZLrgIG+; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZLrgIG+"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70ddd2e61d9so53592086d6.1
        for <mptcp@lists.linux.dev>; Mon, 01 Sep 2025 20:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756784379; x=1757389179; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNCsRNNGEctOm6Bi5AKRWOi8h7+t5A80NTdcB70QbsM=;
        b=cZLrgIG+shnCdRZTpip6Io01OverNCFTQhAPnS9Vtm3xo9421HzTQFFQ6u9fPO5wMP
         39U7LwFj+vS3x7IlMXR6N9u+aVsHIou0uSPp4gNbp5motfao7khooMwc+39pQfxkdJ1z
         +qEwOLmgWwgL+Di+VMRSvF+AWrYpDJEn78eyxBTHJTnPcw03A8kkEFOUBcewdKtVeA66
         M4+EAibEafBAaLSNg2g13ykphBuiDvEB3Kq1eRYPUNKmrHSQRTl+TQZXxlP+nFOm8qd8
         4CjX5TsB543aMXplt3+kmi2YUa5HUgQTr9dCkwYWh6mmn7cOCvjA/CX0ahxxJC0+kJU2
         NbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756784379; x=1757389179;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PNCsRNNGEctOm6Bi5AKRWOi8h7+t5A80NTdcB70QbsM=;
        b=tPluMMVv1OG5WSJgDq74tQgl4etW2cOhRFMZ/BERYIKFB1gHNoSHKnHY7jZ42oAOre
         adQZr7ga5rkuuf3HjdsLyt7elJQ9bNWB2+ue9uhWrKN/MFTabhweG1jp3Pq6ef3LypIu
         fEezCi8vV7LVHj9Tj/p23FhOx8LQqwahRV/otpt+am+r64LTrDHvY2fZHrvYSDuCzNRb
         19/r6Qk7kGmppq1QCFMAjT2IOTn0L0uo9MAaZ8hdzB3+EJzY2/YZ7XBOcsy9GNLb9gvD
         uKXN3+MSHdXF2VY78SJQ1nb4243wsqxY0IXuUsaWDncocjsSAU3LGDsfR2UWeY3WXs8f
         a5Gw==
X-Gm-Message-State: AOJu0YwMdhUEh/Tq/D9H5K9eh4coZoWgnqJ2DYGBBD2Pq7NTor5UoTVH
	YXzitFIytPFN1wTGQbH5Af57DVa7w6h0rpLldBRFzXdJ7PlRhZ3dn2mTyeNz
X-Gm-Gg: ASbGncufVP17+qwgyJ2twc/R1MFRAWWau/Fxgpuq+9zU+jNo9pt16DjaIz8XhpfPRpH
	LvoVn9E79KB04KtIKL7MGgC6WbzAPb/t7p9NHwFI/3UnCPcf25R2/1ccGl8bV5qOJ0RvPvxhMps
	QYaKyxeIOfUptUkobbznYFW6SIJXsi8WQ8AYNcgU0RCy0p8Vj5y2osEoVH8+H0UcbMVFYEsyrfd
	KW7y2bW2/o64QF+FpXwsrTDFfqiLXjnT1ESjKz80UmoQZtLrCe4/7pC+Zo0nzf985UXlYTTicbL
	fyhppkNjdKLvhTH4w3GErt8/Mjd5LHHFLEyLO3p1cKx/UPx9ERu9AckgYJuUoRaGErcWOi9+iD5
	znk+m5I/CzmFFHK8bg1Obn4wfkEam2zLaBR5bYgaxbOFpAF5f
X-Google-Smtp-Source: AGHT+IHj52nB/BXURUGPYLkIdJ9085DxYU75NGrdkCy425ckiXYpkq/pAy57ZzwYPnbbvoO4W2ySlQ==
X-Received: by 2002:a05:6214:5247:b0:71d:f1ad:7b42 with SMTP id 6a1803df08f44-71df1ad7eb5mr43969696d6.34.1756784379221;
        Mon, 01 Sep 2025 20:39:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.200.183.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ada83b25sm5297566d6.27.2025.09.01.20.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 20:39:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1756776801.git.tanggeliang@kylinos.cn>
References: <cover.1756776801.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net 0/3] misc fixes for sockopt selftests
Message-ID: <4c36e353-9759-f49f-9ca5-ed56651c735e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Sep 2025 03:39:37 +0000
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
Unstable: 5 failed test(s): packetdrill_mp_join packetdrill_sockopts =
packetdrill_syscalls selftest_mptcp_connect_checksum selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/17391054770

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/05f2aeac85bd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D997777


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
