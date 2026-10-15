Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A34FECE2
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067357; cv=none; b=QV77oZrS/qGZB2YSfdN5/ScxjWB6rlU2dxPD//vjeTP2LNvrTAifzu490yu6waCsiJbdmTfRrW9Yg0Di0yTPnL4Bhz730UI77dTz4N6GWb6OMyjmXtsi66CgcxTc3WuP5fQiutN1Pek6Az3vRxuHtKoU6ZAvZ2Ji+UkwamCypv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067357; c=relaxed/simple;
	bh=ib80WFuwrP9ITV2xnAIxJ+HXZkrJQfvI54tinRDOPDM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ci8bEVvEinWW6rK9NuPnacFJhDGNDQAKYIw7Ic0A87Tf3z/fI0bJwbNHnH8rEk3ciM2tlMuevYqBAyjUHImIASGtuTLoO/90gy2iUNGs9qYqALck0r8lpIYz62870NBEXMXqPQeDxSxw9rpLciYqjFs9x69MIiKog+rCITsDDHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o5CexZUu; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5CexZUu"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6d68de53053so2226869eaf.0
        for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792067355; x=1792672155; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=naW0J5sSdhBnswSUbUcJeqAB5tEevvH88LZpLBPdPGo=;
        b=o5CexZUujYWXm4mIBr7otYDBAeTK0DKujK6NfN1XZHPGl/JSlPXCi0TAc6zmURMOIM
         lm7PSIxzLn/Iqh4hh2JKULh4TdRBRwdVbJu3rIpFnRDk1DM74FfEUcFBJ+Sv8fDnrqFl
         ejev7l8yMOsQkeZkpkluSljRRv2KOsD3+iQu842xdkIrxB9wiuxHWhLmsaVyqbaBcYtG
         WVaHY0u8xef2d2MqHmci2U3ZI+fZHMDwYNvXcLJkq0/WljhXZ1qZpzTHqSiOGdV+vI4a
         e3MoCKG/QlFE+oJr7gI2U6hWeN1fGAOd+2drrCwuWBIBpv+WLviLgguR6IIH4YJNnkMX
         Ms2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792067355; x=1792672155;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=naW0J5sSdhBnswSUbUcJeqAB5tEevvH88LZpLBPdPGo=;
        b=uirT6VdeBHQWH0RavJ//kWrh/TgsdiGhvKoForwBHXtqijmQKQVrQhcuAwlUAr8lp0
         2PHb7gctlq+lRkLkNqxAKHkX3KfXHGl+7gg7WDcuCVktzSy/6ATU/VgpqgV/n5Zh4M+P
         cYBlxv9EHt7VrxHa+DKSVKxIUSNWk1obLNadNsFh7nYhfZ3YGcGt63xJWsUl/MrEfBrw
         bvn0EtdRX1wsh4K9SUnFN/jEoqxjYquRi5IuG1ZcmGJqXtXk8MNTQuUxGu8IJa56mswe
         D86az2uYtl8tDznwbaAq5g1dNIdsuKFvfI28rLd3n6A2ucrDPNFr7bUFHaiGO7+Zlp/K
         WG0Q==
X-Gm-Message-State: AFq9FYKK7Y7nW/TCcxmLFIkmgobeFiO5N64NVdo4rj6JzYVVmjpVIOMo
	uuBYN/mMeeyIaOr9FTNs2nbNIZNcnWaBW3pl+UUnUTmdjkgJu2rodqM=
X-Gm-Gg: AYBFou1EnQpU/KjST4tpwO2XZYfM1knqxONpnz7lQuj+12q8rjl4FyEelAb9xOKZcZK
	XYtr7jH2D60xblcPMGVSJZXVErxtW7Lm4+/vko6q6eabV6uZ/ooEfAXnJXOYJkPQcpMKl3KU2QX
	zovcbVVjHHcbQZrzJOTdC3rcN5MqM4+UAMhiZ2q4F0X3JkZ9r7soAOV1V5Urys6+D/ccHvdANju
	wKb6TQo9F35PC9sKzUyVeMhoy6kEdFx0A1y2RbLm+pfE5c+23KLR3yl/A+dEly8fgWG4mZmcPlk
	HrTTdGAPXlfLuM3MXhuPoJMJmzftkg4WkagOAzRfu2LRuj4cNV37jT3zStssBjUlQ4kZ5JiNitR
	WQNZ1oqMVthiF6CnWVtHtgfSlcKF3hmdUsbI1DJK5OoblHlLxppBElSfJcibt8jm0Az0PZaBzwr
	zeapCO3KBH1dia6V/tQ4MvZh7T5x4xtTBeJVQVIkukoXoUsGcsjS0LrI04gXTvJk9qDZ2a+iYtS
	T+/X8mVGwmGtsZc/T7gMQjr
X-Received: by 2002:a05:6820:4b8c:b0:6b3:506e:b484 with SMTP id 006d021491bc7-6ef0d8173f8mr15360424eaf.16.1792067355148;
        Thu, 15 Oct 2026 05:29:15 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.95.187])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef03e39840sm15983440eaf.15.2026.10.15.05.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:29:14 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261015-fix-mptcp-issue-638-v1-1-5de999ad601c@proton.me>
References: <20261015-fix-mptcp-issue-638-v1-1-5de999ad601c@proton.me>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: sockopt: pass total bytes
 to do_getsockopts
Message-ID: <3d9c3c35-1036-17aa-1c94-5597576f8560@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:29:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/38728967786

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/03d4b1c8dc=
3f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1186397


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
