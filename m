Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D5D3B388A
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 07:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174439; cv=none; b=BRvccg+NR7pZJv3JDoOaimrRvtou05Tt3YRk7Xhq3tIyv1D1jP8vHy3HPi81TxmEBNsowPCe5G6wMCUocgwWqtXZkhYZorV1D7MkRF9RqLqfbuYr2gpcq2pwdaCszOMtsJV5ncsWlRnv1ceYpf/HyTmTBwuFIPA+Avjit3Rwgy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174439; c=relaxed/simple;
	bh=KrSLTN0L0C5I2Y8w/PYSdljF65QCCRjoejK6hIU6ysI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=T+B1QkhY4br7F3ZOraSQYTJ5HOaoPI3sn5BgV9XU/UYuAK5rObpngp7W4Lz/C4UE26sluOLvMuVg0CqVA8pcD6R32iPz13YKrZplkuqllxoljZogIAH7pBsyO+1giu+2t/XbZ1ASQL+tl062hSqfQ+6LWYGDisQaHSBoyREOnFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nf83vEZq; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf83vEZq"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8acae26e564so43457836d6.2
        for <mptcp@lists.linux.dev>; Tue, 19 May 2026 00:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779174437; x=1779779237; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVN4YYG6HpEDQUiTwtPlGgTjC88DGQ7sYyN1SliMvzI=;
        b=Nf83vEZq0x4qVE2P9vZNeF3TTxhr0tECUgDkNTbHipKouy5PEwyiR5VrCYkgPLkT/g
         2RNvsp4qOwnwfhHekdm8x0g/HKp8iw3DI2ISXy63Z9F2s2hMQDAiYrLksYs12bnaKE2u
         lw0T1HLAqOFwDBZwvwmqT37LcDlcwvaj0sRNQt2y78Fe4kU7NniPBA3vLXSLdPFsnXdw
         wV2JL477MyNrK5f3K7jkqnacFeKERtPgrqJgLQ4gNJnmrWRYyhiL50QkI+wGkpTuOGzw
         Ik6cAq0C7/G3mjpj/IFHhDYnBdrXh/aSGG6sacs7WiXOmKeAw7EbSzTfwob/sHxBz7Hv
         GdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779174437; x=1779779237;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVN4YYG6HpEDQUiTwtPlGgTjC88DGQ7sYyN1SliMvzI=;
        b=c/JJDOk5cinEvJomQX01CbxXO+TSHtm7ZxrmXfQ9RRJPfo37VDOG3eivw9wVRFdxza
         sN4yIdmRLmxsCmSKadp5HUuyYBiolVAAKQIxrEZoFwObUiU5HhEW/uaM/awKSKBsBDKk
         pt5KRIfEeM/FE5M98FaPjuLYlVn088DeDONJphIKAJwR3TiobGFsOh0kAwH/NFQgyyga
         KbTiCFmq0GYjdBaDWJ8UzrZGhouadYvfbkAyeFsXtSVYr6Qlpyg30T7i8pQEtjrHn2g3
         Zpxvpiq/WBu5C+6eQhKGfk8OOAlsJ8VcssdhaVXePJzN37/ClOigKSh3ndNOnpuJrCju
         Gpbw==
X-Gm-Message-State: AOJu0YxvlRLWi9sXvcvWblsvKRkrEij50TbzsMiwxvEpv/ACow8x9+CY
	b/VdFG/iZNATX66T3jQplm9gX7tddm7Qn++s6F7DdWUP7DamA3AizcQ=
X-Gm-Gg: Acq92OHAVVCKzCxmr5GP2ce5ihxi/s2fuMCqQMGY2rcXreovCwbYszU2Hcam/VpHKmT
	we5IOxZJQKl80CrsBsdbM+QB0AHnSvO1uORM6+YB48bYr6ApkW7FUOUsqmv2BKIxg+8HY7wQsyc
	+wnzMlWWircoBFRJ1aMt2kARHx2H8nOpjXHXO6s7iwPtC2TwWA+/eLO+4MkGugCqIqi6NvQKQD/
	jNS4iZpWuTX/20GSXgptGdgna9xC3j/OVebkK4ELy7hTJvCklsAbzbg8p7g1Py2uXULof/HwRI7
	OnxdVRa3eKL1RVFrX+ni6OavAls+eGI6G12BIQKXd3N4/TdMjLaR21UzMz9sZ0ubs5SZwWj/idQ
	J6ChOEE5kWgiajAK+fgqn6sevnx62M2j2FHq0pEJlR227nEf+A9I5eCDccleNlJMCBsr4kMmAC4
	HmXb9NF8MrhAfuHajpsPWI+y2OJbVUFZGr7QSelrTwphGJU0qinODH/PuoRJ79
X-Received: by 2002:a05:6214:3909:b0:8ca:1cee:7c3b with SMTP id 6a1803df08f44-8ca1cee91b4mr268078616d6.29.1779174437545;
        Tue, 19 May 2026 00:07:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.178.119.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3619e814sm82444476d6.39.2026.05.19.00.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:07:16 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
Subject: Re: [PATCH mptcp-net mptcp-next v2 00/15] mptcp: pm: drop TCP TS
 with ADD_ADDRv6 + port
Message-ID: <ff1ab8c2-8d00-e007-129a-758ed81302bd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 07:07:16 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_add_addr packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/260797=
04395

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c0b4970df7b1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1097045


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
