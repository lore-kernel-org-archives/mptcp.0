Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CFA3E1716
	for <mptcp@lists.linux.dev>; Wed, 10 Jun 2026 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781091571; cv=none; b=UkaGrSYaa28zCOHhsQMTU/r42dki7tFXU+WJZ2ZDTLzWMv/UR8hl3IzhU2dpRcJY9ZNmpfrVWhHPQNRL+fqb+jFLIwMoGbtndBQOJ5lchmHwtLWTPCHU4XPuimnEWZj+gzt5wzPGQoYszfap4h22MonzDeVG7Gl9zzB2gSNJ38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781091571; c=relaxed/simple;
	bh=gvxH4kUZt3973peo+BOhbsvA+lZufHpU6dg3qooM6Fk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=dqKItrOKLzsr8RXKWGVt7gZFAEPglJo2NO/LdA9XI2Rh6R88aHY+YAKJED0Dya3sMI3SZ0GlYdvhRFOVugHYACYEkMs9oXwR80NO/W4OraKxFGqeiIIFo+GHWctDdwWW1/3Bra9SijoBvAj/cR0ZaJOA+7A1ZcVZK96V5uMim2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBmBgsJu; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBmBgsJu"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-137335bc3caso8398239c88.0
        for <mptcp@lists.linux.dev>; Wed, 10 Jun 2026 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781091569; x=1781696369; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAPbVxjX33I2KZ8KPyMLsSa39bQF827jaBpGVGliJ88=;
        b=CBmBgsJuPLrHzmLdQEiVKss1KITkDmMu0f9wZ6o0PLlmef2I9x+FvlCdUd8cb9lBqm
         iLQcVl+ccAhaZucHeVqtSprPUYot3Cj+3B1fx2f7jlaOr2XvevbP9jCjATBLodOX5VOf
         GBJU1cgKRnUvB5oVthuMPLV418gaQ0T8QuW+XTfajoDiPKVV1BtYtx2SyNL0tweC2Wex
         bn0bWwcTVEYcFtHvvH2E3wPI0jNUQ0/Tk5k4HadT4HRgd7RyLhgEkf2YmBTnaaQikY+6
         td6tIoAKCmh8K3LtBWclaB/ToFECsh9t9ryWSpdV9DMSOEWJId+co7eBg/6uMhc0uTrC
         35Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781091569; x=1781696369;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAPbVxjX33I2KZ8KPyMLsSa39bQF827jaBpGVGliJ88=;
        b=kqkSoH8lQW1VU1baAj2SlgysCRRm4LHard896188tDp9cY1HbQWRgtYBqHwv28NhIV
         WmIm1SLw35vjTqmo6u5zxbdfR4KthtpJa8ECTnRv5i5G+wWrB5gP8WGUI7oTEulF/Z44
         gyPPbiKTH7N3TF74zz45lc4Wq9U8xLkjJwnZcq4H3Q5Lmf3dndrHaSdDDdA+GMOC6/Ip
         KuatMTGecyXQXY9ZaJuDh+KS65j8RJbew5Mr/LCOZjoXUXeUzQ0yMhMR3mbveea9AstW
         N9jqlLu2ZpKjR3h7+9rhnIfJLpc/KnMXqhD7wVqN02UF6MaOLGe/wgHhfjFgcRvp3Orm
         c8Ag==
X-Gm-Message-State: AOJu0YzPCGX3USTxVwqVfGLng+bgI7HJesKBp0V1D1T+v77wABEwVw5/
	x3kvh++0eRRYWyK51jDkZC/ZwzFMfR0ndNMEWRHGo8a/N40CECGSqn5rbFg7
X-Gm-Gg: Acq92OE74LWoaazwvBCB89sq/x15PXZL3drx1hRhTCF8WYIcfVyTpnd122t1Myzu+s9
	IA9v4eUqNrtXe4Nqd10Hda/1QKddS9pqd9ZsWi4NUfAwlhX0M3HBHhfhBg4gVwS/xxeHCl/oQpm
	jvRoTD50/mJkvgT/oqef/egMWWp3IShluxN9NeZ9O9Y/CCQVvKgnUeohZ+3tsOT4vrCPNHBqMJw
	jMl8u8E32Aw4ar0y09Lqhx7t4MI2YjjBi1I1zY3KQrkyeejJ+LegzHZ1eVM5jQ0OW1+q9s9adUd
	LiO6kPuvoeYin2CzozXOsCmuND8YnGt5QcOE/yQXyhEr59Jjtc3aZfVlIoGvJwmrI8aK1SP6fsP
	PWoYCpc2bLIqhiJzI/IQIqNSuIq05A2cmXWDKJ0TuL8HpH1rWo1+CXOupeS4NTnP/4/0G0T2uFW
	bAZgOVCakA28y9ROe/ohOsLmgxMmzgzVvO1RUG+Ogmln5q5qqXUcLA9yt3j6A=
X-Received: by 2002:a05:7022:e997:b0:138:3742:fe5d with SMTP id a92af1059eb24-1383742ff6fmr2124322c88.18.1781091568637;
        Wed, 10 Jun 2026 04:39:28 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.119.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f553ab33sm17495246c88.10.2026.06.10.04.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:39:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260610101123.765958-1-kalpan.jani@mpiricsoftware.com>
References: <20260610101123.765958-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next] mptcp: use configured TCP RTO min/max
 values
Message-ID: <c2b4a203-bb9d-0223-1761-d8eb5a598fe9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 11:39:27 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Critical: 1 Call =
Trace(s) =E2=9D=8C
- KVM Validation: debug (only selftest_mptcp_join): =
Critical: 1 Call Trace(s) =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Critical: 1 Call Trace(s) =E2=9D=8C
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/27270997828

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9d5266a80f82
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1109170


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
