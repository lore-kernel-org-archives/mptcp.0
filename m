Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631262BAEA
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738163; cv=none; b=M7Cf1R4GJm8d5Q9DHc4WF0CXI1x24KC849zQ/5x3uo+OalEsV84XnyZAeZE9k+cUo2Tq1AhGWenZ9IrmEOr01CEYzpRrh7KXqLDVLWVKYsL9TkpF5+JOOPByKatQYUARmIWf8Vxfl4Xt0Cx7if72/It5A++qKR+/ZP0w5Pd64FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738163; c=relaxed/simple;
	bh=JiAUKQ9xtu0Kplj3TIs9EicRe7B4lHcMuH7X5vy1EPc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iyZoc+LvJ6reZNQcxkgAT0pQMqlSMCAxAFRRyZeOb56qi+sKP8Hw4CMdlYW1sbzj3/2XuBGcbwFlCfW8reNTTzsIqhMWDVQG6MiKH5H+LS/WZMUWAY0Wi7smcEz4ww5F5yWROxxBlgPXfyhZC8wuIBY2VQIkrirRA0eDKULO/xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWJwxsXz; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWJwxsXz"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-46d7a67d751so172860137.2
        for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 03:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707738161; x=1708342961; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wmNkY/lPsVAEHsVvIh+kX3EldHUe6Tjtp9+WLmm92Y=;
        b=WWJwxsXzGPuIyXoqjdxazKgJnUhumVeDYJzUUt/bLrR21J6xfVB+G77HXG2Gi6f7zh
         PiTRIppmlEbqCENozBhJZUR4elCkBHTjEBVs6nHAEsn4TuLI/w5ivmjtYAeS4PGvp4C9
         M4jLx2qZhDbMc2ABWnp9FkTj7+qPOjc/chsaWcXmV0VoKyYsxpc5zb3ITzQrFZKfBNsH
         6rLEQJ01k/jxQHdtEvroiGnKk9rk8diG7VQlZN9n/S8T3XUqCyT2O7F9kw403jqTHHEm
         IgDE89TP/OIApdTClP+W2KZRpgP+Xkycg6lUJ1rTh18G1DKXIdB2UHV/l4l8g9+FpNv3
         U0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738161; x=1708342961;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wmNkY/lPsVAEHsVvIh+kX3EldHUe6Tjtp9+WLmm92Y=;
        b=Qg5S72p74Ocdp68zPm0rKIQj3wS3qAnmUy662llYbC/ie4aDe14H72blnCjz+lKKvP
         4l+0EnNI5tH/RBcaTVawTlxmqJb+QsPn3Md67+jxi+jkckK5QRLFoz9+BM9gV82OOE6e
         aWXJy2apVU2UOhLaIcFDUdGQlWWoo+0yk4ZhNM1Ls9kSfu9vjp6Bc8QhMnEiI9t30pUh
         OcKfV4dM5gNhKuesjf/O82Vs+/jMvfm5htt3HzCtLIz+q5KwLeGyXdUJ21QBbiv1mlq5
         4vcnJw3oreq1nwFxGPL6g1I0mdK3EJE6vf0VE0Ll8P4PgB1u5fD3ZVifGDQxgV8sCzDu
         JIrA==
X-Gm-Message-State: AOJu0YwPFenO0H64N2l9fiJ6G70/F04fxAeHAQkHs88u09R2XM3IyK+g
	EadOsh/vwS5NjX72DfQNY9IrUc/0Ysl9UrQeJND3KnCoRf6720g=
X-Google-Smtp-Source: AGHT+IE/oWOE7dNTrgod6hKIteV9V5Abx8kXWc1RGo9cL2cgp1xubX8fqDrrrMDaxFzuEUhIdrb2CQ==
X-Received: by 2002:a67:e445:0:b0:46d:4082:7e5d with SMTP id n5-20020a67e445000000b0046d40827e5dmr4433614vsm.23.1707738161076;
        Mon, 12 Feb 2024 03:42:41 -0800 (PST)
Received: from [127.0.0.1] ([172.183.36.22])
        by smtp.gmail.com with ESMTPSA id u14-20020a05621411ae00b0068cb1855d84sm66091qvv.130.2024.02.12.03.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:42:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
References:
 <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
Subject: Re: configs/debug: add NET debug config: Tests Results
Message-ID: <a369b89a-11af-fa3b-ba06-858d9e1f82ed@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Feb 2024 11:42:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7870777284

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/367eed27e7e3


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
