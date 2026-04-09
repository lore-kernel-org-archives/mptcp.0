Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78A134750A
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772649; cv=none; b=CTRCFtz4h9iUCv2HtUjl+uGe4VzIcZu/VPTYca4O9yYiib3DzIr70b8RHaZ5Buzu8DQNuhJWMdsxpmgvcvs2cCVTWa8Zb0Mb/mvyOt+wgN+MtbmSvoxDEmMjlB5CXm1CligDk/gxPlSHJhPj62/lwBPuNaGqd/DFVzatVioi/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772649; c=relaxed/simple;
	bh=jrRAJ2uAFhwmNDjSLTqnngsUCkuNBl9Nlw5wInBom2E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=G+C9obO1+4lMy57KWGNHsZCNBO0/5gpp3n8mN6Wn7+HEgpMT2I/h27gVP1XyuCh/7LcofxCFNfMXc5ao4sIqMMHgf6I/isDcZnTAZ+LdUIm1Vojkw4cZabyU5roDUbrJK4ewNHmmU02zobWz6AlM+DM2QLCQxDl5ugcQBou4F/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDxlGLXn; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDxlGLXn"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1271257ae53so8577856c88.1
        for <mptcp@lists.linux.dev>; Thu, 09 Apr 2026 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775772647; x=1776377447; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF49p3qfcVpkGmmeF7Qvz1qYWUro0/ii1rM0LfYBt3Y=;
        b=dDxlGLXnPAXhqv2pQKCpkpaT01MAX48T8DVtbx/HuvbmqAc2IzA4zO7ASWtwRtI9L7
         MAlmc9wP1ak39VS3WVzOudEijOa+e0kYqeGB5Z9meGhFSsZlVqw85R0lW0c3onyQSgQ0
         maFnwCNrAfTHyhmpkMWp6jjZC3Ve5D0pIp76zcRF9cOqHI3+IjVjQtUIvws0LPxx758/
         4tftVS/3b8LlpPQWiqaCD0f6+TKdVA1DRtI1ORZuc3+zKl/5Rb8094WMEI3X3K3JZyUP
         eIu/1orqyHdFzSYXIDNQmcrYK/4zBlM+aLf6c17Gfx9GG2JUMWGf5yvmqYu1K103x/U+
         XP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775772647; x=1776377447;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bF49p3qfcVpkGmmeF7Qvz1qYWUro0/ii1rM0LfYBt3Y=;
        b=Lv+C7QCM9+it+fJW4kGDLAmVUgTN2i+8P35Y2EtNudzadyx9Qt21IBMzzLofVvALJ4
         lVWiuxzxvtzMUY65vEbLXM8d55vo03pncYyAaGzr1xqWWTKhu+BbP5dyXgHNFG/mk8mr
         uVrNxBwn6z759A/94Rb3/uB3iOY+dLvSKoCxISM8CKbSMoMUs4yUdKB5OU5Pa/J0Kuj+
         pKcPUZcddwoQSBzW9jvUKfR/umredi85LwW+PC60mcefYSGteJk/qjWKb998KyuMC1vo
         JoBZP0QgWM8jeOMbSRRiQ/UQxPyKWnIe+tvUHlSwkLxRNzrn8axgiqblirhxDC3nazi0
         t4tw==
X-Gm-Message-State: AOJu0YwjDx5vO/49NODm2ZYcmm+1QXDWnKleLcU2elKEsztgvYciWCey
	GsyTZOc6m/YGJiEjhLEZ4sWYoRinQZux0tZhNFEYxwPI0+vhbNjuwPKLTCkOWSc=
X-Gm-Gg: AeBDies8W/emOxSEEz5s+YV8yvwf5L0/UfqHzJOEI1JIe6emIGyQ6ebjfFqSawuDj9S
	44dad3oS7OngTxrAGkoz4uqNV82H+98g/Yl5sD+jyphCYyZhCVOVPAdZRzdpAEa120rCnzSWd0Q
	x+ibXyUHpgCvHVSm07aiVUOYbTVZ+jq1vsOMutbBBHPUbuNrjE4gr2xtPltcD9AbQAYLaOpxbMt
	xg3hlVEuZTlxZQAJYDMOJDDnCOc4XbwIzqKPkSETLenVgerY+JdWDdwMF9B0x4dabEJXJEX2Di3
	H8KAbXEpMW6XxJSNSinpRQed3vP254BOJXwJbXvwmUN7gvsvoIEJLYoTBaNGkovPeplJafxx90K
	/GLP6h/YjcxmeZw/AeaT4vIY18PTD00+79SETnUfgtjcPno7eSRdajc5JKOoW1mqZncLBRX4n1p
	IdoGhgATSyR3I9n6nPQsT8myZhp284663WpMo=
X-Received: by 2002:a05:7022:517:b0:128:dab3:f528 with SMTP id a92af1059eb24-12c34e892c2mr530076c88.8.1775772646854;
        Thu, 09 Apr 2026 15:10:46 -0700 (PDT)
Received: from [127.0.0.1] ([40.65.56.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346eb314sm1079591c88.10.2026.04.09.15.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 15:10:46 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
Subject: Re: [PATCH mptcp-next 00/16] mptcp: pm: increase limits, and
 related fixes and cleanup
Message-ID: <3e0be4a0-b154-2114-ceda-6cb1f954b9cf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Apr 2026 22:10:45 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_mp_capable =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/242138=
56022

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/66c601bbbc1a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1079423


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
