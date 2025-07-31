Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8A29CB59
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953801; cv=none; b=ax1Od5VykX2I3XBHkcM35jYfFlt3OTeSfN1BntHJx9IGbF0U8SJqvaXxKm0Egks1m60pnUKxcpWBRQYmT7sfZs79/MtL5HnDXKUW7rOwisNORaAmLdC4sE5iwc3DSNXJs3S9xM7VrM8if+QIwVibJMmrNgRF+DJJNPgtHxZTPaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953801; c=relaxed/simple;
	bh=+hvISZuo5ZRfif5eW0RCMwUoORC3diZDwsXiqtiP8rI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Km1/NM/NPa0FQ2L0wMSS0cc8e6ohPHprkMlTHkoc1EkTe8O5/HwrgwjmjIsRptfECKO3DfrZy4NcasT909Sjfzo5HE9iZ8DMPMemb/bAaMXqt8TuecjM29LztlKDr8lesD6K51sgIPwWMfkukGCVXGj6wfiB+R8aHv48Rhj8JHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV4V10RM; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV4V10RM"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab7384b108so8007901cf.0
        for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 02:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753953799; x=1754558599; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFLSjvTjqXnuMIDrBSGzOHbF/D03fX6nrE7951C648w=;
        b=KV4V10RMcQ6DImP+aYH2YwCmWOrC8k/yZkDbuVXk63Y+Wda58g92XX+/RQPsIYdC62
         apiGHIBRvIEisa3g+gQBMqBI1qEH2ObMn8LTGtIGVmgUX/ATlYSN+WbLBDTfk3DkueNm
         vn+z3/ZFY+vvK67pcivOGFFWsTEFNeHdMygCwOyJDy5Un90bamgFzqsoOB1IqLdIwd0a
         Xp+LlrXKi3ztgxxPkCdqn5vmOBjObdW+LkX4s52exiVAfXxmJwS9N106tAQk32GZWx+6
         GW+cy7nc4yj8OpkxlLVnX9dvgm9iB8KvLOHif+fjjgNn2bS2aKZLdUzcN8sSw5gw0dO4
         VlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753953799; x=1754558599;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jFLSjvTjqXnuMIDrBSGzOHbF/D03fX6nrE7951C648w=;
        b=jVpAmkHsM837LehCRPhLXA98FlczGxdFkLPLd7Uq77+gv5rhi1KpDvqlNqKfRCuTsX
         H2RRqu5bjQu6EhONfhmQ8aV+bKqtZJh+JXiAr3LjTvQab9RbaGP6aZMXxJ3Til14JjfP
         p0kv/2zq3naGbCipoNr3CSTFyayp1wOPcuXMSuTkcBz5byYu21Md5NJzJQFku/XGJX1G
         wo+UW3jH6P00m/nsuj1kaZkJZnVtv/ED4bdjtpghKitFAUIW1nAk0uk7piq4pvlw3iJ0
         7D5ZrlcPgQoli/PmX+pu7CyHrgtZ7ycNfL1kLBj4IyoucvC3fdSHNW60FQR9rRj4k8wy
         khoA==
X-Gm-Message-State: AOJu0YwJV6njsLHyPW5tmnbeOuarrky/Tc2TcY2BdJuqgtqAl/MIhKDu
	AcbNxXkIhE/iPL93Xs7RJNmjkVXpSHMCTh+GNT3EcEKbDpTUTB6fM/flM96kaes=
X-Gm-Gg: ASbGncvvzRTlXVjuSDsZwgM30XZYrIDd6C4IOiGzS65cLIAE9zpd3gkW+xOi3PqV2Aq
	GXhxPTozZl+0EuY8FG1E9U/mpqxdsvJzT9PR+P0HLIC/AwImUsMFFJicKslun5bI7Huz29hFhJb
	tRM5zRLyFrN2ahR2jEaEOk6MNQTkyXT6wNh+ogM5J9g3LpNG/3ZK+BUybKw6KhvIV/1ZeAoyZb/
	yFjZp0UgJr82njPhGa3Vn8GKt/2Nh1zrYy5LVLCMC2un2EkBm6m3pim+8uNL5dlcu/b+3KlkNgh
	VA6I02qmJpSQukB8qVjNAALKTKU+hlipmGAOu4v4NNeK0HnB/s6mQV4OHOo5PB34w4ws/PK8Nxo
	ymdVkhZmRkXaVHOnrCpZwOUB3FGbHSL06gZ2dNQ==
X-Google-Smtp-Source: AGHT+IGh/nTb9Aer7Y5sA7XEDwIt9Y/Srgk4su5Y3Z8jE3rorYd+AJS5HRVVs6wrynBnDSaStTH1aw==
X-Received: by 2002:a05:622a:5c8:b0:4ab:a256:771 with SMTP id d75a77b69052e-4aedb9f05acmr97053351cf.4.1753953798620;
        Thu, 31 Jul 2025 02:23:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.127.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeec06851sm6093931cf.22.2025.07.31.02.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:23:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1753946671.git.tanggeliang@kylinos.cn>
References: <cover.1753946671.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/2] mptcp: TCP_MD5SIG support
Message-ID: <610977bd-9656-16b4-0984-e520cbd1f604@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Jul 2025 09:23:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_sockopts =
=F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/166430=
03513

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/af302c9a19a1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D987252


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
