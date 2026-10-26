Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004849;
	b=s2Dsa2REXBnCu/863KbL3yrJVqD9bPPcubf01qB14YLRK18R9f4ga/qmBUrFZBaE/0rO
	 V6cZYrqGRWKK0nZg699O0AlupLZjsPcGD/1vTjiaB11shA0oFupNo0ftRF2UxSAwsBsV9
	 1EGNiqmWQCtv3pLmyTDebhtd+7hiZ0E95Ge/4D/cl+IqnTuCifAwuSdQtGgTlUdJrkhOY
	 beEdUmhips8q+QCL4g/aSDankA3kGlBIKorFN6Z3pbJheqsKQ333u9aKl6nsM9s+gfMMz
	 6Cxy65ERDBBkfJkkTyvkKjNk23lt+o5KK2SORxO2JvJNkJUOBYRtzBxmDHPbjKUOWVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=gaiLYxcBPq51zUa3YjgpOo4I8zuzRiszjaeLgrqtMLY=;
	b=vj4ORe6PUY3pismD5pwRroqcnk1jxC0RGgHMk05EiVhGgo8/lxiuFR+LbJBhL86Vv4Tb
	 n2SRoEcfHp9H6YcVt3izuVNwNsvWY95gs+s3+Ewzq03ODp26lL6zaqwFso62mcl88j66C
	 YSlrHxzdhv1CD6CNlTuj2QVFXIN6bKinRWKhxHpbw0aUfpfHc8lSTQV2d61p0XTgli9f2
	 cb3fGwekmOdtCYimVCJl1Fp9zmWD0crgrR8KnHJuJZM1LSnt+6nJ6W9Yn92H7Ma4WbOcF
	 oTBawijMShPBpqeYbrx/3Xi7eYVk3mSkCQ/zK5OEazE2EDvr/HDBckQwdafcAja/ZfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iItKUsEg;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824B606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 08:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8824B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iItKUsEg
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4592780eec.0
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793004849; x=1793609649; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gaiLYxcBPq51zUa3YjgpOo4I8zuzRiszjaeLgrqtMLY=;
        b=iItKUsEgpqKlFsquInMhLUfEtlT3/ZMoh/1psEl2F021DTmEqPLwEQuev21i6kEJDa
         I+UR4sDInYrlG42M8xaNCD9TG3MNMAf1Z4zY7r0r1hd43lNqP6NKahYJJOpFMVdfs+NG
         HCTnyhjkIoQhAapI/wHQK9QzDkAywbv4GAX5hTLaxJdDf6u6yqy6v0nNfjBsUyVMqg13
         jjPzzHkXJ7JkWmNBV48V0BkZ+vsH0cH3oVXhBk5NMk5dESQqhDRZTcIjg/Khu6iBr5KQ
         bsHXaS6To75tWR3yfIDgb6Q+l5D834wSKiyt3dE0ioItl8yXio1Kr1Q+bPk74rx8Oir+
         0Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793004849; x=1793609649;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gaiLYxcBPq51zUa3YjgpOo4I8zuzRiszjaeLgrqtMLY=;
        b=RE7OjpZ1OIgXtQiMoqPOu4+LuN7u/oyocqJWdwVsk4WMT0xWOXAxgr3/fFseJ8OQfL
         wdCDJ3mBsmGhB0Rp/wPyTqUvKvI4NcOlwSBrHVXXWHYBFG/BSh2VzmE/6CZL3V9vRFtc
         IA2oQ++fxG7sy2lK7J/8Ks10gIyxD3wKQ7Rp1rR8syobm3xta5Z1AUaH0FNj8BvBTyh8
         tHAPwGEtYXc9b9gvguRmjTrB8/Ih/pHUhgv+Lmhob2Jv3grKixCDQk30N7f1ricKj45a
         MmYhyzahcCJxd1SxKMksGm+HI1JbrLWmRrZ2L1J5R/q+9cZaFy7ICVCtWqVvdzJrZn5b
         2w+Q==
X-Gm-Message-State: AFq9FYL+UebZohoiKVZJY6PE0vDiHti/SUlIEXpJcqecA2GBRbsvFlZz
	B4Dq2rD2AkxbhvGZbZT2x/DQd0599q9s/2gFxXAJtg6pDren2pI01mGNQjYh
X-Gm-Gg: AYBFou1GhrecNgwLpo08UhODFANrL5dvPasTJX/EF/6I7hxb1SoghqqH139WR1B0Lxj
	1NVpHQLKwthv+lM8iIAhwTxm2Hjk9MLEE9Iwlmxf7i56bqQwVPDSP1qm1JZ9a0XFep6ODPG58ja
	9Z8sHwaLtVJhF3MW4Pzd3pW1lpIP2RhFsZvGNvgNsyL5/vcY9fd+7w4c0fw0eHaOQOoejIi55PP
	X1puTM0/S6+Wa0zFQ4PeBhePJXt0WpFexlcTF8XZ68Z3mu42gTPV/3BbCy5niXujh/hyVmt32LQ
	60ZSzBgv/Lyhzpwc67+n2qrurKYyNWvquh+WkGM981/KQ9xhYmi54MMxLD0jy/mPbplaGpBnU1t
	4GO1WbvWsaDnhXvNq1ET4RNg5HKSf9zu+SUAJkTnREw+fQa5qglb0pMXC6qHZizy+o5IRxhpOvj
	hrK2NMtfroX8KXRAmnBmdK/1wRP/mtmpxD5+lNmpg/15hoONvQSHqKZXOA7BUnP2LV9kwyi3uuD
	3fIlrKROlZA9zFO1jtjDLe9aFOjDeAWKLHrJ4vhDXxPkNiZbCnSgTRsh/E7JXObN+Qiub/w6kzi
	XN20wPYKzzw=
X-Received: by 2002:a05:7301:a08:b0:367:23b6:94e1 with SMTP id 5a478bee46e88-369e861e0b3mr10280399eec.41.1793004848094;
        Mon, 26 Oct 2026 01:54:08 -0700 (PDT)
Received: from github.com ([57.154.5.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7b23sm32458474eec.19.2026.10.26.01.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:54:07 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1792999988.git.tanggeliang@kylinos.cn>
References: <cover.1792999988.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/6] prepare interfaces for kTLS and sockmap
 support
Message-ID: <713c5da4-e0da-850a-1ba3-82fbf799aa4c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:54:07 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

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
et-next/actions/runs/40289414299

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/3b7253c767=
38
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1193440


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
