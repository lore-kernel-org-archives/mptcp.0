Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611235AC11
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662107; cv=none; b=aCIKzvExVzAM6e/PJX3fbFnFHi9FBZS+p6hlXLfVeri58yqy2DfbtZVM0QDTfEVzx0s1gqCADfxR4zNhP/Z97Ftx8EVLYX26MXj4PQypCfBlMsOnr2s0VQl6/pi/59jQScBQXIVbE3/1tDdFj8BypUzPIqE6ktp/ce9/PaQV1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662107; c=relaxed/simple;
	bh=sm0r8upDP4UeMddaN7waYjC3HS3oyzp1LLGarw1/nWQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=eMRxSIVgVe2FRdg7C4azIOUTot8j3DsJv5XdDZALZSly/rChK8rMyZebotTpa1sEUgGOVehACvbWBeITYrgYM0b1tRDywWglUwdI2kmoSx4JU3A4JKx2qx/ASHNcSwG/LPHZQUBkk2XvXj5lu+K64jPCqe0j5ntShi8gn6CJG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVAfpTNU; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVAfpTNU"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8dbbc6c16b2so296904885a.0
        for <mptcp@lists.linux.dev>; Fri, 01 May 2026 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777662105; x=1778266905; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey7bpcftBMsjUjchkUHgddPR7/GAJCYNrvyrIXQidQc=;
        b=nVAfpTNUa93OWiWzA2zx+gTKsbICdn26RtSRSAmb6RlgUpEJ79zVQxoNCQkBMr3fgR
         veOj+81KBE18lBw0HhLx6jpAOl12H3wmKBxp2u5Ld3t0DRMju5uQ1WdvVGcLyfxs74wx
         3GFNfDgVvxN7pndYzZGWm/iSBMnTvQqZDUDeIIFX/lYJhuXmEt1uUuTK1B3+jlFVWs8+
         GYwEEbRA6uHNubS4NtAsUcZis0OkBKfAHNVIz31ldzGw31ikjmGAzFtJk2SmzDAjBgtM
         KYjhDDq+vusaGN+x07DgSyM6b6GMw0FjTiwmQrWrhXo2bPbeZw6aFk7XeoZkLzpUvFFk
         YOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777662105; x=1778266905;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey7bpcftBMsjUjchkUHgddPR7/GAJCYNrvyrIXQidQc=;
        b=E/Mr4t1kreOez9wwfYhYn3FiEPcPIz0h8PCzhwqytEt+fg4RGZbPqMY0f8KGSttD9z
         1Thh1LHijQuU6htQT3LTQaYLPG7zWWNicHKV1SxcCngz1OX+YGyeAOEtvw66JlbrRMBM
         ISOCMRnV5xjKW1U49m3I4OlsdxsSWlha5urWJ4syxojqEaMxhyrsT7n96FP2gpaGfI6v
         6h/8lCxcqRvcy4Pezsb9L2PhbHhJj3IWnnb6p74G2f70UdfKQir1oebwgv7NEjSypNe0
         9d8uDpOC5RqR07URiujJPNK+v8LOgsFoYbJWB6VYY+VdkbFmNrHdDXfc60PXTaebR64G
         cZAQ==
X-Gm-Message-State: AOJu0YyDWJjDRUxlGWQPFOqfFA3QwUbUXPrbJEBhFUQ1XXBVrfL2qC+Y
	CnNp2sa1BS4qYcnS4XMJ3TM8cJGRzImHVoNu+eXSiEOl/L1OF2Z1qxkyUG17
X-Gm-Gg: AeBDiesJtG+WPiF6zYtdLgLEN2wJ+p/GQvonTGQ/YCqqE7bnjRFrLkpioMDYveEWdyP
	8seYradx8CV32EwrlfwWzNsK2WKvao1W4TDj4aUFspFw9S1z4M+nX70c+KJ0PnVQZCqkyWX//du
	ZpxzK6qob8ZL4eawaJqqMYSQ7E4F79BrJg6FA7mEFyHrZ4uT3lWV+LGdRwJtkNaK4ktwjeKjZH/
	bDK0C42Wz3HY2vo1XgODLQpFzebwhW5xV9/FbVrgYvcTvtRUkovtoxpBt24yYPw2MbDVtmLJnGr
	cYxATDkolgZ/8dI+FUxbOJp5ccB1YqMPiykdVR/qFCUtjR9noB24f1G5eywBULcYzh0SeHbtRqB
	ciyMhkEjRAldDeAZaDKoTfJ9wvtbti/1FDTrWsZaCGi5sGLJ2/rRcgwbPBRAleKTowkNVEQVgbr
	zIpXQu5gcjN/dZsTflmu/c0VG7Dfi1YdsyuocWscotBGqt4jeGb89gND4eFxU=
X-Received: by 2002:a05:620a:2682:b0:8d7:6899:9b6f with SMTP id af79cd13be357-8fabad178b2mr1042198785a.26.1777662104405;
        Fri, 01 May 2026 12:01:44 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.45.194])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253264sm236812885a.22.2026.05.01.12.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 12:01:43 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260501-mptcp-sft-pcap-prefix-v1-0-27affca69415@kernel.org>
References: <20260501-mptcp-sft-pcap-prefix-v1-0-27affca69415@kernel.org>
Subject: Re: [PATCH mptcp-next 0/3] selftests: mptcp: small pcap-related
 improvements
Message-ID: <89b2e4a6-9bca-c677-52f1-8d00daaa597e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 19:01:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_mp_capable packetdrill_syscalls =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/252260=
30943

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4d003db9c654
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1088610


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
