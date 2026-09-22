Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C32541473
	for <mptcp@lists.linux.dev>; Tue, 22 Sep 2026 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079495; cv=none; b=GQAbw0JAsVll03cJ5a7oATR3681iZMrDh+JIHfXNWBEzxMHxuya+JOfdJrwYgci634vFqd+MPBfNWjUCIyIACi2/M0du/29N9a8naQzfv9/jWVJ9DM4MoBqrnsjNhZ7/btls7VVK2605Mwxhbc0XKitSCtEAHvFeh/h6fT8iIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079495; c=relaxed/simple;
	bh=uvAcoVf9IpYqRd6tCBg/5K6vUn9ClKo/dmJ7Fo1Uptc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=okXMhqiC4HTQ4HdIrd880uKgkVB6Vw68+wqsLr/QDSlKg7ZHdJHkFzkk2gKO/VcKdlAsxpSRZoyyft7TEjEvm91FwpXyf6jDnrz1RsJyvBxdlXNzeId5dr/A+F9MhpRZvQGBN8iqO0SfbnFEbwvN5BdL0R7HdvQWXKVbSjN+hxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmxMs/D0; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmxMs/D0"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9123599f5e3so38662716d6.0
        for <mptcp@lists.linux.dev>; Tue, 22 Sep 2026 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790079492; x=1790684292; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8bb9jwRCKaBQ5Vma40QC//9SW2qIQsz8VgeMmC2RlcY=;
        b=HmxMs/D0TtBfc6GBW2oliz7jXPMWKIV2bD3SB4SQ4S2VnyKTgwWJG/sS0HjsfMVifk
         Hgbsrv/qtY6w3mPd/o+urWJ2Lq/Ik1yXMI3EQecyn8f/yqViTKVo+Z13jSRXWl5RsTkt
         le66MOiYaNtKSxSnUV5GRWejFuZe/r+aec44v5+UY5QL46JUtdOj65Gk6UPKNBfU8fDI
         YjpKNWo+w+7FBoPqXj5H/GYFZkIyJtfPTghl2P/L48/ULULXKFOkvyBZp31OLV0nQIRf
         Hgq9p2Pj19p+4+ppRFM2gB9T1/gWNwTAP41lsh6RC/3h0t5f7hW6sjzzp6HYFg3kuTCC
         VACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079492; x=1790684292;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8bb9jwRCKaBQ5Vma40QC//9SW2qIQsz8VgeMmC2RlcY=;
        b=v8TbgzZhAaXke9m/bDSCAMBUD+VosoMtv+d8ceRCfIBbxtU3gE6ttCvWQMIzoFkAOC
         twTTl0a0jy195FIHB4WVuE99ql++Gk14lQseSMtjtOcnVmIbWm7z7DJDp7G21NaHRGfU
         suv0tXvIsFyVrxQKT2X0nQyYGsox7omJV771ysHrP90TsMT846qXJyHgZxKOHqMd7tPz
         0it2TzLwSCsryKs0MnLRMmZZnYkeEl+NJxvECfefLGGM2fljl8AR7C4kxhOAxzK0JVYE
         33uE94rynkq/VsRyjOPT3yDbc+xlSOhTriVbVytRywDE76ZpiZJi4fWYiv8eEYCTA29a
         dv9Q==
X-Gm-Message-State: AFuF++kItnHeZHPOOZoPF5CR3ptlRUL6vv14S80if/MFqgF41mupd2C9
	+Qq/aBZ8Hug3dj1ar483CcOwupCk2GZNkPfY9MWYcPl1Zp9yRaCjVn6nSM6Z
X-Gm-Gg: AYBFou3oVfFbv5X5ClUivZ/hUZBndRzvKyH3DeKFkxvN7bj/iZFuoqFtwFQqV/0eXJt
	glX7ikmHB/S3UU1S6/OKKjfrpv0HNJyjX/NwiMrUHiTGPoB4XfuQlpJrVfgsl4yIsbaCD4hsbO7
	mqtFFOfaGoYtSpjMybBNAblH65dZc6KRflpl2l2HJS7tzMX7q7b1hqIfvzALyqYavBU8+zvth4n
	RSAnnywb83GkXt9GAbnYYUYibmkaWQ0UbmN/AJqu3gpSEYzA7YUPmmiL/CYKmxrODKnyyUCRO/C
	xpEglpB597DJHdKGKBj91BNF/ivl4AiARNtv3/QKfQ+DD1sufo7eNHKpDWKhBzlRpo8MvJV7E/s
	oRGwz6deWne82Tjf2h9VwPeZdXOlYkOuWVLT2JiWfWOIAfz8JEknvoD1sbSSrr6F7En7kVJsO1v
	9qkvY0qzyUtCnLdLwiXpNHjJiUf8HjKmw7EHjj1urMceEoGNuJl8RoM2SLdxS25VCU3/udGkOSz
	Yl8HJ8kPIxC
X-Received: by 2002:a05:6214:2301:b0:912:d9b:aa32 with SMTP id 6a1803df08f44-913fc9301d2mr53337986d6.32.1790079492414;
        Tue, 22 Sep 2026 05:18:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.87.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914024c2e3fsm14116756d6.27.2026.09.22.05.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:18:11 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1f7dc605b16fc0590f7cbf5a27d57271926c01ce.1790074764.git.tanggeliang@kylinos.cn>
References:
 <1f7dc605b16fc0590f7cbf5a27d57271926c01ce.1790074764.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next v4] bpf: drop duplicate check_app_limited in
 tcp_bpf_push
Message-ID: <047b79ba-5b07-5f9b-deec-ca9bf659dc02@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 12:18:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
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
et-next/actions/runs/35721657708

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/82dec578c9=
5e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1171249


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
