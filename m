Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2C32861E
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213680; cv=none; b=siuwDWCZeiuckCUCUy0WRbY2texG6a8F61OixlytXhgZRaR1H0BNK48SmV0cTKAvg/euLORmih+rj5H1rKu3L52XSr+NgvoQu/zXOLO28njbi+7x8o/KLecS/mfu5hIJA52kmq5Pudt4AYbSeHUK5Wq0HILnH7j3O389/O/ue7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213680; c=relaxed/simple;
	bh=Kva8P4EiOLSIk9dHLFi5Xj400n0N7OXI3tNFVyW658s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=M8DChJvr4C1rskEobEuDIeYYHufFd1hb0hn2DFit0H6YX7+wl3PP49vk2qPdXUnnotygQOU/ceF6w4vX/5BCScjZYPzcIMMZdHQ3zRGKCzzxRn6GCzWJ3KWjK9ylf0yzDzmq7gJgTERfdUqqzzG74NUnG5zaSC+wRDJvjbOIDAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3M0GgBc; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3M0GgBc"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ce9df31130so4918236d6.1
        for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781213678; x=1781818478; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5GfuUEDUCLOuTfaSnUYMiXNxmvgIyqEXYFO0BN9Fb8=;
        b=F3M0GgBcg4oc4kHQlcZh5TmWgCj5XCY5qMwupCJEnpWj+Hga7p4dNZa6oZ8MFAPY3U
         XtsRdqHL94LcNu1iCM/JEzDFvC4bKjF4cff6kgCvyFmdu9O95oPG7Nh1ZLNvbT28fNPb
         36x2AJSX5NPTRZEDj/kQ3GuJpva0MbbJwub82zJDorWuY1ZNncMBh102t4/MCP59wpCO
         Wxe+L5cFqDRPWIzkr8r1/069Mlim0XiwskYjaNJXhQpfu8/MyC8iVikHnQ7yiSwGeEZ/
         /KKIX4kFi9kjwnZDydoKJWBy31EMsK3V5rDijoGCAgcX7iy1+tJ246S6Sd+jeltQweED
         vhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213678; x=1781818478;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N5GfuUEDUCLOuTfaSnUYMiXNxmvgIyqEXYFO0BN9Fb8=;
        b=W19oyiSdTQEDZMIyx+ob9/bzDHkIM+vpazq2mZNC7YTaDFNpyWG6OLFfhCPj1nu4cv
         LYHuaZLj5iMR9YbsIETjB4rXiWXd+WRgPQUkpvds0dzLHK+IMlNCQ0CniVOYaHu30lyq
         Ppt5Y52UDcydPIYeNtaP1el+TXE9Ke1CXTz69PPrILroTY0BlClKx1RB9PE+YRgWtk41
         GgpiG8+iMhK495mYBYZNyQHGY/uu1zkN8LXuW2s1bkNkoXIAsQ0K/LQrAvMGpKcWCoZe
         fFrsj7CMaMUydRjXTgMlqoqprLvOznud/o1br0PPEoRl+wJevMmX4tdurJHmQtJrvIuX
         rf/Q==
X-Gm-Message-State: AOJu0YwP44Rt5lwsB42Hhbc3IxiKu7QOy6n85zu9PusgMl6SnzF+w2Es
	qpLjzXLgfR/5KjlUiIGuU8ilIM+xkI+8F3LuQdEM+8Dxh7f4GydukYA=
X-Gm-Gg: Acq92OER7tJLASJbA3DtZWE/OmTo8XZXDXwsMZlrd3tJwNnDwO3vG9CNgTAynB8zhgG
	HhyhFxxi/f4XhfdUphLHBjlMMewUVYlGyYYq/n4vlzmV4puMqRCGhVRdhgoBe73boyV6/hgOLbo
	1k5Pv4/r8W7/FFzs87JKI8yGSs0pkvu2IsmaZ8IrDqjVpkc0QomN+WJfgrjes6JuQzaYTT0Y2HL
	WL2ZOCWnwJuNQBc+tQYtvhZiAEvHavNLHzu+cQ5l8mi78bTsBOIWOubDf2RbG8wEN/BmNhYrEvy
	s/BIN/sDRvZ4Dw5qv5fTwUDRcEJtUExvqAn5LvpwxI6lkvLxOKTDX2fnpOQpOlP9fnD5jhgBlTp
	zm5oxCZUZb3IvDGpck5yHkgp5Sf6NzxSGdGX7XzVB9CJvpPcdiRboLofhbvPtmTxFB4p9SBqQ8s
	3JNUZS4edheTqGAVQZun3uXxfh8hrMfEwe40mupg==
X-Received: by 2002:a05:6214:1d07:b0:8ce:bfe3:6e91 with SMTP id 6a1803df08f44-8d32e9d9d5emr3303816d6.33.1781213678529;
        Thu, 11 Jun 2026 14:34:38 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.117.104])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301c244fdsm5294446d6.18.2026.06.11.14.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:34:38 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260611203219.3448354-1-shardul.b@mpiricsoftware.com>
References: <20260611203219.3448354-1-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH v4 0/2] mptcp: per-event MIB counters for
 MPTCP_RST_EMPTCP
Message-ID: <137f8f11-f562-ecf3-965b-6a0a37544590@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 21:34:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/273761=
33346

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5d23d993f27c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1110277


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
