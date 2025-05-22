Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829DF26460B
	for <mptcp@lists.linux.dev>; Thu, 22 May 2025 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747910527; cv=none; b=kj3CaYengL6ST/VfuGYKji1JyuYI8v6lRetmihHYfz+UX6Ic5xdi3VrAk6UGjp/KS/uoPosLaUzC2kn1Y/ziKmfXVkPN3GQ+iU3uDpX4xyB3Sgf76eUIvgFv3JSyzPfpFRHrBAPHself1OLsi/DtLObSK6bd8seym4EoZFNRZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747910527; c=relaxed/simple;
	bh=j2ZWmYTRovWjqMoqjkT5AwmtRrYDrgGFMCNb0ovLfpk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XhfyT/FxMWcUoD/3F2KLJcp2r0mbfXmWKhbf71OQWJ5CaOcVBVMj1wICb1pxrab3UBFbVjj2LohMwratGkB0r79lbKA6u5gGImgi6T1zqHkLZJW+vl+tui4GWigv/bWDr55KhfsanUdSjh2X9aYVt0+zK0bdgaZ20GTIiinoAh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb0GPw3E; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb0GPw3E"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af51596da56so5933363a12.0
        for <mptcp@lists.linux.dev>; Thu, 22 May 2025 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747910526; x=1748515326; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6igCPViRBvkcJboowBrjSyGM40n5y8CJaebERO7H/M=;
        b=Bb0GPw3EWwvjxu/S/0sJw+BBwWlSlSe5H9bHeN6AoyXwu5ZSZKfoQ6kB/9m/uioJvx
         TTtfFDkvFrULZ1BqeW/RKPUNoEhI2V6UIjnEnZTffV00mBNs0o8hP1DtvMvABroWAGih
         LCCDbS6kTuY8xaqB9CEkeI8e1VRk9QPLyyBv22P/ZUENYlOXGAvTfy1yswctixiujrsc
         bInwvMrw2zmhAgdJuZJ/VHfdM1Xr/z6EqkS7GObJ0qlapiBNVAZH/ZddTvVAqEejr9fi
         OsiQZ8jYxQnPIeg9BNX1Uyf363dnnHCJjhDs7sgXn7rNEiDVLzSnqD2nOoOChcuuZSE4
         SXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747910526; x=1748515326;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w6igCPViRBvkcJboowBrjSyGM40n5y8CJaebERO7H/M=;
        b=uFYBkOaOal6RBiEG3VFDNMrYa6ZLxAmEhWH/omaUMuE2aUAE6qZjfUIQHjDRkfbuOS
         ifjCOO20eSxDy2DSqkJfFRFzRLxMb1MeZbOHPPjnYS1nAZuronThvi+H9GWhPXHu+VHM
         crJKhHLf+UtSmpyCLtoQvdfBlOuNa5VdwgTSt3fKwvwjvWrABNBF9y9WiGcBtf8HDw5U
         xidtukJrY6V31w84pYoLcBFfkoTYeuIDOYhaK1/vzGb5BGiesoH4oAL/C5oiEKPzGUQ9
         OxHTWSZ0m94BNr3tJ4JIBMJpzfkHoQlh+Y2qmrOKXlFc+LRG0TV5rO7venNjBQ0QEXMA
         RNEw==
X-Gm-Message-State: AOJu0YwjYFZRKrfrNx3M6fPNVT1/UhJhveluZZ/ZgOj9NBxmERw4G1ql
	7KS3WHbrfkD9DWpwxhto7HR2P0iIhCQwmgvsL4nAp9G+83O0cP7swE7UK1ZW
X-Gm-Gg: ASbGncvD5Ypq1aAa3hzvETN0BAtpCFGMOyYEHBqbPwc3Udl8liDdiId8AgAqGYGdhyV
	5OKNjhc+ucFYTT6sp7gIm40DujZ3AgVo1h7uZWFi7+Yi/Eqr+ctmhMZ/lLM5epJd41YhQn+0+zv
	YYbTEvAJB9XNH2LbIOcGbb4KMiE4VvXMxZZ89hxw5pM25kkStHX0cofMOt4AuprVxmv2EFVshkL
	UXshpwNzDfB/aLMBrUtPOUsRi8W6YgGF6r7RsVpC15D/3sBRTjqGp4/WHC63azN3RMY0khp6EyW
	8vl/5RiA5eP/0r0k21LZWLIranVWw95MY//Gcrch8DkSiJJ51vq1TTZ1lzDAjBxO
X-Google-Smtp-Source: AGHT+IGVjt9bdAtn/AnPnMJlCuloNmsACa9M0qJCgHUWjE9594gk4N4PIL99H/aLo42nbvtNGPgFyw==
X-Received: by 2002:a17:902:e786:b0:22e:5e82:66fa with SMTP id d9443c01a7336-231d450f307mr340281645ad.19.1747910525593;
        Thu, 22 May 2025 03:42:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.14.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e988c3sm106632415ad.120.2025.05.22.03.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 03:42:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1747904572.git.tanggeliang@kylinos.cn>
References: <cover.1747904572.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] implement mptcp read_sock
Message-ID: <4927ed69-bccf-fb28-1312-5cf5d409c314@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 May 2025 10:42:04 +0000
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
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/15183160676

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/524da7e8bf1a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D965336


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
